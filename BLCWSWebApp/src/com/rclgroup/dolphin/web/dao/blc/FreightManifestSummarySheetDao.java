package com.rclgroup.dolphin.web.dao.blc;

import com.rclgroup.dolphin.web.model.blc.FreightManifestSummarySheetMod;


/**
 * Interface contain methods related to Freight ManifestSummary.
 * @author Cognis Solution
 *
 */

public interface FreightManifestSummarySheetDao {

	String PLACE_HOLDER="_FUN_VALUE_";
	
	String FR_BLC_CHECK_SRVC_EXIST = " SELECT FR_BLC_CHECK_SRVC_EXIST(q'["+PLACE_HOLDER+"]') as count FROM DUAL";
	
	String FR_BLC_CHECK_VESSEL_EXIST = " SELECT FR_BLC_CHECK_VESSEL_EXIST(q'[" + PLACE_HOLDER + "]') as count FROM DUAL";
	
	String FR_BLC_CHECK_VOYAGE_EXIST = "SELECT FR_BLC_CHECK_VOYAGE_EXIST(q'[" + PLACE_HOLDER + "]') as count FROM DUAL";
	
	String FR_BLC_CHECK_POL_EXIST=   "SELECT FR_BLC_CHECK_POL_EXIST(q'[" + PLACE_HOLDER + "]') as count FROM DUAL";
	 /**
	 * Used for search FreightManifest SummaryShee base on search parameter.
	 * <p>Blank search is not allowed</p>
	 * <p>Note:If user input invaid data it return sucess is fale.
	 * @param searchParam {@code BlcFreightManifestSummarySheetMod}
	 * @return {@code BlcFreightManifestSummarySheetMod}
	 */
	
	public FreightManifestSummarySheetMod findFreightManifestSummarySheetData(FreightManifestSummarySheetMod searchParam);
}
