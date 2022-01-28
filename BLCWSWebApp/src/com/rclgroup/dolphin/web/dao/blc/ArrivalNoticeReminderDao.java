/* Copyright (c) 2020 RCL| All Rights Reserved*/

package com.rclgroup.dolphin.web.dao.blc;

/* --------------------Change Log -------------------------------
	##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
	1    23/03/20       Chandu               Initial Version
	-------------------------------------------------------------------
*/

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeReminderMod;

/**
 * Interface contain methods related to B/L Count Arrival Notice Reminder
 * @author user
 *
 */
public interface ArrivalNoticeReminderDao {
	                                                             
	public static final String PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER = "PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER.PCR_DIM_BLC_NOTICE_REMINDER_SEARCH";
	public static final String PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER_PORT="PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER.PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER_PORT_SEARCH";
	public static final String PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER_INVOYAGE = "PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER.PCR_DIM_BLC_NOTICE_REMINDER_SEARCH_INVOYAGE";
	/**
	 * Use to search arrival notice reminder base on search parameter.
	 * @param searchParam {@code BlcArrivalNoticeReminderModel}
	 * @return List of  {@code BlcArrivalNoticeReminderModel}
	 */
  public List<ArrivalNoticeReminderMod> findByGivenKeyForArrivalNoticeReminder(ArrivalNoticeReminderMod searchParam) throws DataAccessException;
	/**
	 * Use to search Port for location user.
	 *  @param searchParam {@code String }
	 * @return List of  {@code string port}
	 */
  public  List<ArrivalNoticeReminderMod> getPortByLocationUser(String fscCode)throws DataAccessException ;
  /**
	 * Use to search arrival notice reminder base on search parameter In Case invoyage.
	 * @param searchParam {@code BlcArrivalNoticeReminderModel}
	 * @return List of  {@code BlcArrivalNoticeReminderModel}
	 */
	public List<ArrivalNoticeReminderMod> findByGivenKeyForArrivalNoticeReminderInCaseInVoyageBrowser(
			ArrivalNoticeReminderMod searchParam)throws DataAccessException ;
}
