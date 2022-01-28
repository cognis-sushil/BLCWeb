package com.rclgroup.dolphin.web.dao.blc;

import java.util.List;

import org.springframework.dao.DataAccessException;

import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeReminderMaintenanceMod;

public interface ArrivalNoticeReminderMaintenanceDao {
	
	public static final String PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER_VIWE_BL = "PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER.PCR_DIM_BLC_NOTICE_REMINDER_VIEW_BL";
	/**
	 * Use to search arrival notice reminder base on search parameter.
	 * 
	 * @param searchParam
	 *            {@code BlcArrivalNoticeReminderModel}
	 * @return List of {@code BlcArrivalNoticeReminderModel}
	 */
	public List<ArrivalNoticeReminderMaintenanceMod> findByGivenKeyForArrivalNoticeReminderMaintenance(ArrivalNoticeReminderMaintenanceMod searchParam)
			throws DataAccessException;
	/**
	 * Use to search arrival notice reminder base on search parameter.
	 * 
	 * @param searchParam
	 *            {@code BlcArrivalNoticeReminderModel}
	 * @return List of {@code BlcArrivalNoticeReminderModel}
	 */
	public List<ArrivalNoticeReminderMaintenanceMod> findByGivenvalue(ArrivalNoticeReminderMaintenanceMod searchParam)throws DataAccessException;
}
