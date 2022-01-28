create or replace FUNCTION FNC_BLC_CHECK_CONTROL_FSC
(
v_line 	itp188.crflv1%type,
v_trade itp188.crflv2%type,
v_agent itp188.crflv3%type,
v_fsc 	itp188.crcntr%type
)
RETURN Number

IS
v_count number;

BEGIN
 	SELECT 	Count(*)
	INTO 	v_count
	FROM 	itp188
 	WHERE 	crflv1 = v_line
	AND	crflv2 = v_trade
	AND 	crflv3 = v_agent
	AND	crcntr = v_fsc
	AND	control_fsc = 'Y';

 	IF v_count > 0 THEN
 		RETURN 1;
 	ELSE
		RETURN 0;
 	END IF;
END;
