-- Первичное наполнение справочника целей кредитования loan_purposes.
-- Источник: docs/analysis/columns_raw.md, колонка purpose (14 уникальных).
-- Идемпотентно: повторный запуск не меняет данные (ON CONFLICT DO NOTHING).

INSERT INTO loan_purposes (purpose_id, purpose_name) VALUES
    (1,  'debt_consolidation'),
    (2,  'credit_card'),
    (3,  'home_improvement'),
    (4,  'other'),
    (5,  'major_purchase'),
    (6,  'medical'),
    (7,  'small_business'),
    (8,  'car'),
    (9,  'vacation'),
    (10, 'moving'),
    (11, 'house'),
    (12, 'wedding'),
    (13, 'renewable_energy'),
    (14, 'educational')
ON CONFLICT (purpose_id) DO NOTHING;