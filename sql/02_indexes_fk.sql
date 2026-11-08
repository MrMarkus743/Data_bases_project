BEGIN;

CREATE INDEX IF NOT EXISTS idx_loans_client_id ON loans(client_id);
CREATE INDEX IF NOT EXISTS idx_loans_purpose_id ON loans(purpose_id);
CREATE INDEX IF NOT EXISTS idx_joint_applications_co_client_id ON joint_applications(co_client_id);
CREATE INDEX IF NOT EXISTS idx_guarantors_loan_id ON guarantors(loan_id);
CREATE INDEX IF NOT EXISTS idx_collaterals_loan_id ON collaterals(loan_id);

CREATE INDEX IF NOT EXISTS idx_loans_status ON loans(loan_status);
CREATE INDEX IF NOT EXISTS idx_loans_issue_d ON loans(issue_d);
CREATE INDEX IF NOT EXISTS idx_guarantors_passport_hash ON guarantors(passport_hash);

CREATE INDEX IF NOT EXISTS idx_audit_log_record ON audit_log(table_name, record_id);
CREATE INDEX IF NOT EXISTS idx_audit_log_changed_at ON audit_log(changed_at);

COMMIT;
