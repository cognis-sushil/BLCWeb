/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.dao.blc;

/* ------------------------- Change Log ---------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    13/03/20       Chandu               Initial Version
-------------------------------------------------------------------------------
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
import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeReminderMod;

import oracle.jdbc.OracleTypes;

/**
 * This class contain implementation of {@code BlcArrivalNoticeReminderDao}
 * @author Cognis Solution
 *
 */
public final class ArrivalNoticeReminderJdbcDao extends RrcStandardDao implements ArrivalNoticeReminderDao {
	private static final Logger logger = Logger.getLogger(ArrivalNoticeReminderJdbcDao.class);
	private BlcArrivleNoticeReminderProcedure blcArrivleNoticeReminderProcedure;
	private BlcGetPortArrivleNoticeStoreReminderProcedure blcGetPortArrivleNoticeStoreReminderProcedure;
	private BlcArrivleNoticeReminderProcedureForInCaseInVoyageBrowser blcArrivleNoticeReminderProcedureForInCaseInVoyageBrowser;
	private int seq;
	private String pot;
	protected void initDao() throws Exception {
        super.initDao();
        blcGetPortArrivleNoticeStoreReminderProcedure= new BlcGetPortArrivleNoticeStoreReminderProcedure(getJdbcTemplate(),new BlPortMapper());
        blcArrivleNoticeReminderProcedure = new BlcArrivleNoticeReminderProcedure(getJdbcTemplate(),new BlcArrivalNoticeReminderMapper());
        blcArrivleNoticeReminderProcedureForInCaseInVoyageBrowser= new BlcArrivleNoticeReminderProcedureForInCaseInVoyageBrowser(getJdbcTemplate(),new BlcArrivalNoticeReminderMapper());
    }

	/**
	 * Inner class for Mapping the database data to java object.
	 * @author Cognis Solution
	 */
	class BlcArrivalNoticeReminderMapper implements RowMapper {

		/**
		 * Map each row of data in the ResultSet.
		 * @param rs {@code ResultSet }
		 * @param rowNum the number of the current row
		 * @return the result object for the current row
		 * @throws SQLException
		 */
		public ArrivalNoticeReminderMod mapRow(ResultSet rs, int rowNum) throws SQLException {

			ArrivalNoticeReminderMod model = new ArrivalNoticeReminderMod();
			model.setSeq(rs.getString("ROWNUM"));		 
			model.setService(rs.getString("DISCHARGE_SERVICE"));
			model.setVessel(rs.getString("DISCHARGE_VESSEL"));
			model.setVoyage(rs.getString("DISCHARGE_VOYAGE"));
			model.setDirection(rs.getString("DISCHARGE_DIRECTION"));
		    model.setPot(pot);
			model.setPol(rs.getString("DN_CUSTOMER_POL"));
			model.setPolEtd(rs.getString("POD_ETD"));			
			model.setPod(rs.getString("DN_CUSTOMER_POD"));
			model.setPodEta(rs.getString("POD_ETA"));
			 
			return model;
		}
	}

	/**
	 * {@inheritDoc}
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */
	@Override
	public List<ArrivalNoticeReminderMod> findByGivenKeyForArrivalNoticeReminder (
			ArrivalNoticeReminderMod searchParam)throws DataAccessException {
		System.out.println("searchParam  DAO  ===>" +searchParam.getDirection());
		System.out.println("   Inside findByGivenKeyForArrivalNoticeReminder   ");
		this.seq=1;
		return blcArrivleNoticeReminderProcedure.getArrivalNoticeReminderSearchData(searchParam);
	}

	/**
	 * Inner class for declared In and Out parameter for StoredProcedure.
	 * @author Cognis Solution
	 *
	 */
	protected class BlcArrivleNoticeReminderProcedure extends StoredProcedure {

		protected BlcArrivleNoticeReminderProcedure(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER);
			declareParameter(new SqlParameter("P_I_V_BL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_SERVICE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VESSEL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VOYAGE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_DIRECTION", OracleTypes.VARCHAR));
			 declareParameter(new SqlParameter("P_I_V_POL", OracleTypes.VARCHAR));
			 declareParameter(new SqlParameter("P_I_V_POD", OracleTypes.VARCHAR));                 
			 declareParameter(new SqlParameter("P_I_V_IN_VOYAGE", OracleTypes.VARCHAR));
			 declareParameter(new SqlParameter("P_I_V_ETA", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_USER_ID", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		/**
		 * 
		 * Used to call StoredProcedure.
		 * @author Cognis Solution
		 *
		 */
		protected List<ArrivalNoticeReminderMod> getArrivalNoticeReminderSearchData(
				ArrivalNoticeReminderMod searchParam) {

			Map inPara = new HashMap();
			inPara.put("P_I_V_BL", searchParam.getBlNo());
			inPara.put("P_I_V_SERVICE", searchParam.getService());
			inPara.put("P_I_V_VESSEL", searchParam.getVessel());
			inPara.put("P_I_V_VOYAGE", searchParam.getVoyage());
			inPara.put("P_I_V_DIRECTION", searchParam.getDirection());
			inPara.put("P_I_V_POL", searchParam.getPol());
			inPara.put("P_I_V_POD", searchParam.getPod());
			inPara.put("P_I_V_IN_VOYAGE", searchParam.getInVoyage());
			inPara.put("P_I_V_ETA", searchParam.getEtaForSgsin());
			inPara.put("P_I_V_USER_ID", searchParam.getUserID());
		
			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<ArrivalNoticeReminderMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

		}
	}
	/**
	 * {@inheritDoc}
	 * 
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */
	public  List<ArrivalNoticeReminderMod> getPortByLocationUser(String fscCode) throws DataAccessException {
		 List<ArrivalNoticeReminderMod> port = blcGetPortArrivleNoticeStoreReminderProcedure.getPortForPrintedArrivalNoticeReminder(fscCode);
		 System.out.println("port ===> " +port.get(0).getPort());
		return port;
	}

	protected class BlcGetPortArrivleNoticeStoreReminderProcedure extends StoredProcedure {

		protected BlcGetPortArrivleNoticeStoreReminderProcedure(JdbcTemplate jdbcTemplate,RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER_PORT);
			declareParameter(new SqlParameter("P_I_V_FSC_CODE", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		protected List<ArrivalNoticeReminderMod> getPortForPrintedArrivalNoticeReminder(String fscCode) {

			Map inPara = new HashMap();
			inPara.put("P_I_V_FSC_CODE", fscCode);
			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<ArrivalNoticeReminderMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

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
		public ArrivalNoticeReminderMod mapRow(ResultSet rs, int rowNum) throws SQLException {
			ArrivalNoticeReminderMod model = null;
			model = new ArrivalNoticeReminderMod();
			model.setPort(rs.getString("OCEAN_PORT"));
			return model;
		}
	}

	@Override
	public List<ArrivalNoticeReminderMod> findByGivenKeyForArrivalNoticeReminderInCaseInVoyageBrowser(
			ArrivalNoticeReminderMod searchParam) throws DataAccessException {
		this.seq=1;
		return blcArrivleNoticeReminderProcedureForInCaseInVoyageBrowser.getArrivalNoticeReminderSearchDataForInCaseInVoyageBrowser(searchParam);
	}
	/**
	 * Inner class for declared In and Out parameter for StoredProcedure.
	 * @author Cognis Solution
	 *
	 */
	protected class BlcArrivleNoticeReminderProcedureForInCaseInVoyageBrowser extends StoredProcedure {

		protected BlcArrivleNoticeReminderProcedureForInCaseInVoyageBrowser(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER_INVOYAGE);
			
			declareParameter(new SqlParameter("P_I_V_BL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_SERVICE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VESSEL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VOYAGE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_DIRECTION", OracleTypes.VARCHAR));
			 declareParameter(new SqlParameter("P_I_V_POL", OracleTypes.VARCHAR));
			 declareParameter(new SqlParameter("P_I_V_POD", OracleTypes.VARCHAR));                 
			 declareParameter(new SqlParameter("P_I_V_IN_VOYAGE", OracleTypes.VARCHAR));
			 declareParameter(new SqlParameter("P_I_V_ETA", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_USER_ID", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		/**
		 * 
		 * Used to call StoredProcedure.
		 * @author Cognis Solution
		 *
		 */
		protected List<ArrivalNoticeReminderMod> getArrivalNoticeReminderSearchDataForInCaseInVoyageBrowser(
				ArrivalNoticeReminderMod searchParam) {

			Map inPara = new HashMap();
			inPara.put("P_I_V_BL", searchParam.getBlNo());
			inPara.put("P_I_V_SERVICE", searchParam.getService());
			inPara.put("P_I_V_VESSEL", searchParam.getVessel());
			inPara.put("P_I_V_VOYAGE", searchParam.getVoyage());
			inPara.put("P_I_V_DIRECTION", searchParam.getDirection());
			inPara.put("P_I_V_POL", searchParam.getPol());
			inPara.put("P_I_V_POD", searchParam.getPod());
			inPara.put("P_I_V_IN_VOYAGE", searchParam.getInVoyage());
			inPara.put("P_I_V_ETA", searchParam.getEtaForSgsin());
			inPara.put("P_I_V_USER_ID", searchParam.getUserID());
		
			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<ArrivalNoticeReminderMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

		}
	}
}
