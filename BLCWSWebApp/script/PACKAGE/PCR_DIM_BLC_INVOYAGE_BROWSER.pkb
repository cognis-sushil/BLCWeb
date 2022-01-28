create or replace PACKAGE BODY PCR_DIM_BLC_INVOYAGE_BROWSER AS
/*-----------------------------------------------------------------------------------------------------------
- Search for DIM INVOYAGE BROWSER
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  Cognis 22/04/2020
- CHANGE LOG ------------------------------------------------------------------------------------------------
## DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01 22/04/2020          Chandu                             
-----------------------------------------------------------------------------------------------------------*/


PROCEDURE   PCR_DIM_BLC_INVOYAGE_BROWSER_SEARCH(


                                          P_I_V_LOOKUP_PORT                IN VARCHAR2,       
                                          P_I_V_LOOKUP_INVOYAGE            IN VARCHAR2,
										  P_I_V_USER_ID                    IN VARCHAR2,
                                          P_I_V_ETA_DATE                   IN VARCHAR2,
                                          P_O_V_BLC_MAPPING_LIST           OUT SYS_REFCURSOR

	 )AS
     V_SQL_1 VARCHAR2(3000);
	 V_SQL_CNDTN VARCHAR2(6000);

    
	BEGIN  

      V_SQL_1 :='SELECT FK_PORT_CALL, IN_VOYAGE, IN_VOYAGE_NO,FK_PORT_CALL_SEQ, FK_SERVICE,FK_VESSEL,FK_VOYAGE,DIRECTION,ETA_DATE ,FK_TERMINAL  FROM RCLTBLS.VSS_INVOYAGE_LOOKUP_HDR H,RCLTBLS.VSS_INVOYAGE_LOOKUP_DTL D WHERE H.PK_HDR_LOOKUP_SEQ = D.FK_HDR_LOOKUP_SEQ ';  
      
       IF(P_I_V_LOOKUP_PORT IS NOT NULL)
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND  PK_LOOKUP_PORT = ' || ''''||P_I_V_LOOKUP_PORT||''''  ;     ---- LOOKUP_PORT
       END IF;

	    IF(P_I_V_LOOKUP_INVOYAGE IS NOT NULL)
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND  PK_LOOKUP_INVOYAGE = ' || ''''||P_I_V_LOOKUP_INVOYAGE||''''  ;     ---- LOOKUP_INVOYAGE
       END IF;
       
        IF( P_I_V_ETA_DATE IS NOT NULL) THEN
      V_SQL_CNDTN := V_SQL_CNDTN || '  AND TO_DATE(ETD_DATE,''YYYYMMDD'') = TO_DATE(' || ''''||P_I_V_ETA_DATE||''' ,''YYYYMMDD'' )'  ;   
     END IF;
     
      V_SQL_1:=V_SQL_1||' '|| V_SQL_CNDTN;


      OPEN P_O_V_BLC_MAPPING_LIST FOR  V_SQL_1;

  END PCR_DIM_BLC_INVOYAGE_BROWSER_SEARCH;

END PCR_DIM_BLC_INVOYAGE_BROWSER;