/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.ws.blc;

/* -------------------------- Change Log ----------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    28/03/20       Chandu            Initial Version
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
import org.springframework.web.bind.annotation.RequestParam;

import com.rclgroup.dolphin.web.common.RrcApplicationContextWS;
import com.rclgroup.dolphin.web.dao.blc.CountByActivitySummaryDao;
import com.rclgroup.dolphin.web.model.blc.CountByActivitySummaryMod;
import com.rclgroup.dolphin.web.model.blc.ErrorMod;
import com.rclgroup.dolphin.web.model.blc.ResponseMod;
import com.rclgroup.dolphin.web.utils.blc.Constants;
import com.rclgroup.dolphin.web.utils.blc.DateUtils;
import com.rclgroup.dolphin.web.utils.blc.Utils;


/**
 *This class contain extends  of {@code BlcBaseService}
 * @author Cognis Solution
 */
@Path("/blCountByActivitySummary")
public final class BlCountByActivitySummaryService extends BlcBaseService {
	private static final Logger logger = Logger.getLogger(BlCountByActivitySummaryService.class);
	private final CountByActivitySummaryDao blCountByActivitySummaryDao = (CountByActivitySummaryDao) RrcApplicationContextWS
			.getBean("blCountByActivitySummaryDao");
	/**
	 * This method is use to get UI search param and call dao class to get Data from DB.
	 * @param request      {@code HttpServletRequest}
	 * @param service      {@code String}
	 * @param vessel       {@code String}
	 * @param voyage       {@code String}
	 * @param direction    {@code String}
	 * @return
	 */
	@POST
	@Path("/search")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getBlCountByActivitySummarySearchList(@Context HttpServletRequest request,	CountByActivitySummaryMod searchParam ) {
		long startTime = System.currentTimeMillis();
		System.out.println("start of blCountByActivitySummarySearch");
		String dateFrom = DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getEtdFrom());
		String dateTo = DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getEtdTo());
		searchParam.setEtdFrom(dateFrom);
		searchParam.setEtdTo(dateTo);
		searchParam.setUserID(searchParam.getBrowserData().getUserId());
		searchParam.setLine(searchParam.getBrowserData().getLine());
		searchParam.setTrade(searchParam.getBrowserData().getTrade());
		searchParam.setAgent(searchParam.getBrowserData().getAgent());
		
		
		
		System.out.println("Search Parameter --> " + searchParam);
		String jsonOutput = null;
		try {
			
			System.out.println(blCountByActivitySummaryDao);
			List<CountByActivitySummaryMod> blCountByActivitySummaryList = blCountByActivitySummaryDao
					.findByGivenKeyForBlCountActivity(searchParam);
			System.out.println("Result List Size --> " + blCountByActivitySummaryList.size());
			System.out.println("Result List Size --> " + blCountByActivitySummaryList.toString());
			ResponseMod responseMod = new ResponseMod(blCountByActivitySummaryList, true);
			jsonOutput = serializeToJSONString(responseMod);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED,
					Constants.BL_COUNT_BY_ACTIVITY_SEARCH);

			return Response.status(Constants.SC_SERVER_ERROR).entity(serializeToJSONString(error)).build();

		}
		System.out.println("end  of blCountByActivitySummarySearch");
		long endTime = System.currentTimeMillis();
		System.out.println("Time Taken in blcIncomingBlInquerySearch" + Utils.getTimeTaken(startTime, endTime));

		return Response.status(Constants.SC_OK).entity(jsonOutput).build();
	}
     
	/**
	 * 
	 * @param request  {@code HttpServletRequest}
	 * @param id       {@code String}
	 * @return
	 */
	@POST
	@Path("/detail")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getBlCountByActivitySummaryDetail(@Context HttpServletRequest request,@RequestParam CountByActivitySummaryMod countActSumVo ){
		
		long startTime = System.currentTimeMillis();
		System.out.println("start of getBlCountByActivitySummaryInfo");
		String jsonOutput = null;
		 String dateFrom = DateUtils.getDateFromDefaultDateStringYYYYMMDD(countActSumVo.getEtdFrom());
		String dateTo = DateUtils.getDateFromDefaultDateStringYYYYMMDD(countActSumVo.getEtdTo());
		countActSumVo.setEtdFrom(dateFrom);
		countActSumVo.setEtdTo(dateTo);
		countActSumVo.setUserID(countActSumVo.getBrowserData().getUserId());
		countActSumVo.setLine(countActSumVo.getBrowserData().getLine());
		countActSumVo.setTrade(countActSumVo.getBrowserData().getTrade());
		countActSumVo.setAgent(countActSumVo.getBrowserData().getAgent());
		//bType
		System.out.println("Search Parameter --> " + countActSumVo);
		
		System.out.println("Search Parameter  service --> " + countActSumVo.getbLType());
		
		 
		try {
			List<CountByActivitySummaryMod> resultList = blCountByActivitySummaryDao
					.findByGivenKeyForBlCountActivityInfo(countActSumVo);
			ResponseMod responseMod = new ResponseMod(resultList, true);
			jsonOutput = serializeToJSONString(responseMod);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED,
					Constants.BL_COUNT_BY_ACTIVITY_DETAIL);

			return Response.status(Constants.SC_SERVER_ERROR).entity(serializeToJSONString(error)).build();

		}
		System.out.println("end  of getBlCountByActivitySummaryInfo");
		long endTime = System.currentTimeMillis();
		System.out.println("Time Taken in blcIncomingBlInquerySearch" + Utils.getTimeTaken(startTime, endTime));

		return Response.status(Constants.SC_OK).entity(jsonOutput).build();
	}
}
