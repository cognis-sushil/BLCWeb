/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.ws.blc;

/* -------------------------- Change Log ----------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    19/03/20       Sushil               Initial Version
---------------------------------------------------------------------------------
*/
import java.util.HashSet;
import java.util.Set;

import javax.ws.rs.core.Application;

/**
 * This class is extends of {@code Application}
 * @author Cognis Solution
 */
public class BlcApplication extends Application {
	public Set<Class<?>> getClasses() {
		Set<Class<?>> setOfService = new HashSet<Class<?>>();
		setOfService.add(BlCountByActivitySummaryService.class);
		setOfService.add(IncomingBlInqueryService.class);		
		setOfService.add(ArrivalNoticeReminderService.class);
		setOfService.add(ArrivalNoticeService.class);
		setOfService.add(ArrivalNoticeReminderMaintenanceService.class);
		setOfService.add(FreightManifestSummarySheetService.class);
		setOfService.add(InvoyageBrowserService.class);
		return setOfService;
	}
}