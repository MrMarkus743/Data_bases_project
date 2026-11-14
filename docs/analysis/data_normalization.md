# Выделение 9 сущностей:

| № | Сущность | Назначение | Связь |
|---|---|---|---|
| 1 | `loan_purposes` | справочник целей кредита | 1:N `loans` |
| 2 | `clients` | заёмщик | 1:N `loans`, 1:N `joint_applications` (как созаёмщик) |
| 3 | `loans` | центральная сущность -- заём | N:1 `clients`, N:1 `loan_purposes`; 1:1 `credit_profiles`, `loan_financial_state`, `joint_applications`; 1:N `guarantors`, `collaterals` |
| 4 | `credit_profiles` | снимок кредитной истории на момент выдачи | 1:1 `loans` (UNIQUE loan_id) |
| 5 | `loan_financial_state` | финансовое состояние займа | 1:1 `loans` (UNIQUE loan_id) |
| 6 | `joint_applications` | совместная заявка: доход и скоринг созаёмщика | 1:1 `loans` (UNIQUE loan_id), N:1 `clients` (co_client_id) |
| 7 | `guarantors` | поручители | N:1 `loans` |
| 8 | `collaterals` | залоги | N:1 `loans` |
| 9 | `audit_log` | журнал аудита изменений критичных таблиц | ссылается логически (table_name + record_id) |

# Индексы:

idx_loans_client_id — ускоряет выборку займов клиента. Типовой запрос «все займы заёмщика».      
idx_loans_purpose_id — ускоряет агрегацию по целям кредита.      
idx_joint_applications_co_client_id — поиск совместных заявок по созаёмщику.      
idx_collaterals_loan_id — выборка залогов по займу.
idx_audit_log_record (table_name, record_id) — история изменений конкретной записи.      
UNIQUE-ограничения на loan_id в credit_profiles, loan_financial_state, joint_applications автоматически создают уникальные индексы (1:1 доступ).

# Итоговые таблицы
## 1. `loan_purposes` — справочник целей

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `purpose_id` | `smallint` | PK, NOT NULL | Открытые |
| `purpose_name` | `varchar(100)` | NOT NULL, UNIQUE | Открытые |
---

## 2. `clients` — клиенты

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `client_id` | `bigint` | PK, NOT NULL | Открытые |
| `addr_state` | `char(2)` | — | ПДн (152-ФЗ) |
| `zip_code` | `char(5)` | CHECK ~ '^[0-9]{3}[0-9xX]{2}$'| ПДн (152-ФЗ) |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |

> Примечание 1: `client_id` генерируется; в датасете `member_id`. На практике `clients 1:1 loans`.
> Примечание 2: 'zip_code' char(5) — в исходном датасете код маскирован (954xx), хранится как строка фиксированной длины 5. Не использовать как int: ведущие нули и xx-суффикс делают числовое представление некорректным.
---

## 3. `loans` — займы

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `loan_id` | `bigint` | PK, NOT NULL | Открытые |
| `client_id` | `bigint` | FK - `clients.client_id`, NOT NULL | Открытые |
| `purpose_id` | `smallint` | FK - `loan_purposes.purpose_id`, NOT NULL | Открытые |
| `application_type` | `varchar(20)` | NOT NULL, CHECK IN ('Individual','Joint') | Открытые |
| `loan_amnt` | `numeric(12,2)` | NOT NULL, CHECK ≥ 0 | Коммерческая тайна |
| `funded_amnt` | `numeric(12,2)` | NOT NULL, CHECK ≥ 0 | Коммерческая тайна |
| `funded_amnt_inv` | `numeric(12,2)` | NOT NULL, CHECK >= 0 | Коммерческая тайна |
| `term_months` | `smallint` | NOT NULL, CHECK IN (36,60) | Коммерческая тайна |
| `int_rate` | `numeric(6,3)` | NOT NULL | Коммерческая тайна |
| `installment` | `numeric(10,2)` | NOT NULL, CHECK >= 0 | Коммерческая тайна |
| `grade` | `char(1)` | NOT NULL, CHECK IN ('A','B','C','D','E','F','G') | Коммерческая тайна |
| `sub_grade` | `varchar(3)` | NOT NULL | Коммерческая тайна |
| `issue_d` | `date` | NOT NULL | Коммерческая тайна |
| `loan_status` | `varchar(40)` | NOT NULL | Коммерческая тайна |
| `pymnt_plan` | `char(1)` | NOT NULL, CHECK IN ('n','y') | Коммерческая тайна |
| `url` | `text` | — | Открытые (внешняя ссылка) |
| `descr` | `text` | — | ПДн (152-ФЗ) |
| `title` | `varchar(255)` | — | ПДн (152-ФЗ) |
| `initial_list_status` | `char(1)` | NOT NULL | Коммерческая тайна |
| `disbursement_method` | `varchar(20)` | NOT NULL | Коммерческая тайна |
| `debt_settlement_flag` | `char(1)` | NOT NULL | Коммерческая тайна |
| `annual_inc` | `numeric(14,2)` | CHECK ≥ 0 | ПДн (152-ФЗ) |
| `emp_title` | `varchar(255)` | — | ПДн (152-ФЗ) |
| `emp_length` | `varchar(20)` | — | ПДн (152-ФЗ) |
| `home_ownership` | `varchar(20)` | — | Открытые |
| `verification_status` | `varchar(20)` | — | Коммерческая тайна |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |

> Примечание 1: grade транзитивно зависит от sub_grade. Оставлено в loans осознанно для упрощения запросов; при строгой 3НФ grade выносится в справочник sub_grades(sub_grade, grade).
> Примечание 2: Связь loan_id:client_id - 1:N на уровне БД. На практике 1:1 из-за отсутствия member_id в датасете. После дополнительного добавления записей клиентов связь может стать 1:N.
> Примечание 3: Поля annual_inc, emp_title, emp_length и home_ownership - неизменяемый скоринговый снимок анкеты на момент выдачи займа.
---

## 4. `credit_profiles` — скоринг и кредитная история (снимок на момент выдачи)
> [!CAUTION]
> *В сырых данных dti < 0 является техническим маркером отсутствия расчета; на этапе ETL такие значения трансформируются в NULL под ограничение CHECK >= 0.*

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `profile_id` | `bigint` | PK, NOT NULL | Открытые |
| `loan_id` | `bigint` | FK - `loans.loan_id`, NOT NULL, UNIQUE | Открытые |
| `dti` | `numeric(6,2)` | CHECK ≥ 0 или NULL| Коммерческая тайна |
| `delinq_2yrs` | `smallint` | — | Коммерческая тайна |
| `earliest_cr_line` | `date` | — | Коммерческая тайна |
| `fico_range_low` | `smallint` | — | Коммерческая тайна |
| `fico_range_high` | `smallint` | — | Коммерческая тайна |
| `inq_last_6mths` | `smallint` | — | Коммерческая тайна |
| `mths_since_last_delinq` | `smallint` | NULL | Коммерческая тайна |
| `mths_since_last_record` | `smallint` | NULL | Коммерческая тайна |
| `open_acc` | `smallint` | — | Коммерческая тайна |
| `pub_rec` | `smallint` | — | Коммерческая тайна |
| `revol_bal` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `revol_util` | `numeric(6,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `total_acc` | `smallint` | — | Коммерческая тайна |
| `collections_12_mths_ex_med` | `smallint` | — | Коммерческая тайна |
| `mths_since_last_major_derog` | `smallint` | NULL | Коммерческая тайна |
| `acc_now_delinq` | `smallint` | — | Коммерческая тайна |
| `tot_coll_amt` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `tot_cur_bal` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `open_acc_6m` | `smallint` | NULL | Коммерческая тайна |
| `open_act_il` | `smallint` | NULL | Коммерческая тайна |
| `open_il_12m` | `smallint` | NULL | Коммерческая тайна |
| `open_il_24m` | `smallint` | NULL | Коммерческая тайна |
| `mths_since_rcnt_il` | `smallint` | NULL | Коммерческая тайна |
| `total_bal_il` | `numeric(14,2)` | NULL, CHECK ≥ 0 | Коммерческая тайна |
| `il_util` | `numeric(6,2)` | NULL | Коммерческая тайна |
| `open_rv_12m` | `smallint` | NULL | Коммерческая тайна |
| `open_rv_24m` | `smallint` | NULL, CHECK ≥ 0 | Коммерческая тайна |
| `max_bal_bc` | `numeric(14,2)` | NULL, CHECK ≥ 0 | Коммерческая тайна |
| `all_util` | `numeric(6,2)` | NULL | Коммерческая тайна |
| `total_rev_hi_lim` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `inq_fi` | `smallint` | NULL | Коммерческая тайна |
| `total_cu_tl` | `smallint` | NULL | Коммерческая тайна |
| `inq_last_12m` | `smallint` | NULL | Коммерческая тайна |
| `acc_open_past_24mths` | `smallint` | — | Коммерческая тайна |
| `avg_cur_bal` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `bc_open_to_buy` | `numeric(14,2)` | — | Коммерческая тайна |
| `bc_util` | `numeric(6,2)` | — | Коммерческая тайна |
| `chargeoff_within_12_mths` | `smallint` | — | Коммерческая тайна |
| `delinq_amnt` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `mo_sin_old_il_acct` | `smallint` | — | Коммерческая тайна |
| `mo_sin_old_rev_tl_op` | `smallint` | — | Коммерческая тайна |
| `mo_sin_rcnt_rev_tl_op` | `smallint` | — | Коммерческая тайна |
| `mo_sin_rcnt_tl` | `smallint` | — | Коммерческая тайна |
| `mort_acc` | `smallint` | — | Коммерческая тайна |
| `mths_since_recent_bc` | `smallint` | — | Коммерческая тайна |
| `mths_since_recent_bc_dlq` | `smallint` | NULL | Коммерческая тайна |
| `mths_since_recent_inq` | `smallint` | NULL | Коммерческая тайна |
| `mths_since_recent_revol_delinq` | `smallint` | NULL | Коммерческая тайна |
| `num_accts_ever_120_pd` | `smallint` | — | Коммерческая тайна |
| `num_actv_bc_tl` | `smallint` | — | Коммерческая тайна |
| `num_actv_rev_tl` | `smallint` | — | Коммерческая тайна |
| `num_bc_sats` | `smallint` | — | Коммерческая тайна |
| `num_bc_tl` | `smallint` | — | Коммерческая тайна |
| `num_il_tl` | `smallint` | — | Коммерческая тайна |
| `num_op_rev_tl` | `smallint` | — | Коммерческая тайна |
| `num_rev_accts` | `smallint` | — | Коммерческая тайна |
| `num_rev_tl_bal_gt_0` | `smallint` | — | Коммерческая тайна |
| `num_sats` | `smallint` | — | Коммерческая тайна |
| `num_tl_120dpd_2m` | `smallint` | — | Коммерческая тайна |
| `num_tl_30dpd` | `smallint` | — | Коммерческая тайна |
| `num_tl_90g_dpd_24m` | `smallint` | — | Коммерческая тайна |
| `num_tl_op_past_12m` | `smallint` | — | Коммерческая тайна |
| `pct_tl_nvr_dlq` | `numeric(6,2)` | — | Коммерческая тайна |
| `percent_bc_gt_75` | `numeric(6,2)` | — | Коммерческая тайна |
| `pub_rec_bankruptcies` | `smallint` | — | Коммерческая тайна |
| `tax_liens` | `smallint` | — | Коммерческая тайна |
| `tot_hi_cred_lim` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `total_bal_ex_mort` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `total_bc_limit` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `total_il_high_credit_limit` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `last_fico_range_high` | `smallint` | — | Коммерческая тайна |
| `last_fico_range_low` | `smallint` | — | Коммерческая тайна |
| `last_credit_pull_d` | `date` | — | Коммерческая тайна |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
---

## 5. `loan_financial_state` — финансовое состояние займа

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `state_id` | `bigint` | PK, NOT NULL | Открытые |
| `loan_id` | `bigint` | FK - `loans.loan_id`, NOT NULL, UNIQUE | Открытые |
| `out_prncp` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `out_prncp_inv` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `total_pymnt` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `total_pymnt_inv` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `total_rec_prncp` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `total_rec_int` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `total_rec_late_fee` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `recoveries` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `collection_recovery_fee` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `last_pymnt_d` | `date` | — | Коммерческая тайна |
| `last_pymnt_amnt` | `numeric(12,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `next_pymnt_d` | `date` | NULL | Коммерческая тайна |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
---

## 6. `joint_applications` — совместные заявки

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `joint_application_id` | `bigint` | PK, NOT NULL | Открытые |
| `loan_id` | `bigint` | FK - `loans.loan_id`, NOT NULL, UNIQUE | Открытые |
| `co_client_id` | `bigint` | FK - `clients.client_id`, NOT NULL | Открытые |
| `annual_inc_joint` | `numeric(14,2)` | CHECK ≥ 0 | ПДн (152-ФЗ) |
| `dti_joint` | `numeric(6,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `verification_status_joint` | `varchar(20)` | — | Коммерческая тайна |
| `revol_bal_joint` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `sec_app_fico_range_low` | `smallint` | — | Коммерческая тайна |
| `sec_app_fico_range_high` | `smallint` | — | Коммерческая тайна |
| `sec_app_earliest_cr_line` | `date` | — | Коммерческая тайна |
| `sec_app_inq_last_6mths` | `smallint` | — | Коммерческая тайна |
| `sec_app_mort_acc` | `smallint` | — | Коммерческая тайна |
| `sec_app_open_acc` | `smallint` | — | Коммерческая тайна |
| `sec_app_revol_util` | `numeric(6,2)` | — | Коммерческая тайна |
| `sec_app_open_act_il` | `smallint` | — | Коммерческая тайна |
| `sec_app_num_rev_accts` | `smallint` | — | Коммерческая тайна |
| `sec_app_chargeoff_within_12_mths` | `smallint` | — | Коммерческая тайна |
| `sec_app_collections_12_mths_ex_med` | `smallint` | — | Коммерческая тайна |
| `sec_app_mths_since_last_major_derog` | `smallint` | NULL | Коммерческая тайна |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |

>Примечание: Ограничение "co_client_id ≠ основной заёмщик". Можно реализовать с помощью триггера или ограничить в коде приложения, которое будет вставлять данные.
---

## 7. `guarantors` — поручители (ТЗ)

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `guarantor_id` | `bigint` | PK, NOT NULL | Открытые |
| `loan_id` | `bigint` | FK - `loans.loan_id`, NOT NULL | Открытые |
| `full_name` | `varchar(255)` | NOT NULL | ПДн (152-ФЗ) |
| `passport_hash` | `char(64)` | NOT NULL | ПДн (152-ФЗ) |
| `phone` | `varchar(20)` | NOT NULL | ПДн (152-ФЗ) |
| `income` | `numeric(14,2)` | CHECK ≥ 0 | ПДн (152-ФЗ) |
| `relationship` | `varchar(50)` | — | ПДн (152-ФЗ) |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |

>Примечание: сделать составное ограничение UNIQUE (loan_id, passport_hash).
---

## 8. `collaterals` — залоги (ТЗ)

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `collateral_id` | `bigint` | PK, NOT NULL | Открытые |
| `loan_id` | `bigint` | FK - `loans.loan_id`, NOT NULL | Открытые |
| `collateral_type` | `varchar(30)` | NOT NULL | Открытые |
| `description` | `text` | — | ПДн (152-ФЗ) |
| `appraised_value` | `numeric(14,2)` | CHECK ≥ 0 | Коммерческая тайна |
| `vin` | `char(17)` | CHECK ~ '^[A-HJ-NPR-Z0-9]{17}$' | ПДн (152-ФЗ) |
| `cadastral_number` | `varchar(30)` | NULL | ПДн (152-ФЗ) |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
---

## 9. `audit_log` — аудит (ТЗ)

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `audit_id` | `bigint` | PK, NOT NULL | Открытые |
| `table_name` | `varchar(63)` | NOT NULL, CHECK IN ('clients','loans','credit_profiles','loan_financial_state','joint_applications','guarantors','collaterals','loan_purposes') | Открытые |
| `record_id` | `bigint` | NOT NULL | Открытые |
| `operation_type` | `varchar(10)` | NOT NULL, CHECK IN ('INSERT','UPDATE','DELETE') | Открытые |
| `changed_by` | `varchar(255)` | NOT NULL | Открытые |
| `changed_at` | `timestamp` | NOT NULL, DEFAULT now() | Открытые |
| `old_value` | `jsonb` | NULL | Наследует категорию `table_name` (ПДн + Коммерческая тайна) |
| `new_value` | `jsonb` | NULL | Наследует категорию `table_name` (ПДн + Коммерческая тайна) |
---