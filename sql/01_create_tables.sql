-- sql/01_create_tables.sql
BEGIN;

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE TABLE loan_purposes (
    purpose_id   smallint PRIMARY KEY,
    purpose_name varchar(100) NOT NULL UNIQUE
);

CREATE TABLE clients (
    client_id   bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    addr_state  char(2),
    zip_code    char(5) CHECK (zip_code ~ '^[0-9]{3}[0-9xX]{2}$'),
    created_at  timestamp NOT NULL DEFAULT now(),
    updated_at  timestamp NOT NULL DEFAULT now()
);

CREATE TABLE loans (
    loan_id                   bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    client_id                 bigint NOT NULL REFERENCES clients(client_id),
    purpose_id                smallint NOT NULL REFERENCES loan_purposes(purpose_id),
    application_type          varchar(20) NOT NULL CHECK (application_type IN ('Individual','Joint')),
    loan_amnt                 numeric(12,2) NOT NULL CHECK (loan_amnt >= 0),
    funded_amnt               numeric(12,2) NOT NULL CHECK (funded_amnt >= 0),
    funded_amnt_inv           numeric(12,2) NOT NULL CHECK (funded_amnt_inv >= 0),
    term_months               smallint NOT NULL CHECK (term_months IN (36,60)),
    int_rate                  numeric(6,3) NOT NULL,
    installment               numeric(10,2) NOT NULL CHECK (installment >= 0),
    grade                     char(1) NOT NULL CHECK (grade IN ('A','B','C','D','E','F','G')),
    sub_grade                 varchar(3) NOT NULL,
    issue_d                   date NOT NULL,
    loan_status               varchar(40) NOT NULL,
    pymnt_plan                char(1) NOT NULL CHECK (pymnt_plan IN ('n','y')),
    url                       text,
    descr_encrypted           bytea,
    title_encrypted           bytea,
    initial_list_status       char(1) NOT NULL,
    disbursement_method       varchar(20) NOT NULL,
    debt_settlement_flag      char(1) NOT NULL,
    
    annual_inc_encrypted      bytea,
    emp_title_encrypted       bytea,
    emp_length_encrypted      bytea,
    
    home_ownership            varchar(20),
    verification_status       varchar(20),
    policy_code               smallint NOT NULL CHECK (policy_code IN (1,2)),
    hardship_flag             char(1) NOT NULL CHECK (hardship_flag IN ('N','Y')),
    
    hardship_type             varchar(50),
    hardship_reason           varchar(50),
    hardship_status           varchar(20),
    deferral_term             smallint,
    hardship_amount           numeric(12,2) CHECK (hardship_amount >= 0),
    hardship_start_date       date,
    hardship_end_date         date,
    payment_plan_start_date   date,
    hardship_length           smallint,
    hardship_dpd              smallint,
    hardship_loan_status      varchar(40),
    orig_projected_additional_accrued_interest numeric(12,2) CHECK (orig_projected_additional_accrued_interest >= 0),
    hardship_payoff_balance_amount numeric(14,2) CHECK (hardship_payoff_balance_amount >= 0),
    hardship_last_payment_amount   numeric(12,2) CHECK (hardship_last_payment_amount >= 0),
    
    debt_settlement_flag_date date,
    settlement_status         varchar(20),
    settlement_date           date,
    settlement_amount         numeric(14,2) CHECK (settlement_amount >= 0),
    settlement_percentage     numeric(6,2),
    settlement_term           smallint,
    
    created_at                timestamp NOT NULL DEFAULT now(),
    updated_at                timestamp NOT NULL DEFAULT now()
);

CREATE TABLE credit_profiles (
    profile_id               bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    loan_id                  bigint NOT NULL UNIQUE REFERENCES loans(loan_id),
    dti                      numeric(6,2) CHECK (dti >= 0 OR dti IS NULL),
    delinq_2yrs              smallint,
    earliest_cr_line         date,
    fico_range_low           smallint,
    fico_range_high          smallint,
    inq_last_6mths           smallint,
    mths_since_last_delinq   smallint,
    mths_since_last_record   smallint,
    open_acc                 smallint,
    pub_rec                  smallint,
    revol_bal                numeric(14,2) CHECK (revol_bal >= 0),
    revol_util               numeric(6,2) CHECK (revol_util >= 0),
    total_acc                smallint,
    collections_12_mths_ex_med smallint,
    mths_since_last_major_derog smallint,
    acc_now_delinq           smallint,
    tot_coll_amt             numeric(14,2) CHECK (tot_coll_amt >= 0),
    tot_cur_bal              numeric(14,2) CHECK (tot_cur_bal >= 0),
    open_acc_6m              smallint,
    open_act_il              smallint,
    open_il_12m              smallint,
    open_il_24m              smallint,
    mths_since_rcnt_il       smallint,
    total_bal_il             numeric(14,2) CHECK (total_bal_il >= 0),
    il_util                  numeric(6,2),
    open_rv_12m              smallint,
    open_rv_24m              smallint CHECK (open_rv_24m >= 0),
    max_bal_bc               numeric(14,2) CHECK (max_bal_bc >= 0),
    all_util                 numeric(6,2),
    total_rev_hi_lim         numeric(14,2) CHECK (total_rev_hi_lim >= 0),
    inq_fi                   smallint,
    total_cu_tl              smallint,
    inq_last_12m             smallint,
    acc_open_past_24mths     smallint,
    avg_cur_bal              numeric(14,2) CHECK (avg_cur_bal >= 0),
    bc_open_to_buy           numeric(14,2),
    bc_util                  numeric(6,2),
    chargeoff_within_12_mths smallint,
    delinq_amnt              numeric(14,2) CHECK (delinq_amnt >= 0),
    mo_sin_old_il_acct       smallint,
    mo_sin_old_rev_tl_op     smallint,
    mo_sin_rcnt_rev_tl_op    smallint,
    mo_sin_rcnt_tl           smallint,
    mort_acc                 smallint,
    mths_since_recent_bc     smallint,
    mths_since_recent_bc_dlq smallint,
    mths_since_recent_inq    smallint,
    mths_since_recent_revol_delinq smallint,
    num_accts_ever_120_pd    smallint,
    num_actv_bc_tl           smallint,
    num_actv_rev_tl          smallint,
    num_bc_sats              smallint,
    num_bc_tl                smallint,
    num_il_tl                smallint,
    num_op_rev_tl            smallint,
    num_rev_accts            smallint,
    num_rev_tl_bal_gt_0      smallint,
    num_sats                 smallint,
    num_tl_120dpd_2m         smallint,
    num_tl_30dpd             smallint,
    num_tl_90g_dpd_24m       smallint,
    num_tl_op_past_12m       smallint,
    pct_tl_nvr_dlq           numeric(6,2),
    percent_bc_gt_75         numeric(6,2),
    pub_rec_bankruptcies     smallint,
    tax_liens                smallint,
    tot_hi_cred_lim          numeric(14,2) CHECK (tot_hi_cred_lim >= 0),
    total_bal_ex_mort        numeric(14,2) CHECK (total_bal_ex_mort >= 0),
    total_bc_limit           numeric(14,2) CHECK (total_bc_limit >= 0),
    total_il_high_credit_limit numeric(14,2) CHECK (total_il_high_credit_limit >= 0),
    last_fico_range_high     smallint,
    last_fico_range_low      smallint,
    last_credit_pull_d       date,
    created_at               timestamp NOT NULL DEFAULT now(),
    updated_at               timestamp NOT NULL DEFAULT now()
);

CREATE TABLE loan_financial_state (
    state_id                 bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    loan_id                  bigint NOT NULL UNIQUE REFERENCES loans(loan_id),
    out_prncp                numeric(14,2) CHECK (out_prncp >= 0),
    out_prncp_inv            numeric(14,2) CHECK (out_prncp_inv >= 0),
    total_pymnt              numeric(14,2) CHECK (total_pymnt >= 0),
    total_pymnt_inv          numeric(14,2) CHECK (total_pymnt_inv >= 0),
    total_rec_prncp          numeric(14,2) CHECK (total_rec_prncp >= 0),
    total_rec_int            numeric(14,2) CHECK (total_rec_int >= 0),
    total_rec_late_fee       numeric(14,2) CHECK (total_rec_late_fee >= 0),
    recoveries               numeric(14,2) CHECK (recoveries >= 0),
    collection_recovery_fee  numeric(14,2) CHECK (collection_recovery_fee >= 0),
    last_pymnt_d             date,
    last_pymnt_amnt          numeric(12,2) CHECK (last_pymnt_amnt >= 0),
    next_pymnt_d             date,
    created_at               timestamp NOT NULL DEFAULT now(),
    updated_at               timestamp NOT NULL DEFAULT now()
);

CREATE TABLE joint_applications (
    joint_application_id     bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    loan_id                  bigint NOT NULL UNIQUE REFERENCES loans(loan_id),
    co_client_id             bigint NOT NULL REFERENCES clients(client_id),
    annual_inc_joint_encrypted bytea,
    dti_joint                numeric(6,2) CHECK (dti_joint >= 0 OR dti_joint IS NULL),
    verification_status_joint varchar(20),
    revol_bal_joint          numeric(14,2) CHECK (revol_bal_joint >= 0),
    sec_app_fico_range_low   smallint,
    sec_app_fico_range_high  smallint,
    sec_app_earliest_cr_line date,
    sec_app_inq_last_6mths   smallint,
    sec_app_mort_acc         smallint,
    sec_app_open_acc         smallint,
    sec_app_revol_util       numeric(6,2),
    sec_app_open_act_il      smallint,
    sec_app_num_rev_accts    smallint,
    sec_app_chargeoff_within_12_mths smallint,
    sec_app_collections_12_mths_ex_med smallint,
    sec_app_mths_since_last_major_derog smallint,
    created_at               timestamp NOT NULL DEFAULT now(),
    updated_at               timestamp NOT NULL DEFAULT now()
);

CREATE TABLE guarantors (
    guarantor_id    bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    loan_id         bigint NOT NULL REFERENCES loans(loan_id),
    
    full_name_encrypted bytea NOT NULL,       
    phone_encrypted     bytea NOT NULL,       
    passport_hash       char(64) NOT NULL,    
    income_encrypted    bytea,                 
    
    relationship    varchar(50),
    created_at      timestamp NOT NULL DEFAULT now(),
    updated_at      timestamp NOT NULL DEFAULT now(),
    
    CONSTRAINT uq_guarantor_passport UNIQUE (loan_id, passport_hash)
);

CREATE TABLE collaterals (
    collateral_id   bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    loan_id         bigint NOT NULL REFERENCES loans(loan_id),
    collateral_type varchar(30) NOT NULL,
    description_encrypted bytea, 
    appraised_value numeric(14,2) CHECK (appraised_value >= 0),
    vin             char(17) CHECK (vin ~ '^[A-HJ-NPR-Z0-9]{17}$'),
    cadastral_number varchar(30),
    created_at      timestamp NOT NULL DEFAULT now(),
    updated_at      timestamp NOT NULL DEFAULT now()
);

CREATE TABLE audit_log (
    audit_id    bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    table_name  varchar(63) NOT NULL CHECK (table_name IN ('clients','loans','credit_profiles','loan_financial_state','joint_applications','guarantors','collaterals','loan_purposes')),
    record_id   bigint NOT NULL,
    operation   varchar(10) NOT NULL CHECK (operation IN ('INSERT','UPDATE','DELETE')),
    changed_by  varchar(255) NOT NULL, 
    changed_at  timestamp NOT NULL DEFAULT now(),
    old_value   jsonb,
    new_value   jsonb
);

CREATE INDEX idx_loans_client_id ON loans(client_id);
CREATE INDEX idx_loans_purpose_id ON loans(purpose_id);
CREATE INDEX idx_credit_profiles_loan_id ON credit_profiles(loan_id);
CREATE INDEX idx_loan_financial_state_loan_id ON loan_financial_state(loan_id);
CREATE INDEX idx_joint_applications_loan_id ON joint_applications(loan_id);
CREATE INDEX idx_joint_applications_co_client_id ON joint_applications(co_client_id);
CREATE INDEX idx_guarantors_loan_id ON guarantors(loan_id);
CREATE INDEX idx_guarantors_passport_hash ON guarantors(passport_hash);
CREATE INDEX idx_collaterals_loan_id ON collaterals(loan_id);

COMMIT;
