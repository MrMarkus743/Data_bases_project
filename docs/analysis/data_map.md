**Легенда:**
- **Обязательность** — Да для NOT NULL или PK;
- **Уникальность** — Да для PK и UNIQUE;
- **Примечание** — категория (ПДн / коммерческая тайна / открытые).

---
| Источник данных | Сущность | Атрибут | Тип данных | Пример значения | Обязательность | Уникальность | Примечание |
|---|---|---|---|---|---|---|---|
| loan_purposes | Справочник целей | purpose_id | smallint | 1 | Да | Да | открытые |
| loan_purposes | Справочник целей | purpose_name | varchar(100) | debt_consolidation | Да | Да | открытые |
| clients | Клиенты | client_id | bigint | 68407277 | Да | Да | открытые |
| clients | Клиенты | addr_state | char(2) | PA | Нет | Нет | ПДн |
| clients | Клиенты | zip_code | char(5) | 190xx | Нет | Нет | ПДн |
| clients | Клиенты | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| clients | Клиенты | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| loans | Займы | loan_id | bigint | 1001 | Да | Да | открытые |
| loans | Займы | client_id | bigint | 68407277 | Да | Нет | открытые |
| loans | Займы | purpose_id | smallint | 1 | Да | Нет | открытые |
| loans | Займы | application_type | varchar(20) | Individual | Да | Нет | открытые |
| loans | Займы | loan_amnt | numeric(12,2) | 3600.00 | Да | Нет | коммерческая тайна |
| loans | Займы | funded_amnt | numeric(12,2) | 3600.00 | Да | Нет | коммерческая тайна |
| loans | Займы | funded_amnt_inv | numeric(12,2) | 3600.00 | Да | Нет | коммерческая тайна |
| loans | Займы | term_months | smallint | 36 | Да | Нет | коммерческая тайна |
| loans | Займы | int_rate | numeric(6,3) | 13.990 | Да | Нет | коммерческая тайна |
| loans | Займы | installment | numeric(10,2) | 123.03 | Да | Нет | коммерческая тайна |
| loans | Займы | grade | char(1) | C | Да | Нет | коммерческая тайна |
| loans | Займы | sub_grade | varchar(3) | C4 | Да | Нет | коммерческая тайна |
| loans | Займы | issue_d | date | 2015-12-01 | Да | Нет | коммерческая тайна |
| loans | Займы | loan_status | varchar(40) | Fully Paid | Да | Нет | коммерческая тайна |
| loans | Займы | pymnt_plan | char(1) | n | Да | Нет | коммерческая тайна |
| loans | Займы | url | text | https://lendingclub.com/browse/loanDetail... | Нет | Нет | открытые |
| loans | Займы | descr | text | We knew that using our credit cards... | Нет | Нет | ПДн |
| loans | Займы | title | varchar(255) | Debt consolidation | Нет | Нет | ПДн |
| loans | Займы | initial_list_status | char(1) | w | Да | Нет | коммерческая тайна |
| loans | Займы | disbursement_method | varchar(20) | Cash | Да | Нет | коммерческая тайна |
| loans | Займы | debt_settlement_flag | char(1) | N | Да | Нет | коммерческая тайна |
| loans | Займы | annual_inc | numeric(14,2) | 55000.00 | Нет | Нет | ПДн |
| loans | Займы | emp_title | varchar(255) | leadman | Нет | Нет | ПДн |
| loans | Займы | emp_length | varchar(20) | 10+ years | Нет | Нет | ПДн |
| loans | Займы | home_ownership | varchar(20) | MORTGAGE | Нет | Нет | открытые |
| loans | Займы | verification_status | varchar(20) | Not Verified | Нет | Нет | коммерческая тайна |
| loans | Займы | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| loans | Займы | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| credit_profiles | Скоринг и кредитная история | profile_id | bigint | 1 | Да | Да | открытые |
| credit_profiles | Скоринг и кредитная история | loan_id | bigint | 1001 | Да | Да | открытые |
| credit_profiles | Скоринг и кредитная история | dti | numeric(6,2) | 5.91 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | delinq_2yrs | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | earliest_cr_line | date | 2003-08-01 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | fico_range_low | smallint | 675 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | fico_range_high | smallint | 679 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | inq_last_6mths | smallint | 1 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mths_since_last_delinq | smallint | 30 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mths_since_last_record | smallint | 106 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | open_acc | smallint | 7 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | pub_rec | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | revol_bal | numeric(14,2) | 2765.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | revol_util | numeric(6,2) | 29.70 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | total_acc | smallint | 13 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | collections_12_mths_ex_med | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mths_since_last_major_derog | smallint | 30 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | acc_now_delinq | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | tot_coll_amt | numeric(14,2) | 722.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | tot_cur_bal | numeric(14,2) | 144904.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | open_acc_6m | smallint | 2 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | open_act_il | smallint | 2 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | open_il_12m | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | open_il_24m | smallint | 1 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mths_since_rcnt_il | smallint | 21 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | total_bal_il | numeric(14,2) | 4981.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | il_util | numeric(6,2) | 36.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | open_rv_12m | smallint | 3 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | open_rv_24m | smallint | 3 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | max_bal_bc | numeric(14,2) | 722.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | all_util | numeric(6,2) | 34.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | total_rev_hi_lim | numeric(14,2) | 9300.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | inq_fi | smallint | 3 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | total_cu_tl | smallint | 1 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | inq_last_12m | smallint | 4 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | acc_open_past_24mths | smallint | 4 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | avg_cur_bal | numeric(14,2) | 20701.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | bc_open_to_buy | numeric(14,2) | 1506.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | bc_util | numeric(6,2) | 37.20 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | chargeoff_within_12_mths | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | delinq_amnt | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mo_sin_old_il_acct | smallint | 148 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mo_sin_old_rev_tl_op | smallint | 128 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mo_sin_rcnt_rev_tl_op | smallint | 3 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mo_sin_rcnt_tl | smallint | 3 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mort_acc | smallint | 1 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mths_since_recent_bc | smallint | 4 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mths_since_recent_bc_dlq | smallint | 69 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mths_since_recent_inq | smallint | 4 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | mths_since_recent_revol_delinq | smallint | 69 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_accts_ever_120_pd | smallint | 2 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_actv_bc_tl | smallint | 2 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_actv_rev_tl | smallint | 4 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_bc_sats | smallint | 2 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_bc_tl | smallint | 5 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_il_tl | smallint | 3 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_op_rev_tl | smallint | 4 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_rev_accts | smallint | 9 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_rev_tl_bal_gt_0 | smallint | 4 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_sats | smallint | 7 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_tl_120dpd_2m | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_tl_30dpd | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_tl_90g_dpd_24m | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | num_tl_op_past_12m | smallint | 3 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | pct_tl_nvr_dlq | numeric(6,2) | 76.90 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | percent_bc_gt_75 | numeric(6,2) | 0.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | pub_rec_bankruptcies | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | tax_liens | smallint | 0 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | tot_hi_cred_lim | numeric(14,2) | 178050.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | total_bal_ex_mort | numeric(14,2) | 7746.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | total_bc_limit | numeric(14,2) | 2400.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | total_il_high_credit_limit | numeric(14,2) | 13734.00 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | last_fico_range_high | smallint | 564 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | last_fico_range_low | smallint | 560 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | last_credit_pull_d | date | 2019-03-01 | Нет | Нет | коммерческая тайна |
| credit_profiles | Скоринг и кредитная история | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| credit_profiles | Скоринг и кредитная история | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| loan_financial_state | Финансовое состояние займа | state_id | bigint | 1 | Да | Да | открытые |
| loan_financial_state | Финансовое состояние займа | loan_id | bigint | 1001 | Да | Да | открытые |
| loan_financial_state | Финансовое состояние займа | out_prncp | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | out_prncp_inv | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | total_pymnt | numeric(14,2) | 4421.72 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | total_pymnt_inv | numeric(14,2) | 4421.72 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | total_rec_prncp | numeric(14,2) | 3600.00 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | total_rec_int | numeric(14,2) | 821.72 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | total_rec_late_fee | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | recoveries | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | collection_recovery_fee | numeric(14,2) | 0.00 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | last_pymnt_d | date | 2019-01-01 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | last_pymnt_amnt | numeric(12,2) | 122.67 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | next_pymnt_d | date | 2019-04-01 | Нет | Нет | коммерческая тайна |
| loan_financial_state | Финансовое состояние займа | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| loan_financial_state | Финансовое состояние займа | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| joint_applications | Совместные заявки | joint_application_id | bigint | 1 | Да | Да | открытые |
| joint_applications | Совместные заявки | loan_id | bigint | 1001 | Да | Да | открытые |
| joint_applications | Совместные заявки | co_client_id | bigint | 68407278 | Да | Нет | открытые |
| joint_applications | Совместные заявки | annual_inc_joint | numeric(14,2) | 71000.00 | Нет | Нет | ПДн |
| joint_applications | Совместные заявки | dti_joint | numeric(6,2) | 13.85 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | verification_status_joint | varchar(20) | Not Verified | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | revol_bal_joint | numeric(14,2) | 7101.00 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_fico_range_low | smallint | 610 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_fico_range_high | smallint | 614 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_earliest_cr_line | date | 2005-02-01 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_inq_last_6mths | smallint | 3 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_mort_acc | smallint | 1 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_open_acc | smallint | 14 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_revol_util | numeric(6,2) | 80.00 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_open_act_il | smallint | 11 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_num_rev_accts | smallint | 8 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_chargeoff_within_12_mths | smallint | 0 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_collections_12_mths_ex_med | smallint | 2 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | sec_app_mths_since_last_major_derog | smallint | 37 | Нет | Нет | коммерческая тайна |
| joint_applications | Совместные заявки | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| joint_applications | Совместные заявки | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| guarantors | Поручители | guarantor_id | bigint | 1 | Да | Да | открытые |
| guarantors | Поручители | loan_id | bigint | 1001 | Да | Нет | открытые |
| guarantors | Поручители | full_name | varchar(255) | Иванов Иван Иванович | Да | Нет | ПДн |
| guarantors | Поручители | passport_hash | char(64) | a3f5...9c2d (64 hex) | Да | Да (в составе loan_id, passport_hash) | ПДн |
| guarantors | Поручители | phone | varchar(20) | +7 900 123-45-67 | Да | Нет | ПДн |
| guarantors | Поручители | income | numeric(14,2) | 45000.00 | Нет | Нет | ПДн |
| guarantors | Поручители | relationship | varchar(50) | Супруг(а) | Нет | Нет | ПДн |
| guarantors | Поручители | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| guarantors | Поручители | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| collaterals | Залоги | collateral_id | bigint | 1 | Да | Да | открытые |
| collaterals | Залоги | loan_id | bigint | 1001 | Да | Нет | открытые |
| collaterals | Залоги | collateral_type | varchar(30) | Автомобиль | Да | Нет | открытые |
| collaterals | Залоги | description | text | Toyota Camry 2018, VIN ... | Нет | Нет | ПДн |
| collaterals | Залоги | appraised_value | numeric(14,2) | 850000.00 | Нет | Нет | коммерческая тайна |
| collaterals | Залоги | vin | char(17) | XW8ZZZ61ZJG000001 | Нет | Нет | ПДн |
| collaterals | Залоги | cadastral_number | varchar(30) | 77:01:0001001:1234 | Нет | Нет | ПДн |
| collaterals | Залоги | created_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| collaterals | Залоги | updated_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| audit_log | Аудит | audit_id | bigint | 1 | Да | Да | открытые |
| audit_log | Аудит | table_name | varchar(63) | loans | Да | Нет | открытые |
| audit_log | Аудит | record_id | bigint | 1001 | Да | Нет | открытые |
| audit_log | Аудит | operation | varchar(10) | UPDATE | Да | Нет | открытые |
| audit_log | Аудит | changed_by | varchar(255) | etl_user | Да | Нет | ПДн |
| audit_log | Аудит | changed_at | timestamp | 2024-01-15 10:00:00 | Да | Нет | открытые |
| audit_log | Аудит | old_value | jsonb | {"loan_status":"Current"} | Нет | Нет | ПДн + коммерческая тайна (наследует) |
| audit_log | Аудит | new_value | jsonb | {"loan_status":"Fully Paid"} | Нет | Нет | ПДн + коммерческая тайна (наследует) |