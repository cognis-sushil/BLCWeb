/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.dao.blc;

/* --------------------------- Change Log ------------------------------------------
 	##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
	1    29/03/20       Chandu           Initial Version
   ---------------------------------------------------------------------------------
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
import com.rclgroup.dolphin.web.model.blc.IncomingBlInqueryMod;

import oracle.jdbc.OracleTypes;

/**
 * This class contain implementation of {@code BlIncomingBlInqueryDao}
 * @author Cognis Solution
 *
 */
public final class IncomingBlInqueryJdbcDao extends RrcStandardDao implements IncomingBlInqueryDao {
	private static final Logger logger = Logger.getLogger(IncomingBlInqueryJdbcDao.class);
    private BlcIncomingBlInqueryProcedure blcIncomingBlInqueryProcedure;
    int seq;
    protected void initDao() throws Exception {
        super.initDao();
        blcIncomingBlInqueryProcedure = new BlcIncomingBlInqueryProcedure(getJdbcTemplate(),new BlcIncomingBlInqueryMapper());
    }

	/**
	 * Inner class for Mapping the database data to java object.
	 * @author Cognis Solution
	 *
	 */
	class BlcIncomingBlInqueryMapper implements RowMapper {

		/**
		 * Map each row of data in the ResultSet.
		 * @param rs     {@code ResultSet }
		 * @param rowNum  the number of the current row
		 * @return the result object for the current row
		 * @throws SQLException
		 */
		public IncomingBlInqueryMod mapRow(ResultSet rs, int rowNum) throws SQLException {

			IncomingBlInqueryMod model = new IncomingBlInqueryMod();
			model.setSeq(rs.getString("ROWNUM"));
			model.setService(rs.getString("DISCHARGE_SERVICE"));
			model.setVessel(rs.getString("DISCHARGE_VESSEL"));
			model.setVoyage(rs.getString("DISCHARGE_VOYAGE"));
			model.setDirection(rs.getString("DISCHARGE_DIRECTION"));
			model.setPot(rs.getString("DN_POT1"));
			model.setPodEtd(rs.getString("POD_ETD"));
			model.setPolEtd(rs.getString("POL_ETD"));
			model.setPod(rs.getString("DN_CUSTOMER_POD"));
			model.setPol(rs.getString("DN_CUSTOMER_POL"));
			model.setPodEta(rs.getString("POD_ETA"));
			model.setBls(rs.getString("CALC_AYSTAT"));
			return model;
		}
	}

	/**
	 * 
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */
	@Override
	public List<IncomingBlInqueryMod> findByGivenKeyForIncomingBlInquery(IncomingBlInqueryMod searchParam)throws DataAccessException {
		System.out.println("   Inside findByGivenKeyForIncomingBlInquery   ");
		seq = 1;
		return blcIncomingBlInqueryProcedure.getBlcIncomingBlInquerySearchData(searchParam);
	}

	/**
	 * Inner class for declared In and Out parameter and there data type.
	 * @author Cognis Solution
	 *
	 */
	protected class BlcIncomingBlInqueryProcedure extends StoredProcedure {
		protected BlcIncomingBlInqueryProcedure(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_INCOMING_BL_INQUERY_SEARCH);

			declareParameter(new SqlParameter("P_I_V_SERVICE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VESSEL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VOYAGE", OracleTypes.VARCHAR));
		    declareParameter(new SqlParameter("P_I_V_DIRECTION", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_POL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_POT", OracleTypes.VARCHAR));
		    declareParameter(new SqlParameter("P_I_V_START_DATE", OracleTypes.VARCHAR));
		    declareParameter(new SqlParameter("P_I_V_END_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_USER_ID", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_FSC_CDOE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_AGENT", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		/**
		 * 
		 * Used to call StoredProcedure.
		 * @author Cognis Solution
		 *
		 */
		protected List<IncomingBlInqueryMod> getBlcIncomingBlInquerySearchData(
				IncomingBlInqueryMod searchParam) {

			Map inPara = new HashMap();

			inPara.put("P_I_V_SERVICE", searchParam.getService());
			inPara.put("P_I_V_VESSEL", searchParam.getVessel());
			inPara.put("P_I_V_VOYAGE", searchParam.getVoyage());
			inPara.put("P_I_V_DIRECTION", searchParam.getDirection());
			inPara.put("P_I_V_POL", searchParam.getPol());
			inPara.put("P_I_V_POT", searchParam.getPod());
			inPara.put("P_I_V_START_DATE", searchParam.getEtd());
			inPara.put("P_I_V_END_DATE", searchParam.getEta());
			inPara.put("P_I_V_USER_ID", searchParam.getUserID());
			inPara.put("P_I_V_FSC_CDOE", searchParam.getBrowserData().getFscCode());
			inPara.put("P_I_V_AGENT", searchParam.getBrowserData().getAgent());		
			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<IncomingBlInqueryMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

		}

	}
}
