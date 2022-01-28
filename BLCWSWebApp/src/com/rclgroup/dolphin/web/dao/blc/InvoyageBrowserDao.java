/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.dao.blc;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.rclgroup.dolphin.web.model.blc.InvoyageBrowserMod;

/**
 * Interface contain methods related to Invoyage Browser .
 * @author Cognis Solution
 *
 */

public interface InvoyageBrowserDao {

	/**
	 * Used for search Arrival Notice base on search parameter.
	 * <p>Blank search is not allowed</p>
	 * @param searchParam {@code BlcArrivalNoticeModel}
	 * @return List of {@code BlcArrivalNoticeModel}
	 */
	public static final  String	PCR_DIM_BLC_INVOYAGE_BROWSER_SEARCH = "PCR_DIM_BLC_INVOYAGE_BROWSER.PCR_DIM_BLC_INVOYAGE_BROWSER_SEARCH";
	
    List<InvoyageBrowserMod> findDataForInvoyageBrowser(InvoyageBrowserMod searchParam) throws DataAccessException;

}
