
create or replace FUNCTION "FR_BLC_CHECK_VOYAGE_EXIST" (p_voyage VARCHAR2)                                                       
RETURN NUMBER IS                                                                
v_voyage VRL_BKG_BOOKING_CTR_SERV.VOYAGE%type;                                                      
v_count NUMBER;                                                                 
BEGIN                                                                           
-- File Name   : voyage.sql                                                    
-- Program Name : FR_BLC_CHECK_VOYAGE_EXIST                                            
-- Author : soumya                                                              
-- Date  : 28-04-20                                                            
-- Description  : Function Checking voyage existance.                          
--                                                                              
v_voyage := TRIM(p_voyage);                                                         

  IF v_voyage IS NOT NULL THEN               

SELECT COUNT(1) INTO v_count FROM VRL_BL_VESSEL_SCHEDULE_ALL WHERE VOYAGE =q'[v_voyage]';


    IF v_count <= 0 THEN                                                        
       RETURN 0;                                                                
    ELSE                                                                        
       RETURN 1;                                                                
    END IF;                                                                     
  END IF;                                                                       
END;