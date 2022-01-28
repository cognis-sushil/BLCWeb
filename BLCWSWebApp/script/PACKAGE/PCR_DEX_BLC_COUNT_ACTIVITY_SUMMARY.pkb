create or replace PACKAGE BODY PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY AS
/*-----------------------------------------------------------------------------------------------------------
- Search for DIM COUNT BY ACTIVITY SUMMARY
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  Cognis 23/04/2020
- CHANGE LOG ------------------------------------------------------------------------------------------------
## DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01 23/04/2020          Chandu                             
-----------------------------------------------------------------------------------------------------------*/

    PROCEDURE PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH (

      P_I_V_SERVICE                IN VARCHAR2,
      P_I_V_VESSEL                 IN VARCHAR2,
      P_I_V_VOYAGE                 IN VARCHAR2, 
      P_I_V_DIRECTION              IN VARCHAR2,
      P_I_V_POL                    IN VARCHAR2,
      P_I_V_START_DATE             IN VARCHAR2,
      P_I_V_END_DATE               IN VARCHAR2,      
      P_I_V_USER_ID                IN VARCHAR2,
      P_I_V_LINE                   IN VARCHAR2,
      P_I_V_TRADE                  IN VARCHAR2,
      P_I_V_AGENT                  IN VARCHAR2,
      P_I_V_FSC_CODE               IN VARCHAR2,
      P_O_V_BLC_MAPPING_LIST       OUT SYS_REFCURSOR
    ) AS
        V_SQL_1        VARCHAR2(6000);
        V_SQL_CNDTN    VARCHAR2(6000);
      
          P_I_V_CODE   VARCHAR2(3);

    BEGIN  
     
           
       IF(P_I_V_SERVICE IS NOT NULL )
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.LOAD_SERVICE) = ' || ''''||P_I_V_SERVICE||''''  ;     ---- SERVICE
       END IF;

       IF(P_I_V_VESSEL IS NOT NULL)
        THEN                  
          V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.FIRST_VESSEL) = ' || ''''||P_I_V_VESSEL||''''  ;     ---- VESSEL
       END IF;       

       IF(P_I_V_VOYAGE IS NOT NULL)
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.FIRST_VOYAGE) = ' || ''''||P_I_V_VOYAGE||''''  ;          ---- VOYAGE
       END IF;

       IF(P_I_V_DIRECTION IS NOT NULL) THEN 
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.LOAD_DIRECTION) = ' || ''''||P_I_V_DIRECTION||''''  ;      ---- DIRECTION
       END IF; 

        IF(P_I_V_POL IS NOT NULL) THEN 
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.DN_POL) = ' || ''''||P_I_V_POL||''''  ;            ---- POL
       END IF; 

     IF( P_I_V_START_DATE IS NOT NULL) THEN
      V_SQL_CNDTN := V_SQL_CNDTN || '  AND to_date(hrd.POL_ETD,''YYYYMMDD'') >= to_date(' || ''''||P_I_V_START_DATE||''' ,''YYYYMMDD'' )'  ;   
     END IF;

       IF( P_I_V_END_DATE IS NOT NULL) THEN        
      V_SQL_CNDTN := V_SQL_CNDTN || '  AND to_date(hrd.POL_ETD,''YYYYMMDD'') <=  to_date(' || ''''||P_I_V_END_DATE||''' ,''YYYYMMDD'' )'  ;   
     END IF;

      IF( P_I_V_TRADE IS NOT NULL AND P_I_V_TRADE ='*') THEN        
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.LINE  = ' || ''''||P_I_V_LINE||''''  ;     ---- Line
     ELSIF( P_I_V_AGENT IS NOT NULL AND P_I_V_AGENT ='***') THEN        
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.LINE  = ' || ''''||P_I_V_LINE||''' AND TRADE = '''||P_I_V_TRADE||''''  ;     ---- TRADE
    ELSIF( P_I_V_AGENT IS NOT NULL AND P_I_V_AGENT <>'***') THEN  

   SELECT FNC_BLC_CHECK_CONTROL_FSC( P_I_V_LINE , P_I_V_TRADE ,P_I_V_AGENT ,P_I_V_FSC_CODE ) INTO P_I_V_CODE FROM DUAL;
              
     IF( P_I_V_CODE IS NOT NULL AND P_I_V_CODE ='1') THEN   
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND ( hrd.LINE  = ' || ''''||P_I_V_LINE||''' AND hrd.TRADE = '''||P_I_V_TRADE||''' AND hrd.AGENT  = '''||P_I_V_AGENT||''') '  ;     ---- Line
       ELSE
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.BL_PREPARED_BY  = ' || ''''||P_I_V_FSC_CODE ||''''  ;     ---- fsc
        END IF;
     END IF;

        V_SQL_1 := 'SELECT  * FROM 
(


SELECT COUNT(1) AS CNT_BL1, BL_TYPE  AS BL_TYPE1 FROM rcltbls.dex_bl_header hrd
WHERE 1=1 '||V_SQL_CNDTN||'
   GROUP BY BL_TYPE 

) t1 

FULL OUTER JOIN

(
SELECT COUNT(1) AS CNT_BL2, BL_TYPE  AS BL_TYPE2 FROM rcltbls.dex_bl_header hrd
WHERE  DEX_STATUS = ''2''  '||V_SQL_CNDTN||'
   GROUP BY BL_TYPE 

) t2 ON t1.BL_TYPE1  = t2.BL_TYPE2

FULL OUTER JOIN
(
SELECT COUNT(1) AS CNT_BL3, BL_TYPE  AS BL_TYPE3 FROM rcltbls.dex_bl_header hrd
WHERE hrd.BL_PRINT_STATUS    = ''R'' '||V_SQL_CNDTN||'
   GROUP BY BL_TYPE 

) t3 ON t2.BL_TYPE2  = t3.BL_TYPE3

FULL OUTER JOIN

(
SELECT COUNT(1) AS CNT_BL4, BL_TYPE  AS BL_TYPE4 FROM
(
SELECT DISTINCT hrd.PK_BL_NO   , hrd.BL_TYPE 
FROM rcltbls.dex_bl_header hrd INNER JOIN DEX_BL_REVENUE rev ON hrd.PK_BL_NO    = rev.FK_BL_NO
WHERE (rev.FK_INVOICE_NO IS NOT NULL OR TRIM(rev.FK_INVOICE_NO) != '''')  AND rev.FLAG_PREPAID_COLLECT = ''P'' '||V_SQL_CNDTN||'
   ) 
GROUP BY BL_TYPE 

) t4 ON t3.BL_TYPE3  = t4.BL_TYPE4

FULL OUTER JOIN

(
SELECT COUNT(1) AS CNT_BL5, BL_TYPE  AS BL_TYPE5 FROM
(
SELECT DISTINCT hrd.PK_BL_NO   , hrd.BL_TYPE 
FROM rcltbls.dex_bl_header hrd INNER JOIN DEX_BL_REVENUE rev ON hrd.PK_BL_NO    = rev.FK_BL_NO
WHERE (rev.INVOICE_PRINTED_FLAG IS NOT NULL AND TRIM(rev.INVOICE_PRINTED_FLAG) = ''Y'')  AND rev.FLAG_PREPAID_COLLECT = ''P'' '||V_SQL_CNDTN||'
   ) 
GROUP BY BL_TYPE 

) t5 ON t4.BL_TYPE4  = t5.BL_TYPE5
FULL OUTER JOIN

(
SELECT COUNT(1) AS CNT_BL6, BL_TYPE  AS BL_TYPE6 FROM rcltbls.dex_bl_header hrd
WHERE hrd.DEX_STATUS = ''4'' '||V_SQL_CNDTN||'
   GROUP BY BL_TYPE 

) t6 ON t5.BL_TYPE5  = t6.BL_TYPE6
FULL OUTER JOIN

(

SELECT COUNT(1) AS CNT_BL7, BL_TYPE  AS BL_TYPE7 FROM rcltbls.dex_bl_header hrd
WHERE hrd.BL_RELEASED_FLAG  != ''Y''  '||V_SQL_CNDTN||'
   GROUP BY BL_TYPE 
) t7 ON t6.BL_TYPE6  = t7.BL_TYPE7
FULL OUTER JOIN

(

SELECT COUNT(1) AS CNT_BL8, BL_TYPE AS BL_TYPE8 FROM  rcltbls.dex_bl_header hrd
WHERE hrd.SPECIAL_RELEASE_REQUESTED = ''Y'' '||V_SQL_CNDTN||'
   GROUP BY BL_TYPE

) t8 ON t7.BL_TYPE7  = t8.BL_TYPE8
';


        V_SQL_1 := V_SQL_1;
        
          
         
        OPEN P_O_V_BLC_MAPPING_LIST FOR V_SQL_1;

    END PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH;

 /*-----------------------------------------------------------------------------------------------------------
- Search for DIM COUNT BY ACTIVITY SUMMARY Detailes.
-------------------------------------------------------------------------------------------------------------
COPYRIGHT RCL PUBLIC CO., LTD. 2010
-------------------------------------------------------------------------------------------------------------
AUTHOR  Cognis 23/04/2020
- CHANGE LOG ------------------------------------------------------------------------------------------------
## DD/MM/YY           -USER-          -TASKREF-           -SHORT DESCRIPTION
01 23/04/2020          Chandu                             
-----------------------------------------------------------------------------------------------------------*/

PROCEDURE PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH_DETAILE ( 
      P_I_V_ACTION                 IN VARCHAR2, 
      P_I_V_BLTYPE                 IN VARCHAR2,
      P_I_V_SERVICE                IN VARCHAR2,
      P_I_V_VESSEL                 IN VARCHAR2,
      P_I_V_VOYAGE                 IN VARCHAR2,
      P_I_V_DIRECTION              IN VARCHAR2,
      P_I_V_POL                    IN VARCHAR2,
      P_I_V_START_DATE             IN VARCHAR2,
      P_I_V_END_DATE               IN VARCHAR2,  
      P_I_V_USER_ID                IN VARCHAR2,
      P_O_V_BLC_MAPPING_LIST       OUT SYS_REFCURSOR
  ) AS
        V_SQL_1        VARCHAR2(3000);
        V_SQL_CNDTN    VARCHAR2(6000);
        P_I_V_FSC_CDOE   VARCHAR2(6);
        P_I_V_LINE       VARCHAR2(1);
        P_I_V_AGENT       VARCHAR2(3);
        P_I_V_TRADE       VARCHAR2(1);

         BEGIN  

          SELECT FSC_CODE,FSC_LVL1,FSC_LVL2 INTO   P_I_V_FSC_CDOE,P_I_V_LINE,P_I_V_TRADE FROM   VR_RCM_USER WHERE  PRSN_LOG_ID = P_I_V_USER_ID; 

       IF(P_I_V_SERVICE IS NOT NULL )
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.LOAD_SERVICE) = ' || ''''||P_I_V_SERVICE||''''  ;     ---- SERVICE
       END IF;

       IF(P_I_V_VESSEL IS NOT NULL)
        THEN                  
          V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.FIRST_VESSEL) = ' || ''''||P_I_V_VESSEL||''''  ;     ---- VESSEL
       END IF;       

       IF(P_I_V_VOYAGE IS NOT NULL)
        THEN                  
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.FIRST_VOYAGE) = ' || ''''||P_I_V_VOYAGE||''''  ;          ---- VOYAGE
       END IF;

       IF(P_I_V_DIRECTION IS NOT NULL) THEN 
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.LOAD_DIRECTION) = ' || ''''||P_I_V_DIRECTION||''''  ;      ---- DIRECTION
       END IF; 

        IF(P_I_V_POL IS NOT NULL) THEN 
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.DN_POL) = ' || ''''||P_I_V_POL||''''  ;            ---- POL
       END IF; 

      IF(P_I_V_BLTYPE IS NOT NULL) THEN 
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND UPPER(hrd.BL_TYPE) = ' || ''''||P_I_V_BLTYPE||''''  ;            ---- BL TYPE
       END IF;

 

     IF( P_I_V_START_DATE IS NOT NULL) THEN
      V_SQL_CNDTN := V_SQL_CNDTN || '  AND to_date(hrd.POL_ETD,''YYYYMMDD'') >= to_date(' || ''''||P_I_V_START_DATE||''' ,''YYYYMMDD'' )'  ;   
     END IF;

       IF( P_I_V_END_DATE IS NOT NULL) THEN        
      V_SQL_CNDTN := V_SQL_CNDTN || '  AND to_date(hrd.POL_ETD,''YYYYMMDD'') <=  to_date(' || ''''||P_I_V_END_DATE||''' ,''YYYYMMDD'' )'  ;   
     END IF;

      IF( P_I_V_TRADE IS NOT NULL AND P_I_V_TRADE ='*') THEN        
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.LINE  = ' || ''''||P_I_V_LINE||''''  ;     ---- Line
     ELSIF( P_I_V_AGENT IS NOT NULL AND P_I_V_AGENT ='***') THEN        
        V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.LINE  = ' || ''''||P_I_V_LINE||''' AND hrd.TRADE = '''||P_I_V_TRADE||''''  ;     ---- TRADE
    ELSIF( P_I_V_AGENT IS NOT NULL AND P_I_V_AGENT <>'***') THEN  

     IF( P_I_V_FSC_CDOE IS NOT NULL AND P_I_V_FSC_CDOE ='1') THEN   
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND ( hrd.LINE  = ' || ''''||P_I_V_LINE||''' AND hrd.TRADE = '''||P_I_V_TRADE||''' AND hrd.AGENT  = '''||P_I_V_AGENT||''') '  ;     ---- Line
       ELSE
         V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.BL_PREPARED_BY  = ' || ''''||P_I_V_FSC_CDOE||''''  ;     ---- fsc
        END IF;
     END IF;

  v_sql_1 := 'SELECT DISTINCT hrd.PK_BL_NO, hrd.BL_TYPE, hrd.DEX_STATUS, hrd.BL_PRINT_STATUS,  CASE WHEN (rev.FK_INVOICE_NO IS NOT NULL AND  rev.FLAG_PREPAID_COLLECT = ''P'' ) THEN ''Y'' ELSE ''N'' END AS Generated_Invoices  , CASE WHEN (rev.INVOICE_PRINTED_FLAG  IS NOT NULL AND rev.FLAG_PREPAID_COLLECT = ''P'' ) THEN ''Y'' ELSE ''N'' END AS Printed_Invoices ,  hrd.BL_RELEASED_FLAG,  hrd.SPECIAL_RELEASE_REQUESTED FROM rcltbls.dex_bl_header  hrd LEFT OUTER JOIN  DEX_BL_REVENUE rev ON hrd.PK_BL_NO = rev.FK_BL_NO  WHERE 1=1 ';
   

       case  

      WHEN P_I_V_ACTION = '2' THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND  hrd.DEX_STATUS = ''2''';
      WHEN P_I_V_ACTION  = '3' THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.BL_PRINT_STATUS = ''R''';  
      WHEN P_I_V_ACTION = '4' THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND (rev.FK_INVOICE_NO IS NOT NULL OR TRIM(rev.FK_INVOICE_NO) != '' '')';                     
      WHEN P_I_V_ACTION  = '5' THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND (rev.INVOICE_PRINTED_FLAG IS NOT NULL AND TRIM(rev.INVOICE_PRINTED_FLAG) = ''Y'')';
      WHEN P_I_V_ACTION = '6' THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.DEX_STATUS = ''4''';
      WHEN P_I_V_ACTION  = '7' THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.BL_RELEASED_FLAG = ''Y''';
      WHEN P_I_V_ACTION = '8' THEN  V_SQL_CNDTN := V_SQL_CNDTN || ' AND hrd.SPECIAL_RELEASE_REQUESTED = ''Y''';    
      ELSE V_SQL_CNDTN := V_SQL_CNDTN;
   end case; 

        V_SQL_1 := V_SQL_1 || ' '|| V_SQL_CNDTN;
       
      
        OPEN P_O_V_BLC_MAPPING_LIST FOR V_SQL_1;

   END PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH_DETAILE;

END PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY;