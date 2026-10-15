# Параметры подключения к PostgreSQL

Проект использует переменные окружения. Шаблон параметров — в файле
`.env.example` в корне проекта. Локальный `.env` создаётся копированием
шаблона и **не коммитится в Git**.

## 0. Подготовка окружения

### Windows (PowerShell)

```powershell
copy .env.example .env
```

### Linux / macOS

```bash
cp .env.example .env
```

После этого при необходимости отредактировать значения в `.env`.

## 1. Порт подключения

| Параметр | Значение |
|---|---|
| Переменная в `.env`    | `POSTGRES_PORT` |
| Значение по умолчанию  | `5433` |
| Порт внутри контейнера | `5432` |

Подключение с хост-машины (DBeaver, psql, приложение) выполняется
на порт **5433**.

## 2. Имя базы данных

| Параметр | Значение |
|---|---|
| Переменная в `.env`   | `POSTGRES_DB` |
| Значение по умолчанию | `landing_club` |

## 3. Пользователь и пароль по умолчанию

| Параметр | Переменная | Значение по умолчанию |
|---|---|---|
| Пользователь | `POSTGRES_USER`     | `ultima` |
| Пароль       | `POSTGRES_PASSWORD` | `ultima_dev_pw` |
| Хост         | —                   | `localhost` |
| Порт         | `POSTGRES_PORT`     | `5433` |
| База данных  | `POSTGRES_DB`       | `landing_club` |

Строка подключения:

```
postgresql://ultima:ultima_dev_pw@localhost:5433/landing_club
```

## 4. Команды запуска и остановки

Все команды выполняются из корня проекта (там, где лежит `docker-compose.yml`).

### Запуск контейнера

```bash
docker compose up -d
```

### Проверка статуса

```bash
docker compose ps
```

### Остановка контейнера

```bash
docker compose stop
```

### Полная остановка и удаление контейнера

```bash
docker compose down
```

### Полная очистка (включая данные)

```bash
docker compose down -v
```

⚠️ Флаг `-v` удаляет volume — **все данные в БД будут потеряны безвозвратно**.

### Подключение через psql внутри контейнера

```bash
docker exec -it bigdata_postgres psql -U ultima -d landing_club
```

### Просмотр логов

```bash
docker compose logs postgres
```

## 5. Подключение через DBeaver

### Шаг 1. Убедиться, что контейнер запущен

```bash
docker compose up -d
docker compose ps
```

Статус должен быть `running` или `healthy`.

### Шаг 2. Создать новое подключение

Меню **Database → New Database Connection → PostgreSQL → Next**.

### Шаг 3. Заполнить поля

| Поле в DBeaver | Значение |
|---|---|
| **Host**     | `localhost` |
| **Port**     | `5433` |
| **Database** | `landing_club` |
| **Username** | `ultima` |
| **Password** | `ultima_dev_pw` |

> Значения соответствуют `.env.example`. Если в локальном `.env`
> параметры изменены — использовать их.

### Шаг 4. Проверить соединение

Нажать **Test Connection**. Если DBeaver предложит скачать
JDBC-драйвер PostgreSQL — согласиться. При успехе — **Finish**.

### Типовые ошибки

| Ошибка | Причина | Решение |
|---|---|---|
| `Connection refused` | Контейнер не запущен | `docker compose ps`, `docker compose logs postgres` |
| `password authentication failed` | Пароль изменён после первого запуска | `docker compose down -v && docker compose up -d` |
| `database ... does not exist` | Опечатка в `POSTGRES_DB` или смена регистра | Проверить `.env`, зайти в psql: `\l` |
| `port is already allocated` | Порт занят | Изменить `POSTGRES_PORT` в `.env` и перезапустить |