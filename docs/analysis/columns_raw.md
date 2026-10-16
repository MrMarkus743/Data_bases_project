# Реестр колонок исходного датасета Lending Club

> Всего строк: **2,260,701**  
> Всего колонок: **151**  

|   № | Имя колонки                                  | Тип Pandas   | Заполненность      | Уникальных   | Пример значения                          |
|----:|:---------------------------------------------|:-------------|:-------------------|:-------------|:-----------------------------------------|
|   1 | `id`                                         | `int64`      | 2,260,701 (100.0%) | > 500        | 68407277                                 |
|   2 | `loan_amnt`                                  | `float64`    | 2,260,668 (100.0%) | > 500        | 3600.0                                   |
|   3 | `funded_amnt`                                | `float64`    | 2,260,668 (100.0%) | > 500        | 3600.0                                   |
|   4 | `funded_amnt_inv`                            | `float64`    | 2,260,668 (100.0%) | > 500        | 3600.0                                   |
|   5 | `term`                                       | `str`        | 2,260,668 (100.0%) | 2            | 36 months                                |
|   6 | `int_rate`                                   | `float64`    | 2,260,668 (100.0%) | > 500        | 13.99                                    |
|   7 | `installment`                                | `float64`    | 2,260,668 (100.0%) | > 500        | 123.03                                   |
|   8 | `grade`                                      | `str`        | 2,260,668 (100.0%) | 7            | C                                        |
|   9 | `sub_grade`                                  | `str`        | 2,260,668 (100.0%) | 35           | C4                                       |
|  10 | `emp_title`                                  | `str`        | 2,093,699 (92.6%)  | > 500        | leadman                                  |
|  11 | `emp_length`                                 | `str`        | 2,113,761 (93.5%)  | 11           | 10+ years                                |
|  12 | `home_ownership`                             | `str`        | 2,260,668 (100.0%) | 6            | MORTGAGE                                 |
|  13 | `annual_inc`                                 | `float64`    | 2,260,664 (100.0%) | > 500        | 55000.0                                  |
|  14 | `verification_status`                        | `str`        | 2,260,668 (100.0%) | 3            | Not Verified                             |
|  15 | `issue_d`                                    | `str`        | 2,260,668 (100.0%) | 139          | Dec-2015                                 |
|  16 | `loan_status`                                | `str`        | 2,260,668 (100.0%) | 9            | Fully Paid                               |
|  17 | `pymnt_plan`                                 | `str`        | 2,260,668 (100.0%) | 2            | n                                        |
|  18 | `url`                                        | `str`        | 2,260,668 (100.0%) | > 500        | https://lendingclub.com/browse/loanDe... |
|  19 | `desc`                                       | `str`        | 126,065 (5.6%)     | > 500        | We knew that using our credit cards t... |
|  20 | `purpose`                                    | `str`        | 2,260,668 (100.0%) | 14           | debt_consolidation                       |
|  21 | `title`                                      | `str`        | 2,237,342 (99.0%)  | > 500        | Debt consolidation                       |
|  22 | `zip_code`                                   | `str`        | 2,260,667 (100.0%) | > 500        | 190xx                                    |
|  23 | `addr_state`                                 | `str`        | 2,260,668 (100.0%) | 51           | PA                                       |
|  24 | `dti`                                        | `float64`    | 2,258,957 (99.9%)  | > 500        | 5.91                                     |
|  25 | `delinq_2yrs`                                | `float64`    | 2,260,639 (100.0%) | 37           | 0.0                                      |
|  26 | `earliest_cr_line`                           | `str`        | 2,260,639 (100.0%) | > 500        | Aug-2003                                 |
|  27 | `fico_range_low`                             | `float64`    | 2,260,668 (100.0%) | 48           | 675.0                                    |
|  28 | `fico_range_high`                            | `float64`    | 2,260,668 (100.0%) | 48           | 679.0                                    |
|  29 | `inq_last_6mths`                             | `float64`    | 2,260,638 (100.0%) | 28           | 1.0                                      |
|  30 | `mths_since_last_delinq`                     | `float64`    | 1,102,166 (48.8%)  | 173          | 30.0                                     |
|  31 | `mths_since_last_record`                     | `float64`    | 359,156 (15.9%)    | 129          | 106.0                                    |
|  32 | `open_acc`                                   | `float64`    | 2,260,639 (100.0%) | 91           | 7.0                                      |
|  33 | `pub_rec`                                    | `float64`    | 2,260,639 (100.0%) | 43           | 0.0                                      |
|  34 | `revol_bal`                                  | `float64`    | 2,260,668 (100.0%) | > 500        | 2765.0                                   |
|  35 | `revol_util`                                 | `float64`    | 2,258,866 (99.9%)  | > 500        | 29.7                                     |
|  36 | `total_acc`                                  | `float64`    | 2,260,639 (100.0%) | 152          | 13.0                                     |
|  37 | `initial_list_status`                        | `str`        | 2,260,668 (100.0%) | 2            | w                                        |
|  38 | `out_prncp`                                  | `float64`    | 2,260,668 (100.0%) | > 500        | 0.0                                      |
|  39 | `out_prncp_inv`                              | `float64`    | 2,260,668 (100.0%) | > 500        | 0.0                                      |
|  40 | `total_pymnt`                                | `float64`    | 2,260,668 (100.0%) | > 500        | 4421.723916800001                        |
|  41 | `total_pymnt_inv`                            | `float64`    | 2,260,668 (100.0%) | > 500        | 4421.72                                  |
|  42 | `total_rec_prncp`                            | `float64`    | 2,260,668 (100.0%) | > 500        | 3600.0                                   |
|  43 | `total_rec_int`                              | `float64`    | 2,260,668 (100.0%) | > 500        | 821.72                                   |
|  44 | `total_rec_late_fee`                         | `float64`    | 2,260,668 (100.0%) | > 500        | 0.0                                      |
|  45 | `recoveries`                                 | `float64`    | 2,260,668 (100.0%) | > 500        | 0.0                                      |
|  46 | `collection_recovery_fee`                    | `float64`    | 2,260,668 (100.0%) | > 500        | 0.0                                      |
|  47 | `last_pymnt_d`                               | `str`        | 2,258,241 (99.9%)  | 136          | Jan-2019                                 |
|  48 | `last_pymnt_amnt`                            | `float64`    | 2,260,668 (100.0%) | > 500        | 122.67                                   |
|  49 | `next_pymnt_d`                               | `str`        | 915,358 (40.5%)    | 106          | Apr-2019                                 |
|  50 | `last_credit_pull_d`                         | `str`        | 2,260,596 (100.0%) | 141          | Mar-2019                                 |
|  51 | `last_fico_range_high`                       | `float64`    | 2,260,668 (100.0%) | 72           | 564.0                                    |
|  52 | `last_fico_range_low`                        | `float64`    | 2,260,668 (100.0%) | 71           | 560.0                                    |
|  53 | `collections_12_mths_ex_med`                 | `float64`    | 2,260,523 (100.0%) | 16           | 0.0                                      |
|  54 | `mths_since_last_major_derog`                | `float64`    | 580,775 (25.7%)    | 183          | 30.0                                     |
|  55 | `policy_code`                                | `float64`    | 2,260,668 (100.0%) | 1            | 1.0                                      |
|  56 | `application_type`                           | `str`        | 2,260,668 (100.0%) | 2            | Individual                               |
|  57 | `annual_inc_joint`                           | `float64`    | 120,710 (5.3%)     | > 500        | 71000.0                                  |
|  58 | `dti_joint`                                  | `float64`    | 120,706 (5.3%)     | > 500        | 13.85                                    |
|  59 | `verification_status_joint`                  | `str`        | 115,730 (5.1%)     | 3            | Not Verified                             |
|  60 | `acc_now_delinq`                             | `float64`    | 2,260,639 (100.0%) | 9            | 0.0                                      |
|  61 | `tot_coll_amt`                               | `float64`    | 2,190,392 (96.9%)  | > 500        | 722.0                                    |
|  62 | `tot_cur_bal`                                | `float64`    | 2,190,392 (96.9%)  | > 500        | 144904.0                                 |
|  63 | `open_acc_6m`                                | `float64`    | 1,394,538 (61.7%)  | 19           | 2.0                                      |
|  64 | `open_act_il`                                | `float64`    | 1,394,539 (61.7%)  | 54           | 2.0                                      |
|  65 | `open_il_12m`                                | `float64`    | 1,394,539 (61.7%)  | 19           | 0.0                                      |
|  66 | `open_il_24m`                                | `float64`    | 1,394,539 (61.7%)  | 31           | 1.0                                      |
|  67 | `mths_since_rcnt_il`                         | `float64`    | 1,350,744 (59.7%)  | 405          | 21.0                                     |
|  68 | `total_bal_il`                               | `float64`    | 1,394,539 (61.7%)  | > 500        | 4981.0                                   |
|  69 | `il_util`                                    | `float64`    | 1,191,818 (52.7%)  | 280          | 36.0                                     |
|  70 | `open_rv_12m`                                | `float64`    | 1,394,539 (61.7%)  | 29           | 3.0                                      |
|  71 | `open_rv_24m`                                | `float64`    | 1,394,539 (61.7%)  | 50           | 3.0                                      |
|  72 | `max_bal_bc`                                 | `float64`    | 1,394,539 (61.7%)  | > 500        | 722.0                                    |
|  73 | `all_util`                                   | `float64`    | 1,394,320 (61.7%)  | 188          | 34.0                                     |
|  74 | `total_rev_hi_lim`                           | `float64`    | 2,190,392 (96.9%)  | > 500        | 9300.0                                   |
|  75 | `inq_fi`                                     | `float64`    | 1,394,539 (61.7%)  | 33           | 3.0                                      |
|  76 | `total_cu_tl`                                | `float64`    | 1,394,538 (61.7%)  | 62           | 1.0                                      |
|  77 | `inq_last_12m`                               | `float64`    | 1,394,538 (61.7%)  | 48           | 4.0                                      |
|  78 | `acc_open_past_24mths`                       | `float64`    | 2,210,638 (97.8%)  | 57           | 4.0                                      |
|  79 | `avg_cur_bal`                                | `float64`    | 2,190,322 (96.9%)  | > 500        | 20701.0                                  |
|  80 | `bc_open_to_buy`                             | `float64`    | 2,185,733 (96.7%)  | > 500        | 1506.0                                   |
|  81 | `bc_util`                                    | `float64`    | 2,184,597 (96.6%)  | > 500        | 37.2                                     |
|  82 | `chargeoff_within_12_mths`                   | `float64`    | 2,260,523 (100.0%) | 11           | 0.0                                      |
|  83 | `delinq_amnt`                                | `float64`    | 2,260,639 (100.0%) | > 500        | 0.0                                      |
|  84 | `mo_sin_old_il_acct`                         | `float64`    | 2,121,597 (93.8%)  | > 500        | 148.0                                    |
|  85 | `mo_sin_old_rev_tl_op`                       | `float64`    | 2,190,391 (96.9%)  | > 500        | 128.0                                    |
|  86 | `mo_sin_rcnt_rev_tl_op`                      | `float64`    | 2,190,391 (96.9%)  | 333          | 3.0                                      |
|  87 | `mo_sin_rcnt_tl`                             | `float64`    | 2,190,392 (96.9%)  | 232          | 3.0                                      |
|  88 | `mort_acc`                                   | `float64`    | 2,210,638 (97.8%)  | 47           | 1.0                                      |
|  89 | `mths_since_recent_bc`                       | `float64`    | 2,187,256 (96.8%)  | > 500        | 4.0                                      |
|  90 | `mths_since_recent_bc_dlq`                   | `float64`    | 519,701 (23.0%)    | 177          | 69.0                                     |
|  91 | `mths_since_recent_inq`                      | `float64`    | 1,965,233 (86.9%)  | 26           | 4.0                                      |
|  92 | `mths_since_recent_revol_delinq`             | `float64`    | 740,359 (32.7%)    | 179          | 69.0                                     |
|  93 | `num_accts_ever_120_pd`                      | `float64`    | 2,190,392 (96.9%)  | 44           | 2.0                                      |
|  94 | `num_actv_bc_tl`                             | `float64`    | 2,190,392 (96.9%)  | 42           | 2.0                                      |
|  95 | `num_actv_rev_tl`                            | `float64`    | 2,190,392 (96.9%)  | 57           | 4.0                                      |
|  96 | `num_bc_sats`                                | `float64`    | 2,202,078 (97.4%)  | 60           | 2.0                                      |
|  97 | `num_bc_tl`                                  | `float64`    | 2,190,392 (96.9%)  | 76           | 5.0                                      |
|  98 | `num_il_tl`                                  | `float64`    | 2,190,392 (96.9%)  | 122          | 3.0                                      |
|  99 | `num_op_rev_tl`                              | `float64`    | 2,190,392 (96.9%)  | 81           | 4.0                                      |
| 100 | `num_rev_accts`                              | `float64`    | 2,190,391 (96.9%)  | 117          | 9.0                                      |
| 101 | `num_rev_tl_bal_gt_0`                        | `float64`    | 2,190,392 (96.9%)  | 50           | 4.0                                      |
| 102 | `num_sats`                                   | `float64`    | 2,202,078 (97.4%)  | 91           | 7.0                                      |
| 103 | `num_tl_120dpd_2m`                           | `float64`    | 2,107,011 (93.2%)  | 7            | 0.0                                      |
| 104 | `num_tl_30dpd`                               | `float64`    | 2,190,392 (96.9%)  | 5            | 0.0                                      |
| 105 | `num_tl_90g_dpd_24m`                         | `float64`    | 2,190,392 (96.9%)  | 34           | 0.0                                      |
| 106 | `num_tl_op_past_12m`                         | `float64`    | 2,190,392 (96.9%)  | 33           | 3.0                                      |
| 107 | `pct_tl_nvr_dlq`                             | `float64`    | 2,190,237 (96.9%)  | > 500        | 76.9                                     |
| 108 | `percent_bc_gt_75`                           | `float64`    | 2,185,289 (96.7%)  | 284          | 0.0                                      |
| 109 | `pub_rec_bankruptcies`                       | `float64`    | 2,259,303 (99.9%)  | 12           | 0.0                                      |
| 110 | `tax_liens`                                  | `float64`    | 2,260,563 (100.0%) | 42           | 0.0                                      |
| 111 | `tot_hi_cred_lim`                            | `float64`    | 2,190,392 (96.9%)  | > 500        | 178050.0                                 |
| 112 | `total_bal_ex_mort`                          | `float64`    | 2,210,638 (97.8%)  | > 500        | 7746.0                                   |
| 113 | `total_bc_limit`                             | `float64`    | 2,210,638 (97.8%)  | > 500        | 2400.0                                   |
| 114 | `total_il_high_credit_limit`                 | `float64`    | 2,190,392 (96.9%)  | > 500        | 13734.0                                  |
| 115 | `hardship_flag`                              | `str`        | 2,260,668 (100.0%) | 2            | N                                        |
| 116 | `hardship_type`                              | `str`        | 10,917 (0.5%)      | 1            | INTEREST ONLY-3 MONTHS DEFERRAL          |
| 117 | `hardship_reason`                            | `str`        | 10,917 (0.5%)      | 9            | NATURAL_DISASTER                         |
| 118 | `hardship_status`                            | `str`        | 10,917 (0.5%)      | 3            | BROKEN                                   |
| 119 | `deferral_term`                              | `float64`    | 10,917 (0.5%)      | 1            | 3.0                                      |
| 120 | `hardship_amount`                            | `float64`    | 10,917 (0.5%)      | > 500        | 47.01                                    |
| 121 | `hardship_start_date`                        | `str`        | 10,917 (0.5%)      | 27           | Sep-2017                                 |
| 122 | `hardship_end_date`                          | `str`        | 10,917 (0.5%)      | 28           | Dec-2017                                 |
| 123 | `payment_plan_start_date`                    | `str`        | 10,917 (0.5%)      | 27           | Oct-2017                                 |
| 124 | `hardship_length`                            | `float64`    | 10,917 (0.5%)      | 1            | 3.0                                      |
| 125 | `hardship_dpd`                               | `float64`    | 10,917 (0.5%)      | 34           | 26.0                                     |
| 126 | `hardship_loan_status`                       | `str`        | 10,917 (0.5%)      | 5            | Late (16-30 days)                        |
| 127 | `orig_projected_additional_accrued_interest` | `float64`    | 8,651 (0.4%)       | > 500        | 442.41                                   |
| 128 | `hardship_payoff_balance_amount`             | `float64`    | 10,917 (0.5%)      | > 500        | 3058.14                                  |
| 129 | `hardship_last_payment_amount`               | `float64`    | 10,917 (0.5%)      | > 500        | 61.23                                    |
| 130 | `disbursement_method`                        | `str`        | 2,260,668 (100.0%) | 2            | Cash                                     |
| 131 | `debt_settlement_flag`                       | `str`        | 2,260,668 (100.0%) | 2            | N                                        |
| 132 | `debt_settlement_flag_date`                  | `str`        | 34,246 (1.5%)      | 83           | Nov-2017                                 |
| 133 | `settlement_status`                          | `str`        | 34,246 (1.5%)      | 3            | COMPLETE                                 |
| 134 | `settlement_date`                            | `str`        | 34,246 (1.5%)      | 90           | Sep-2017                                 |
| 135 | `settlement_amount`                          | `float64`    | 34,246 (1.5%)      | > 500        | 9915.0                                   |
| 136 | `settlement_percentage`                      | `float64`    | 34,246 (1.5%)      | > 500        | 55.0                                     |
| 137 | `settlement_term`                            | `float64`    | 34,246 (1.5%)      | 40           | 1.0                                      |
| 138 | `revol_bal_joint`                            | `float64`    | 108,020 (4.8%)     | > 500        | 7101.0                                   |
| 139 | `sec_app_fico_range_low`                     | `float64`    | 108,021 (4.8%)     | 62           | 610.0                                    |
| 140 | `sec_app_fico_range_high`                    | `float64`    | 108,021 (4.8%)     | 62           | 614.0                                    |
| 141 | `sec_app_earliest_cr_line`                   | `str`        | 108,021 (4.8%)     | > 500        | Feb-2005                                 |
| 142 | `sec_app_inq_last_6mths`                     | `float64`    | 108,021 (4.8%)     | 7            | 3.0                                      |
| 143 | `sec_app_mort_acc`                           | `float64`    | 108,021 (4.8%)     | 23           | 1.0                                      |
| 144 | `sec_app_open_acc`                           | `float64`    | 108,021 (4.8%)     | 67           | 14.0                                     |
| 145 | `sec_app_revol_util`                         | `float64`    | 106,184 (4.7%)     | > 500        | 80.0                                     |
| 146 | `sec_app_open_act_il`                        | `float64`    | 108,021 (4.8%)     | 40           | 11.0                                     |
| 147 | `sec_app_num_rev_accts`                      | `float64`    | 108,021 (4.8%)     | 86           | 8.0                                      |
| 148 | `sec_app_chargeoff_within_12_mths`           | `float64`    | 108,021 (4.8%)     | 22           | 0.0                                      |
| 149 | `sec_app_collections_12_mths_ex_med`         | `float64`    | 108,021 (4.8%)     | 18           | 2.0                                      |
| 150 | `sec_app_mths_since_last_major_derog`        | `float64`    | 35,942 (1.6%)      | 140          | 37.0                                     |
| 151 | `member_id`                                  | `float64`    | 0 (0.0%)           | 0            | -                                        |
