# Параметры подключения к PostgreSQL

## 1. Порт подключения

| Параметр | Значение |
|---|---|
| Порт на хосте (внешний) | `5433` |
| Порт внутри контейнера   | `5432` |

Подключение с хост-машины (DBeaver, psql, приложение) выполняется на порт **5433**.

## 2. Имя базы данных

```
landing_club
```

## 3. Пользователь и пароль по умолчанию

| Параметр | Значение |
|---|---|
| Пользователь | `ultima` |
| Пароль       | `ultima_dev_pw` |
| Хост         | `localhost` |
| Порт         | `5433` |
| База данных  | `landing_club` |

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

Флаг `-d` запускает контейнер в фоне (detached mode).

### Проверка статуса

```bash
docker compose ps
```

### Остановка контейнера

```bash
docker compose stop
```

Останавливает контейнер, но **не удаляет** его и не трогает данные в volume.

### Полная остановка и удаление контейнера

```bash
docker compose down
```

Удаляет контейнер и сеть, но **данные в volume сохраняются**.

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

---

## 5. Подключение через DBeaver

### Шаг 1. Убедиться, что контейнер запущен

```bash
docker compose up -d
docker compose ps
```

В выводе `docker compose ps` статус должен быть `running` (или `healthy`).

### Шаг 2. Создать новое подключение

Меню **Database → New Database Connection → PostgreSQL → Next**.

### Шаг 3. Заполнить поля подключения

В окне **Main** ввести ровно эти значения:

| Поле в DBeaver | Значение |
|---|---|
| **Host**         | `localhost` |
| **Port**         | `5433` |
| **Database**     | `landing_club` |
| **Username**     | `ultima` |
| **Password**     | `ultima_dev_pw` |

Галочку **Save password** — по желанию 

### Шаг 4. Проверить соединение

Нажать **Test Connection**.

- Если DBeaver предложит **скачать JDBC-драйвер PostgreSQL** — согласиться (Download).
- При успехе появится сообщение `Connected` — нажать **Finish**.

### Шаг 5. Открыть подключение

В левой панели **Database Navigator** появится новое подключение. Двойной клик — и можно писать SQL-запросы в **SQL Editor**.

---

### Если `Test Connection` падает

| Ошибка | Причина | Решение |
|---|---|---|
| `Connection refused` | Контейнер не запущен / порт не проброшен | `docker compose ps`, `docker compose logs postgres` |
| `password authentication failed` | Неверный пароль, либо пароль менялся **после** первого запуска | `docker compose down -v && docker compose up -d` (⚠️ удалит данные) |
| `database "landing_club" does not exist` | БД создалась с другим регистром (`Landing_Club`) | Проверить: `docker exec -it bigdata_postgres psql -U ultima -d postgres -c "\l"`. Если имя с заглавными — вводить его в DBeaver **в двойных кавычках**: `"Landing_Club"` |
| `port is already allocated` | Порт `5433` занят | Поменять левую часть в `ports` на `5434` и обновить поле **Port** в DBeaver |

### Проверка параметров изнутри контейнера

```bash
# список баз данных
docker exec -it bigdata_postgres psql -U ultima -d postgres -c "\l"

# список пользователей
docker exec -it bigdata_postgres psql -U ultima -d postgres -c "\du"

# какие порты проброшены
docker port bigdata_postgres
# → 5432/tcp -> 0.0.0.0:5433
```