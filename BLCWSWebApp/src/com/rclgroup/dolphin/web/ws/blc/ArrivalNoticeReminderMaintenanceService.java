/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.ws.blc;

/* -------------------------- Change Log ----------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    28/03/20       chandu               Initial Version
---------------------------------------------------------------------------------
*/
import java.util.List;

/* -------------------------- Change Log ----------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    27/03/20       Sushil               Initial Version
---------------------------------------------------------------------------------
*/

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;

import com.rclgroup.dolphin.web.common.RrcApplicationContextWS;
import com.rclgroup.dolphin.web.dao.blc.ArrivalNoticeReminderMaintenanceDao;
import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeReminderMaintenanceMod;
import com.rclgroup.dolphin.web.model.blc.ErrorMod;
import com.rclgroup.dolphin.web.model.blc.ResponseMod;
import com.rclgroup.dolphin.web.utils.blc.Constants;
import com.rclgroup.dolphin.web.utils.blc.DateUtils;
import com.rclgroup.dolphin.web.utils.blc.Utils;

/**
 *This class contain extends  of {@code BlcBaseService}
 * @author Cognis Solution
 */
@Path("/blcArrivalNoticeMaintenance")
public final class ArrivalNoticeReminderMaintenanceService extends BlcBaseService {
	private static final Logger logger = Logger.getLogger(ArrivalNoticeReminderMaintenanceService.class);
	private final ArrivalNoticeReminderMaintenanceDao blcarrivalNoticeReminderMaintenanceDao = (ArrivalNoticeReminderMaintenanceDao) RrcApplicationContextWS
			.getBean("blcarrivalNoticeReminderMaintenanceDao");

	/**
	 * This method is use to get UI search param and call dao class to get Data from DB.
	 * @param request {@code HttpServletRequest}
	 * @param bl      {@code String}
	 * @param opCode  {@code String}
	 * @param socCoc  {@code String}
	 * @return
	 */
	@POST
	@Path("/search")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)

	public Response getblcArrivalNoticeReminderMaintenance(@Context HttpServletRequest request,ArrivalNoticeReminderMaintenanceMod searchParam) {
		long startTime = System.currentTimeMillis();
		System.out.println("start of blcArrivalNoticeReminderMaintenanceSearch");
		String jsonOutput = null;
		System.out.println("Search Parameter --> " + searchParam);
		searchParam.setUserID(searchParam.getBrowserData().getUserId());
		searchParam.setPodEtd(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getPodEtd()));
		searchParam.setPodEta(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getPodEta()));
		searchParam.setDirection(Utils.getDirectionAsCode(searchParam.getDirection()));
		List<ArrivalNoticeReminderMaintenanceMod> resultList = blcarrivalNoticeReminderMaintenanceDao.findByGivenvalue(searchParam);
		ResponseMod responseMod = new ResponseMod(resultList, true);
		jsonOutput = serializeToJSONString(responseMod);
		long endTime = System.currentTimeMillis();		
		System.out.println("Time Taken in blcArrivalNoticeReminderSearch "+Utils.getTimeTaken(startTime, endTime));
		System.out.println("end  of blcArrivalNoticeReminderSearch");
		return Response.status(200).entity(jsonOutput).build();

	}
	/**
	 * This method is use to get UI search param and call dao class to get Data from DB. 
	 * @param request   {@code HttpServletRequest}
	 * @param searchBy  {@code String}
	 * @param service   {@code String}
	 * @param vessel    {@code String}
	 * @param voyage    {@code String}
	 * @param direction {@code String}
	 * @param inVoyage  {@code String}
	 * @param etaForSgsin  {@code String}
	 * @return
	 */
	
      
		@POST
		@Path("/editBl")
		@Consumes(MediaType.APPLICATION_JSON)
		@Produces(MediaType.APPLICATION_JSON)
	    public Response getblcArrivalNoticeReminderFilterdBLList(@Context HttpServletRequest request,ArrivalNoticeReminderMaintenanceMod searchParam) {
		long startTime = System.currentTimeMillis();
		searchParam.setPodEtd(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getPodEtd()));
		searchParam.setPodEta(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getPodEta()));
		searchParam.setDirection(Utils.getDirectionAsCode(searchParam.getDirection()));
		//searchParam.setEtaForSgsin(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getEtaForSgsin()));
		searchParam.setUserID(searchParam.getBrowserData().getUserId());

		System.out.println("start of blcArrivalNoticeReminderMaintance");
		System.out.println("Search Parameter --> " + searchParam);

		String jsonOutput = null;

		try {

			
			List<ArrivalNoticeReminderMaintenanceMod> blcArrivalNoticeReminderList = blcarrivalNoticeReminderMaintenanceDao
					.findByGivenKeyForArrivalNoticeReminderMaintenance(searchParam);
			System.out.println("Result List Size ===> " + blcArrivalNoticeReminderList.size());
			ResponseMod responseMod = new ResponseMod(blcArrivalNoticeReminderList, true);
			jsonOutput = serializeToJSONString(responseMod);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED, Constants.ARRIVAL_NOTICE_REMINDER_SEARCH);
			return Response.status(Constants.SC_SERVER_ERROR).entity(serializeToJSONString(error)).build();

		}
		long endTime = System.currentTimeMillis();		
		System.out.println("end of blcArrivalNoticeReminderMaintance");
		System.out.println("Time Taken in blcArrivalNoticeReminderMaintance "+Utils.getTimeTaken(startTime, endTime));
		return Response.status(Constants.SC_OK).entity(jsonOutput).build();
	}
}
