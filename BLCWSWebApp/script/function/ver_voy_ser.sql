create or replace FUNCTION "FR_BLC_CHECK_VES_VOY_SRVC_EXIST" (p_srvc VARCHAR2,p_vessel VARCHAR2,p_voyage VARCHAR2)                                                       
RETURN NUMBER IS                                                                
v_srvc VRL_BKG_BOOKING_CTR_SERV.SERVICE%type;          
v_vessel VRL_BKG_BOOKING_CTR_SERV.VESSEL%type;  
v_voyage VRL_BKG_BOOKING_CTR_SERV.VOYAGE%type; 
v_count NUMBER;                                                                 
BEGIN                                                                           
-- File Name   : ver_voy_ser.sql                                                    
-- Program Name : FR_BLC_CHECK_VES_VOY_SRVC                                            
-- Author : soumya                                                              
-- Date  : 17--20                                                            
-- Description  : Function Checking pol existance.                          
--                                                                              
v_srvc := TRIM(p_srvc);
v_vessel := TRIM(p_vessel);   
v_voyage := TRIM(p_voyage); 

  IF v_srvc IS NOT NULL AND  v_vessel IS NOT NULL  AND v_voyage IS NOT NULL THEN               

SELECT COUNT(1) INTO v_count FROM VRL_BL_VESSEL_SCHEDULE_ALL WHERE SERVICE   =q'[v_srvc]' AND VESSEL=q'[v_vessel]' AND  VOYAGE   =q'[v_voyage]';


    IF v_count <= 0 THEN                                                        
       RETURN 0;                                                                
    ELSE                                                                        
       RETURN 1;                                                                
    END IF;                                                                     
  END IF;    
   RETURN 0; 
END;