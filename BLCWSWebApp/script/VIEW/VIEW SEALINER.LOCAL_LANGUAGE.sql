CREATE OR REPLACE FORCE EDITIONABLE VIEW SEALINER.LOCAL_LANGUAGE( LOCAL_LANGUAGE_CODE,DESCRIPTION,RECORD_ADD_USER,RECORD_ADD_DATE,RECORD_ADD_TIME,RECORD_CHANGE_USER,RECORD_CHANGE_DATE,RECORD_CHANGE_TIME)
AS
  SELECT 
	 PK_CODE,DESCRIPTION,RECORD_ADD_USER,RECORD_ADD_DATE,RECORD_ADD_TIME,RECORD_CHANGE_USER,RECORD_CHANGE_DATE,RECORD_CHANGE_TIME
  FROM RCLTBLS.CAM_LOCAL_LANGUAGE;


GRANT SELECT ON SEALINER.LOCAL_LANGUAGE to RCLAPPS WITH GRANT OPTION;
GRANT SELECT,INSERT,UPDATE,DELETE ON SEALINER.LOCAL_LANGUAGE to RCLJOBS, VASAPPS WITH GRANT OPTION;