package com.rclgroup.dolphin.web.ws.blc;

import java.util.ArrayList;
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
import com.rclgroup.dolphin.web.dao.blc.FreightManifestSummarySheetDao;
import com.rclgroup.dolphin.web.model.blc.ErrorMod;
import com.rclgroup.dolphin.web.model.blc.FreightManifestSummarySheetMod;
import com.rclgroup.dolphin.web.model.blc.ResponseMod;
import com.rclgroup.dolphin.web.utils.blc.Constants;
import com.rclgroup.dolphin.web.utils.blc.Utils;

@Path("/blcFreightManifestSummarySheet")
public  final class FreightManifestSummarySheetService extends BlcBaseService {

	private static final Logger logger = Logger.getLogger(FreightManifestSummarySheetService.class);
	private final FreightManifestSummarySheetDao blcFreightmanifestsummarysheetDao = (FreightManifestSummarySheetDao) RrcApplicationContextWS
			.getBean("blcFreightManifestSummarySheetDao");

	@POST
	@Path("/search")
	@Consumes(MediaType.APPLICATION_JSON)
	@Produces(MediaType.APPLICATION_JSON)

	public Response getFreightManifestSummarySheetData(@Context HttpServletRequest request,
			FreightManifestSummarySheetMod fsMod) {
 		long startTime = System.currentTimeMillis();
		System.out.println("start of FreightManifestSummarySheet");
		System.out.println("Search Parameter --> " + fsMod);
		String jsonOutput = null;
		try {

			FreightManifestSummarySheetMod freightManifestSummarySheetMod = blcFreightmanifestsummarysheetDao
					.findFreightManifestSummarySheetData(fsMod);
			//jsonOutput = serializeToJSONString(freightManifestSummarySheetMod);
			List<FreightManifestSummarySheetMod>  freightManifestSummarySheetModList = new ArrayList<FreightManifestSummarySheetMod>();
			freightManifestSummarySheetModList.add(freightManifestSummarySheetMod);
			ResponseMod responseMod = new ResponseMod(freightManifestSummarySheetModList, true);
			jsonOutput = serializeToJSONString(responseMod);

		} catch (Exception e) {
			e.printStackTrace();
			ErrorMod error = new ErrorMod(Constants.SC_SERVER_ERROR, e.getMessage(), Constants.FAILED,
					Constants.ARRIVAL_NOTICE_SEARCH);
			return Response.status(Constants.SC_SERVER_ERROR).entity(serializeToJSONString(error)).build();
		}

		long endTime = System.currentTimeMillis();
		System.out.println("end of FreightManifestSummarySheet");
		System.out.println("Time Taken in FreightManifestSummarySheet " + Utils.getTimeTaken(startTime, endTime));
		return Response.status(200).entity(jsonOutput).build();
	}

}
