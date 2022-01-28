/* Copyright (c) 2020 RCL| All Rights Reserved*/

package com.rclgroup.dolphin.web.dao.blc;

/* --------------------Change Log -------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    26/03/20       Chandu               Initial Version
-------------------------------------------------------------------
*/

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.rclgroup.dolphin.web.model.blc.CountByActivitySummaryMod;


/**
 * Interface contain methods related to B/L Count By Activity.
 * @author Cognis Solution
 *
 */
public interface CountByActivitySummaryDao {
	
	public static final String 	PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH ="PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY.PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH";
	 
	public static final String PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH_DETAILE = "PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY.PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH_DETAILE";
	
	
	/**
	 * Use to search Bl Count Activity base on search parameter.
	 * @param searchParam {@code BlCountByActivitySummaryModel}
	 * @return List of  {@code BlCountByActivitySummaryModel}
	 */
	public List<CountByActivitySummaryMod> findByGivenKeyForBlCountActivity(CountByActivitySummaryMod searchParam)throws DataAccessException;

	
	/**
	 * Use to search Bl Count Activity Info base on search parameter.
	 * @param searchParam {@code BlCountByActivitySummaryModel}
	 * @return List of  {@code BlCountByActivitySummaryModel}
	 */
	public List<CountByActivitySummaryMod> findByGivenKeyForBlCountActivityInfo(CountByActivitySummaryMod seachParam)throws DataAccessException;

}
