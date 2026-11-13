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

# PK, FK

| № | Сущность | Первичный ключ (PK) | Внешние ключи (FK) |
|---|---|---|---|
| 1 | `loan_purposes` | `purpose_id`| — |
| 2 | `clients` | `client_id`| — |
| 3 | `loans` | `loan_id`| `client_id` - `clients.client_id`; `purpose_id` - `loan_purposes.purpose_id` |
| 4 | `credit_profiles` | `profile_id`| `loan_id` - `loans.loan_id` (1:1, UNIQUE) |
| 5 | `loan_financial_state` | `state_id` | `loan_id` - `loans.loan_id` (1:1, UNIQUE) |
| 6 | `joint_applications` | `joint_application_id`| `loan_id` → `loans.loan_id` (1:1, UNIQUE); `co_client_id` - `clients.client_id` |
| 7 | `guarantors` | `guarantor_id`| `loan_id` - `loans.loan_id` (1:N) |
| 8 | `collaterals` | `collateral_id`| `loan_id` - `loans.loan_id` (1:N) |
| 9 | `audit_log` | `audit_id` | Логическая ссылка `(table_name, record_id)` - `<table_name>.<PK>`, не FK|

# Ограничения CHECK, UNIQUE, NOT NULL 

| № | Сущность | Атрибут | CHECK | UNIQUE | NOT NULL |
|---:|---|---|---|---|---|
| 1 | `loan_purposes` | `purpose_id` | — | + (PK) | + (PK) |
| 2 | `loan_purposes` | `purpose_name` | — | + | + |
| 3 | `clients` | `client_id` | — | + (PK) | + (PK) |
| 4 | `clients` | `addr_state` | — | — | — |
| 5 | `clients` | `zip_code` | + `~ '^[0-9]{3}[0-9xX]{2}$'` | — | — |
| 6 | `clients` | `created_at` | — | — | + DEFAULT now() |
| 7 | `clients` | `updated_at` | — | — | + DEFAULT now() |
| 8 | `loans` | `loan_id` | — | + (PK) | + (PK) |
| 9 | `loans` | `client_id` | — | — | + (FK) |
| 10 | `loans` | `purpose_id` | — | — | + (FK) |
| 11 | `loans` | `application_type` | + `IN ('Individual','Joint')` | — | + |
| 12 | `loans` | `loan_amnt` | + `>= 0` | — | + |
| 13 | `loans` | `funded_amnt` | + `>= 0` | — | + |
| 14 | `loans` | `funded_amnt_inv` | + `>= 0` | — | + |
| 15 | `loans` | `term_months` | + `IN (36, 60)` | — | + |
| 16 | `loans` | `int_rate` | — | — | + |
| 17 | `loans` | `installment` | + `>= 0` | — | + |
| 18 | `loans` | `grade` | + `IN ('A'…'G')` | — | + |
| 19 | `loans` | `sub_grade` | — | — | + |
| 20 | `loans` | `issue_d` | — | — | + |
| 21 | `loans` | `loan_status` | — | — | + |
| 22 | `loans` | `pymnt_plan` | + `IN ('n','y')` | — | + |
| 23 | `loans` | `url` | — | — | — |
| 24 | `loans` | `descr` | — | — | — |
| 25 | `loans` | `title` | — | — | — |
| 26 | `loans` | `initial_list_status` | — | — | + |
| 27 | `loans` | `disbursement_method` | — | — | + |
| 28 | `loans` | `debt_settlement_flag` | — | — | + |
| 29 | `loans` | `annual_inc` | + `>= 0` | — | — |
| 30 | `loans` | `emp_title` | — | — | — |
| 31 | `loans` | `emp_length` | — | — | — |
| 32 | `loans` | `home_ownership` | — | — | — |
| 33 | `loans` | `verification_status` | — | — | — |
| 34 | `loans` | `created_at` | — | — | + DEFAULT now() |
| 35 | `loans` | `updated_at` | — | — | + DEFAULT now() |
| 36 | `credit_profiles` | `profile_id` | — | + (PK) | + (PK) |
| 37 | `credit_profiles` | `loan_id` | — | + (1:1) | + (FK) |
| 38 | `credit_profiles` | `dti` | + `>= 0 OR NULL` | — | — |
| 39 | `credit_profiles` | `delinq_2yrs` | — | — | — |
| 40 | `credit_profiles` | `earliest_cr_line` | — | — | — |
| 41 | `credit_profiles` | `fico_range_low` | — | — | — |
| 42 | `credit_profiles` | `fico_range_high` | — | — | — |
| 43 | `credit_profiles` | `inq_last_6mths` | — | — | — |
| 44 | `credit_profiles` | `mths_since_last_delinq` | — | — | — |
| 45 | `credit_profiles` | `mths_since_last_record` | — | — | — |
| 46 | `credit_profiles` | `open_acc` | — | — | — |
| 47 | `credit_profiles` | `pub_rec` | — | — | — |
| 48 | `credit_profiles` | `revol_bal` | + `>= 0` | — | — |
| 49 | `credit_profiles` | `revol_util` | + `>= 0` | — | — |
| 50 | `credit_profiles` | `total_acc` | — | — | — |
| 51 | `credit_profiles` | `collections_12_mths_ex_med` | — | — | — |
| 52 | `credit_profiles` | `mths_since_last_major_derog` | — | — | — |
| 53 | `credit_profiles` | `acc_now_delinq` | — | — | — |
| 54 | `credit_profiles` | `tot_coll_amt` | + `>= 0` | — | — |
| 55 | `credit_profiles` | `tot_cur_bal` | + `>= 0` | — | — |
| 56 | `credit_profiles` | `open_acc_6m` | — | — | — |
| 57 | `credit_profiles` | `open_act_il` | — | — | — |
| 58 | `credit_profiles` | `open_il_12m` | — | — | — |
| 59 | `credit_profiles` | `open_il_24m` | — | — | — |
| 60 | `credit_profiles` | `mths_since_rcnt_il` | — | — | — |
| 61 | `credit_profiles` | `total_bal_il` | + `>= 0` | — | — |
| 62 | `credit_profiles` | `il_util` | — | — | — |
| 63 | `credit_profiles` | `open_rv_12m` | — | — | — |
| 64 | `credit_profiles` | `open_rv_24m` | + `>= 0` | — | — |
| 65 | `credit_profiles` | `max_bal_bc` | + `>= 0` | — | — |
| 66 | `credit_profiles` | `all_util` | — | — | — |
| 67 | `credit_profiles` | `total_rev_hi_lim` | + `>= 0` | — | — |
| 68 | `credit_profiles` | `inq_fi` | — | — | — |
| 69 | `credit_profiles` | `total_cu_tl` | — | — | — |
| 70 | `credit_profiles` | `inq_last_12m` | — | — | — |
| 71 | `credit_profiles` | `acc_open_past_24mths` | — | — | — |
| 72 | `credit_profiles` | `avg_cur_bal` | + `>= 0` | — | — |
| 73 | `credit_profiles` | `bc_open_to_buy` | — | — | — |
| 74 | `credit_profiles` | `bc_util` | — | — | — |
| 75 | `credit_profiles` | `chargeoff_within_12_mths` | — | — | — |
| 76 | `credit_profiles` | `delinq_amnt` | + `>= 0` | — | — |
| 77 | `credit_profiles` | `mo_sin_old_il_acct` | — | — | — |
| 78 | `credit_profiles` | `mo_sin_old_rev_tl_op` | — | — | — |
| 79 | `credit_profiles` | `mo_sin_rcnt_rev_tl_op` | — | — | — |
| 80 | `credit_profiles` | `mo_sin_rcnt_tl` | — | — | — |
| 81 | `credit_profiles` | `mort_acc` | — | — | — |
| 82 | `credit_profiles` | `mths_since_recent_bc` | — | — | — |
| 83 | `credit_profiles` | `mths_since_recent_bc_dlq` | — | — | — |
| 84 | `credit_profiles` | `mths_since_recent_inq` | — | — | — |
| 85 | `credit_profiles` | `mths_since_recent_revol_delinq` | — | — | — |
| 86 | `credit_profiles` | `num_accts_ever_120_pd` | — | — | — |
| 87 | `credit_profiles` | `num_actv_bc_tl` | — | — | — |
| 88 | `credit_profiles` | `num_actv_rev_tl` | — | — | — |
| 89 | `credit_profiles` | `num_bc_sats` | — | — | — |
| 90 | `credit_profiles` | `num_bc_tl` | — | — | — |
| 91 | `credit_profiles` | `num_il_tl` | — | — | — |
| 92 | `credit_profiles` | `num_op_rev_tl` | — | — | — |
| 93 | `credit_profiles` | `num_rev_accts` | — | — | — |
| 94 | `credit_profiles` | `num_rev_tl_bal_gt_0` | — | — | — |
| 95 | `credit_profiles` | `num_sats` | — | — | — |
| 96 | `credit_profiles` | `num_tl_120dpd_2m` | — | — | — |
| 97 | `credit_profiles` | `num_tl_30dpd` | — | — | — |
| 98 | `credit_profiles` | `num_tl_90g_dpd_24m` | — | — | — |
| 99 | `credit_profiles` | `num_tl_op_past_12m` | — | — | — |
| 100 | `credit_profiles` | `pct_tl_nvr_dlq` | — | — | — |
| 101 | `credit_profiles` | `percent_bc_gt_75` | — | — | — |
| 102 | `credit_profiles` | `pub_rec_bankruptcies` | — | — | — |
| 103 | `credit_profiles` | `tax_liens` | — | — | — |
| 104 | `credit_profiles` | `tot_hi_cred_lim` | + `>= 0` | — | — |
| 105 | `credit_profiles` | `total_bal_ex_mort` | + `>= 0` | — | — |
| 106 | `credit_profiles` | `total_bc_limit` | + `>= 0` | — | — |
| 107 | `credit_profiles` | `total_il_high_credit_limit` | + `>= 0` | — | — |
| 108 | `credit_profiles` | `last_fico_range_high` | — | — | — |
| 109 | `credit_profiles` | `last_fico_range_low` | — | — | — |
| 110 | `credit_profiles` | `last_credit_pull_d` | — | — | — |
| 111 | `credit_profiles` | `created_at` | — | — | + DEFAULT now() |
| 112 | `credit_profiles` | `updated_at` | — | — | + DEFAULT now() |
| 113 | `loan_financial_state` | `state_id` | — | + (PK) | + (PK) |
| 114 | `loan_financial_state` | `loan_id` | — | + (1:1) | + (FK) |
| 115 | `loan_financial_state` | `out_prncp` | + `>= 0` | — | — |
| 116 | `loan_financial_state` | `out_prncp_inv` | + `>= 0` | — | — |
| 117 | `loan_financial_state` | `total_pymnt` | + `>= 0` | — | — |
| 118 | `loan_financial_state` | `total_pymnt_inv` | + `>= 0` | — | — |
| 119 | `loan_financial_state` | `total_rec_prncp` | + `>= 0` | — | — |
| 120 | `loan_financial_state` | `total_rec_int` | + `>= 0` | — | — |
| 121 | `loan_financial_state` | `total_rec_late_fee` | + `>= 0` | — | — |
| 122 | `loan_financial_state` | `recoveries` | + `>= 0` | — | — |
| 123 | `loan_financial_state` | `collection_recovery_fee` | + `>= 0` | — | — |
| 124 | `loan_financial_state` | `last_pymnt_d` | — | — | — |
| 125 | `loan_financial_state` | `last_pymnt_amnt` | + `>= 0` | — | — |
| 126 | `loan_financial_state` | `next_pymnt_d` | — | — | — |
| 127 | `loan_financial_state` | `created_at` | — | — | + DEFAULT now() |
| 128 | `loan_financial_state` | `updated_at` | — | — | + DEFAULT now() |
| 129 | `joint_applications` | `joint_application_id` | — | + (PK) | + (PK) |
| 130 | `joint_applications` | `loan_id` | — | + (1:1) | + (FK) |
| 131 | `joint_applications` | `co_client_id` | — | — | + (FK) |
| 132 | `joint_applications` | `annual_inc_joint` | + `>= 0` | — | — |
| 133 | `joint_applications` | `dti_joint` | + `>= 0 OR NULL` | — | — |
| 134 | `joint_applications` | `verification_status_joint` | — | — | — |
| 135 | `joint_applications` | `revol_bal_joint` | + `>= 0` | — | — |
| 136 | `joint_applications` | `sec_app_fico_range_low` | — | — | — |
| 137 | `joint_applications` | `sec_app_fico_range_high` | — | — | — |
| 138 | `joint_applications` | `sec_app_earliest_cr_line` | — | — | — |
| 139 | `joint_applications` | `sec_app_inq_last_6mths` | — | — | — |
| 140 | `joint_applications` | `sec_app_mort_acc` | — | — | — |
| 141 | `joint_applications` | `sec_app_open_acc` | — | — | — |
| 142 | `joint_applications` | `sec_app_revol_util` | — | — | — |
| 143 | `joint_applications` | `sec_app_open_act_il` | — | — | — |
| 144 | `joint_applications` | `sec_app_num_rev_accts` | — | — | — |
| 145 | `joint_applications` | `sec_app_chargeoff_within_12_mths` | — | — | — |
| 146 | `joint_applications` | `sec_app_collections_12_mths_ex_med` | — | — | — |
| 147 | `joint_applications` | `sec_app_mths_since_last_major_derog` | — | — | — |
| 148 | `joint_applications` | `created_at` | — | — | + DEFAULT now() |
| 149 | `joint_applications` | `updated_at` | — | — | + DEFAULT now() |
| 150 | `guarantors` | `guarantor_id` | — | + (PK) | + (PK) |
| 151 | `guarantors` | `loan_id` | — | + (в составе `loan_id, passport_hash`) | + (FK) |
| 152 | `guarantors` | `full_name` | — | — | + |
| 153 | `guarantors` | `passport_hash` | — | + (в составе `loan_id, passport_hash`) | + |
| 154 | `guarantors` | `phone` | — | — | + |
| 155 | `guarantors` | `income` | + `>= 0` | — | — |
| 156 | `guarantors` | `relationship` | — | — | — |
| 157 | `guarantors` | `created_at` | — | — | + DEFAULT now() |
| 158 | `guarantors` | `updated_at` | — | — | + DEFAULT now() |
| 159 | `collaterals` | `collateral_id` | — | + (PK) | + (PK) |
| 160 | `collaterals` | `loan_id` | — | — | + (FK) |
| 161 | `collaterals` | `collateral_type` | — | — | + |
| 162 | `collaterals` | `description` | — | — | — |
| 163 | `collaterals` | `appraised_value` | + `>= 0` | — | — |
| 164 | `collaterals` | `vin` | + `~ '^[A-HJ-NPR-Z0-9]{17}$'` | — | — |
| 165 | `collaterals` | `cadastral_number` | — | — | — |
| 166 | `collaterals` | `created_at` | — | — | + DEFAULT now() |
| 167 | `collaterals` | `updated_at` | — | — | + DEFAULT now() |
| 168 | `audit_log` | `audit_id` | — | + (PK) | + (PK) |
| 169 | `audit_log` | `table_name` | + `IN ('clients','loans','credit_profiles','loan_financial_state','joint_applications','guarantors','collaterals','loan_purposes')` | — | + |
| 170 | `audit_log` | `record_id` | — | — | + |
| 171 | `audit_log` | `operation_type` | + `IN ('INSERT','UPDATE','DELETE')` | — | + |
| 172 | `audit_log` | `changed_by` | — | — | + |
| 173 | `audit_log` | `changed_at` | — | — | + DEFAULT now() |
| 174 | `audit_log` | `old_value` | — | — | — |
| 175 | `audit_log` | `new_value` | — | — | — |

# Индексы:

idx_loans_client_id — ускоряет выборку займов клиента. Типовой запрос «все займы заёмщика».      
idx_loans_purpose_id — ускоряет агрегацию по целям кредита.      
idx_joint_applications_co_client_id — поиск совместных заявок по созаёмщику.      
idx_collaterals_loan_id — выборка залогов по займу.
idx_audit_log_record (table_name, record_id) — история изменений конкретной записи.      
UNIQUE-ограничения на loan_id в credit_profiles, loan_financial_state, joint_applications автоматически создают уникальные индексы (1:1 доступ).