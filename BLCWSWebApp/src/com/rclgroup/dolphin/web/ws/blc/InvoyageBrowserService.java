/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.ws.blc;

/* -------------------------- Change Log ----------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    19/04/20      Akash Gupta            Initial Version
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
import com.rclgroup.dolphin.web.dao.blc.InvoyageBrowserDao;
import com.rclgroup.dolphin.web.model.blc.ErrorMod;
import com.rclgroup.dolphin.web.model.blc.InvoyageBrowserMod;
import com.rclgroup.dolphin.web.model.blc.ResponseMod;
import com.rclgroup.dolphin.web.utils.blc.Constants;
import com.rclgroup.dolphin.web.utils.blc.DateUtils;
import com.rclgroup.dolphin.web.utils.blc.Utils;

/**
 * This class contain extends of {@code BlcBaseService}
 * 
 * @author Cognis Solution
 */

@Path("/blcInvoyageBrowser")
public final class InvoyageBrowserService extends BlcBaseService {

	private static final Logger logger = Logger.getLogger(InvoyageBrowserService.class);
	private final InvoyageBrowserDao invoyageBrowserDao = (InvoyageBrowserDao) RrcApplicationContextWS.getBean("blcInvoyageBrowserDao");

	/**
	 * This method is use to get UI search param and call dao class to get Data from
	 * DB.
	 * 
	 * @param port
	 *            {@code HttpServletRequest}
	 * @param terminal
	 *            {@code String}
	 * @param invoyageBrowser
	 *            {@code String}
	 * @param exptInvoyage
	 *            {@code String}
	 * @param service
	 *            {@code String}
	 * @param portSeq
	 *            {@code String}
	 * @param vessel
	 *            {@code String} * @param voyage {@code String} * @param direction
	 *            {@code String} * @param eta {@code String}
	 * @return
	 */

	@POST
	@Path("/search")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)

	public Response getBlcInvoyageBrowserList(@Context HttpServletRequest request, InvoyageBrowserMod searchParam) {

		String jsonOutput = null;
		searchParam.setEtaForSgsin(DateUtils.getDateFromDefaultDateStringYYYYMMDD(searchParam.getEtaForSgsin()));
		System.out.println("searchParam ===> " + searchParam.toString());
		long startTime = System.currentTimeMillis();
		System.out.println("start of invoyageBrowserSearch");

		try {
			List<InvoyageBrowserMod> blcInvoyageBrowserList = invoyageBrowserDao.findDataForInvoyageBrowser(searchParam);
			ResponseMod responseMod = new ResponseMod(blcInvoyageBrowserList, true);
			jsonOutput = serializeToJSONString(responseMod);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println(e.getStackTrace());
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED,
					Constants.INVOYAGE_BROWSER);
			return Response.status(Constants.SC_SERVER_ERROR).entity(serializeToJSONString(error)).build();
		}
		System.out.println("  end  of invoyageBrowserSearch ");
		long endTime = System.currentTimeMillis();
		System.out.println("Time Taken in invoyageBrowserSearch : " + Utils.getTimeTaken(startTime, endTime));

		return Response.status(Constants.SC_OK).entity(jsonOutput).build();
	}
}
