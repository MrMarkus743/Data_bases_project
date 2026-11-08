BEGIN;

INSERT INTO loan_purposes (purpose_id, purpose_name) VALUES
(1, 'debt_consolidation'),
(2, 'credit_card'),
(3, 'home_improvement'),
(4, 'other'),
(5, 'major_purchase'),
(6, 'small_business'),
(7, 'car'),
(8, 'medical'),
(9, 'moving'),
(10, 'vacation'),
(11, 'house'),
(12, 'wedding'),
(13, 'renewable_energy'),
(14, 'educational')
ON CONFLICT (purpose_id) DO NOTHING;

COMMIT;
