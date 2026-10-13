import functools
import os
import time

import pandas as pd

# Константы путей
DATA_FILE = os.path.join('data', 'accepted_2007_to_2018Q4.csv.gz')
OUTPUT_DIR = os.path.join('docs', 'analysis')
OUTPUT_FILE = os.path.join(OUTPUT_DIR, 'columns_raw.md')

# Константы параметров обработки
CHUNK_SIZE = 100_000
CARDINALITY_LIMIT = 500


def timer(func):
    """Декоратор для замера времени выполнения функции."""
    @functools.wraps(func)
    def wrapper(*args, **kwargs):
        start_time = time.perf_counter()
        result = func(*args, **kwargs)
        elapsed = time.perf_counter() - start_time
        print(f'Функция "{func.__name__}" выполнена за {elapsed:.4f} сек.')
        return result
    return wrapper


def validate_filepath(filepath: str) -> None:
    """Проверка нахождения файла по заданному пути."""
    if not os.path.exists(filepath):
        raise FileNotFoundError(f'Файл не найден: {filepath}')


@timer
def collect_column_stats(
    filepath: str,
    chunk_size: int,
    limit: int,
) -> tuple[dict, int]:
    """Проходит по файлу чанками и собирает сырую статистику."""
    total_rows = 0         # счетчик строк
    non_null_counts = {}   # кол-во непустых значений для каждой колонки
    unique_sets = {}       # кол-во уникальных значений для каждой колонки
    overflow_cols = set()  # колонки которые имеют более 500 различных значений
    first_samples = {}     # пример первого значения для каждой колонки
    dtypes = {}            # типы данных для каждой колонки

    for chunk in pd.read_csv(filepath, chunksize=chunk_size, low_memory=False):
        total_rows += len(chunk)
        print(f'Обработано строк: {total_rows:,}...', end='\r')

        # Инициализация словарей на первом чанке
        if not dtypes:
            for col in chunk.columns:
                dtypes[col] = str(chunk[col].dtype)
                non_null_counts[col] = 0
                unique_sets[col] = set()
                first_samples[col] = None

        for col in chunk.columns:
            # Подсчет непустых ячеек
            non_null_counts[col] += int(chunk[col].notna().sum())

            # Фиксация первого непустого образца
            if first_samples[col] is None:
                valid_values = chunk[col].dropna()
                if not valid_values.empty:
                    first_samples[col] = str(valid_values.iloc[0])

            # Сбор уникальных значений
            if col not in overflow_cols:
                unique_sets[col].update(chunk[col].dropna().unique())
                if len(unique_sets[col]) > limit:
                    overflow_cols.add(col)
                    unique_sets[col].clear()

    print()
    stats = {
        'dtypes': dtypes,
        'non_null_counts': non_null_counts,
        'unique_sets': unique_sets,
        'overflow_cols': overflow_cols,
        'first_samples': first_samples,
    }
    return stats, total_rows


def save_markdown_report(
    stats: dict,
    output_path: str,
    total_rows: int,
) -> None:
    """Превращает сырую статистику в DataFrame и сохраняет Markdown отчет."""
    rows = []

    for idx, col in enumerate(stats['dtypes'].keys(), start=1):
        dtype = stats['dtypes'][col]
        non_null = stats['non_null_counts'][col]
        pct = (non_null / total_rows) * 100 if total_rows > 0 else 0

        # Определение кардинальности
        if col in stats['overflow_cols']:
            cardinality = '> 500'
        else:
            cardinality = str(len(stats['unique_sets'][col]))

        # Обработка примера значения
        raw_sample = stats['first_samples'].get(col)
        if raw_sample is None:
            sample_str = '-'
        else:
            sample_str = str(raw_sample).replace('\n', ' ').replace('|', '/')
            if len(sample_str) > 40:
                sample_str = sample_str[:37] + '...'

        rows.append({
            '№': idx,
            'Имя колонки': f'`{col}`',
            'Тип Pandas': f'`{dtype}`',
            'Заполненность': f'{non_null:,} ({pct:.1f}%)',
            'Уникальных': cardinality,
            'Пример значения': sample_str,
        })

    report_df = pd.DataFrame(rows)

    os.makedirs(os.path.dirname(output_path), exist_ok=True)

    with open(output_path, 'w', encoding='utf-8') as f:
        f.write('# Реестр колонок исходного датасета Lending Club\n\n')
        f.write(f'> Всего строк: **{total_rows:,}**  \n')
        f.write(f'> Всего колонок: **{len(rows)}**  \n\n')
        f.write(report_df.to_markdown(index=False))
        f.write('\n')


def main() -> None:
    print(f'Проверка исходного файла: {DATA_FILE}')
    validate_filepath(DATA_FILE)

    print('Потоковый сбор характеристик колонок...')
    stats, total_rows = collect_column_stats(
        DATA_FILE, CHUNK_SIZE, CARDINALITY_LIMIT
    )

    print(f'Формирование Markdown-отчета в: {OUTPUT_FILE}')
    save_markdown_report(stats, OUTPUT_FILE, total_rows)
    print(f'Анализ завершен! Обработано строк: {total_rows:,}')


if __name__ == '__main__':
    main()

