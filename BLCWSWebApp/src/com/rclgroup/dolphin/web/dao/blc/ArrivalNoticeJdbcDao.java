/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.dao.blc;

/* --------------------Change Log -------------------------------
 	##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
	1    24/03/20       Chandu            Initial Version
   -------------------------------------------------------------------
*/
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.log4j.Logger;
import org.springframework.dao.DataAccessException;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.jdbc.core.SqlOutParameter;
import org.springframework.jdbc.core.SqlParameter;
import org.springframework.jdbc.object.StoredProcedure;

import com.rclgroup.dolphin.web.common.RrcStandardDao;
import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeMod;
import com.rclgroup.dolphin.web.util.RutCodeDescription;
import com.rclgroup.dolphin.web.utils.blc.Utils;

import oracle.jdbc.internal.OracleTypes;

/**
 * This class contain implementation of {@code BlArrivalNoticeDao}
 * 
 * @author Cognis Solution
 *
 */
public final class ArrivalNoticeJdbcDao extends RrcStandardDao implements ArrivalNoticeDao {
	private static final Logger logger = Logger.getLogger(ArrivalNoticeJdbcDao.class);
	private static final RowMapper Object[] = null;
	private BlcArrivleNoticeStoreProcedure blcArrivleNoticeStoreProcedure;
	private BlcPrintedArrivleNoticeStoreProcedure blcPrintedArrivleNoticeStoreProcedure;
	private BlcGetPortArrivleNoticeStoreProcedure blcGetPortArrivleNoticeStoreProcedure;
	private BlcArrivleNoticeForInvoyageBrowStoreProcedure blcArrivleNoticeForInvoyageBrowStoreProcedure;
	

	protected void initDao() throws Exception {
		super.initDao();
		blcArrivleNoticeStoreProcedure = new BlcArrivleNoticeStoreProcedure(getJdbcTemplate(),
				new BlArrivalNoticeMapper());
		blcPrintedArrivleNoticeStoreProcedure = new BlcPrintedArrivleNoticeStoreProcedure(getJdbcTemplate(),
				new BlArrivalNoticeMapper());
		blcGetPortArrivleNoticeStoreProcedure = new BlcGetPortArrivleNoticeStoreProcedure(getJdbcTemplate(),new BlPortMapper());
		blcArrivleNoticeForInvoyageBrowStoreProcedure = new BlcArrivleNoticeForInvoyageBrowStoreProcedure(getJdbcTemplate(),
				new BlArrivalNoticeMapper());
	}

	/**
	 * Inner class for Mapping the database data to java object.
	 * 
	 * @author Cognis Solution
	 *
	 */
	class BlArrivalNoticeMapper implements RowMapper {

		/**
		 * Map each row of data in the ResultSet.
		 * 
		 * @param rs
		 *            {@code ResultSet }
		 * @param rowNum
		 *            the number of the current row
		 * @return the result object for the current row
		 * @throws SQLException
		 */
		public ArrivalNoticeMod mapRow(ResultSet rs, int rowNum) throws SQLException {
			ArrivalNoticeMod model = null;
			model = new ArrivalNoticeMod();
			model.setSeq(rs.getString("ROWNUM"));
			model.setBlNo(rs.getString("PK_BL_NO"));
			model.setBlid(RutCodeDescription.getBlIdDesc(rs.getString("BLID")));
			model.setBltype(RutCodeDescription.getBlTypeDesc(rs.getString("BL_TYPE")));
			model.setCreationoffice(rs.getString("FOR_FSC"));
			model.setSc(Utils.getSOC(rs.getString("SOC_COC")));
			model.setOutstatus(RutCodeDescription.getBlStatusDesc(rs.getString("DEX_STATUS")));
			model.setInstatus(RutCodeDescription.getBlStatusDesc(rs.getString("DIM_STATUS")));
			model.setVessel(rs.getString("DISCHARGE_VESSEL"));
			model.setVoyage(rs.getString("DISCHARGE_VOYAGE"));
			model.setEta(rs.getString("POD_ETA"));
			model.setPor(rs.getString("DN_PLR"));
			model.setPol(rs.getString("POLCNAME"));
			model.setPot(rs.getString("DN_POT1"));
			model.setPod(rs.getString("PODCNAME"));
			model.setDel(rs.getString("DN_PLD"));
			model.setShiptype(rs.getString("SHIPMENT_TYPE_AT_POL"));
			model.setPrinted(rs.getString("NUMBER_OF_TIME_ARRAVAL_PRINTED"));
			model.setDateprinted(rs.getString("LAST_DATE_ARRIVAL_PRINTED"));
			model.setSelect("");

			return model;
		}
	}

	/**
	 * {@inheritDoc}
	 * 
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */
	@Override
	public List<ArrivalNoticeMod> findArrivalNoticeData(ArrivalNoticeMod searchParam) throws DataAccessException {
		System.out.println("Inside findArrivalNoticeData");
		return blcArrivleNoticeStoreProcedure.getArrivalNoticeSearchData(searchParam);
	}

	/**
	 * Inner class for declared In and Out parameter for StoredProcedure.
	 * 
	 * @author Cognis Solution
	 *
	 */
	protected class BlcArrivleNoticeStoreProcedure extends StoredProcedure {

		protected BlcArrivleNoticeStoreProcedure(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH);
			declareParameter(new SqlParameter("P_I_V_BL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_SERVICE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VESSEL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VOYAGE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_PORT_LOOKUP", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_SOC_COC", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_ETA_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_ETA_PORT_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_USER_ID", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		/**
		 * 
		 * Used to call StoredProcedure.
		 * 
		 * @author Cognis Solution
		 *
		 */
		protected List<ArrivalNoticeMod> getArrivalNoticeSearchData(ArrivalNoticeMod searchParam) {
			System.out.println(" P_I_V_USER_ID -->getArrivalNoticeSearchData " + searchParam.getBrowserData().getUserId());
			Map inPara = new HashMap();
			inPara.put("P_I_V_BL", searchParam.getBlNo());
			inPara.put("P_I_V_SERVICE", searchParam.getService());
			inPara.put("P_I_V_VESSEL", searchParam.getVessel());
			inPara.put("P_I_V_VOYAGE", searchParam.getVoyage());
			inPara.put("P_I_V_PORT_LOOKUP", searchParam.getPod());
			inPara.put("P_I_V_SOC_COC", searchParam.getSocCoc());
			inPara.put("P_I_V_ETA_DATE", searchParam.getEtaDate());
			inPara.put("P_I_V_ETA_PORT_DATE", searchParam.getEtaPort());
			inPara.put("P_I_V_USER_ID", searchParam.getBrowserData().getUserId());
			Map outMap = execute(inPara);
			
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<ArrivalNoticeMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

		}

	}

	/**
	 * {@inheritDoc}
	 * 
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */

	@Override
	public void updateForPrintedArrivalNotice(String bl, String date) throws DataAccessException {
		System.out.println("Inside update ArrivalNotice Printed ");
		synchronized (this) {
			blcPrintedArrivleNoticeStoreProcedure.updatePrintedArrivalNotice(bl, date);
		}

	}

	protected class BlcPrintedArrivleNoticeStoreProcedure extends StoredProcedure {

		protected BlcPrintedArrivleNoticeStoreProcedure(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_ARRIVALE_NOTICE_UPDATE);
			declareParameter(new SqlParameter("P_I_V_BL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_DATE", OracleTypes.VARCHAR));

			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		protected List<ArrivalNoticeMod> updatePrintedArrivalNotice(String bl, String date) {

			Map inPara = new HashMap();
			inPara.put("P_I_V_BL", bl);
			inPara.put("P_I_V_DATE", date);

			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<ArrivalNoticeMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

		}
	}

	/**
	 * {@inheritDoc}
	 * 
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */
	public List<ArrivalNoticeMod> getPortByLocationUser(String fscCode) throws DataAccessException {
		 List<ArrivalNoticeMod> port = blcGetPortArrivleNoticeStoreProcedure.getPortForPrintedArrivalNotice(fscCode);
		 System.out.println("port ===> " +port.get(0).getEtaPort());
		return port;
	}

	protected class BlcGetPortArrivleNoticeStoreProcedure extends StoredProcedure {

		protected BlcGetPortArrivleNoticeStoreProcedure(JdbcTemplate jdbcTemplate,RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_ARRIVALE_NOTICE_GET_PORT);
			declareParameter(new SqlParameter("P_I_V_FSC_CODE", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		protected List<ArrivalNoticeMod> getPortForPrintedArrivalNotice(String fscCode) {

			Map inPara = new HashMap();
			inPara.put("P_I_V_FSC_CODE", fscCode);

			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<ArrivalNoticeMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

		}
	}
	/**
	 * Map each row of data in the ResultSet.
	 * 
	 * @param rs
	 *            {@code ResultSet }
	 * @param rowNum
	 *            the number of the current row
	 * @return the result object for the current row
	 * @throws SQLException
	 */
	class BlPortMapper implements RowMapper {

		/**
		 * Map each row of data in the ResultSet.
		 * 
		 * @param rs
		 *            {@code ResultSet }
		 * @param rowNum
		 *            the number of the current row
		 * @return the result object for the current row
		 * @throws SQLException
		 */
		public ArrivalNoticeMod mapRow(ResultSet rs, int rowNum) throws SQLException {
			ArrivalNoticeMod model = null;
			model = new ArrivalNoticeMod();
			
			model.setEtaPort(rs.getString("OCEAN_PORT"));
			
			return model;
		}
	}

	@Override
	public List<ArrivalNoticeMod> findArrivalNoticeDataForInVoyageBrowser(ArrivalNoticeMod searchParam) {
		System.out.println("Inside findArrivalNoticeDataForInVoyageBrowser");
		return blcArrivleNoticeForInvoyageBrowStoreProcedure.getArrivalNoticeSearchDataForInvoyageBrow(searchParam);
	}
	
	protected class BlcArrivleNoticeForInvoyageBrowStoreProcedure extends StoredProcedure {

		protected BlcArrivleNoticeForInvoyageBrowStoreProcedure(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_ARRIVALE_NOTICE_SEARCH_INVOYAGE);
			
			declareParameter(new SqlParameter("P_I_V_BL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_SERVICE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VESSEL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VOYAGE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_DIRECTION", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_PORT_LOOKUP", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_SOC_COC", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_ETA_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_ETA_PORT_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_USER_ID", OracleTypes.VARCHAR));
			 declareParameter(new SqlParameter("P_I_V_IN_VOYAGE", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
			}

		/**
		 * 
		 * Used to call StoredProcedure.
		 * 
		 * @author Cognis Solution
		 *
		 */
		protected List<ArrivalNoticeMod> getArrivalNoticeSearchDataForInvoyageBrow(ArrivalNoticeMod searchParam) {
			System.out.println(" P_I_V_USER_ID -->getArrivalNoticeSearchData " + searchParam.getBrowserData().getUserId());
			Map inPara = new HashMap();
			
			inPara.put("P_I_V_BL", searchParam.getBlNo());
			inPara.put("P_I_V_SERVICE", searchParam.getService());
			inPara.put("P_I_V_VESSEL", searchParam.getVessel());
			inPara.put("P_I_V_VOYAGE", searchParam.getVoyage());
			inPara.put("P_I_V_DIRECTION", searchParam.getDirection());
			inPara.put("P_I_V_PORT_LOOKUP", searchParam.getPod());
			inPara.put("P_I_V_SOC_COC", searchParam.getSocCoc());
			inPara.put("P_I_V_ETA_DATE", searchParam.getEtaDate());
			inPara.put("P_I_V_ETA_PORT_DATE", searchParam.getEtaPort());
			inPara.put("P_I_V_USER_ID", searchParam.getBrowserData().getUserId());
			inPara.put("P_I_V_IN_VOYAGE", searchParam.getInVoyage());
			
			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<ArrivalNoticeMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

		}

	}

	@Override
	public String getUrlForReportFilePath() {
		String sqlQuery =SQL_FOR_URL_REPORT_FILE_PATH ;
		
		List<String> result= getJdbcTemplate().queryForList(sqlQuery, String.class);
		System.out.println("   Query  excuted for url   "+  result.size());
					
		System.out.println("   Query  excuted for url   "+  result.toString());
		return result.get(0);
	}
	
	@Override
	public String getUrlForReportServerName() {
		String sqlQuery =SQL_FOR_URL_REPORT_SERVER_NAME ;
		
		List<String> result= getJdbcTemplate().queryForList(sqlQuery, String.class);
		System.out.println("   Query  excuted for url   "+  result.size());
					
		System.out.println("   Query  excuted for url   "+  result.toString());
		return result.get(0);
	}


}
