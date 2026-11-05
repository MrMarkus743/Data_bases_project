import os
from contextlib import contextmanager

import psycopg
from dotenv import load_dotenv
from psycopg.rows import dict_row
from psycopg_pool import ConnectionPool

# Загружаем переменные из .env
load_dotenv()

# Список обязательных переменных для подключения к БД
REQUIRED_ENV_VARS = [
    "POSTGRES_HOST",
    "POSTGRES_PORT",
    "POSTGRES_DB",
    "POSTGRES_USER",
    "POSTGRES_PASSWORD",
]

missing_vars = [var for var in REQUIRED_ENV_VARS if not os.getenv(var)]
if missing_vars:
    raise RuntimeError(
        f"❌ Ошибка конфигурации! В .env отсутствуют обязательные переменные: {', '.join(missing_vars)}.\n"
        "Скопируйте .env.example в .env и укажите актуальные параметры подключения."
    )

DB_HOST = os.environ["POSTGRES_HOST"]
DB_PORT = os.environ["POSTGRES_PORT"]
DB_NAME = os.environ["POSTGRES_DB"]
DB_USER = os.environ["POSTGRES_USER"]
DB_PASSWORD = os.environ["POSTGRES_PASSWORD"]

# Формируем строку подключения
DATABASE_URL = (
    f"postgresql://{DB_USER}:{DB_PASSWORD}@{DB_HOST}:{DB_PORT}/{DB_NAME}"
)

# Инициализируем пул соединений psycopg (min 1, max 10)
pool = ConnectionPool(
    conninfo=DATABASE_URL,
    min_size=1,
    max_size=10,
    open=True,
    kwargs={"row_factory": dict_row},
)


@contextmanager
def get_connection():
    """Контекстный менеджер для безопасного извлечения и возврата соединения из пула."""
    with pool.connection() as conn:
        yield conn


def test_connection() -> str:
    """Выполняет тестовый запрос SELECT version() для валидации подключения к СУБД."""
    with get_connection() as conn, conn.cursor() as cur:
        cur.execute("SELECT version();")
        result = cur.fetchone()
        return result["version"] if result else "No version returned"


if __name__ == "__main__":
    print(f"⏳ Подключение к базе '{DB_NAME}' на {DB_HOST}:{DB_PORT} (пользователь: {DB_USER})...")
    try:
        version = test_connection()
        print(f"✅ Успешное подключение к PostgreSQL!\n{version}")
    except psycopg.Error as err:
        print(f"❌ Ошибка базы данных (PostgreSQL): {err}")
    finally:
        pool.close()
