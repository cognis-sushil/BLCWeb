/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.ws.blc;

/* -------------------------- Change Log ----------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    28/03/20       chandu               Initial Version
---------------------------------------------------------------------------------
*/
import java.util.List;

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
import com.rclgroup.dolphin.web.dao.blc.ArrivalNoticeReminderDao;
import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeReminderMod;
import com.rclgroup.dolphin.web.model.blc.ErrorMod;
import com.rclgroup.dolphin.web.model.blc.ResponseMod;
import com.rclgroup.dolphin.web.util.RutString;
import com.rclgroup.dolphin.web.utils.blc.Constants;
import com.rclgroup.dolphin.web.utils.blc.DateUtils;
import com.rclgroup.dolphin.web.utils.blc.Utils;

/**
 *This class contain extends  of {@code BlcBaseService}
 * @author Cognis Solution
 */
@Path("/blcArrivalNoticeReminder")
public final class ArrivalNoticeReminderService extends BlcBaseService {
	                                  
	private static final Logger logger = Logger.getLogger(ArrivalNoticeReminderService.class);
	private final ArrivalNoticeReminderDao blcArrivalNoticeReminderDao = (ArrivalNoticeReminderDao) RrcApplicationContextWS
			.getBean("blcArrivalNoticeReminderDao");
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
	@Path("/search")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)

	public Response getBlcArrivalNoticeReminderSearchList(@Context HttpServletRequest request,ArrivalNoticeReminderMod searchParam) {
		long startTime = System.currentTimeMillis();
		
		searchParam.setUserID(searchParam.getBrowserData().getUserId());

		System.out.println("start of blcArrivalNoticeReminderSearch");
		System.out.println("Search Parameter --> " + searchParam);

		String jsonOutput = null;

		 
		try {
			 if( RutString.isEmptyString(searchParam.getService()) && RutString.isEmptyString(searchParam.getVessel()) 
				&& RutString.isEmptyString(searchParam.getDirection()) && RutString.isEmptyString(searchParam.getInVoyage()) && 
				RutString.isEmptyString(searchParam.getEtaForSgsin()) 
				&& RutString.isEmptyString(searchParam.getVoyage())
				) {
				 searchParam.setEtaForSgsin(DateUtils.getDefaultDateYYYYMMDD(-180));
			 }
             List<ArrivalNoticeReminderMod> blcArrivalNoticeReminderList = blcArrivalNoticeReminderDao
					.findByGivenKeyForArrivalNoticeReminder(searchParam);
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
		System.out.println("end of blcArrivalNoticeReminderSearch");
		System.out.println("Time Taken in blcArrivalNoticeReminderSearch "+Utils.getTimeTaken(startTime, endTime));
		return Response.status(Constants.SC_OK).entity(jsonOutput).build();
	}
	
	@POST
	@Path("/searchPort")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getPort(@Context HttpServletRequest request,ArrivalNoticeReminderMod arrivalNoticeReminderVo) {
		System.out.println("start of blcArrivalNotice getPort");
		long startTime = System.currentTimeMillis();
		String fscCode = arrivalNoticeReminderVo.getBrowserData().getFscCode();
		String jsonOutput = null;

		try {
			 List<ArrivalNoticeReminderMod> port = blcArrivalNoticeReminderDao.getPortByLocationUser(fscCode);
			System.out.println("Port ===> " + port);
			ResponseMod responseMod = new ResponseMod(port, true);
			jsonOutput = serializeToJSONString(responseMod);

		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED, Constants.ARRIVAL_NOTICE_REMINDER_SEARCH);
			return Response.status(Constants.SC_SERVER_ERROR).entity(serializeToJSONString(error)).build();
		}
		long endTime = System.currentTimeMillis();		
		System.out.println("end of blcArrivalNoticeReminderSearch");
		System.out.println("Time Taken in getPort "+Utils.getTimeTaken(startTime, endTime));
		return Response.status(Constants.SC_OK).entity(jsonOutput).build();
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
	@Path("/searchForInVoyageBrowser")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)

	public Response getblcArrivalNoticeReminderSearchListForInVoyageBrowser(@Context HttpServletRequest request,ArrivalNoticeReminderMod searchParam) {
		long startTime = System.currentTimeMillis();
		
		searchParam.setUserID(searchParam.getBrowserData().getUserId());

		System.out.println("start of getblcArrivalNoticeReminderSearchListForInVoyageBrowser");
		System.out.println("Search Parameter --> " + searchParam);

		String jsonOutput = null;

		 
		try {
			 if( RutString.isEmptyString(searchParam.getService()) && RutString.isEmptyString(searchParam.getVessel()) 
				&& RutString.isEmptyString(searchParam.getDirection()) && RutString.isEmptyString(searchParam.getInVoyage()) && 
				RutString.isEmptyString(searchParam.getEtaForSgsin()) 
				&& RutString.isEmptyString(searchParam.getVoyage())
				) {
				 searchParam.setEtaForSgsin(DateUtils.getDefaultDateYYYYMMDD(-180));
			 }
             List<ArrivalNoticeReminderMod> blcArrivalNoticeReminderList = blcArrivalNoticeReminderDao
					.findByGivenKeyForArrivalNoticeReminderInCaseInVoyageBrowser(searchParam);
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
		System.out.println("end of blcArrivalNoticeReminderSearch");
		System.out.println("Time Taken in blcArrivalNoticeReminderSearch "+Utils.getTimeTaken(startTime, endTime));
		return Response.status(Constants.SC_OK).entity(jsonOutput).build();
	}
	
}
