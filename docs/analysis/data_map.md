**Описание предметной области**

Датасет Lending Club описывает бизнес-область потребительского кредитования -- процесс выдачи, сопровождения и погашения займов физическим лицам. Система автоматизирует полный жизненный цикл займа: приём заявки, скоринг заёмщика, принятие кредитного решения, выдачу средств, сопровождение платежей и работу с просрочками и дефолтами. В основе лежит скоринговая модель: на момент выдачи фиксируется снимок кредитной истории и анкеты заёмщика, который затем используется для оценки риска. Финансовое состояние займа отслеживает остаток основного долга, платежи, просрочки и восстановления, а статус займа отражает его текущее положение. Отдельно выделены совместные заявки с доходами и скорингом созаёмщика, а также поручители и залоги как обеспечительные механизмы. Все изменения критичных таблиц фиксируются в журнале аудита для последующего контроля. Пользователи системы разделены по ролям: кредитный аналитик видит банковскую тайну и скоринг, но ПДн маскированы и аудит недоступен; оператор кредитования видит ПДн полностью и оформляет договоры, но не может менять скоринг и кредитную историю; системный аудитор имеет доступ только к журналу аудита. На основе данных принимаются кредитные решения, присваивается рейтинг и процентная ставка в зависимости от риск-профиля, ведётся мониторинг портфеля и просрочек, выявляются дефолты и оцениваются совместные заявки по совокупному доходу и скорингу созаёмщика.

**Легенда:**
- **Источник данных:** `Lending Club dataset` — данные из исходного датасета, при переименовании оригинальное название из датасета указано в скобках, `Faker` — сгенерированы фейкером, `Generated` — сгенерированы иным способом (например, audit-записи, вычисляемые поля);
- **Обязательность** — Да для NOT NULL или PK;
- **Уникальность** — Да для PK и UNIQUE;
- **Примечание** — категория (ПДн / коммерческая тайна / открытые).

| Источник данных | Сущность | Атрибут | Тип данных | Пример значения | Обязательность | Уникальность | Примечание |
|---|---|---|---|---|---|---|---|
| Generated | loan_purposes | purpose_id | smallint | 1 | Да | Да | открытые |
| Lending Club dataset (purpose) | loan_purposes | purpose_name | varchar(100) | debt_consolidation | Да | Да | открытые |
| Generated | clients | client_id | bigint | 1 | Да | Да | открытые |
| Lending Club dataset | clients | addr_state | char(2) | PA | Нет | Нет | ПДн |
| Lending Club dataset | clients | zip_code | char(5) | 190xx | Нет | Нет | ПДн |
| Generated | clients | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | clients | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | loans | loan_id | bigint | 1 | Да | Да | открытые |
| Generated | loans | client_id | bigint | 1 | Да | Нет | открытые |
| Generated | loans | purpose_id | smallint | 1 | Да | Нет | открытые |
| Lending Club dataset | loans | application_type | varchar(20) | Individual | Да | Нет | открытые |
| Lending Club dataset | loans | loan_amnt | numeric(12,2) | 3600.00 | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | funded_amnt | numeric(12,2) | 3600.00 | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | funded_amnt_inv | numeric(12,2) | 3600.00 | Да | Нет | коммерческая тайна |
| Lending Club dataset (term) | loans | term_months | smallint | 36 | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | int_rate | numeric(6,3) | 13.990 | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | installment | numeric(10,2) | 123.03 | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | grade | char(1) | C | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | sub_grade | varchar(3) | C4 | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | issue_d | date | 2015-12-01 | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | loan_status | varchar(40) | Fully Paid | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | pymnt_plan | char(1) | n | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | url | text | https://lendingclub.com/browse/loanDetail... | Нет | Нет | открытые |
| Lending Club dataset | loans | descr | text | We knew that using our credit cards... | Нет | Нет | ПДн |
| Lending Club dataset | loans | title | varchar(255) | Debt consolidation | Нет | Нет | ПДн |
| Lending Club dataset | loans | initial_list_status | char(1) | w | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | disbursement_method | varchar(20) | Cash | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | debt_settlement_flag | char(1) | N | Да | Нет | коммерческая тайна |
| Lending Club dataset | loans | annual_inc | numeric(14,2) | 55000.00 | Нет | Нет | ПДн |
| Lending Club dataset | loans | emp_title | varchar(255) | leadman | Нет | Нет | ПДн |
| Lending Club dataset | loans | emp_length | varchar(20) | 10+ years | Нет | Нет | ПДн |
| Lending Club dataset | loans | home_ownership | varchar(20) | MORTGAGE | Нет | Нет | открытые |
| Lending Club dataset | loans | verification_status | varchar(20) | Not Verified | Нет | Нет | коммерческая тайна |
| Generated | loans | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | loans | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | credit_profiles | profile_id | bigint | 1 | Да | Да | открытые |
| Generated | credit_profiles | loan_id | bigint | 1 | Да | Да | открытые |
| Lending Club dataset | credit_profiles | dti | numeric(6,2) | 5.91 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | delinq_2yrs | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | earliest_cr_line | date | 2003-08-01 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | fico_range_low | smallint | 675 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | fico_range_high | smallint | 679 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | inq_last_6mths | smallint | 1 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mths_since_last_delinq | smallint | 30 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mths_since_last_record | smallint | 106 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | open_acc | smallint | 7 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | pub_rec | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | revol_bal | numeric(14,2) | 2765.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | revol_util | numeric(6,2) | 29.70 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | total_acc | smallint | 13 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | collections_12_mths_ex_med | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mths_since_last_major_derog | smallint | 30 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | acc_now_delinq | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | tot_coll_amt | numeric(14,2) | 722.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | tot_cur_bal | numeric(14,2) | 144904.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | open_acc_6m | smallint | 2 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | open_act_il | smallint | 2 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | open_il_12m | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | open_il_24m | smallint | 1 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mths_since_rcnt_il | smallint | 21 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | total_bal_il | numeric(14,2) | 4981.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | il_util | numeric(6,2) | 36.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | open_rv_12m | smallint | 3 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | open_rv_24m | smallint | 3 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | max_bal_bc | numeric(14,2) | 722.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | all_util | numeric(6,2) | 34.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | total_rev_hi_lim | numeric(14,2) | 9300.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | inq_fi | smallint | 3 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | total_cu_tl | smallint | 1 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | inq_last_12m | smallint | 4 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | acc_open_past_24mths | smallint | 4 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | avg_cur_bal | numeric(14,2) | 20701.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | bc_open_to_buy | numeric(14,2) | 1506.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | bc_util | numeric(6,2) | 37.20 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | chargeoff_within_12_mths | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | delinq_amnt | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mo_sin_old_il_acct | smallint | 148 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mo_sin_old_rev_tl_op | smallint | 128 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mo_sin_rcnt_rev_tl_op | smallint | 3 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mo_sin_rcnt_tl | smallint | 3 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mort_acc | smallint | 1 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mths_since_recent_bc | smallint | 4 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mths_since_recent_bc_dlq | smallint | 69 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mths_since_recent_inq | smallint | 4 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | mths_since_recent_revol_delinq | smallint | 69 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_accts_ever_120_pd | smallint | 2 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_actv_bc_tl | smallint | 2 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_actv_rev_tl | smallint | 4 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_bc_sats | smallint | 2 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_bc_tl | smallint | 5 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_il_tl | smallint | 3 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_op_rev_tl | smallint | 4 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_rev_accts | smallint | 9 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_rev_tl_bal_gt_0 | smallint | 4 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_sats | smallint | 7 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_tl_120dpd_2m | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_tl_30dpd | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_tl_90g_dpd_24m | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | num_tl_op_past_12m | smallint | 3 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | pct_tl_nvr_dlq | numeric(6,2) | 76.90 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | percent_bc_gt_75 | numeric(6,2) | 0.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | pub_rec_bankruptcies | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | tax_liens | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | tot_hi_cred_lim | numeric(14,2) | 178050.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | total_bal_ex_mort | numeric(14,2) | 7746.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | total_bc_limit | numeric(14,2) | 2400.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | total_il_high_credit_limit | numeric(14,2) | 13734.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | last_fico_range_high | smallint | 564 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | last_fico_range_low | smallint | 560 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | credit_profiles | last_credit_pull_d | date | 2019-03-01 | Нет | Нет | коммерческая тайна |
| Generated | credit_profiles | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | credit_profiles | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | loan_financial_state | state_id | bigint | 1 | Да | Да | открытые |
| Generated | loan_financial_state | loan_id | bigint | 1 | Да | Да | открытые |
| Lending Club dataset | loan_financial_state | out_prncp | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | out_prncp_inv | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | total_pymnt | numeric(14,2) | 4421.72 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | total_pymnt_inv | numeric(14,2) | 4421.72 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | total_rec_prncp | numeric(14,2) | 3600.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | total_rec_int | numeric(14,2) | 821.72 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | total_rec_late_fee | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | recoveries | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | collection_recovery_fee | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | last_pymnt_d | date | 2019-01-01 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | last_pymnt_amnt | numeric(12,2) | 122.67 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | loan_financial_state | next_pymnt_d | date | 2019-04-01 | Нет | Нет | коммерческая тайна |
| Generated | loan_financial_state | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | loan_financial_state | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | joint_applications | joint_application_id | bigint | 1 | Да | Да | открытые |
| Generated | joint_applications | loan_id | bigint | 1 | Да | Да | открытые |
| Generated | joint_applications | co_client_id | bigint | 2 | Да | Нет | открытые |
| Lending Club dataset | joint_applications | annual_inc_joint | numeric(14,2) | 71000.00 | Нет | Нет | ПДн |
| Lending Club dataset | joint_applications | dti_joint | numeric(6,2) | 13.85 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | verification_status_joint | varchar(20) | Not Verified | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | revol_bal_joint | numeric(14,2) | 7101.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_fico_range_low | smallint | 610 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_fico_range_high | smallint | 614 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_earliest_cr_line | date | 2005-02-01 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_inq_last_6mths | smallint | 3 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_mort_acc | smallint | 1 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_open_acc | smallint | 14 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_revol_util | numeric(6,2) | 80.00 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_open_act_il | smallint | 11 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_num_rev_accts | smallint | 8 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_chargeoff_within_12_mths | smallint | 0 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_collections_12_mths_ex_med | smallint | 2 | Нет | Нет | коммерческая тайна |
| Lending Club dataset | joint_applications | sec_app_mths_since_last_major_derog | smallint | 37 | Нет | Нет | коммерческая тайна |
| Generated | joint_applications | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | joint_applications | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | guarantors | guarantor_id | bigint | 1 | Да | Да | открытые |
| Generated | guarantors | loan_id | bigint | 1 | Да | Нет | открытые |
| Faker | guarantors | full_name | varchar(255) | Ivan Ivanov | Да | Нет | ПДн |
| Faker | guarantors | passport_hash | char(64) | a3f5...9c2d (64 hex) | Да | Да (в составе loan_id, passport_hash) | ПДн |
| Faker | guarantors | phone | varchar(20) | +7 900 123-45-67 | Да | Нет | ПДн |
| Faker | guarantors | income | numeric(14,2) | 45000.00 | Нет | Нет | ПДн |
| Faker | guarantors | relationship | varchar(50) | Spouse | Нет | Нет | ПДн |
| Generated | guarantors | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | guarantors | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | collaterals | collateral_id | bigint | 1 | Да | Да | открытые |
| Generated | collaterals | loan_id | bigint | 1 | Да | Нет | открытые |
| Faker | collaterals | collateral_type | varchar(30) | Car | Да | Нет | открытые |
| Faker | collaterals | description | text | Toyota Camry 2018, VIN ... | Нет | Нет | ПДн |
| Faker | collaterals | appraised_value | numeric(14,2) | 850000.00 | Нет | Нет | коммерческая тайна |
| Faker | collaterals | vin | char(17) | XW8ZZZ61ZJG000001 | Нет | Нет | ПДн |
| Faker | collaterals | cadastral_number | varchar(30) | 77:01:0001001:1234 | Нет | Нет | ПДн |
| Generated | collaterals | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | collaterals | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | audit_log | audit_id | bigint | 1 | Да | Да | открытые |
| Generated | audit_log | table_name | varchar(63) | loans | Да | Нет | открытые |
| Generated | audit_log | record_id | bigint | 1 | Да | Нет | открытые |
| Generated | audit_log | operation_type | varchar(10) | UPDATE | Да | Нет | открытые |
| Generated | audit_log | changed_by | varchar(255) | etl_user | Да | Нет | открытые |
| Generated | audit_log | changed_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| Generated | audit_log | old_value | jsonb | {"loan_status":"Current"} | Нет | Нет | ПДн + коммерческая тайна (наследует) |
| Generated | audit_log | new_value | jsonb | {"loan_status":"Fully Paid"} | Нет | Нет | ПДн + коммерческая тайна (наследует) |

--- 