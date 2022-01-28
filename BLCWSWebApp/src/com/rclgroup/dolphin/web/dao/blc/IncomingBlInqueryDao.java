/* Copyright (c) 2020 RCL| All Rights Reserved*/

package com.rclgroup.dolphin.web.dao.blc;

/* ----------------------------- Change Log ----------------------------------------
	##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
	1    29/03/20       Chandu               Initial Version
	--------------------------------------------------------------------------------
*/
import java.util.List;

import org.springframework.dao.DataAccessException;

import com.rclgroup.dolphin.web.model.blc.IncomingBlInqueryMod;

/**
 * Interface contain methods related to B/L Incoming Bl Inquery.
 * @author Cognis Solution
 */

public interface IncomingBlInqueryDao {                          
	
	public static final String PCR_DIM_BLC_INCOMING_BL_INQUERY_SEARCH = "PCR_DIM_BLC_INCOMING_BL_INQUERY.PCR_DIM_BLC_INCOMING_BL_INQUERY_SEARCH";
	
	/**
	 * Use to search Incoming Bl Inquery base on search parameter.
	 * @param searchParam {@code BlcIncomingBlInqueryModel}
	 * @return List of  {@code BlcIncomingBlInqueryModel}
	 */
	public List<IncomingBlInqueryMod> findByGivenKeyForIncomingBlInquery(IncomingBlInqueryMod searchParam)throws DataAccessException;
   
}
