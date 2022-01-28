create or replace PACKAGE BODY PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER AS
/*-----------------------------------------------------------------------------------------------------------
- Search for DIM Arrival Notice Reminder
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  Cognis 22/04/2020
- CHANGE LOG ------------------------------------------------------------------------------------------------
## DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01 22/04/2020          Chandu                             
-----------------------------------------------------------------------------------------------------------*/

 PROCEDURE PCR_DIM_BLC_NOTICE_REMINDER_SEARCH(
      P_I_V_BL                       IN VARCHAR2,       
      P_I_V_SERVICE                  IN VARCHAR2,
      P_I_V_VESSEL                   IN VARCHAR2,
      P_I_V_VOYAGE                   IN VARCHAR2, 
      P_I_V_DIRECTION                IN VARCHAR2,      
      P_I_V_POL                      IN VARCHAR2,
      P_I_V_POD                      IN VARCHAR2,
      P_I_V_IN_VOYAGE                IN VARCHAR2,         
      P_I_V_ETA                      IN VARCHAR2,      
	  P_I_V_USER_ID                  IN VARCHAR2,
      
      P_O_V_BLC_MAPPING_LIST         OUT SYS_REFCURSOR

    ) AS
       V_SQL_1            VARCHAR2(3000);
        V_SQL_CNDTN       VARCHAR2(6000);
        V_SQL_CNDTN2      VARCHAR2(3000);
        P_I_V_FSC_CDOE    VARCHAR2(6);
        L_V_LINE        VARCHAR2(1);
        P_I_V_AGENT       VARCHAR2(3);
        P_I_V_TRADE       VARCHAR2(1);

    BEGIN  
      SELECT FSC_CODE,LINE
              INTO   P_I_V_FSC_CDOE,L_V_LINE
              FROM   RCLTBLS.ESM_USER_LOGIN 
              WHERE  USER_ID = P_I_V_USER_ID; 
              
        IF ( P_I_V_SERVICE IS NOT NULL ) THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DISCHARGE_SERVICE) = ' || '''' || p_i_v_service || '''';     ---- SERVICE
        END IF;

        IF ( P_I_V_VESSEL IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DISCHARGE_VESSEL) = ' || '''' || P_I_V_VESSEL || '''';     ---- VESSEL
        END IF;

        IF ( P_I_V_VOYAGE IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DISCHARGE_VOYAGE) = ' || '''' || P_I_V_VOYAGE || '''';     ---- VESSEL
        END IF;

         IF ( P_I_V_DIRECTION IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DISCHARGE_DIRECTION) = ' || '''' || P_I_V_DIRECTION || '''';     ---- DIRECTION
        END IF;
        
        IF ( P_I_V_POL IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DN_CUSTOMER_POL) = ' || '''' || P_I_V_POL || '''';     ---- POL
       END IF;
             
        IF ( P_I_V_POD IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DN_CUSTOMER_POD ) = ' || '''' || P_I_V_POD || '''';     ---- POD
        END IF;

       IF ( P_I_V_IN_VOYAGE IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.FIRST_VOYAGE) = ' || '''' || P_I_V_IN_VOYAGE || '''';     ---- IN_VOYAGE
       END IF;
      
       IF ( P_I_V_ETA IS NOT NULL ) THEN
       
        V_SQL_CNDTN := V_SQL_CNDTN || '  AND to_date(POD_ETA,''YYYYMMDD'') >= to_date(' || ''''||P_I_V_ETA||''' ,''YYYYMMDD'' )'  ;   
       END IF;
     

 v_sql_1 := ' select   DISCHARGE_VESSEL,DISCHARGE_VOYAGE,DISCHARGE_SERVICE,
 FOR_FSC,DISCHARGE_DIRECTION,DN_CUSTOMER_POL,DN_CUSTOMER_POD,DN_POT1,POD_ETD,POD_ETA,LINE from DEX_BL_HEADER HRD group by DISCHARGE_VESSEL,DISCHARGE_VOYAGE,DISCHARGE_SERVICE,
 FOR_FSC,DISCHARGE_DIRECTION,DN_CUSTOMER_POL,DN_CUSTOMER_POD,DN_POT1,POD_ETD,POD_ETA,LINE HAVING 1=1 ';  
        
    IF (  L_V_LINE  IS NOT NULL  ) THEN V_SQL_1 := V_SQL_1 || ' AND LINE = ' || '''' ||  L_V_LINE  || '''';     ---- lINE
      END IF;
     IF (  P_I_V_FSC_CDOE  != 'R'  ) THEN V_SQL_1 := V_SQL_1 || ' AND FOR_FSC = ' || '''' ||  P_I_V_FSC_CDOE  || '''';     ---- FOR_FSC
      END IF;  
    
    
    V_SQL_CNDTN2 :=  'ORDER BY HRD.DISCHARGE_SERVICE ';     
    V_SQL_1:=V_SQL_1||' '|| V_SQL_CNDTN||' '||V_SQL_CNDTN2;
      
  OPEN P_O_V_BLC_MAPPING_LIST FOR  V_SQL_1;

    END PCR_DIM_BLC_NOTICE_REMINDER_SEARCH;
    
    /*-----------------------------------------------------------------------------------------------------------
- Search for DIM Arrival Notice Reminder
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  Cognis 22/04/2020
- CHANGE LOG ------------------------------------------------------------------------------------------------
## DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01 22/04/2020          Chandu                             
-----------------------------------------------------------------------------------------------------------*/
    PROCEDURE PCR_DIM_BLC_NOTICE_REMINDER_VIEW_BL(
      P_I_V_BL                       IN VARCHAR2,       
      P_I_V_SERVICE                  IN VARCHAR2,
      P_I_V_VESSEL                   IN VARCHAR2,
      P_I_V_VOYAGE                   IN VARCHAR2, 
      P_I_V_DIRECTION                IN VARCHAR2,      
      P_I_V_POL                      IN VARCHAR2,
      P_I_V_POD                      IN VARCHAR2,
      P_I_V_IN_VOYAGE                IN VARCHAR2,         
      P_I_V_ETA                      IN VARCHAR2,      
	  P_I_V_USER_ID                  IN VARCHAR2,
	  ------------
	   P_I_V_FOR_FSC                 IN VARCHAR2,
	   P_I_V_PRINCIPAL_CODE          IN VARCHAR2,
	   P_I_V_SOC_COC                 IN VARCHAR2,
	   P_I_V_POD_ETA                 IN VARCHAR2,
	    ------------------
      P_O_V_BLC_MAPPING_LIST       OUT SYS_REFCURSOR
       
    ) AS
        V_SQL_1           VARCHAR2(3000);
        V_SQL_CNDTN       VARCHAR2(6000);
        V_SQL_CNDTN2      VARCHAR2(3000);
        P_I_V_FSC_CDOE    VARCHAR2(6);
        P_I_V_LINE        VARCHAR2(1);
        P_I_V_AGENT       VARCHAR2(3);
        P_I_V_TRADE       VARCHAR2(1);
        
    BEGIN  
     
     
        IF ( P_I_V_FOR_FSC IS NOT NULL ) THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.FOR_FSC) = ' || '''' || P_I_V_FOR_FSC || '''';     ---- FOR_FSC
        END IF;
  
        IF ( P_I_V_SERVICE IS NOT NULL ) THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DISCHARGE_SERVICE) = ' || '''' || P_I_V_SERVICE || '''';     ---- SERVICE
        END IF;

        IF ( P_I_V_VESSEL IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DISCHARGE_VESSEL) = ' || '''' || P_I_V_VESSEL || '''';     ---- VESSEL
        END IF;

        IF ( p_i_v_voyage IS NOT NULL ) THEN v_sql_cndtn := v_sql_cndtn || ' AND  UPPER(HRD.DISCHARGE_VOYAGE) = ' || '''' || p_i_v_voyage || '''';     ---- VESSEL
        END IF;
        
         IF ( P_I_V_DIRECTION IS NOT NULL ) THEN v_sql_cndtn := v_sql_cndtn || ' AND  UPPER(HRD.DISCHARGE_DIRECTION) = ' || '''' || P_I_V_DIRECTION || '''';     ---- DIRECTION
        END IF;   
        
        IF ( P_I_V_POL IS NOT NULL ) THEN v_sql_cndtn := v_sql_cndtn || ' AND  UPPER(HRD.DN_CUSTOMER_POL) = ' || '''' || P_I_V_POL || '''';     ---- POL
        END IF;
        
        IF ( P_I_V_POD IS NOT NULL ) THEN v_sql_cndtn := v_sql_cndtn || ' AND  UPPER(HRD.DN_CUSTOMER_POD ) = ' || '''' || P_I_V_POD || '''';     ---- POD
        END IF;
        
        IF ( p_i_v_PRINCIPAL_CODE IS NOT NULL ) THEN v_sql_cndtn := v_sql_cndtn || ' AND  UPPER(HRD.PRINCIPAL_CODE) = ' || '''' || P_I_V_PRINCIPAL_CODE || '''';     ----PRINCIPAL_CODE
        END IF;
        
         IF ( P_I_V_BL IS NOT NULL ) THEN v_sql_cndtn := v_sql_cndtn || ' AND  UPPER(HRD.PK_BL_NO) = ' || '''' || P_I_V_BL || '''';     ---- BL_NO
        END IF;   
        
        IF ( P_I_V_SOC_COC IS NOT NULL ) THEN v_sql_cndtn := v_sql_cndtn || ' AND  UPPER(HRD.SOC_COC) = ' || '''' || P_I_V_SOC_COC || '''';     ---- SOC COC
        END IF;
        
        IF ( P_I_V_POD_ETA IS NOT NULL ) THEN v_sql_cndtn := v_sql_cndtn || ' AND  UPPER(HRD.POD_ETA ) = ' || '''' || P_I_V_POD_ETA || '''';     ---- POD_ETA
        END IF;
    
 V_SQL_1 := 'SELECT 
    hrd.for_fsc,
    hrd.discharge_service,
    hrd.DISCHARGE_VESSEL ,
    hrd.DISCHARGE_VOYAGE ,
    hrd.DISCHARGE_DIRECTION,
    hrd.DN_CUSTOMER_POL ,
    hrd.DN_CUSTOMER_POD,
    hrd.FIRST_VOYAGE,
    hrd.FIRST_VESSEL,
    hrd.PK_BL_NO,
    hrd.BL_PREPARED_AT ,
    hrd.BL_PREPARED_BY,
    '||''''''||' PRINT_POL,
    '||''''''||' PRINT_POD ,
    hrd.SOC_COC,
    hrd.DIM_STATUS,
    hrd.TRADE_FSC ,
    hrd.BL_TYPE,
    hrd.BL_CREATION_DATE,
    hrd.BL_PRINT_STATUS,
    hrd.BL_ORG_QTY,
    hrd.DN_POL_PCSQ,
    hrd.DN_POL,
    hrd.DN_POD,
    hrd.LOAD_VESSEL_TYPE ,
    hrd.FINAL_DEST_ETA,
    hrd.POL_ETD,
    hrd.FINAL_SEALEG_POL,
    hrd.FINAL_SEALEG_POD,
    hrd.DISCHARGE_VESSEL_TYPE,
    hrd.POD_ETA,
    hrd.POD_ETD,
    '||''''''||' AYPVES,
    '||''''''||' AYPVOY ,
    '||''''''||' AYPSRV ,
    hrd.DN_PLR,
    hrd.DN_PLD,
    '||''''''||' AYDPTM,
    hrd.GROSS_CARGO_WT_IMP,
    hrd.GROSS_CARGO_MT_IMP,
    hrd.IMP_MT,
    hrd.MET_WT,
    hrd.MET_MT,
    hrd.QTY_PKG,
    hrd.QTY_20,
    hrd.QTY_40,
    hrd.SHIPMENT_TERM,
    hrd.DN_MA_REASON_CODE,
    '||''''''||' NVOCC_FLAG,
    hrd.PRINCIPAL_CODE,
    hrd.SHIPMENT_TYPE_AT_POL,
    hrd.SHIPMENT_TYPE_AT_POD,
    hrd.AYS2PL,
    hrd.AYS2PD,
    hrd.FK_PREVIOUS_BL_NO,
    hrd.QTY_45,
    hrd.SEND_TO_DISCH_AGENT_FLAG,
    '||''''''||' SHORT_SHIPPED_FLAG,
    hrd.HAZMAT_CONTACT_AT_ORIGIN,
    hrd.HAZMAT_CONTACT_AT_DESTINATION,
    hrd.HAZMAT_ORIGIN_TELNO,
    hrd.HAZMAT_DESTINATION_TELNO,
    hrd.PRINT_OCEAN_VESSEL1,
    hrd.PRINT_OCEAN_VOYAGE1,
    hrd.PRINT_OCEAN_VOYAGE2,
    hrd.PRINT_OCEAN_VOYAGE2,
    hrd.AYRLOF,
    hrd.AYRLDT,
    hrd.GROSS_CARGO_MT_MET,
    '||''''''||' AYMSM2,
    hrd.GROSS_CARGO_WT_MET,
    '||''''''||' AYWTM2,
    hrd.TOTAL_TEUS,
    hrd.SHIPMENT_TYPE1_TEU,
    hrd.SHIPMENT_TYPE2_TEU,
    '||''''''||' AYPRYN,
    '||''''''||' AYPOLP,
    '||''''''||' AYPODP,
    '||''''''||' AYRDTP,
    '||''''''||' AYSDTP,
    '||''''''||' EDI_STATUS,
    '||''''''||' EDI_DATE,
    '||''''''||' EDI_TIME,
    hrd.MA_SEQ_NO,
    hrd.MA_USER,
    hrd.MA_USER,
    '||''''''||' AYINST,
    '||''''''||' AYINDT,
    '||''''''||' AYINTM,
    hrd.DIM_MANIFESTED_DATE,
    hrd.PART_OF_BL_FLAG,
    hrd.TOTAL_PKG,
    '||''''''||' AYWTI2,
    '||''''''||' AYMSI2,
    hrd.AYPCK2,
    hrd.IMP_MET,
    hrd.IMP_WT,
    hrd.DEX_MANIFESTED_DATE,
    hrd.DEX_STATUS,
    hrd.DN_DESTINATION_FSC,
    hrd.LOAD_SERVICE,
    hrd.LOAD_DIRECTION,
    hrd.NUMBER_OF_TIME_ARRAVAL_PRINTED,
    hrd.LAST_DATE_ARRIVAL_PRINTED
   --, fnc_get_port_name(hrd.DN_CUSTOMER_POL) AS polcname,
   -- fnc_get_port_name(hrd.DN_CUSTOMER_POD) AS podcname
FROM DEX_BL_HEADER HRD WHERE HRD.DIM_STATUS IN (''2'',''3'',''4'',''5'')';  
  
   --IF ( P_I_V_AGENT IS NOT NULL AND P_I_V_AGENT = '***' ) THEN V_SQL_1 := V_SQL_1 || ' AND LINE = ' || '''' || P_I_V_LINE || '''';     ---- DIRECTION
   --     END IF;
    
    
    V_SQL_CNDTN2 :=  'ORDER BY HRD.PK_BL_NO ';     
    V_SQL_1:=V_SQL_1||' '|| V_SQL_CNDTN||' '||V_SQL_CNDTN2;
       
      
  OPEN P_O_V_BLC_MAPPING_LIST FOR  V_SQL_1;

END PCR_DIM_BLC_NOTICE_REMINDER_VIEW_BL;
    
 /*-----------------------------------------------------------------------------------------------------------
- Search for DIM GET PORT
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  Cognis 22/04/2020
- -----------CHANGE LOG ------------------------------------------------------------------------------------
##     DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01     15/05/2020          Chandu                             
-----------------------------------------------------------------------------------------------------------*/
 PROCEDURE PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER_PORT_SEARCH(


                                          P_I_V_FSC_CODE                    IN VARCHAR2,
                                          P_O_V_BLC_MAPPING_LIST           OUT SYS_REFCURSOR

)AS
     V_SQL_1 VARCHAR2(3000);
	 V_SQL_CNDTN VARCHAR2(6000);


	BEGIN  

      V_SQL_1 := 'Select OCEAN_PORT from ( SELECT CRCNTR, CRCONM, CRFLV1, CRFLV2, CRFLV3, (SELECT SGDATE FROM ITP001 WHERE SGLINE = ITP188.CRFLV1 AND SGTRAD = ITP188.CRFLV2) 
            AS DATE_FORMAT, CRADD1, CRADD2, CRADD3, CRADD4, CRCITY, CRSTAT, CRZIP, CRPHON, CRFAXN, TEMP.SMCURR AS SMCURR,TEMP.SSCURR AS SCCURR, CRDESC, CRCNCD, FSC_CM, CONTROL_FSC_CM, 
            LOCATION_CM, CRPONT, CONTROL_FSC, (SELECT DISTINCT STTCUR FROM ITP0TD WHERE SGTRAD = ''*'') AS STTCUR, (SELECT CASE WHEN (PREFER_PORT_1 IS NULL OR PREFER_PORT_1 ='''') 
            THEN PREFER_PORT_2 WHEN (PREFER_PORT_1 IS NULL OR PREFER_PORT_1 ='''') AND (PREFER_PORT_2 IS NULL OR PREFER_PORT_2 ='''') THEN PREFER_PORT_3 ELSE PREFER_PORT_1 END FROM POINT_MASTER WHERE POINT_CODE = CRPONT) 
            AS OCEAN_PORT, ITPLVL.MAIN_CURRENCY FROM ITP188,ITPLVL ,(SELECT SMCURR, SSCURR FROM ITP001 WHERE ITP001.SGTRAD = ''*'') TEMP
			WHERE ITPLVL.LVLINE = ITP188.CRFLV1  AND ITPLVL.LVTRAD = ITP188.CRFLV2  AND ITPLVL.LVAGNT = ITP188.CRFLV3 ';

			 IF(P_I_V_FSC_CODE IS NOT NULL)
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND ITP188.CRCNTR = ' || ''''||P_I_V_FSC_CODE||''''||')'  ;     ---- LOOKUP_PORT
       END IF;

      V_SQL_1:=V_SQL_1||' '|| V_SQL_CNDTN;

       

      OPEN P_O_V_BLC_MAPPING_LIST FOR  V_SQL_1;


END PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER_PORT_SEARCH;

  /*-----------------------------------------------------------------------------------------------------------
- Search for DIM GET SEARCH INVOYAGE
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  Cognis 22/04/2020
- -----------CHANGE LOG ------------------------------------------------------------------------------------
##     DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01     15/06/2020          Chandu                             
-----------------------------------------------------------------------------------------------------------*/
PROCEDURE PCR_DIM_BLC_NOTICE_REMINDER_SEARCH_INVOYAGE(

                                              
                                          P_I_V_BL                       IN VARCHAR2,       
                                          P_I_V_SERVICE                  IN VARCHAR2,
                                          P_I_V_VESSEL                   IN VARCHAR2,
                                          P_I_V_VOYAGE                   IN VARCHAR2, 
                                          P_I_V_DIRECTION                IN VARCHAR2,      
                                          P_I_V_POL                      IN VARCHAR2,
                                          P_I_V_POD                      IN VARCHAR2,
                                          P_I_V_IN_VOYAGE                IN VARCHAR2,         
                                          P_I_V_ETA                      IN VARCHAR2,      
                                          P_I_V_USER_ID                  IN VARCHAR2,
                                          
                                          P_O_V_BLC_MAPPING_LIST         OUT SYS_REFCURSOR

)AS
       V_SQL_1 VARCHAR2(3000);
	   V_SQL_CNDTN VARCHAR2(6000);
       V_SQL_CNDTN2 VARCHAR2(3000);
       L_V_FSC_CODE VARCHAR2(6);
       L_V_LINE VARCHAR2(6);
       L_V_SERVICE VARCHAR2(1000);
       L_V_VESSEL VARCHAR2(1000);
       L_V_VOYAGE VARCHAR2(1000);
       L_V_DIRECTION   VARCHAR2(1000);
	BEGIN  
    
 	 SELECT FSC_CODE,LINE
              INTO   L_V_FSC_CODE,L_V_LINE
              FROM   RCLTBLS.ESM_USER_LOGIN 
              WHERE  USER_ID = P_I_V_USER_ID; 

	 V_SQL_1 :='select DISCHARGE_VESSEL,DISCHARGE_VOYAGE,FIRST_VOYAGE,DISCHARGE_SERVICE,
 FOR_FSC,DISCHARGE_DIRECTION,DN_CUSTOMER_POL,DN_CUSTOMER_POD,DN_POT1,POD_ETD,POD_ETA,LINE from DEX_BL_HEADER HRD group by DISCHARGE_VESSEL,DISCHARGE_VOYAGE,FIRST_VOYAGE,DISCHARGE_SERVICE,
 FOR_FSC,DISCHARGE_DIRECTION,DN_CUSTOMER_POL,DN_CUSTOMER_POD,DN_POT1,POD_ETD,POD_ETA,LINE HAVING 1=1 ';  
--HQ USER
        IF L_V_FSC_CODE ='R' THEN
        V_SQL_CNDTN := V_SQL_CNDTN|| ' AND HRD.LINE =''R'' ';
        ELSE  
        V_SQL_CNDTN :=V_SQL_CNDTN|| 'AND HRD.LINE ='||''''||L_V_LINE||''''||' AND FOR_FSC ='||''''||L_V_FSC_CODE||'''';
        END IF; 

        L_V_SERVICE := 'SELECT REGEXP_SUBSTR('||''''||P_I_V_SERVICE||''''||',''[^,]+'', 1, LEVEL) FROM DUAL CONNECT BY REGEXP_SUBSTR('||''''||P_I_V_SERVICE||''''||', ''[^,]+'', 1, LEVEL) IS NOT NULL';
         L_V_VESSEL := 'SELECT REGEXP_SUBSTR('||''''||P_I_V_VESSEL||''''||',''[^,]+'', 1, LEVEL) FROM DUAL CONNECT BY REGEXP_SUBSTR('||''''||P_I_V_VESSEL||''''||', ''[^,]+'', 1, LEVEL) IS NOT NULL';
        L_V_VOYAGE := 'SELECT REGEXP_SUBSTR('||''''||P_I_V_VOYAGE||''''||',''[^,]+'', 1, LEVEL) FROM DUAL CONNECT BY REGEXP_SUBSTR('||''''||P_I_V_VOYAGE||''''||', ''[^,]+'', 1, LEVEL) IS NOT NULL';
       L_V_DIRECTION := 'SELECT REGEXP_SUBSTR('||''''||P_I_V_DIRECTION||''''||',''[^,]+'', 1, LEVEL) FROM DUAL CONNECT BY REGEXP_SUBSTR('||''''||P_I_V_DIRECTION||''''||', ''[^,]+'', 1, LEVEL) IS NOT NULL';

                   
        IF(P_I_V_SERVICE IS NOT NULL )
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.DISCHARGE_SERVICE IN ( ' || L_V_SERVICE||' )'  ;     ---- SERVICE
       END IF;

       IF(P_I_V_VESSEL IS NOT NULL)
        THEN                  
          V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.DISCHARGE_VESSEL IN (' ||L_V_VESSEL||' )'  ;     ---- VESSEL
       END IF;       

       IF(P_I_V_VOYAGE IS NOT NULL)
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.DISCHARGE_VOYAGE IN (' || L_V_VOYAGE||' )'  ;      ---- VESSEL
       END IF;
        
         IF ( P_I_V_DIRECTION IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.DISCHARGE_DIRECTION IN (' ||L_V_DIRECTION||' )'  ;    ---- DIRECTION
        END IF;
        
        IF ( P_I_V_POL IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DN_CUSTOMER_POL) = ' || '''' || P_I_V_POL || '''';     ---- POL
       END IF;
             
        IF ( P_I_V_POD IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.DN_CUSTOMER_POD ) = ' || '''' || P_I_V_POD || '''';     ---- POD
        END IF;

       IF ( P_I_V_IN_VOYAGE IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.FIRST_VOYAGE) = ' || '''' || P_I_V_IN_VOYAGE || '''';     ---- IN_VOYAGE
       END IF;
      
       IF ( P_I_V_ETA IS NOT NULL ) THEN
       
        V_SQL_CNDTN := V_SQL_CNDTN || '  AND to_date(POD_ETA,''YYYYMMDD'') >= to_date(' || ''''||P_I_V_ETA||''' ,''YYYYMMDD'' )'  ;   
       END IF;
     
       
     -- V_SQL_CNDTN2 :=  'ORDER BY HRD.PK_BL_NO '; 
     -- V_SQL_1:=V_SQL_1||' '|| V_SQL_CNDTN; 
     V_SQL_CNDTN2 :=  'ORDER BY HRD.DISCHARGE_SERVICE ';     
    V_SQL_1:=V_SQL_1||' '|| V_SQL_CNDTN||' '||V_SQL_CNDTN2;
            
            
  OPEN P_O_V_BLC_MAPPING_LIST FOR  V_SQL_1;
  END PCR_DIM_BLC_NOTICE_REMINDER_SEARCH_INVOYAGE;
         
END PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER;