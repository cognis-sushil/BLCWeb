/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.dao.blc;

/* ----------------------------Change Log -----------------------------------------  
 	##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
	1    20/04/20      Akash Gupta            Initial Version
   --------------------------------------------------------------------------------
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
import com.rclgroup.dolphin.web.model.blc.InvoyageBrowserMod;

import oracle.jdbc.OracleTypes;

/**
 * This class contain implementation of {@code BlcInvoyageBrowserDao}
 * 
 * @author Cognis Solution
 */
public final class InvoyageBrowserJdbcDao extends RrcStandardDao implements InvoyageBrowserDao {
	private static final Logger logger = Logger.getLogger(InvoyageBrowserDao.class);
	private BlcInvoyageBrowserProcedure blcInvoyageBrowserProcedure;
	

	protected void initDao() throws Exception {
		super.initDao();
		blcInvoyageBrowserProcedure = new BlcInvoyageBrowserProcedure(getJdbcTemplate(), new InvoyageBrowserMapper());
	}

	/**
	 * Inner class for Mapping the database data to java object.
	 * 
	 * @author Cognis Solution
	 *
	 */
	class InvoyageBrowserMapper implements RowMapper {

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
		public InvoyageBrowserMod mapRow(ResultSet rs, int rowNum) throws SQLException {

			InvoyageBrowserMod browserModel = new InvoyageBrowserMod();
			browserModel.setSeq(rs.getString("ROWNUM"));
			browserModel.setPort(rs.getString("FK_PORT_CALL"));
			browserModel.setTerminal(rs.getString("FK_TERMINAL"));
			browserModel.setInvoyageBrowser(rs.getString("IN_VOYAGE"));
			browserModel.setExptInvoyage(rs.getString("IN_VOYAGE_NO"));
			browserModel.setPortSeq(rs.getString("FK_PORT_CALL_SEQ"));
			browserModel.setService(rs.getString("FK_SERVICE"));
			browserModel.setVessel(rs.getString("FK_VESSEL"));
			browserModel.setVoyage(rs.getString("FK_VOYAGE"));
			browserModel.setDirection(rs.getString("DIRECTION"));
			browserModel.setEta(rs.getString("ETA_DATE"));

			return browserModel;
		}
	}

	/**
	 * {@inheritDoc}
	 * 
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */

	@Override
	public List<InvoyageBrowserMod> findDataForInvoyageBrowser(InvoyageBrowserMod searchParam)
			throws DataAccessException {
		System.out.println("start of BlcInvoyageBrowser ");
		System.out.println("searchParam ===> " + searchParam);
		List<InvoyageBrowserMod> resultList = blcInvoyageBrowserProcedure.getBlcInvoyageBrowserData(searchParam);
		System.out.println("result List size ===> " + resultList.size());
		return resultList;
	}

	/**
	 * Inner class for declared In and Out parameter and there data type.
	 * 
	 * @author Cognis Solution
	 *
	 */
	protected class BlcInvoyageBrowserProcedure extends StoredProcedure {
		protected BlcInvoyageBrowserProcedure(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DIM_BLC_INVOYAGE_BROWSER_SEARCH);

			declareParameter(new SqlParameter("P_I_V_LOOKUP_PORT", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_LOOKUP_INVOYAGE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_USER_ID", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_ETA_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		/**
		 * 
		 * Used to call StoredProcedure.
		 * 
		 * @author Cognis Solution
		 *
		 */
		protected List<InvoyageBrowserMod> getBlcInvoyageBrowserData(InvoyageBrowserMod searchParam) {

			Map inPara = new HashMap();

			inPara.put("P_I_V_LOOKUP_PORT", searchParam.getPort());
			inPara.put("P_I_V_LOOKUP_INVOYAGE", searchParam.getInvoyageBrowser());
			inPara.put("P_I_V_USER_ID", searchParam.getBrowserData().getUserId());
			inPara.put("P_I_V_ETA_DATE", searchParam.getEtaForSgsin());

			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			return (List<InvoyageBrowserMod>) outMap.get("P_O_V_BLC_MAPPING_LIST");

		}

	}

}