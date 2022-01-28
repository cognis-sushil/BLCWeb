/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.ui.blc.dim;

/* ------------------------- Change Log ---------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    13/03/20       Chandu               Initial Version
-------------------------------------------------------------------------------
*/

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.rclgroup.dolphin.blc.utils.Constants;
import com.rclgroup.dolphin.web.common.RrcStandardSvc;

public class ArrivalNoticeReminderSvc extends RrcStandardSvc {
	public void execute(HttpServletRequest request, HttpServletResponse response, ServletContext context)
			throws Exception {
		try {
			String strTarget = Constants.BLC_IMPORT_EXPORT_VIEW_ARRIVAL_NOTICE_REMINDER_SCN;
			request.setAttribute("target", strTarget);
		} catch (Exception exc) {
			exc.printStackTrace();
		}
	}
}

