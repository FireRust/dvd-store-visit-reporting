CREATE OR REPLACE FUNCTION fn_update_st_visit_summary()
RETURNS TRIGGER AS $$
DECLARE
    v_reporting_month DATE;
BEGIN
    -- Determine the reporting month (first day of the month)
    v_reporting_month := DATE_TRUNC('month', NEW.visit_date)::DATE;

    -- Remove existing summary row for this store + month
    DELETE FROM rpt_st_visit_summary
    WHERE store_id = NEW.store_id
      AND reporting_period = v_reporting_month;

    -- Recalculate summary metrics for this store + month
    INSERT INTO rpt_st_visit_summary (
        store_id,
        store_location,
        reporting_period,
        total_visits,
        distinct_customers,
        repeat_visits,
        new_customer_visits,
        frequent_visitors
    )
    SELECT
        d.store_id,
        d.store_location,
        v_reporting_month AS reporting_period,
        COUNT(*) AS total_visits,
        COUNT(DISTINCT d.customer_id) AS distinct_customers,
        SUM(
            CASE
                WHEN d.visit_label IN ('Occasional Visitor', 'Frequent Visitor')
                THEN 1 ELSE 0
            END
        ) AS repeat_visits,
        SUM(
            CASE
                WHEN d.visit_label = 'New Customer'
                THEN 1 ELSE 0
            END
        ) AS new_customer_visits,
        COUNT(
            DISTINCT CASE
                WHEN d.visit_label = 'Frequent Visitor'
                THEN d.customer_id
            END
        ) AS frequent_visitors
    FROM rpt_st_visit_detail d
    WHERE d.store_id = NEW.store_id
      AND DATE_TRUNC('month', d.visit_date)::DATE = v_reporting_month
    GROUP BY d.store_id, d.store_location;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;
