create or replace FUNCTION "FR_BLC_CHECK_VESSEL_EXIST" (p_vessel VARCHAR2)                                                       
RETURN NUMBER IS                                                                
v_vessel VRL_BKG_BOOKING_CTR_SERV.VESSEL%type;                                                      
v_count NUMBER;                                                                 
BEGIN                                                                           
-- File Name   : vessel.sql                                                   
-- Program Name : FR_BLC_CHECK_VESSEL_EXIST                                            
-- Author : soumya                                                              
-- Date  : 28-04-20                                                           
-- Description  : Function Checking vessel existance.                          
--                                                                              
v_vessel := TRIM(p_vessel);                                                         

  IF v_vessel IS NOT NULL THEN               

SELECT COUNT(1) INTO v_count FROM VRL_BL_VESSEL_SCHEDULE_ALL WHERE VESSEL=Q'[v_vessel]';


    IF v_count <= 0 THEN                                                        
       RETURN 0;                                                                
    ELSE                                                                        
       RETURN 1;                                                                
    END IF;                                                                     
  END IF;                                                                       
END;