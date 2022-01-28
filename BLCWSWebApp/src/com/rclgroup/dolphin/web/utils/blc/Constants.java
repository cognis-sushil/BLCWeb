/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.utils.blc;


/* ------------------------- Change Log ---------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    13/03/20       Chandu               Initial Version
-------------------------------------------------------------------------------
*/
public class Constants {
	
	public static final String RCL_WEB_ROOT = "/BLC_Import_Export";
    public static final String ERR_PAGE_URL = RCL_WEB_ROOT+"/pages/error";  
    public static final String SEALINER_ORA_URL = RCL_WEB_ROOT+"/pages/include/screen";
	/**
	 * 	All JSP URL
	 */
	public static final String BLC_IMPORT_EXPORT_VIEW_ARRIVAL_NOTICE_SCN = "./pages/screen/BlcArrivalNoticeScn.jsp";
	public static final String BLC_IMPORT_EXPORT_VIEW_ARRIVAL_NOTICE_REMINDER_SCN = "./pages/screen/BlcArrivalNoticeReminderScn.jsp";
	public static final String BLC_IMPORT_EXPORT_VIEW_BL_COUNT_SUMMARY_SCN = "./pages/screen/BlcBlCountByActivitySummaryScn.jsp";
	public static final String BLC_IMPORT_EXPORT_VIEW_BL_ACTIVITY_DETAIL_SCN = "./pages/screen/BlcBlCountByActivityDetailScn.jsp";

	public static final String BLC_IMPORT_EXPORT_VIEW_BL_INCOMING_BL_INQUERY_SCN = "./pages/screen/BlcIncomingBlInqueryScn.jsp";
	public static final String BLC_IMPORT_EXPORT_VIEW_BL_INVOYAGE_BROWSER_SCN = "./pages/screen/BlcInvoyageBrowserScn.jsp";
	public static final String BLC_IMPORT_EXPORT_VIEW_BL_FREIGHT_MANIFEST_DIMP_SCN = "./pages/screen/dimp/BlcFreightManifestSummarySheetScn.jsp";
	public static final String BLC_IMPORT_EXPORT_VIEW_BL_FREIGHT_MANIFEST_DEXP_SCN = "./pages/screen/dexp/BlcFreightManifestSummarySheetScn.jsp";
	/**
	 * This Contain Constant for Page Name
	 */
	
	public static final String FREIGHT_MANIFEST_DEXP_SEARCH = "Freight manifest dexp search";
	public static final String FREIGHT_MANIFEST_DIMP_SEARCH = "Freight manifest dimp search";
	public static final String ARRIVAL_NOTICE_SEARCH = "Arrival Notice Search";

	public static final String ARRIVAL_NOTICE_REMINDER_SEARCH = "Arrival Notice Reminder Search";

	public static final String INCOMING_BL_INQUIRY_SEARCH = "Incoming B/L Inquiry Search";
	public static final String INVOYAGE_BROWSER = "Invoyage Browser";
	public static final String BL_COUNT_BY_ACTIVITY_SEARCH = "B/L Count By Activity Search";
	public static final String BL_COUNT_BY_ACTIVITY_DETAIL = "B/L Count By Activity Detail";

	public static final String FAILED = "FAILED";

	public static final String YES = "Y";
	public static final String NO = "N";
	public static final String YES_STRING = "Yes";
	public static final String NO_STRING = "No";

	/**
	 * This For Http Status Code
	 */
	public static final int SC_SERVER_ERROR = 500;
	public static final int SC_OK = 200;
}
