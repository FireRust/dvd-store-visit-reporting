CREATE TABLE IF NOT EXISTS rpt_st_visit_detail (
    visit_id INT PRIMARY KEY,
    visit_date DATE,
    store_id INT,
    store_location VARCHAR(50),
    customer_id INT,
    customer_full_name VARCHAR(50),
    visit_label VARCHAR(50)
);
