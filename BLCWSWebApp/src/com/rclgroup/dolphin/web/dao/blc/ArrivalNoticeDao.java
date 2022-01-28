/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.dao.blc;

/* --------------------Change Log -------------------------------
 	##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
	1    24/03/20       chandu            Initial Version
   -------------------------------------------------------------------
*/

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeMod;
import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeReminderMod;

/**
 * Interface contain methods related to Arrival Notice.
 * @author Cognis Solution
 *
 */

public interface ArrivalNoticeDao {
	                    
	public static final String PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH = "PCR_DIM_BLC_ARRIVALE_NOTICE.PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH";
	public static final String PCR_DIM_BLC_ARRIVALE_NOTICE_UPDATE = "PCR_DIM_BLC_ARRIVALE_NOTICE.PCR_DIM_BLC_ARRIVALE_NOTICE_PRINTED_UPDATE";
	public static final String PCR_DIM_BLC_ARRIVALE_NOTICE_GET_PORT = "PCR_DIM_BLC_ARRIVALE_NOTICE.PCR_DIM_BLC_ARRIVALE_NOTICE_PORT_SEARCH";
	public static final String PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH_INVOYAGE = "PCR_DIM_BLC_ARRIVALE_NOTICE.PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH_INVOYAGE";
	public static final String SQL_FOR_URL_REPORT_SERVER_NAME ="SELECT max(CONSTANT_VALUE) from RCM_CONSTANT where CONSTANT_KEY ='REPORT_SERVER_SERVER_NAME'";
	public static final String SQL_FOR_URL_REPORT_FILE_PATH ="SELECT max(CONSTANT_VALUE) from RCM_CONSTANT where CONSTANT_KEY = 'REPORT_FILE_FOLDER_UPLOADED'";
	/**
	 * Used for search Arrival Notice base on search parameter.
	 * <p>Blank search is not allowed</p>
	 * @param searchParam {@code BlcArrivalNoticeModel}
	 * @return List of {@code BlcArrivalNoticeModel}
	 */
	public List<ArrivalNoticeMod> findArrivalNoticeData(ArrivalNoticeMod searchParam) throws DataAccessException;
	/**
	 * Used to update printed Arrival Notice .
	 * <p>Blank search is not allowed</p>
	 * @param BL Number  {@code String}
	 * @return 
	 */
	public void updateForPrintedArrivalNotice(String bl, String date)throws DataAccessException;
	
	/**
	 * Use to search Port for location user.
	 * @param searchParam {@code String } FSC Code
	 * @return List of  {@code string port}
	 */
  public List<ArrivalNoticeMod> getPortByLocationUser(String fscCode)throws DataAccessException;
  /**
	 * Used for search Arrival Notice base on search parameter for InVoyageBrowser.
	 * <p>Blank search is not allowed</p>
	 * @param searchParam {@code BlcArrivalNoticeModel}
	 * @return List of {@code BlcArrivalNoticeModel}
	 */
	public List<ArrivalNoticeMod> findArrivalNoticeDataForInVoyageBrowser(ArrivalNoticeMod searchParam)throws DataAccessException;
	/**
	 * Used to report Url .
	 * <p>Blank search is not allowed</p>
	 * @param BL Number  {@code String}
	 * @return 
	 */
    public String getUrlForReportFilePath()throws DataAccessException;
    
    /**
	 * Used to report Url .
	 * <p>Blank search is not allowed</p>
	 * @param BL Number  {@code String}
	 * @return 
	 */
    public String getUrlForReportServerName()throws DataAccessException;
   
}
