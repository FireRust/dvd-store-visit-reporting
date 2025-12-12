CREATE OR REPLACE PROCEDURE sp_refresh_st_visit_report()
LANGUAGE plpgsql
AS $$
BEGIN
    -- Clear existing report data
    TRUNCATE TABLE rpt_st_visit_summary;
    TRUNCATE TABLE rpt_st_visit_detail;

    -- Rebuild detailed report table from source data
    INSERT INTO rpt_st_visit_detail (
        visit_id,
        visit_date,
        store_id,
        store_location,
        customer_id,
        customer_full_name,
        visit_label
    )
    SELECT
        r.rental_id AS visit_id,
        r.rental_date::DATE AS visit_date,
        s.store_id,
        city.city AS store_location,
        c.customer_id,
        c.first_name || ' ' || c.last_name AS customer_full_name,
        get_visit_label(c.customer_id) AS visit_label
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN store s ON i.store_id = s.store_id
    JOIN address a ON s.address_id = a.address_id
    JOIN city ON a.city_id = city.city_id
    JOIN customer c ON r.customer_id = c.customer_id;
END;
$$;
