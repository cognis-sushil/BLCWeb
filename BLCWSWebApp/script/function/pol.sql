create or replace FUNCTION "FR_BLC_CHECK_POL_EXIST" (p_pol VARCHAR2)                                                       
RETURN NUMBER IS                                                                
v_pol VRL_PORT.CODE%type;                                                      
v_count NUMBER;                                                                 
BEGIN                                                                           
-- File Name   : pol.sql                                                    
-- Program Name : FR_BLC_CHECK_POL_EXIST                                            
-- Author : soumya                                                              
-- Date  : 28-04-20                                                            
-- Description  : Function Checking pol existance.                          
--                                                                              
v_pol := TRIM(p_pol);                                                         

  IF v_pol IS NOT NULL THEN               

SELECT COUNT(1) INTO v_count FROM VRL_PORT WHERE CODE  =v_pol;


    IF v_count <= 0 THEN                                                        
       RETURN 0;                                                                
    ELSE                                                                        
       RETURN 1;                                                                
    END IF;                                                                     
  END IF;                                                                       
END; 

