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
import com.rclgroup.dolphin.web.model.blc.ArrivalNoticeReminderMaintenanceMod;
import com.rclgroup.dolphin.web.util.RutCodeDescription;
import com.rclgroup.dolphin.web.utils.blc.Utils;

import oracle.jdbc.OracleTypes;

/**
 * This class contain implementation of {@code ArrivalNoticeReminderMaintenanceDao}
 * @author Cognis Solution
 *
 */
public class ArrivalNoticeReminderMaintenanceJdbcDao extends RrcStandardDao implements ArrivalNoticeReminderMaintenanceDao {

	private static final Logger logger = Logger.getLogger(ArrivalNoticeReminderMaintenanceJdbcDao.class);
	private BlcArrivleNoticeReminderMaintenanceProcedure blcArrivleNoticeReminderProcedure;
	private int seq;
	protected void initDao() throws Exception {
        super.initDao();
        blcArrivleNoticeReminderProcedure = new BlcArrivleNoticeReminderMaintenanceProcedure(getJdbcTemplate(),new BlcArrivalNoticeReminderMaintenanceMapper());
    }

	/**
	 * Inner class for Mapping the database data to java object.
	 * @author Cognis Solution
	 */
	class BlcArrivalNoticeReminderMaintenanceMapper implements RowMapper {

		/**
		 * Map each row of data in the ResultSet.
		 * @param rs {@code ResultSet }
		 * @param rowNum the number of the current row
		 * @return the result object for the current row
		 * @throws SQLException
		 */
		public ArrivalNoticeReminderMaintenanceMod mapRow(ResultSet rs, int rowNum) throws SQLException {

			ArrivalNoticeReminderMaintenanceMod model = new ArrivalNoticeReminderMaintenanceMod();
			model.setSeq(rs.getString("ROWNUM"));
			model.setBlNo(rs.getString("PK_BL_NO"));
			model.setService(rs.getString("DISCHARGE_SERVICE"));
			model.setVessel(rs.getString("DISCHARGE_VESSEL"));
			model.setVoyage(rs.getString("DISCHARGE_VOYAGE"));
			model.setDirection(rs.getString("DISCHARGE_DIRECTION"));
			model.setInVoyage(rs.getString("FIRST_VOYAGE"));
			model.setEtaForSgsin(rs.getString("POL_ETD"));
			model.setPol(rs.getString("DN_CUSTOMER_POL"));
			model.setPodEtd(rs.getString("POD_ETD"));
			model.setPolEtd(rs.getString("POL_ETD"));
			model.setPod(rs.getString("DN_CUSTOMER_POD"));
			model.setPodEta(rs.getString("POD_ETA"));
			model.setInStatus(RutCodeDescription.getBlStatusDesc(rs.getString("DIM_STATUS")));
			model.setIssueOffice(rs.getString("TRADE_FSC"));
			model.setOpCode(rs.getString("PRINCIPAL_CODE"));
			model.setSocCoc(Utils.getSOC(rs.getString("SOC_COC")));
			model.setNumberOfTimeArravalPrinted(rs.getString("NUMBER_OF_TIME_ARRAVAL_PRINTED"));
			model.setLastDateArrivalPrinted(rs.getString("LAST_DATE_ARRIVAL_PRINTED"));
			return model;
		}
	}

	/**
	 * {@inheritDoc}
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */
	@Override
	public List<ArrivalNoticeReminderMaintenanceMod> findByGivenKeyForArrivalNoticeReminderMaintenance (
			ArrivalNoticeReminderMaintenanceMod searchParam)throws DataAccessException {
		System.out.println("searchParam  DAO  ===>" +searchParam.toString());
		System.out.println("   Inside findByGivenKeyForArrivalNoticeReminderMaintenance   ");
		this.seq=1;
		return blcArrivleNoticeReminderProcedure.getArrivalNoticeReminderMaintanceEditBl(searchParam);
	}

	/**
	 * Inner class for declared In and Out parameter for StoredProcedure.
	 * @author Cognis Solution
	 *
	 */
	protected class BlcArrivleNoticeReminderMaintenanceProcedure extends StoredProcedure {

		protected BlcArrivleNoticeReminderMaintenanceProcedure(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_ARRIVALE_NOTICE_REMINDER_VIWE_BL);
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
			declareParameter(new SqlParameter("P_I_V_FOR_FSC", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_PRINCIPAL_CODE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_SOC_COC", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_POD_ETA", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		/**
		 * 
		 * Used to call StoredProcedure.
		 * @author Cognis Solution
		 *
		 */
		protected List<ArrivalNoticeReminderMaintenanceMod> getArrivalNoticeReminderMaintanceEditBl(
				ArrivalNoticeReminderMaintenanceMod searchParam) {         
			Map inPara = new HashMap();
			inPara.put("P_I_V_BL", searchParam.getBlNo());
			inPara.put("P_I_V_SERVICE", searchParam.getService());
			inPara.put("P_I_V_VESSEL", searchParam.getVessel());
			inPara.put("P_I_V_VOYAGE", searchParam.getVoyage());
			inPara.put("P_I_V_DIRECTION", searchParam.getDirection());        
			inPara.put("P_I_V_POL", searchParam.getPol());
			inPara.put("P_I_V_POD", searchParam.getPod());
			inPara.put("P_I_V_IN_VOYAGE", searchParam.getInVoyage());
			inPara.put("P_I_V_ETA", null);
			inPara.put("P_I_V_USER_ID", searchParam.getUserID());
			inPara.put("P_I_V_FOR_FSC", searchParam.getForFsc());                
			inPara.put("P_I_V_PRINCIPAL_CODE", searchParam.getOpCode()); 
			inPara.put("P_I_V_SOC_COC", searchParam.getSocCoc());                 
			inPara.put("P_I_V_POD_ETA", searchParam.getPodEta());		
			
			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<ArrivalNoticeReminderMaintenanceMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

		}

	}
	/**
	 * {@inheritDoc}
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */
	@Override
	public List<ArrivalNoticeReminderMaintenanceMod> findByGivenvalue(ArrivalNoticeReminderMaintenanceMod searchParam)throws DataAccessException{
		this.seq =1;
		return findByGivenKeyForArrivalNoticeReminderMaintenance (searchParam);
	}

}
