package com.rclgroup.dolphin.web.dao.blc;

import org.apache.log4j.Logger;

import com.rclgroup.dolphin.web.common.RrcStandardDao;
import com.rclgroup.dolphin.web.model.blc.FreightManifestSummarySheetMod;

/**
 * This class contain implementation of
 * {@code BlcFreightManifestSummarySheetjdbcDao} * @author Cognis Solution
 *
 */

public final class FreightManifestSummarySheetJdbcDao extends RrcStandardDao implements FreightManifestSummarySheetDao {
	private static final Logger logger = Logger.getLogger(FreightManifestSummarySheetJdbcDao.class);

	/**
	 * {@inheritDoc}
	 * 
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */
	@Override
	public FreightManifestSummarySheetMod findFreightManifestSummarySheetData(
			FreightManifestSummarySheetMod searchParam) {
		System.out.println("Inside findFreightManifestSummarySheetData");
		String service = searchParam.getService();
		String vessel = searchParam.getVessel();
		String voyage = searchParam.getVoyage();
		String pol = searchParam.getPol();
		String sqlQuery = "";

		if (service != null && !service.equals("")) {
			sqlQuery = FR_BLC_CHECK_SRVC_EXIST.replace(PLACE_HOLDER, service);
			int recordCount = getJdbcTemplate().queryForInt(sqlQuery);
			System.out.println("sqlQuery  +++++++++++++++++" + sqlQuery);
			System.out.println("Servcie count +++++++++++++++++" + recordCount);
			if (recordCount == 0) {
				searchParam.setStatus(false);
				searchParam.setMessage("Service not found");
				return searchParam;
			}
		}

		if (vessel != null && !vessel.equals("")) {
			sqlQuery = FR_BLC_CHECK_VESSEL_EXIST.replace(PLACE_HOLDER, vessel);
			int recordCount = getJdbcTemplate().queryForInt(sqlQuery);
			System.out.println("sqlQuery  +++++++++++++++++" + sqlQuery);
			System.out.println(vessel + "Vessele count +++++++++++++++++++" + recordCount);
			if (recordCount == 0) {
				searchParam.setStatus(false);
				searchParam.setMessage("Vessel not found");
				return searchParam;
			}
		}

		if (voyage != null && !voyage.equals("")) {
			sqlQuery = FR_BLC_CHECK_VOYAGE_EXIST.replace(PLACE_HOLDER, voyage);
			int recordCount = getJdbcTemplate().queryForInt(sqlQuery);
			System.out.println(" Voge count +++++++++++++++++++" + recordCount);
			if (recordCount == 0) {
				searchParam.setStatus(false);
				searchParam.setMessage("Voyage not found");
				return  searchParam;
			
			}
		}

		if (pol != null && !pol.equals("")) {
			sqlQuery = FR_BLC_CHECK_POL_EXIST.replace(PLACE_HOLDER, pol);
			int recordCount = getJdbcTemplate().queryForInt(sqlQuery);
			System.out.println("POl count +++++++++++++++++++" + recordCount);
			if (recordCount == 0) {
				searchParam.setStatus(false);
				searchParam.setMessage(" Pol not found");
				return searchParam;			
			}
		}
		if (service != null && vessel != null && voyage != null)
			if (!"".equals(service) && !"".equals(vessel) && !"".equals(voyage)) {
				System.out.println("Vessal Service and Voyge is there ");
				sqlQuery = "SELECT FR_BLC_CHECK_VES_VOY_SRVC_EXIST(q'[" + service + "]',q'[" + vessel + "]',q'[" + voyage
						+ "]') as count FROM DUAL  ";
				int recordCount = getJdbcTemplate().queryForInt(sqlQuery);
				
				System.out.println("sqlQuery====>           "+sqlQuery);
				System.out.println(service + " vessel " + vessel + "voyage" + voyage + " All coung recordCount  " + recordCount);
				if (recordCount == 0) {
					searchParam.setStatus(false);
					searchParam.setMessage("Service,vessel Or voyage not found");
					return  searchParam;				
				}
			}
		searchParam.setStatus(true);
		return  searchParam;
	}

}
