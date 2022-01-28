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

import com.rclgroup.dolphin.web.common.RrcApplicationContextWS;
import com.rclgroup.dolphin.web.dao.blc.IncomingBlInqueryDao;
import com.rclgroup.dolphin.web.model.blc.ErrorMod;
import com.rclgroup.dolphin.web.model.blc.IncomingBlInqueryMod;
import com.rclgroup.dolphin.web.model.blc.ResponseMod;
import com.rclgroup.dolphin.web.utils.blc.Constants;
import com.rclgroup.dolphin.web.utils.blc.DateUtils;
import com.rclgroup.dolphin.web.utils.blc.Utils;

/**
 *This class contain extends  of {@code BlcBaseService}
 * @author Cognis Solution
 */
@Path("/blcIncomingBlInquery")
public final class IncomingBlInqueryService extends BlcBaseService{
	private static final Logger logger = Logger.getLogger(IncomingBlInqueryService.class);
	private final IncomingBlInqueryDao incomingBlInqueryDao = (IncomingBlInqueryDao) RrcApplicationContextWS.getBean("blIncomingBlInqueryDao");
		
	/**
	 * This method is use to get UI search param and call dao class to get Data from DB.
	 * @param request      {@code HttpServletRequest}
	 * @param service      {@code String}
	 * @param vessel       {@code String}
	 * @param voyage       {@code String}
	 * @param direction    {@code String}
	 * @param pol          {@code String}
	 * @param pot          {@code String}
	 * @return
	 */
	@POST
	@Path("/search")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)
	public Response getBlcIncomingBlInquerySearchList(@Context HttpServletRequest request, IncomingBlInqueryMod searchParam ){
		long startTime =System.currentTimeMillis();
		System.out.println("start of blcIncomingBlInquerySearch");
		
		String jsonOutput = null;
		searchParam.setEtd(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getEtd()));
		searchParam.setEta(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getEta()));
		searchParam.setUserID(searchParam.getBrowserData().getUserId());
		System.out.println("Search Parameter --> "+searchParam);
		 try {
			 List<IncomingBlInqueryMod> blcIncomingBlInqueryList = incomingBlInqueryDao.findByGivenKeyForIncomingBlInquery(searchParam);
				ResponseMod responseMod = new ResponseMod(blcIncomingBlInqueryList, true);
				jsonOutput = serializeToJSONString(responseMod);
		 	
		} catch ( Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED, Constants.INCOMING_BL_INQUIRY_SEARCH);			
			return Response.status(Constants.SC_SERVER_ERROR).entity(serializeToJSONString(error)).build();
			
		}
		 System.out.println("end  of blcIncomingBlInquerySearch");
		 long endTime =System.currentTimeMillis();
		 System.out.println("Time Taken in blcIncomingBlInquerySearch"+Utils.getTimeTaken(startTime, endTime));
		 
		 return Response.status(Constants.SC_OK).entity(jsonOutput).build();		
	}
	
}
