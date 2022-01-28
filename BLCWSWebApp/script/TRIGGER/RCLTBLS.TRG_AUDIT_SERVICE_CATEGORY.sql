create or replace TRIGGER RCLTBLS.TRG_AUDIT_SERVICE_CATEGORY
 BEFORE INSERT OR UPDATE ON CAM_SERVICE_CATEGORY_DTL
 FOR EACH ROW
Declare
lCount number;
BEGIN
	
	IF INSERTING THEN
		:new.RECORD_ADD_USER := SUBSTR(USER, 1, 10);
	END IF;
	IF INSERTING THEN
		:new.RECORD_ADD_DATE := to_number(to_char(sysdate, 'yyyymmdd'));
	END IF;
	IF INSERTING THEN
		:new.RECORD_ADD_TIME := to_number(to_char(sysdate, 'HH24MI'));
	END IF;
	IF UPDATING THEN
		:new.RECORD_CHANGE_USER := SUBSTR(USER, 1, 10);
	END IF;
	IF UPDATING THEN
		:new.RECORD_CHANGE_DATE := to_number(to_char(sysdate, 'yyyymmdd'));
	END IF;
	IF UPDATING THEN
		:new.RECORD_CHANGE_TIME := to_number(to_char(sysdate, 'HH24MI'));
	END IF;
END;