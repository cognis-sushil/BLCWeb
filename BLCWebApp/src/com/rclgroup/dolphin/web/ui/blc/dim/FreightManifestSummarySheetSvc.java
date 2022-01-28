package com.rclgroup.dolphin.web.ui.blc.dim;


import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rclgroup.dolphin.blc.utils.Constants;
import com.rclgroup.dolphin.web.common.RrcStandardSvc;

public class FreightManifestSummarySheetSvc extends RrcStandardSvc {
	public void execute(HttpServletRequest request, HttpServletResponse response, ServletContext context)
			throws Exception {
		try {
			String strTarget = Constants.BLC_IMPORT_EXPORT_VIEW_BL_FREIGHT_MANIFEST_DIMP_SCN;
			request.setAttribute("target", strTarget);
		} catch (Exception exc) {
			exc.printStackTrace();
		}
	}
}
