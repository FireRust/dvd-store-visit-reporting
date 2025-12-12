CREATE OR REPLACE FUNCTION get_visit_label(l_customer_id INT)
RETURNS TEXT AS $$
SELECT CASE
    WHEN total_visits = 1 THEN 'New Customer'
    WHEN total_visits BETWEEN 2 AND 3 THEN 'Occasional Visitor'
    ELSE 'Frequent Visitor'
END
FROM (
    SELECT COUNT(*) AS total_visits
    FROM rental
    WHERE rental.customer_id = l_customer_id
) AS visit_count;
$$ LANGUAGE sql;
