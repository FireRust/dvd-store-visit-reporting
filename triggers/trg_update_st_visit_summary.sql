CREATE TRIGGER trg_update_st_visit_summary
AFTER INSERT ON rpt_st_visit_detail
FOR EACH ROW
EXECUTE FUNCTION fn_update_st_visit_summary();
