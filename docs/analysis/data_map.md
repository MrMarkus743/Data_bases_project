> [!NOTE]
> **Статус:** Утверждено к разработке DDL<br>
> **Дата утверждения:** 31.10.2026<br>
> **Ответственные:**
> * 🟢 **DBA** (@dkovyaboba) — валидация типов данных, целостности и ограничений
> * 🔵 **Developer** (@MrMarkus743) — сверка маппинга колонок Lending Club и генерации Faker
> * 🟣 **Analyst** (@ProgCodTim) — концептуальная модель и разметка 152-ФЗ
---

## 1. `loan_purposes` — справочник целей

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `purpose_id` | `smallint` | PK, NOT NULL | Общедоступные |
| `purpose_name` | `varchar(100)` | NOT NULL, UNIQUE | Общедоступные |
---

## 2. `clients` — клиенты

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `client_id` | `bigint` | PK, NOT NULL | Общедоступные |
| `addr_state` | `char(2)` | — | ПДн (152-ФЗ) |
| `zip_code` | `char(5)` | CHECK (zip_code ~ '^[0-9]{3}[0-9xX]{2}$') | ПДн (152-ФЗ) |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |

> Примечание 1: client_id генерируется; в датасете member_id.

> Примечание 2: `member_id` в исходном датасете полностью пустой (0% заполнения), поэтому `client_id` генерируется суррогатным ключом (SERIAL/IDENTITY). Маппинг `member_id` → `client_id` не выполняется.

> Примечание 3: `zip_code` char(5) — в исходном датасете код маскирован (954xx), хранится как строка фиксированной длины 5. Не использовать как int: ведущие нули и xx-суффикс делают числовое представление некорректным.
---

## 3. `loans` — займы

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `loan_id` | `bigint` | PK, NOT NULL | Общедоступные |
| `client_id` | `bigint` | FK → `clients.client_id`, NOT NULL | Общедоступные |
| `purpose_id` | `smallint` | FK → `loan_purposes.purpose_id`, NOT NULL | Общедоступные |
| `application_type` | `varchar(20)` | NOT NULL, CHECK IN ('Individual','Joint') | Общедоступные |
| `loan_amnt` | `numeric(12,2)` | NOT NULL, CHECK ≥ 0 | Банковская тайна |
| `funded_amnt` | `numeric(12,2)` | NOT NULL, CHECK ≥ 0 | Банковская тайна |
| `funded_amnt_inv` | `numeric(12,2)` | NOT NULL, CHECK >= 0 | Банковская тайна |
| `term_months` | `smallint` | NOT NULL, CHECK IN (36,60) | Банковская тайна |
| `int_rate` | `numeric(6,3)` | NOT NULL | Банковская тайна |
| `installment` | `numeric(10,2)` | NOT NULL, CHECK >= 0 | Банковская тайна |
| `grade` | `char(1)` | NOT NULL, CHECK IN ('A','B','C','D','E','F','G') | Банковская тайна |
| `sub_grade` | `varchar(3)` | NOT NULL | Банковская тайна |
| `issue_d` | `date` | NOT NULL | Банковская тайна |
| `loan_status` | `varchar(40)` | NOT NULL | Банковская тайна |
| `pymnt_plan` | `char(1)` | NOT NULL, CHECK IN ('n','y') | Банковская тайна |
| `url` | `text` | — | Общедоступные (внешняя ссылка) |
| `descr` | `text` | — | ПДн (152-ФЗ) |
| `title` | `varchar(255)` | — | ПДн (152-ФЗ) |
| `initial_list_status` | `char(1)` | NOT NULL | Банковская тайна |
| `disbursement_method` | `varchar(20)` | NOT NULL | Банковская тайна |
| `debt_settlement_flag` | `char(1)` | NOT NULL | Банковская тайна |
| `annual_inc` | `numeric(14,2)` | CHECK ≥ 0 | ПДн (152-ФЗ) |
| `emp_title` | `varchar(255)` | — | ПДн (152-ФЗ) |
| `emp_length` | `varchar(20)` | — | ПДн (152-ФЗ) |
| `home_ownership` | `varchar(20)` | — | Общедоступные |
| `verification_status` | `varchar(20)` | — | Банковская тайна |
| `policy_code` | `smallint` | NOT NULL, CHECK IN (1,2) | Банковская тайна |
| `hardship_flag` | `char(1)` | NOT NULL, CHECK IN ('N','Y') | Банковская тайна |
| `hardship_type` | `varchar(50)` | NULL | Банковская тайна |
| `hardship_reason` | `varchar(50)` | NULL | Банковская тайна |
| `hardship_status` | `varchar(20)` | NULL | Банковская тайна |
| `deferral_term` | `smallint` | NULL | Банковская тайна |
| `hardship_amount` | `numeric(12,2)` | NULL, CHECK ≥ 0 | Банковская тайна |
| `hardship_start_date` | `date` | NULL | Банковская тайна |
| `hardship_end_date` | `date` | NULL | Банковская тайна |
| `payment_plan_start_date` | `date` | NULL | Банковская тайна |
| `hardship_length` | `smallint` | NULL | Банковская тайна |
| `hardship_dpd` | `smallint` | NULL | Банковская тайна |
| `hardship_loan_status` | `varchar(40)` | NULL | Банковская тайна |
| `orig_projected_additional_accrued_interest` | `numeric(12,2)` | NULL, CHECK ≥ 0 | Банковская тайна |
| `hardship_payoff_balance_amount` | `numeric(14,2)` | NULL, CHECK ≥ 0 | Банковская тайна |
| `hardship_last_payment_amount` | `numeric(12,2)` | NULL, CHECK ≥ 0 | Банковская тайна |
| `debt_settlement_flag_date` | `date` | NULL | Банковская тайна |
| `settlement_status` | `varchar(20)` | NULL | Банковская тайна |
| `settlement_date` | `date` | NULL | Банковская тайна |
| `settlement_amount` | `numeric(14,2)` | NULL, CHECK ≥ 0 | Банковская тайна |
| `settlement_percentage` | `numeric(6,2)` | NULL | Банковская тайна |
| `settlement_term` | `smallint` | NULL | Банковская тайна |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |

> Примечание 1: grade транзитивно зависит от sub_grade. Оставлено в loans осознанно для упрощения запросов; при строгой 3НФ grade выносится в справочник sub_grades(sub_grade, grade).

> Примечание 2: Связь loan_id:client_id - 1:N на уровне БД.

> Примечание 3: Поля annual_inc, emp_title, emp_length и home_ownership - неизменяемый скоринговый снимок анкеты на момент выдачи займа.

> Примечание 4: Поле `term` в исходном CSV приходит как строка '36 months'/'60 months', требует парсинга в `smallint` (term_months) на этапе ETL.

> Примечание 5: Поля `issue_d`, `earliest_cr_line`, `last_pymnt_d`, `next_pymnt_d`, `last_credit_pull_d`, `debt_settlement_flag_date`, `settlement_date`, `hardship_start_date`, `hardship_end_date`, `payment_plan_start_date` в исходном CSV приходят в формате MMM-YYYY (например, 'Dec-2015'), требуют парсинга в `DATE` на этапе ETL.

> Примечание 6: Поля hardship_* и settlement_* заполнены частично (0.4–1.5% в датасете), поэтому допускают NULL.

> Примечание 7: Поле `int_rate` в исходном датасете содержит пробелы и знак '%' (' 10.65%'). На этапе ETL требует очистки для numeric(6,3).
---

## 4. `credit_profiles` — скоринг и кредитная история (снимок на момент выдачи)
> [!CAUTION]
> *В сырых данных dti < 0 является техническим маркером отсутствия расчета; на этапе ETL такие значения трансформируются в NULL под ограничение CHECK >= 0.*

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `profile_id` | `bigint` | PK, NOT NULL | Общедоступные |
| `loan_id` | `bigint` | FK → `loans.loan_id`, NOT NULL, UNIQUE | Общедоступные |
| `dti` | `numeric(6,2)` | CHECK (dti >= 0 OR dti IS NULL) | Банковская тайна |
| `delinq_2yrs` | `smallint` | — | Банковская тайна |
| `earliest_cr_line` | `date` | — | Банковская тайна |
| `fico_range_low` | `smallint` | — | Банковская тайна |
| `fico_range_high` | `smallint` | — | Банковская тайна |
| `inq_last_6mths` | `smallint` | — | Банковская тайна |
| `mths_since_last_delinq` | `smallint` | NULL | Банковская тайна |
| `mths_since_last_record` | `smallint` | NULL | Банковская тайна |
| `open_acc` | `smallint` | — | Банковская тайна |
| `pub_rec` | `smallint` | — | Банковская тайна |
| `revol_bal` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `revol_util` | `numeric(6,2)` | CHECK ≥ 0 | Банковская тайна |
| `total_acc` | `smallint` | — | Банковская тайна |
| `collections_12_mths_ex_med` | `smallint` | — | Банковская тайна |
| `mths_since_last_major_derog` | `smallint` | NULL | Банковская тайна |
| `acc_now_delinq` | `smallint` | — | Банковская тайна |
| `tot_coll_amt` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `tot_cur_bal` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `open_acc_6m` | `smallint` | NULL | Банковская тайна |
| `open_act_il` | `smallint` | NULL | Банковская тайна |
| `open_il_12m` | `smallint` | NULL | Банковская тайна |
| `open_il_24m` | `smallint` | NULL | Банковская тайна |
| `mths_since_rcnt_il` | `smallint` | NULL | Банковская тайна |
| `total_bal_il` | `numeric(14,2)` | NULL, CHECK ≥ 0 | Банковская тайна |
| `il_util` | `numeric(6,2)` | NULL | Банковская тайна |
| `open_rv_12m` | `smallint` | NULL | Банковская тайна |
| `open_rv_24m` | `smallint` | NULL, CHECK ≥ 0 | Банковская тайна |
| `max_bal_bc` | `numeric(14,2)` | NULL, CHECK ≥ 0 | Банковская тайна |
| `all_util` | `numeric(6,2)` | NULL | Банковская тайна |
| `total_rev_hi_lim` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `inq_fi` | `smallint` | NULL | Банковская тайна |
| `total_cu_tl` | `smallint` | NULL | Банковская тайна |
| `inq_last_12m` | `smallint` | NULL | Банковская тайна |
| `acc_open_past_24mths` | `smallint` | — | Банковская тайна |
| `avg_cur_bal` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `bc_open_to_buy` | `numeric(14,2)` | — | Банковская тайна |
| `bc_util` | `numeric(6,2)` | — | Банковская тайна |
| `chargeoff_within_12_mths` | `smallint` | — | Банковская тайна |
| `delinq_amnt` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `mo_sin_old_il_acct` | `smallint` | — | Банковская тайна |
| `mo_sin_old_rev_tl_op` | `smallint` | — | Банковская тайна |
| `mo_sin_rcnt_rev_tl_op` | `smallint` | — | Банковская тайна |
| `mo_sin_rcnt_tl` | `smallint` | — | Банковская тайна |
| `mort_acc` | `smallint` | — | Банковская тайна |
| `mths_since_recent_bc` | `smallint` | — | Банковская тайна |
| `mths_since_recent_bc_dlq` | `smallint` | NULL | Банковская тайна |
| `mths_since_recent_inq` | `smallint` | NULL | Банковская тайна |
| `mths_since_recent_revol_delinq` | `smallint` | NULL | Банковская тайна |
| `num_accts_ever_120_pd` | `smallint` | — | Банковская тайна |
| `num_actv_bc_tl` | `smallint` | — | Банковская тайна |
| `num_actv_rev_tl` | `smallint` | — | Банковская тайна |
| `num_bc_sats` | `smallint` | — | Банковская тайна |
| `num_bc_tl` | `smallint` | — | Банковская тайна |
| `num_il_tl` | `smallint` | — | Банковская тайна |
| `num_op_rev_tl` | `smallint` | — | Банковская тайна |
| `num_rev_accts` | `smallint` | — | Банковская тайна |
| `num_rev_tl_bal_gt_0` | `smallint` | — | Банковская тайна |
| `num_sats` | `smallint` | — | Банковская тайна |
| `num_tl_120dpd_2m` | `smallint` | — | Банковская тайна |
| `num_tl_30dpd` | `smallint` | — | Банковская тайна |
| `num_tl_90g_dpd_24m` | `smallint` | — | Банковская тайна |
| `num_tl_op_past_12m` | `smallint` | — | Банковская тайна |
| `pct_tl_nvr_dlq` | `numeric(6,2)` | — | Банковская тайна |
| `percent_bc_gt_75` | `numeric(6,2)` | — | Банковская тайна |
| `pub_rec_bankruptcies` | `smallint` | — | Банковская тайна |
| `tax_liens` | `smallint` | — | Банковская тайна |
| `tot_hi_cred_lim` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `total_bal_ex_mort` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `total_bc_limit` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `total_il_high_credit_limit` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `last_fico_range_high` | `smallint` | — | Банковская тайна |
| `last_fico_range_low` | `smallint` | — | Банковская тайна |
| `last_credit_pull_d` | `date` | — | Банковская тайна |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
---
> Примечание: Поля с процентными ставками (например, revol_util, il_util, all_util, bc_util, pct_tl_nvr_dlq, percent_bc_gt_75) в исходном CSV могут содержать знак %. На этапе ETL требуется очистка строки от знака % и приведение к типу numeric.

## 5. `loan_financial_state` — финансовое состояние займа

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `state_id` | `bigint` | PK, NOT NULL | Общедоступные |
| `loan_id` | `bigint` | FK → `loans.loan_id`, NOT NULL, UNIQUE | Общедоступные |
| `out_prncp` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `out_prncp_inv` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `total_pymnt` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `total_pymnt_inv` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `total_rec_prncp` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `total_rec_int` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `total_rec_late_fee` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `recoveries` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `collection_recovery_fee` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `last_pymnt_d` | `date` | — | Банковская тайна |
| `last_pymnt_amnt` | `numeric(12,2)` | CHECK ≥ 0 | Банковская тайна |
| `next_pymnt_d` | `date` | NULL | Банковская тайна |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
---

## 6. `joint_applications` — совместные заявки

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `joint_application_id` | `bigint` | PK, NOT NULL | Общедоступные |
| `loan_id` | `bigint` | FK → `loans.loan_id`, NOT NULL, UNIQUE | Общедоступные |
| `co_client_id` | `bigint` | FK → `clients.client_id`, NOT NULL | Общедоступные |
| `annual_inc_joint` | `numeric(14,2)` | CHECK ≥ 0 | ПДн (152-ФЗ) |
| `dti_joint` | `numeric(6,2)` | CHECK (dti_joint >= 0 OR dti_joint IS NULL) | Банковская тайна |
| `verification_status_joint` | `varchar(20)` | — | Банковская тайна |
| `revol_bal_joint` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `sec_app_fico_range_low` | `smallint` | — | Банковская тайна |
| `sec_app_fico_range_high` | `smallint` | — | Банковская тайна |
| `sec_app_earliest_cr_line` | `date` | — | Банковская тайна |
| `sec_app_inq_last_6mths` | `smallint` | — | Банковская тайна |
| `sec_app_mort_acc` | `smallint` | — | Банковская тайна |
| `sec_app_open_acc` | `smallint` | — | Банковская тайна |
| `sec_app_revol_util` | `numeric(6,2)` | — | Банковская тайна |
| `sec_app_open_act_il` | `smallint` | — | Банковская тайна |
| `sec_app_num_rev_accts` | `smallint` | — | Банковская тайна |
| `sec_app_chargeoff_within_12_mths` | `smallint` | — | Банковская тайна |
| `sec_app_collections_12_mths_ex_med` | `smallint` | — | Банковская тайна |
| `sec_app_mths_since_last_major_derog` | `smallint` | NULL | Банковская тайна |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |

> Примечание 1: Ограничение "co_client_id ≠ основной заёмщик". Можно реализовать с помощью триггера или ограничить в коде приложения, которое будет вставлять данные.

> Примечание 2: Поле sec_app_revol_util в исходном CSV может содержать знак %. На этапе ETL требуется очистка строки от знака % и приведение к типу numeric.
---

## 7. `guarantors` — поручители (ТЗ)

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `guarantor_id` | `bigint` | PK, NOT NULL | Общедоступные |
| `loan_id` | `bigint` | FK → `loans.loan_id`, NOT NULL | Общедоступные |
| `full_name` | `varchar(255)` | NOT NULL | ПДн (152-ФЗ) |
| `passport_hash` | `char(64)` | NOT NULL, UNIQUE (loan_id, passport_hash) | ПДн (152-ФЗ) |
| `phone` | `varchar(20)` | NOT NULL | ПДн (152-ФЗ) |
| `income` | `numeric(14,2)` | CHECK ≥ 0 | ПДн (152-ФЗ) |
| `relationship` | `varchar(50)` | — | ПДн (152-ФЗ) |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |

> Примечание 1: составное ограничение UNIQUE (loan_id, passport_hash) задано на уровне таблицы (не только в примечании).

> Примечание 2: таблица отсутствует в Lending Club; поля `full_name`, `phone`, `income`, `relationship` и `passport_hash` формируются генератором синтетических данных (Faker) в соответствии со 152-ФЗ.
---

## 8. `collaterals` — залоги (ТЗ)

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `collateral_id` | `bigint` | PK, NOT NULL | Общедоступные |
| `loan_id` | `bigint` | FK → `loans.loan_id`, NOT NULL | Общедоступные |
| `collateral_type` | `varchar(30)` | NOT NULL | Общедоступные |
| `description` | `text` | — | ПДн (152-ФЗ) |
| `appraised_value` | `numeric(14,2)` | CHECK ≥ 0 | Банковская тайна |
| `vin` | `char(17)` | NULL, CHECK (vin ~ '^[A-HJ-NPR-Z0-9]{17}$') | ПДн (152-ФЗ) |
| `cadastral_number` | `varchar(30)` | NULL | ПДн (152-ФЗ) |
| `created_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
| `updated_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |

> Примечание: таблица отсутствует в Lending Club; поля `collateral_type`, `description`, `appraised_value`, `vin` и `cadastral_number` генерируются Faker для выполнения условий ТЗ по залогам.
---

## 9. `audit_log` — аудит (ТЗ)

| Поле | Тип | Ограничения | Категория |
|---|---|---|---|
| `audit_id` | `bigint` | PK, NOT NULL | Общедоступные |
| `table_name` | `varchar(63)` | NOT NULL, CHECK IN ('clients','loans','credit_profiles','loan_financial_state','joint_applications','guarantors','collaterals','loan_purposes') | Общедоступные |
| `record_id` | `bigint` | NOT NULL | Общедоступные |
| `operation` | `varchar(10)` | NOT NULL, CHECK IN ('INSERT','UPDATE','DELETE') | Общедоступные |
| `changed_by` | `varchar(255)` | NOT NULL — заполняется триггером из session_user, DEFAULT не требуется | Общедоступные |
| `changed_at` | `timestamp` | NOT NULL, DEFAULT now() | Общедоступные |
| `old_value` | `jsonb` | NULL | Наследует категорию `table_name` (ПДн + Банковская тайна) |
| `new_value` | `jsonb` | NULL | Наследует категорию `table_name` (ПДн + Банковская тайна) |

> [!CAUTION]
> *Регламент ETL: скрипт прямой загрузки данных в audit_log ничего не пишет. Таблица наполняется исключительно триггерами СУБД (triggers_functions.sql). На момент выполнения первичной пакетной заливки CSV триггеры аудита должны быть отключены (DISABLE TRIGGER) либо создаваться строго после завершения загрузки.*
---
