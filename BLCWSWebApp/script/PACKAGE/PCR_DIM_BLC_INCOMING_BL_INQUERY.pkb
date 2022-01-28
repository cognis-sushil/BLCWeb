create or replace PACKAGE BODY PCR_DIM_BLC_INCOMING_BL_INQUERY AS
/*-----------------------------------------------------------------------------------------------------------
- SEARCH FOR DIM INCOMING BL INQUERY.
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  COGNIS 23/04/2020
- CHANGE LOG ------------------------------------------------------------------------------------------------
## DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01 23/04/2020          CHANDU                             
-----------------------------------------------------------------------------------------------------------*/

    PROCEDURE PCR_DIM_BLC_INCOMING_BL_INQUERY_SEARCH (

      P_I_V_SERVICE                  IN VARCHAR2,
      P_I_V_VESSEL                   IN VARCHAR2,
      P_I_V_VOYAGE                   IN VARCHAR2, 
      P_I_V_DIRECTION                IN VARCHAR2,
      P_I_V_POL                      IN VARCHAR2,
      P_I_V_POT                      IN VARCHAR2,         
      P_I_V_START_DATE               IN VARCHAR2,
      P_I_V_END_DATE                 IN VARCHAR2,      
	  P_I_V_USER_ID                  IN VARCHAR2,
      P_O_V_BLC_MAPPING_LIST         OUT SYS_REFCURSOR
    ) AS
        V_SQL_1        VARCHAR2(3000);
        V_SQL_CNDTN    VARCHAR2(6000);
        V_SQL_CNDTN2    VARCHAR2(6000);
        P_I_V_FSC_CDOE   VARCHAR2(6);
        P_I_V_LINE       VARCHAR2(1);
        P_I_V_AGENT       VARCHAR2(3);
        P_I_V_TRADE       VARCHAR2(1);
    BEGIN  


  SELECT FSC_CODE,FSC_LVL1,FSC_LVL2
              INTO   P_I_V_FSC_CDOE,P_I_V_LINE,P_I_V_TRADE
                FROM   VR_RCM_USER 
                   WHERE  PRSN_LOG_ID = P_I_V_USER_ID; 


 IF ( P_I_V_SERVICE IS NOT NULL ) THEN
            V_SQL_CNDTN := V_SQL_CNDTN || ' AND (DISCHARGE_SERVICE) = ' || ''''|| P_I_V_SERVICE|| '''';     ---- SERVICE
        END IF;

        IF ( P_I_V_VESSEL IS NOT NULL ) THEN
            V_SQL_CNDTN := V_SQL_CNDTN || ' AND (DISCHARGE_VESSEL) = ' || ''''|| P_I_V_VESSEL|| '''';     ---- VESSEL
        END IF;

        IF ( P_I_V_VOYAGE IS NOT NULL ) THEN
            V_SQL_CNDTN := V_SQL_CNDTN || ' AND (DISCHARGE_VOYAGE) = ' || ''''|| P_I_V_VOYAGE|| '''';     ---- VOYAGE
        END IF;

        IF(P_I_V_DIRECTION IS NOT NULL) THEN 
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND (DISCHARGE_DIRECTION) = ' || ''''||P_I_V_DIRECTION||''''  ;      ---- DIRECTION
       END IF; 

       IF(P_I_V_POL IS NOT NULL) THEN 
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND (DN_CUSTOMER_POL) = ' || ''''||P_I_V_POL||''''  ;            ---- POL  
       END IF; 

       IF(P_I_V_POT IS NOT NULL) THEN 
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND (DN_POT1) = ' || ''''||P_I_V_POT||''''  ;                   ---- POT  
       END IF; 

     IF( P_I_V_START_DATE IS NOT NULL) THEN
      V_SQL_CNDTN := V_SQL_CNDTN || '  AND TO_DATE(POD_ETD,''YYYYMMDD'') = TO_DATE(' || ''''||P_I_V_START_DATE||''' ,''YYYYMMDD'' )'  ;   
     END IF;

       IF( P_I_V_END_DATE IS NOT NULL) THEN        
      V_SQL_CNDTN := V_SQL_CNDTN || '  AND TO_DATE(POD_ETA,''YYYYMMDD'') =  TO_DATE(' || ''''||P_I_V_END_DATE||''' ,''YYYYMMDD'' )'  ;   
     END IF;

      IF( P_I_V_AGENT IS NOT NULL AND P_I_V_AGENT ='***') THEN        
         IF( P_I_V_FSC_CDOE IS NOT NULL AND P_I_V_FSC_CDOE =' ') THEN
            V_SQL_CNDTN := V_SQL_CNDTN|| ' AND  ' || ''''||P_I_V_FSC_CDOE||'''' || ' IN (DEX_BL_HEADER.FOR_FSC)';
         END IF;
     END IF;

        V_SQL_1 := ' SELECT DISTINCT DISCHARGE_SERVICE,DISCHARGE_VESSEL,DISCHARGE_VOYAGE,DN_CUSTOMER_POL,DN_POT1,DN_POT2,DN_POT3,DISCHARGE_DIRECTION,POD_ETD,
                     POL_ETD,DN_CUSTOMER_POD,FOR_FSC,POD_ETA,COUNT(PK_BL_NO) AS CALC_AYSTAT FROM RCLTBLS.DEX_BL_HEADER WHERE 1=1 ';
     V_SQL_CNDTN2 := 'AND DEX_STATUS > '||''' '''||' 
                    AND DEX_STATUS != ''9'' GROUP BY DISCHARGE_SERVICE,DISCHARGE_VESSEL,DISCHARGE_VOYAGE,DISCHARGE_DIRECTION,DN_CUSTOMER_POL,DN_POT1,DN_POT2,
                    DN_POT3,POD_ETD,POL_ETD,DN_CUSTOMER_POD,FOR_FSC,POD_ETA  ORDER BY DISCHARGE_SERVICE, DISCHARGE_VESSEL,DISCHARGE_VOYAGE,DISCHARGE_DIRECTION,DN_CUSTOMER_POL,DN_POT1,POD_ETD,POD_ETA';  

        V_SQL_1 := V_SQL_1 || ' ' || V_SQL_CNDTN || ' ' || V_SQL_CNDTN2;
          
        OPEN P_O_V_BLC_MAPPING_LIST FOR V_SQL_1;
           
    END PCR_DIM_BLC_INCOMING_BL_INQUERY_SEARCH;

END PCR_DIM_BLC_INCOMING_BL_INQUERY;