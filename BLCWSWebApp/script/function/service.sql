create or replace FUNCTION "FR_BLC_CHECK_SRVC_EXIST" (p_srvc VARCHAR2)                                                       
RETURN NUMBER IS                                                                
v_srvc VRL_BKG_BOOKING_CTR_SERV.SERVICE%type;                                                      
v_count NUMBER;                                                                 
BEGIN                                                                           
-- File Name   : servcie.sql                                                     
-- Program Name : FR_BLC_CHECK_VES_SRVC                                            
-- Author : soumya                                                              
-- Date  : 28-04-20                                                         
-- Description  : Function Checking service existance.                          
--                                                                              
v_srvc := TRIM(p_srvc);                                                         

  IF v_srvc IS NOT NULL THEN               

SELECT COUNT(1) INTO v_count FROM VRL_BL_VESSEL_SCHEDULE_ALL WHERE SERVICE   =Q'[v_srvc]';


    IF v_count <= 0 THEN                                                        
       RETURN 0;                                                                
    ELSE                                                                        
       RETURN 1;                                                                
    END IF;                                                                     
  END IF;                                                                       
END;