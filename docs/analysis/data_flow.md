# Диаграмма потоков данных (Data Flow Diagram, DFD)

Данный документ описывает жизненный цикл и архитектуру движения данных в системе: от исходных внешних источников (архив кредитного скоринга Lending Club и модуль генерации синтетических персональных данных по 152-ФЗ) через потоковый ETL-конвейер на Python до нормализованного хранилища PostgreSQL 16 в Docker, триггеров бизнес-валидации, CDC-аудита и витрин разграничения доступа.

---

## 1. Реестр интерфейсов и потоков данных

| ID потока | Источник (Source) | Приёмник (Target) | Передаваемые данные | Формат / Протокол | Назначение потока |
| :---: | :--- | :--- | :--- | :--- | :--- |
| **DF-01** | Внешний архив (Kaggle) | Python ETL (`etl_loader.py`) | 2.26 млн сырых записей кредитных историй, скоринга и платежей | CSV.GZ (Gzip-сжатый CSV, UTF-8, RFC 4180) | Извлечение (Extract) исторических данных Lending Club с потоковой декомпрессией чанками |
| **DF-02** | Модуль генерации ПДн (`Faker`) | Python ETL (`etl_loader.py`) | Синтетические ФИО поручителей, телефоны, вычисленные хеши паспортов (SHA-256), данные залогов | Python In-Memory Generator Stream | Обогащение обезличенного набора реалистичными ПДн для соблюдения требований 152-ФЗ |
| **DF-03** | Сид-скрипт (`sql/seed.sql`) | PostgreSQL (`loan_purposes`) | 14 нормализованных категорий целей кредитования | SQL DML (`INSERT ... ON CONFLICT`) | Первичное наполнение системных классификаторов до старта пакетного импорта |
| **DF-04** | Python ETL (`etl_loader.py`) | PostgreSQL (7 таблиц 3НФ) | Очищенные, приведенные к типам и валидированные батчи записей | `psycopg` Binary Stream / `COPY FROM STDIN` | Скоростная пакетная загрузка 2.26M строк с поддержанием ссылочной целостности FK |
| **DF-05** | Таблица `loans` | Серверная логика (`triggers_functions.sql`) | Новые и модифицируемые строки заявок и кредитных договоров | PL/pgSQL (`BEFORE INSERT OR UPDATE`) | Контроль бизнес-правил (неотрицательность балансов, лимиты сумм, допустимые грейды) |
| **DF-06** | Серверные триггеры CDC | Таблица `audit_log` | Имя таблицы, тип операции, timestamp, пользователь, снимки OLD/NEW | JSONB (`AFTER INSERT OR UPDATE OR DELETE`) | Неизменяемый структурированный аудит операций над чувствительными данными (152-ФЗ) |
| **DF-07** | Таблицы `loans`, `clients` | Маскированные представления (`VIEW`) | Обезличенные анкеты заёмщиков со скрытыми персональными данными и доходами | SQL Security Views (DCL) | Динамическая изоляция конфиденциальных сведений по 152-ФЗ |
| **DF-07b** | Таблицы `loans`, `loan_financial_state`, `credit_profiles` | Материализованная витрина (`MATERIALIZED VIEW`) | Предрассчитанные тяжелые агрегаты портфеля, скоринговые метрики и статистика дефолтов | SQL Materialized View | Высокопроизводительная витрина для бизнес-аналитиков без пересчёта 2.26M строк |
| **DF-08** | Маскированные представления | Роль `credit_analyst` | Деперсонализированные выборки, метрики дефолтов, витрины | SQL Query / Read-Only Cursor | Анализ кредитного портфеля, скоринговое моделирование, построение отчётов |
| **DF-09** | Таблицы `clients`, `loans`, `joint_applications`, `guarantors`, `collaterals` | Роль `loan_operator` | Анкеты заёмщиков, параметры заявок, договоры, обеспечение и поручители | SQL Client / Транзакционный доступ (OLTP) | Ведение клиентских профилей, скоринг, оформление договоров и проверка обеспечения |
| **DF-10** | Таблица `audit_log` | Роль `system_auditor` | Хронологический журнал изменений данных: `table_name`, `record_id`, `operation_type`, `changed_by`, `changed_at`, снимки `old_value`/`new_value` | SQL SELECT (Read-Only) | Аудит фактов модификации записей в чувствительных таблицах (152-ФЗ); журнал неизменяем |
| **DF-11** | Таблицы `loans`, `collaterals` | Роль `loan_committee` | Параметры заявок, статус решения (`loan_status`), предметы залога и оценочная стоимость | SQL Client / Транзакционный доступ (OLTP) | Чтение заявок и залогов для принятия решения; обновление только `loans.loan_status` (статус решения) |

---

## 2. Архитектурная контекстная DFD-диаграмма

Диаграмма визуализирует границы системы, внешние сущности, вычислительные процессы, физические хранилища и потоки разграничения прав.

```mermaid
flowchart TD
    %% Внешние источники
    subgraph EXT_SOURCES ["1. Внешние источники данных"]
        DS_CSV["Архив Lending Club<br/>(2.26M строк, CSV.GZ)"]
        FAKER["Faker Generator<br/>(Синтетические ПДн и залоги)"]
        SEED_FILE["sql/seed.sql<br/>(Справочные сиды)"]
    end

    %% ETL-конвейер
    subgraph PIPELINE ["2. ETL-конвейер обработки (Python / etl_loader.py)"]
        P_INGEST["Потоковое чтение и распаковка gzip<br/>(Chunking 50k / In-Memory)"]
        P_ENRICH["Генерация синтетики под 152-ФЗ<br/>(Поручители Faker, залоги, хэширование SHA-256)"]
        P_NORM["Декомпозиция на сущности 3НФ<br/>(Приведение типов, нормализация связей)"]
        P_BATCH["Скоростная вставка в СУБД<br/>(PostgreSQL COPY FROM STDIN)"]
    end

    %% Хранилище PostgreSQL
    subgraph DATABASE ["3. Реляционное хранилище (PostgreSQL 16 в Docker)"]
        subgraph DICT_STORAGE ["Справочники"]
            T_PURPOSES[("loan_purposes<br/>(14 категорий целей)")]
        end

        subgraph CORE_STORAGE ["Основные сущности 3НФ (sql/schema.sql)"]
            T_CLIENTS[("clients<br/>(ID, локация заёмщика)")]
            T_LOANS[("loans<br/>(Параметры займов и договоров)")]
            T_PROFILES[("credit_profiles<br/>(FICO, скоринг 1:1)")]
            T_FIN_STATE[("loan_financial_state<br/>(Балансы, платежи 1:1)")]
            T_JOINT[("joint_applications<br/>(Созаёмщики 1:1)")]
            T_GUARANTORS[("guarantors<br/>(Поручители 1:N / ПДн)")]
            T_COLLATERALS[("collaterals<br/>(Залоговое имущество 1:N)")]
        end

        subgraph SYSTEM_STORAGE ["Служебные сущности"]
            T_AUDIT[("audit_log<br/>(JSONB CDC-аудит)")]
        end

        subgraph SERVER_LOGIC ["Серверная логика (sql/triggers_functions.sql)"]
            TRG_VALID["Триггеры валидации<br/>(Контроль лимитов)"]
            TRG_AUDIT["Триггеры CDC-аудита<br/>(Фиксация OLD/NEW)"]
        end
    end

    %% Слой представлений
    subgraph SECURITY_LAYER ["4. Слой витрин и маскирования (152-ФЗ)"]
        V_MASKED["v_loans_masked<br/>(Обезличенные договоры и доходы)"]
        V_ANALYTICS["v_portfolio_analytics<br/>(Аналитическая витрина риска)"]
    end

    %% Роли
    subgraph CONSUMERS ["5. Потребители данных (Ролевая модель DCL / sql/roles.sql)"]
        R_ANALYST["credit_analyst<br/>(Кредитный аналитик)"]
        R_OPERATOR["loan_operator<br/>(Кредитный оператор)"]
        R_COMMITTEE["loan_committee<br/>(Кредитный комитет)"]
        R_AUDITOR["system_auditor<br/>(Аудитор системы: чтение audit_log)"]
    end

    %% Потоки инициализации справочников
    SEED_FILE -->|DF-03: Первичный сид категорий| T_PURPOSES
    T_PURPOSES -.->|FK связь| T_LOANS

    %% Потоки загрузки ETL
    DS_CSV -->|DF-01: Потоковые чанки CSV.GZ| P_INGEST
    FAKER -->|DF-02: Поток ПДн поручителей и залогов| P_ENRICH
    P_INGEST --> P_ENRICH
    P_ENRICH --> P_NORM
    P_NORM --> P_BATCH

    P_BATCH -->|DF-04: COPY| T_CLIENTS
    P_BATCH -->|DF-04: COPY| T_LOANS
    P_BATCH -->|DF-04: COPY| T_PROFILES
    P_BATCH -->|DF-04: COPY| T_FIN_STATE
    P_BATCH -->|DF-04: COPY| T_JOINT
    P_BATCH -->|DF-04: COPY| T_GUARANTORS
    P_BATCH -->|DF-04: COPY| T_COLLATERALS

    %% Триггерная логика
    T_LOANS -->|DF-05: BEFORE INSERT/UPDATE| TRG_VALID
    T_LOANS -->|События DML| TRG_AUDIT
    T_CLIENTS -->|События DML| TRG_AUDIT
    T_GUARANTORS -->|События DML| TRG_AUDIT
    TRG_AUDIT -->|DF-06: Логирование слепков в JSONB| T_AUDIT

    %% Формирование представлений
    T_LOANS -->|DF-07: Маскирование доходов| V_MASKED
    T_CLIENTS -->|DF-07: Обезличивание локаций| V_MASKED
    T_LOANS -->|DF-07b: Параметры займов| V_ANALYTICS
    T_PROFILES -->|DF-07b: Агрегация скоринга| V_ANALYTICS
    T_FIN_STATE -->|DF-07b: Расчёт выплат| V_ANALYTICS

    %% Потоки к ролям
    V_MASKED -->|DF-08: Обезличенные выборки| R_ANALYST
    V_ANALYTICS -->|DF-08: Аналитические витрины| R_ANALYST
    T_CLIENTS -->|DF-09: Управление заёмщиками| R_OPERATOR
    T_LOANS -->|DF-09: Оформление договоров| R_OPERATOR
    T_JOINT -->|DF-09: Проверка созаёмщиков| R_OPERATOR
    T_GUARANTORS -->|DF-09: Проверка поручителей| R_OPERATOR
    T_COLLATERALS -->|DF-09: Оценка залогов| R_OPERATOR
    T_AUDIT -->|DF-10: Чтение журнала изменений данных| R_AUDITOR
    T_LOANS -->|DF-11: Чтение заявок, U loan_status| R_COMMITTEE
    T_COLLATERALS -->|DF-11: Чтение залогов| R_COMMITTEE
```
---

## 3. Спецификация технических форматов и протоколов

### 3.1. Первичный входной поток (Lending Club CSV.GZ)
* **Формат хранения:** Сжатый архив GZIP (`.csv.gz`), кодировка текста UTF-8, экранирование RFC 4180.
* **Объём данных:** 2 260 701 строка, 151 исходный столбец.
* **Особенности предобработки:** Потоковая декомпрессия (in-memory streaming через модуль `gzip` / параметр `chunksize=50000` библиотеки `pandas`) без предварительной физической распаковки файла на диск, что исключает переполнение дискового пространства хоста.

### 3.2. Синтетический поток ПДн и обеспечения (152-ФЗ)
* **Сущность `clients` (клиенты):** Суррогатный первичный ключ `client_id` генерируется последовательно в конвейере ETL ввиду отсутствия `member_id` в исходном архиве. Поле `zip_code` сохраняется строковым типом `CHAR(5)` с сохранением маскирования исходного датасета (вида `954xx`).
* **Сущность `guarantors` (поручители):** Так как датасет Lending Club обезличен, для ~10% договоров генерируются синтетические поручители библиотекой `Faker(locale='ru_RU')` (ФИО, телефон, доход, отношение к заёмщику).
* **Паспортные данные поручителей:** Не сохраняются в открытом виде. Вычисляется криптографический хеш алгоритмом SHA-256:
  $$\text{passport\_hash} = \text{SHA256}(\text{series} + \text{number} + \text{salt})$$
  Формат в базе данных: `CHAR(64)` с контролем составного ограничения уникальности `UNIQUE (loan_id, passport_hash)`.
* **Сущность `collaterals` (залоги):** Синтезируются типы обеспечения (недвижимость, автотранспорт), оценочная стоимость, кадастровые номера и VIN-коды (`CHAR(17)`) для отработки аналитических запросов по кредитному покрытию.

### 3.3. Внутренний протокол загрузки в PostgreSQL
* **Драйвер подключения:** Python `psycopg3`.
* **Механизм переноса:** Использование протокола потокового копирования `COPY ... FROM STDIN (FORMAT CSV, DELIMITER ',', QUOTE '"', ESCAPE '"')` для обеспечения скорости загрузки свыше 25 000 строк/сек при сохранении ссылочной целостности внешних ключей.

### 3.4. Служебный формат лога аудита (JSONB)
* Таблица `audit_log` хранит метаданные операции в реляционных столбцах (`audit_id`, `table_name`, `record_id`, `operation_type`, `changed_by`, `changed_at`), а слепки состояния строки фиксируются в столбцах типа `JSONB`:
  * **`old_value`** (снимок до операции):
    ```json
    {
      "loan_status": "Current",
      "out_prncp": 12500.00,
      "last_pymnt_d": "2018-09-01"
    }
    ```
  * **`new_value`** (снимок после операции):
    ```json
    {
      "loan_status": "Fully Paid",
      "out_prncp": 0.00,
      "last_pymnt_d": "2018-10-01"
    }
    ```