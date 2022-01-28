/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.ws.blc;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
/* -------------------------- Change Log ----------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    28/03/20       Chandu            Initial Version
---------------------------------------------------------------------------------
*/
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.QueryParam;
import javax.ws.rs.core.Context;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;

import org.apache.log4j.Logger;
import org.springframework.util.StringUtils;

import com.rclgroup.dolphin.web.common.RrcApplicationContextWS;
import com.rclgroup.dolphin.web.dao.blc.ArrivalNoticeDao;
import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeMod;
import com.rclgroup.dolphin.web.model.blc.ErrorMod;
import com.rclgroup.dolphin.web.model.blc.ResponseMod;
import com.rclgroup.dolphin.web.util.RutString;
import com.rclgroup.dolphin.web.utils.blc.Constants;
import com.rclgroup.dolphin.web.utils.blc.DateUtils;
import com.rclgroup.dolphin.web.utils.blc.Utils;

/**
 * This class contain extends of {@code BlcBaseService}
 * 
 * @author Cognis Solution
 */
@Path("/blcArrivalNotice")
public final class ArrivalNoticeService extends BlcBaseService {

	private static final Logger logger = Logger.getLogger(ArrivalNoticeService.class);
	public static final String COC = "Both";
	private final ArrivalNoticeDao blArrivalNoticeDao = (ArrivalNoticeDao) RrcApplicationContextWS
			.getBean("blArrivalnoticeDao");

	/**
	 * This method is use to get UI search param and call dao class to get Data from
	 * DB.
	 * 
	 * @param request
	 *            {@code HttpServletRequest}
	 * @param searchBy
	 *            {@code String}
	 * @param bl
	 *            {@code String}
	 * @param vessel
	 *            {@code String}
	 * @param voyage
	 *            {@code String}
	 * @param etaDate
	 *            {@code String}
	 * @param inVoyage
	 *            {@code String}
	 * @param etaIdjkt
	 *            {@code String}
	 * @param pod
	 *            {@code String}
	 * @param socCoc
	 *            {@code String}
	 * @return
	 */
	@POST
	@Path("/search")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)

	public Response getblcArrivalNoticeSearch(@Context HttpServletRequest request, ArrivalNoticeMod searchParam) {

		long startTime = System.currentTimeMillis();
		searchParam.setEtaDate(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getEtaDate()));
		searchParam.setUserID(searchParam.getBrowserData().getUserId());
		System.out.println("start of blcArrivalNoticeSearch");
		System.out.println("Search Parameter --> " + searchParam.toString());

		String jsonOutput = null;
		
		if ( RutString.isEmptyString(searchParam.getVessel()) && RutString.isEmptyString(searchParam.getBlNo())
				&& RutString.isEmptyString(searchParam.getInVoyage()) && RutString.isEmptyString(searchParam.getPod())
				&& COC.equals(searchParam.getSocCoc())
				&& (RutString.isEmptyString(searchParam.getEtaDate()))
				&& RutString.isEmptyString(searchParam.getVoyage())

		) {
			searchParam.setEtaDate(DateUtils.getDefaultDateYYYYMMDD(-720));
			System.out.println("Search Parameter getEtaDate --> " + searchParam.getEtaDate());
		}
		try {
			List<ArrivalNoticeMod> blarrivalnoticedaoimplList = blArrivalNoticeDao.findArrivalNoticeData(searchParam);
			ResponseMod responseMod = new ResponseMod(blarrivalnoticedaoimplList, true);
			jsonOutput = serializeToJSONString(responseMod);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED,
					Constants.ARRIVAL_NOTICE_SEARCH);
			return Response.status(500).entity(serializeToJSONString(error)).build();
		}
		long endTime = System.currentTimeMillis();
		System.out.println("end  of blcArrivalNoticeSearch");
		System.out.println(" Time Taken in seconds " + Utils.getTimeTaken(startTime, endTime));
		return Response.status(200).entity(jsonOutput).build();
	}

	@POST
	@Path("/update")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response updatePrintArrivalNoticePrintedAndDate(@Context HttpServletRequest request,
			ArrivalNoticeMod mod) {
		System.out.println("start of Update Print Arrival Notice");
		System.out.println(" Bl No for update ===> " + mod.getBlNo());
		long startTime = System.currentTimeMillis();
		String jsonOutput = null;
		String date = "";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		date = sdf.format(new Date());
		try {
			blArrivalNoticeDao.updateForPrintedArrivalNotice(mod.getBlNo(), date);
			//jsonOutput = serializeToJSONString("");
			List<String> list = new ArrayList();
			list.add("");
			ResponseMod responseMod = new ResponseMod(list, true);
			jsonOutput = serializeToJSONString(responseMod);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED,
					Constants.ARRIVAL_NOTICE_SEARCH);
			return Response.status(500).entity(serializeToJSONString(error)).build();
		}
		long endTime = System.currentTimeMillis();
		System.out.println("end  of blcArrivalNoticeSearch");
		System.out.println(" Time Taken in seconds " + Utils.getTimeTaken(startTime, endTime));
		return Response.status(200).entity(jsonOutput).build();
	}
	
	
	@POST
	@Path("/searchForInVoyageBrowser")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)

	public Response getblcArrivalNoticeSearchForInVoyageBrowser(@Context HttpServletRequest request, ArrivalNoticeMod searchParam) {

		long startTime = System.currentTimeMillis();
		searchParam.setEtaDate(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getEtaDate()));
		searchParam.setUserID(searchParam.getBrowserData().getUserId());
		System.out.println("start of getblcArrivalNoticeSearchForInVoyageBrowser");
		System.out.println("Search Parameter --> " + searchParam);

		String jsonOutput = null;
		
		if ( RutString.isEmptyString(searchParam.getVessel()) && RutString.isEmptyString(searchParam.getBlNo())
				&& RutString.isEmptyString(searchParam.getInVoyage()) && RutString.isEmptyString(searchParam.getPod())
				&& COC.equals(searchParam.getSocCoc())
				&& (RutString.isEmptyString(searchParam.getEtaDate()))
				&& RutString.isEmptyString(searchParam.getVoyage())

		) {
			searchParam.setEtaDate(DateUtils.getDefaultDateYYYYMMDD(-720));
			
		}
		try {
			List<ArrivalNoticeMod> blarrivalnoticedaoimplList = blArrivalNoticeDao.findArrivalNoticeDataForInVoyageBrowser(searchParam);
			System.out.println("blarrivalnoticedaoimplList result========>       " + blarrivalnoticedaoimplList.size());
			ResponseMod responseMod = new ResponseMod(blarrivalnoticedaoimplList, true);
			jsonOutput = serializeToJSONString(responseMod);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED,
					Constants.ARRIVAL_NOTICE_SEARCH);
			return Response.status(500).entity(serializeToJSONString(error)).build();
		}
		long endTime = System.currentTimeMillis();
		System.out.println("end  of blcArrivalNoticeSearch");
		System.out.println(" Time Taken in seconds " + Utils.getTimeTaken(startTime, endTime));
		return Response.status(200).entity(jsonOutput).build();
	}
	
	
	@POST
	@Path("/getPort")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getPort(@Context HttpServletRequest request, ArrivalNoticeMod arrivalNoticeModVO) {
		System.out.println("start of blcArrivalNotice getPort");
		long startTime = System.currentTimeMillis();
		String fscCode = arrivalNoticeModVO.getBrowserData().getFscCode();
		String jsonOutput = null;
		try {
			List<ArrivalNoticeMod> port = blArrivalNoticeDao.getPortByLocationUser(fscCode);
			System.out.println("Port ===> " + port);
			ResponseMod responseMod = new ResponseMod(port, true);
			jsonOutput = serializeToJSONString(responseMod);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED,
					Constants.ARRIVAL_NOTICE_REMINDER_SEARCH);
			return Response.status(Constants.SC_SERVER_ERROR).entity(serializeToJSONString(error)).build();
		}
		long endTime = System.currentTimeMillis();
		System.out.println("end of get prot");
		System.out.println("Time Taken in getPort " + Utils.getTimeTaken(startTime, endTime));
		return Response.status(Constants.SC_OK).entity(jsonOutput).build();
	}
	
	
	@POST
	@Path("/getReportUrl")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getReportUrl(@Context HttpServletRequest request, ArrivalNoticeMod arrivalNoticeModVO) {
		System.out.println("start of blcArrivalNotice getReportUrl");
		long startTime = System.currentTimeMillis();
		
		String jsonOutput = null;
		try {
			List<String>  url = new ArrayList();
					url.add(blArrivalNoticeDao.getUrlForReportServerName());
					url.add(blArrivalNoticeDao.getUrlForReportFilePath());
				
			System.out.println("Port ===> " + url);
			/*List<String> resultURL = new ArrayList();
			resultURL.add(url);*/
			ResponseMod responseMod = new ResponseMod(url, true);
			jsonOutput = serializeToJSONString(responseMod);
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED,
					Constants.ARRIVAL_NOTICE_REMINDER_SEARCH);
			return Response.status(Constants.SC_SERVER_ERROR).entity(serializeToJSONString(error)).build();
		}
		long endTime = System.currentTimeMillis();
		System.out.println("end of get Url");
		System.out.println("Time Taken in getPort " + Utils.getTimeTaken(startTime, endTime));
		return Response.status(Constants.SC_OK).entity(jsonOutput).build();
	}
	
}
