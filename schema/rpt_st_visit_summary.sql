CREATE TABLE IF NOT EXISTS rpt_st_visit_summary (
    store_id INT,
    store_location VARCHAR(50),
    reporting_period DATE,
    total_visits INT,
    distinct_customers INT,
    repeat_visits INT,
    new_customer_visits INT,
    frequent_visitors INT,
    PRIMARY KEY (store_id, reporting_period)
);
