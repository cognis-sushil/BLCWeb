create or replace PACKAGE BODY PCR_DIM_BLC_ARRIVALE_NOTICE AS
/*-----------------------------------------------------------------------------------------------------------
- Search for DIM Arrival Notice
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  Cognis 22/04/2020
- CHANGE LOG ------------------------------------------------------------------------------------------------
## DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01 22/04/2020          Chandu                             
-----------------------------------------------------------------------------------------------------------*/


PROCEDURE   PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH( 

                                          P_I_V_BL                     IN VARCHAR2,       
                                          P_I_V_SERVICE                IN VARCHAR2,
                                          P_I_V_VESSEL                 IN VARCHAR2,
                                          P_I_V_VOYAGE                 IN VARCHAR2,       
                                          P_I_V_PORT_LOOKUP            IN VARCHAR2,
                                          P_I_V_SOC_COC                IN VARCHAR2,         
                                          P_I_V_ETA_DATE               IN VARCHAR2,
                                          P_I_V_ETA_PORT_DATE          IN VARCHAR2,     
                                          P_I_V_USER_ID                IN VARCHAR2,
                                          P_O_V_BLC_MAPPING_LIST       OUT SYS_REFCURSOR
	 )AS
     V_SQL_1 VARCHAR2(3000);
	 V_SQL_CNDTN VARCHAR2(6000);
     V_SQL_CNDTN2      VARCHAR2(3000);
        L_V_FSC_CODE VARCHAR2(6);
        L_V_LINE VARCHAR2(6);
	BEGIN  
       
     
   
 	 SELECT FSC_CODE,LINE
              INTO   L_V_FSC_CODE,L_V_LINE
              FROM   RCLTBLS.ESM_USER_LOGIN 
              WHERE  USER_ID = P_I_V_USER_ID; 



	 V_SQL_1 :=' SELECT HRD.FOR_FSC,HRD.DISCHARGE_SERVICE,HRD.DISCHARGE_VESSEL ,HRD.DISCHARGE_VOYAGE ,HRD.DISCHARGE_DIRECTION,
     HRD.DN_CUSTOMER_POL ,HRD.DN_CUSTOMER_POD,HRD.FIRST_VOYAGE,HRD.FIRST_VESSEL,HRD.PK_BL_NO,HRD.BL_PREPARED_AT ,HRD.BL_PREPARED_BY,
     '||''''''||' PRINT_POL,'||''''''||' PRINT_POD ,'||'HRD.SOC_COC,HRD.DIM_STATUS,HRD.TRADE_FSC ,HRD.BL_TYPE,HRD.BL_CREATION_DATE,
     HRD.BL_PRINT_STATUS,
     HRD.BL_ORG_QTY,HRD.DN_POL_PCSQ,HRD.DN_POL,HRD.DN_POD,HRD.LOAD_VESSEL_TYPE ,HRD.FINAL_DEST_ETA,HRD.POL_ETD,HRD.FINAL_SEALEG_POL,
    HRD.FINAL_SEALEG_POD,HRD.DISCHARGE_VESSEL_TYPE,HRD.POD_ETA,HRD.POD_ETD,'||''''''||' AYPVES,'||''''''||'AYPVOY ,'||''''''||
    ' AYPSRV ,HRD.DN_PLR, HRD.DN_PLD,'||''''''||' AYDPTM,'||'HRD.GROSS_CARGO_WT_IMP,HRD.GROSS_CARGO_MT_IMP,HRD.IMP_MT,HRD.MET_WT,
    HRD.MET_MT,HRD.QTY_PKG,HRD.QTY_20,HRD.QTY_40, HRD.SHIPMENT_TERM,HRD.DN_MA_REASON_CODE,'||''''''||' NVOCC_FLAG,'||'HRD.PRINCIPAL_CODE
    ,HRD.SHIPMENT_TYPE_AT_POL,HRD.SHIPMENT_TYPE_AT_POD, HRD.AYS2PL,HRD.AYS2PD,HRD.FK_PREVIOUS_BL_NO,HRD.QTY_45,
    HRD.SEND_TO_DISCH_AGENT_FLAG,'||''''''||' SHORT_SHIPPED_FLAG,'||'HRD.HAZMAT_CONTACT_AT_ORIGIN, HRD.HAZMAT_CONTACT_AT_DESTINATION,
    HRD.HAZMAT_ORIGIN_TELNO,HRD.HAZMAT_DESTINATION_TELNO,HRD.PRINT_OCEAN_VESSEL1,HRD.PRINT_OCEAN_VOYAGE1,
    HRD.PRINT_OCEAN_VOYAGE2,HRD.PRINT_OCEAN_VOYAGE2,HRD.AYRLOF,HRD.AYRLDT,HRD.GROSS_CARGO_MT_MET,'||''''''||' AYMSM2,'||'HRD.GROSS_CARGO_WT_MET,
   '||''''''||'AYWTM2,'||'HRD.TOTAL_TEUS,HRD.SHIPMENT_TYPE1_TEU,HRD.SHIPMENT_TYPE2_TEU,'||''''''||' AYPRYN,'||''''''||' AYPOLP,'||''''''||'AYPODP,
   '||''''''||' AYRDTP,AYSDTP AYSDTP,'||''''''||' EDI_STATUS,'||''''''||' EDI_DATE,'||''''''||' EDI_TIME,'||'HRD.MA_SEQ_NO,HRD.MA_USER,
   HRD.MA_USER,'||''''''||' AYINST,'||''''''||' AYINDT,'||''''''||' AYINTM,'||'HRD.DIM_MANIFESTED_DATE, HRD.PART_OF_BL_FLAG,
   HRD.TOTAL_PKG,'||''''''||' AYWTI2,'||''''''||' AYMSI2,'||'HRD.AYPCK2,HRD.IMP_MET,HRD.IMP_WT,HRD.DEX_MANIFESTED_DATE,HRD.DEX_STATUS,
    HRD.DN_DESTINATION_FSC,HRD.LOAD_SERVICE,HRD.LOAD_DIRECTION,HRD.NUMBER_OF_TIME_ARRAVAL_PRINTED,HRD.LAST_DATE_ARRIVAL_PRINTED
 ,HRD.BLID as BLID
    ,HRD.DN_POT1
    ,HRD.DN_CUSTOMER_POD as PODCNAME,
    HRD.DN_CUSTOMER_POL  AS POLCNAME
FROM DEX_BL_HEADER HRD WHERE HRD.DIM_STATUS IN (''2'',''3'',''4'',''5'')';  
--HQ USER
        IF L_V_FSC_CODE ='R' THEN
        V_SQL_CNDTN := V_SQL_CNDTN|| ' AND HRD.LINE =''R'' ';
        ELSE  
        V_SQL_CNDTN :=V_SQL_CNDTN|| 'AND HRD.LINE ='||''''||L_V_LINE||''''||' AND FOR_FSC ='||''''||L_V_FSC_CODE||'''';
        END IF; 


        IF(P_I_V_BL IS NOT NULL )
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.PK_BL_NO = ' || ''''||P_I_V_BL||''''  ;     ---- SERVICE
       END IF;

        IF(P_I_V_SERVICE IS NOT NULL )
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.DISCHARGE_SERVICE = ' || ''''||P_I_V_SERVICE||''''  ;     ---- SERVICE
       END IF;

        IF(P_I_V_SOC_COC IS NOT NULL )
        THEN 
          IF(P_I_V_SOC_COC = 'SOC') 
           THEN
           V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.SOC_COC = ''S'''  ;     ---- SOC
          ELSIF(P_I_V_SOC_COC = 'COC')
           THEN
           V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.SOC_COC = ''C'''  ;     ---- COC
       --   ELSE
      --     V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.SOC_COC = ''B'''  ;     ---- BOTH
          END IF;
       END IF;

       IF(P_I_V_VESSEL IS NOT NULL)
        THEN                  
          V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.DISCHARGE_VESSEL = ' || ''''||P_I_V_VESSEL||''''  ;     ---- VESSEL
       END IF;       

       IF(P_I_V_VOYAGE IS NOT NULL)
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.DISCHARGE_VOYAGE = ' || ''''||P_I_V_VOYAGE||''''  ;     ---- VESSEL
       END IF;

       IF(P_I_V_PORT_LOOKUP IS NOT NULL)
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.DN_CUSTOMER_POD = ' || ''''||P_I_V_PORT_LOOKUP||''''  ;     ---- VESSEL
       END IF;

       IF(P_I_V_ETA_DATE IS NOT NULL)
        THEN   --In data base there are Invalied date  are there that way comment the beloow line             
        -- V_SQL_CNDTN := V_SQL_CNDTN || 'AND TO_DATE(' || '''' || P_I_V_ETA_DATE || '''' ||', ''YYYYMMDD'') = to_date(HRD.POD_ETA, ''YYYYMMDD'') ';   ---- ETA DATE
      V_SQL_CNDTN := V_SQL_CNDTN || 'AND ' || '''' || P_I_V_ETA_DATE || '''' ||' = HRD.POD_ETA ';
       END IF;

       IF(P_I_V_ETA_PORT_DATE IS NOT NULL) 
        THEN                   
         V_SQL_CNDTN := V_SQL_CNDTN || 'AND TO_DATE(' || '''' || P_I_V_ETA_PORT_DATE || '''' ||', ''YYYYMMDD'') = to_date(HRD.FINAL_DEST_ETA, ''YYYYMMDD'') ';   ---- ETA PORT DATE
       END IF;
       
      V_SQL_CNDTN2 :=  'ORDER BY HRD.PK_BL_NO '; 
      V_SQL_1:=V_SQL_1||' '|| V_SQL_CNDTN ||' '|| V_SQL_CNDTN2;
      
      
     
  OPEN P_O_V_BLC_MAPPING_LIST FOR  V_SQL_1;

END PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH;

/*-----------------------------------------------------------------------------------------------------------
- Update for DIM Arrival Notice Printed
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  Cognis 08/05/2020
- CHANGE LOG ------------------------------------------------------------------------------------------------
## DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01 08/05/2020          Chandu                             
-----------------------------------------------------------------------------------------------------------*/
PROCEDURE PCR_DIM_BLC_ARRIVALE_NOTICE_PRINTED_UPDATE(
                          P_I_V_BL                     IN VARCHAR2,
                          P_I_V_DATE                   IN VARCHAR2,
                          P_O_V_BLC_MAPPING_LIST       OUT SYS_REFCURSOR
  )AS
     V_SQL_1 VARCHAR2(3000);
	 V_SQL_CNDTN VARCHAR2(6000);
     L_V_FSC_CODE VARCHAR2(6);
      L_V_PRINTED VARCHAR2(6);
       
	BEGIN  
         UPDATE DEX_BL_HEADER SET   last_date_arrival_printed = P_I_V_DATE WHERE PK_BL_NO =P_I_V_BL  ;
  
 -- OPEN P_O_V_BLC_MAPPING_LIST FOR  V_SQL_1;
  END PCR_DIM_BLC_ARRIVALE_NOTICE_PRINTED_UPDATE;

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
 PROCEDURE PCR_DIM_BLC_ARRIVALE_NOTICE_PORT_SEARCH(


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

END PCR_DIM_BLC_ARRIVALE_NOTICE_PORT_SEARCH;
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
PROCEDURE PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH_INVOYAGE(

                                              
                                          P_I_V_BL                     IN VARCHAR2,       
                                          P_I_V_SERVICE                IN VARCHAR2,
                                          P_I_V_VESSEL                 IN VARCHAR2,
                                          P_I_V_VOYAGE                 IN VARCHAR2, 
                                          P_I_V_DIRECTION              IN VARCHAR2,
                                          P_I_V_PORT_LOOKUP            IN VARCHAR2,
                                          P_I_V_SOC_COC                IN VARCHAR2,         
                                          P_I_V_ETA_DATE               IN VARCHAR2,
                                          P_I_V_ETA_PORT_DATE          IN VARCHAR2,     
                                          P_I_V_USER_ID                IN VARCHAR2,
                                          P_I_V_IN_VOYAGE                IN VARCHAR2,
                                          P_O_V_BLC_MAPPING_LIST       OUT SYS_REFCURSOR
)AS
     V_SQL_1 VARCHAR2(3000);
	 V_SQL_CNDTN VARCHAR2(6000);
     V_SQL_CNDTN2      VARCHAR2(3000);
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

	 V_SQL_1 :=' SELECT HRD.FOR_FSC,HRD.DISCHARGE_SERVICE,HRD.DISCHARGE_VESSEL ,HRD.DISCHARGE_VOYAGE ,HRD.DISCHARGE_DIRECTION,
     HRD.DN_CUSTOMER_POL ,HRD.DN_CUSTOMER_POD,HRD.FIRST_VOYAGE,HRD.FIRST_VESSEL,HRD.PK_BL_NO,HRD.BL_PREPARED_AT ,HRD.BL_PREPARED_BY,
     '||''''''||' PRINT_POL,'||''''''||' PRINT_POD ,'||'HRD.SOC_COC,HRD.DIM_STATUS,HRD.TRADE_FSC ,HRD.BL_TYPE,HRD.BL_CREATION_DATE,
     HRD.BL_PRINT_STATUS,
     HRD.BL_ORG_QTY,HRD.DN_POL_PCSQ,HRD.DN_POL,HRD.DN_POD,HRD.LOAD_VESSEL_TYPE ,HRD.FINAL_DEST_ETA,HRD.POL_ETD,HRD.FINAL_SEALEG_POL,
    HRD.FINAL_SEALEG_POD,HRD.DISCHARGE_VESSEL_TYPE,HRD.POD_ETA,HRD.POD_ETD,'||''''''||' AYPVES,'||''''''||'AYPVOY ,'||''''''||
    ' AYPSRV ,HRD.DN_PLR, HRD.DN_PLD,'||''''''||' AYDPTM,'||'HRD.GROSS_CARGO_WT_IMP,HRD.GROSS_CARGO_MT_IMP,HRD.IMP_MT,HRD.MET_WT,
    HRD.MET_MT,HRD.QTY_PKG,HRD.QTY_20,HRD.QTY_40, HRD.SHIPMENT_TERM,HRD.DN_MA_REASON_CODE,'||''''''||' NVOCC_FLAG,'||'HRD.PRINCIPAL_CODE
    ,HRD.SHIPMENT_TYPE_AT_POL,HRD.SHIPMENT_TYPE_AT_POD, HRD.AYS2PL,HRD.AYS2PD,HRD.FK_PREVIOUS_BL_NO,HRD.QTY_45,
    HRD.SEND_TO_DISCH_AGENT_FLAG,'||''''''||' SHORT_SHIPPED_FLAG,'||'HRD.HAZMAT_CONTACT_AT_ORIGIN, HRD.HAZMAT_CONTACT_AT_DESTINATION,
    HRD.HAZMAT_ORIGIN_TELNO,HRD.HAZMAT_DESTINATION_TELNO,HRD.PRINT_OCEAN_VESSEL1,HRD.PRINT_OCEAN_VOYAGE1,
    HRD.PRINT_OCEAN_VOYAGE2,HRD.PRINT_OCEAN_VOYAGE2,HRD.AYRLOF,HRD.AYRLDT,HRD.GROSS_CARGO_MT_MET,'||''''''||' AYMSM2,'||'HRD.GROSS_CARGO_WT_MET,
   '||''''''||'AYWTM2,'||'HRD.TOTAL_TEUS,HRD.SHIPMENT_TYPE1_TEU,HRD.SHIPMENT_TYPE2_TEU,'||''''''||' AYPRYN,'||''''''||' AYPOLP,'||''''''||'AYPODP,
   '||''''''||' AYRDTP,AYSDTP AYSDTP,'||''''''||' EDI_STATUS,'||''''''||' EDI_DATE,'||''''''||' EDI_TIME,'||'HRD.MA_SEQ_NO,HRD.MA_USER,
   HRD.MA_USER,'||''''''||' AYINST,'||''''''||' AYINDT,'||''''''||' AYINTM,'||'HRD.DIM_MANIFESTED_DATE, HRD.PART_OF_BL_FLAG,
   HRD.TOTAL_PKG,'||''''''||' AYWTI2,'||''''''||' AYMSI2,'||'HRD.AYPCK2,HRD.IMP_MET,HRD.IMP_WT,HRD.DEX_MANIFESTED_DATE,HRD.DEX_STATUS,
    HRD.DN_DESTINATION_FSC,HRD.LOAD_SERVICE,HRD.LOAD_DIRECTION,HRD.NUMBER_OF_TIME_ARRAVAL_PRINTED,HRD.LAST_DATE_ARRIVAL_PRINTED
 ,HRD.BLID as BLID
    ,HRD.DN_POT1
    ,HRD.DN_CUSTOMER_POD as PODCNAME,
    HRD.DN_CUSTOMER_POL  AS POLCNAME
FROM DEX_BL_HEADER HRD WHERE HRD.DIM_STATUS IN (''2'',''3'',''4'',''5'')';  
--HQ USER
        IF L_V_FSC_CODE ='R' THEN
        V_SQL_CNDTN := V_SQL_CNDTN|| ' AND HRD.LINE =''R'' ';
        ELSE  
        V_SQL_CNDTN :=V_SQL_CNDTN|| 'AND HRD.LINE ='||''''||L_V_LINE||''''||' AND FOR_FSC ='||''''||L_V_FSC_CODE||'''';
        END IF; 

        L_V_SERVICE := 'SELECT REGEXP_SUBSTR('||''''||P_I_V_SERVICE||''''||',''[^,]+'', 1, LEVEL) FROM DUAL CONNECT BY REGEXP_SUBSTR('||''''||P_I_V_SERVICE||''''||', ''[^,]+'', 1, LEVEL) IS NOT NULL';
         L_V_VESSEL := 'SELECT REGEXP_SUBSTR('||''''||P_I_V_VESSEL||''''||',''[^,]+'', 1, LEVEL) FROM DUAL CONNECT BY REGEXP_SUBSTR('||''''||P_I_V_VESSEL||''''||', ''[^,]+'', 1, LEVEL) IS NOT NULL';
        L_V_VOYAGE := 'SELECT REGEXP_SUBSTR('||''''||P_I_V_VOYAGE||''''||',''[^,]+'', 1, LEVEL) FROM DUAL CONNECT BY REGEXP_SUBSTR('||''''||P_I_V_VOYAGE||''''||', ''[^,]+'', 1, LEVEL) IS NOT NULL';
       L_V_DIRECTION := 'SELECT REGEXP_SUBSTR('||''''||P_I_V_DIRECTION||''''||',''[^,]+'', 1, LEVEL) FROM DUAL CONNECT BY REGEXP_SUBSTR('||''''||P_I_V_DIRECTION||''''||', ''[^,]+'''', 1, LEVEL) IS NOT NULL';

         IF(P_I_V_BL IS NOT NULL )
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.PK_BL_NO = ' || ''''||P_I_V_BL||''''  ;     ---- SERVICE
       END IF;
       
                
                   
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
          
          IF(P_I_V_SOC_COC IS NOT NULL )
        THEN 
          IF(P_I_V_SOC_COC = 'SOC') 
           THEN
           V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.SOC_COC = ''S'''  ;     ---- SOC
          ELSIF(P_I_V_SOC_COC = 'COC')
           THEN
           V_SQL_CNDTN := V_SQL_CNDTN || ' AND  HRD.SOC_COC = ''C'''  ;     ---- COC
      
          END IF;
       END IF;
       
        IF(P_I_V_ETA_DATE IS NOT NULL)
        THEN   --In data base there are Invalied date  are there that way comment the beloow line             
        -- V_SQL_CNDTN := V_SQL_CNDTN || 'AND TO_DATE(' || '''' || P_I_V_ETA_DATE || '''' ||', ''YYYYMMDD'') = to_date(HRD.POD_ETA, ''YYYYMMDD'') ';   ---- ETA DATE
      V_SQL_CNDTN := V_SQL_CNDTN || 'AND ' || '''' || P_I_V_ETA_DATE || '''' ||' = HRD.POD_ETA ';
       END IF;

       IF(P_I_V_ETA_PORT_DATE IS NOT NULL) 
        THEN                   
         V_SQL_CNDTN := V_SQL_CNDTN || 'AND TO_DATE(' || '''' || P_I_V_ETA_PORT_DATE || '''' ||', ''YYYYMMDD'') = to_date(HRD.FINAL_DEST_ETA, ''YYYYMMDD'') ';   ---- ETA PORT DATE
       END IF;
           
            IF ( P_I_V_IN_VOYAGE IS NOT NULL ) THEN V_SQL_CNDTN := V_SQL_CNDTN || ' AND  UPPER(HRD.FIRST_VOYAGE) = ' || '''' || P_I_V_IN_VOYAGE || '''';     ---- IN_VOYAGE
       END IF; 
     -- V_SQL_CNDTN2 :=  'ORDER BY HRD.PK_BL_NO '; 
      V_SQL_1:=V_SQL_1||' '|| V_SQL_CNDTN; 
            
  OPEN P_O_V_BLC_MAPPING_LIST FOR  V_SQL_1;
  END PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH_INVOYAGE;

END PCR_DIM_BLC_ARRIVALE_NOTICE;