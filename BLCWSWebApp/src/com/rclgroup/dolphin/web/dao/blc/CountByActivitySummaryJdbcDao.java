/*Copyright (c) 2020 RCL| All Rights Reserved  */
package com.rclgroup.dolphin.web.dao.blc;

/* ------------------------- Change Log ----------------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    24/03/20       Chandu               Initial Version
--------------------------------------------------------------------------------
*/
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.LinkedHashMap;
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
import com.rclgroup.dolphin.web.model.blc.CountByActivitySummaryMod;

import oracle.jdbc.OracleTypes;

/**
 * This class contain implementation of {@code BlCountByActivitySummaryDao}
 * 
 * @author Cognis Solution
 *
 */
public final class CountByActivitySummaryJdbcDao extends RrcStandardDao implements CountByActivitySummaryDao {
	private static final Logger logger = Logger.getLogger(CountByActivitySummaryJdbcDao.class);
	private Map<String, CountByActivitySummaryMod> uniqueBls = new LinkedHashMap<String, CountByActivitySummaryMod>();
	private int seq;
	private BlCountByActivitySummaryProcedure blCountByActivitySummaryProcedure;
	private BlCountByActivitySummaryDetaileProcedure blCountByActivitySummaryDetaileProcedure;

	protected void initDao() throws Exception {
		super.initDao();
		blCountByActivitySummaryProcedure = new BlCountByActivitySummaryProcedure(getJdbcTemplate(),
				new BlCountByActivitySummaryMapper());
		blCountByActivitySummaryDetaileProcedure = new BlCountByActivitySummaryDetaileProcedure(getJdbcTemplate(),
				new BlCountByActivitySummaryDetaileMapper());
	}

	/**
	 * Inner class for Mapping the database data to java object.
	 * 
	 * @author Cognis Solution
	 *
	 */
	class BlCountByActivitySummaryMapper implements RowMapper {

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
		@Override
		public CountByActivitySummaryMod mapRow(ResultSet rs, int rowNum) throws SQLException {
			CountByActivitySummaryMod model = null;

			if (rs.getString("BL_TYPE1") != null && rs.getString("CNT_BL1") != null) {
				model = createDataObject(uniqueBls, rs.getString("BL_TYPE1"));
				model.setNoOfBL(rs.getString("CNT_BL1"));
			} 
			if (rs.getString("BL_TYPE2") != null && rs.getString("CNT_BL2") != null) {
				model = createDataObject(uniqueBls, rs.getString("BL_TYPE2"));
				model.setNoOfConformBl(rs.getString("CNT_BL2"));
			} 
			if (rs.getString("BL_TYPE3") != null && rs.getString("CNT_BL3") != null) {
				model = createDataObject(uniqueBls, rs.getString("BL_TYPE3"));
				model.setNoOfPrintedBl(rs.getString("CNT_BL3"));
			}  
			if (rs.getString("BL_TYPE4") != null && rs.getString("CNT_BL4") != null) {
				model = createDataObject(uniqueBls, rs.getString("BL_TYPE4"));
				model.setNoOfGenratedInvoices(rs.getString("CNT_BL4"));
			}  
			if (rs.getString("BL_TYPE5") != null && rs.getString("CNT_BL5") != null) {
				model = createDataObject(uniqueBls, rs.getString("BL_TYPE5"));
				model.setNoOfPrintedInvoice(rs.getString("CNT_BL5"));
			}

			if (rs.getString("BL_TYPE6") != null && rs.getString("CNT_BL6") != null) {
				model = createDataObject(uniqueBls, rs.getString("BL_TYPE6"));
				model.setNoOfManifestedBl(rs.getString("CNT_BL6"));
			}  
			if (rs.getString("BL_TYPE7") != null && rs.getString("CNT_BL7") != null) {
				model = createDataObject(uniqueBls, rs.getString("BL_TYPE7"));
				model.setNoOfUnreleaseBl(rs.getString("CNT_BL7"));
			} 

			if (rs.getString("BL_TYPE8") != null && rs.getString("CNT_BL8") != null) {
				model = createDataObject(uniqueBls, rs.getString("BL_TYPE8"));
				model.setNoOfSpecialRelease(rs.getString("CNT_BL8"));
			} 

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
	public List<CountByActivitySummaryMod> findByGivenKeyForBlCountActivity(CountByActivitySummaryMod searchParam)
			throws DataAccessException {
		System.out.println("   Inside findByGivenKeyForBlCountActivityInfo   ");
		return blCountByActivitySummaryProcedure.getBlCountByActivitySummarySearchData(searchParam);
	}

	/**
	 * Inner class for declared In and Out parameter for StoredProcedure.
	 * 
	 * @author Cognis Solution
	 *
	 */
	protected class BlCountByActivitySummaryProcedure extends StoredProcedure {

		protected BlCountByActivitySummaryProcedure(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH);

			declareParameter(new SqlParameter("P_I_V_SERVICE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VESSEL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VOYAGE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_DIRECTION", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_POL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_START_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_END_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_USER_ID", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_LINE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_TRADE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_AGENT", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_FSC_CODE", OracleTypes.VARCHAR));

			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		/**
		 * 
		 * Used to call StoredProcedure.
		 * 
		 * @author Cognis Solution
		 *
		 */
		protected List<CountByActivitySummaryMod> getBlCountByActivitySummarySearchData(
				CountByActivitySummaryMod searchParam) {

			Map inPara = new HashMap();

			inPara.put("P_I_V_SERVICE", searchParam.getService());
			inPara.put("P_I_V_VESSEL", searchParam.getVessel());
			inPara.put("P_I_V_VOYAGE", searchParam.getVoyage());
			inPara.put("P_I_V_DIRECTION", searchParam.getDirection());
			inPara.put("P_I_V_POL", searchParam.getPol());
			inPara.put("P_I_V_START_DATE", searchParam.getEtdFrom());
			inPara.put("P_I_V_END_DATE", searchParam.getEtdTo());
			inPara.put("P_I_V_USER_ID", searchParam.getUserID());
			inPara.put("P_I_V_LINE", searchParam.getLine());
			inPara.put("P_I_V_TRADE", searchParam.getTrade());
			inPara.put("P_I_V_AGENT", searchParam.getAgent());
			inPara.put("P_I_V_FSC_CODE", searchParam.getBrowserData().getFscCode());
			uniqueBls.clear();
			seq = 1;
			Map outMap = execute(inPara);
			System.out.println("   StoredProcedure executed Successfully...!   ");
			outMap.get("P_O_V_BLC_MAPPING_LIST");

		//	return new ArrayList<CountByActivitySummaryMod>(uniqueBls.values());
			List<CountByActivitySummaryMod> list = new ArrayList<CountByActivitySummaryMod>(uniqueBls.values());
			
			Collections.sort(list, new Comparator<CountByActivitySummaryMod>() {
				public int compare(CountByActivitySummaryMod mod1, CountByActivitySummaryMod mod2) {
					if (mod1 != null && mod2 != null) {
						if (mod1.getBlType() != null && mod2.getBlType() != null) {
							return mod1.getBlType().compareTo(mod2.getBlType()) * -1;

						} else {
							return 0;
						}
					} else {
						return 0;
					}
				}
			});
			int index=0;
			for (CountByActivitySummaryMod newMod : list) {
				index++;
				newMod.setSeq(String.valueOf(index));
			}
			return list;

		}
	}

	private CountByActivitySummaryMod createDataObject(Map<String, CountByActivitySummaryMod> ht, String value) {

		CountByActivitySummaryMod countByActivitymod;

		value = value.toUpperCase();
		if (ht.containsKey(value)) {
			countByActivitymod = (CountByActivitySummaryMod) ht.get(value);
		} else {
			countByActivitymod = new CountByActivitySummaryMod();
			countByActivitymod.setSeq(String.valueOf(seq++));
			countByActivitymod.setBlType(value);
			ht.put(value, countByActivitymod);
		}
		return countByActivitymod;

	}

	/**
	 * {@inheritDoc}
	 * 
	 * @param {@inheritDoc}
	 * @return {@inheritDoc}
	 */
	@Override
	public List<CountByActivitySummaryMod> findByGivenKeyForBlCountActivityInfo(CountByActivitySummaryMod seacrhParam)
			throws DataAccessException {
		System.out.println("   Inside findByGivenKeyForBlCountActivityInfo   ");
		return blCountByActivitySummaryDetaileProcedure.getBlCountByActivitySummaryDetaileSearchData(seacrhParam);
	}

	/**
	 * Inner class for declared In and Out parameter for StoredProcedure.
	 * 
	 * @author Cognis Solution
	 *
	 */
	protected class BlCountByActivitySummaryDetaileProcedure extends StoredProcedure {
		protected BlCountByActivitySummaryDetaileProcedure(JdbcTemplate jdbcTemplate, RowMapper rowMapper) {
			super(jdbcTemplate, PCR_DEX_BLC_COUNT_ACTIVITY_SUMMARY_SEARCH_DETAILE);
			declareParameter(new SqlParameter("P_I_V_ACTION", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_BLTYPE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_SERVICE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VESSEL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_VOYAGE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_DIRECTION", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_POL", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_START_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_END_DATE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_USER_ID", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_LINE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_TRADE", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_AGENT", OracleTypes.VARCHAR));
			declareParameter(new SqlParameter("P_I_V_FSC_CODE", OracleTypes.VARCHAR));
			declareParameter(new SqlOutParameter("P_O_V_BLC_MAPPING_LIST", OracleTypes.CURSOR, rowMapper));
		}

		/**
		 * 
		 * Used to call StoredProcedure.
		 * 
		 * @author Cognis Solution
		 *
		 */

		protected List<CountByActivitySummaryMod> getBlCountByActivitySummaryDetaileSearchData(
				CountByActivitySummaryMod searchParam) {

			Map inPara = new HashMap();
			inPara.put("P_I_V_ACTION", searchParam.getId());
			inPara.put("P_I_V_BLTYPE", searchParam.getbLType());
			inPara.put("P_I_V_SERVICE", searchParam.getService());
			inPara.put("P_I_V_VESSEL", searchParam.getVessel());
			inPara.put("P_I_V_VOYAGE", searchParam.getVoyage());
			inPara.put("P_I_V_DIRECTION", searchParam.getDirection());
			inPara.put("P_I_V_POL", searchParam.getPol());
			inPara.put("P_I_V_START_DATE", searchParam.getEtdFrom());
			inPara.put("P_I_V_END_DATE", searchParam.getEtdTo());
			inPara.put("P_I_V_USER_ID", searchParam.getUserID());
			inPara.put("P_I_V_LINE", searchParam.getLine());
			inPara.put("P_I_V_TRADE", searchParam.getTrade());
			inPara.put("P_I_V_AGENT", searchParam.getAgent());
			inPara.put("P_I_V_FSC_CODE", searchParam.getBrowserData().getFscCode());
			uniqueBls.clear();
			seq = 1;
			Map outMap = execute(inPara);

			System.out.println("   StoredProcedure executed Successfully...!   ");
			outMap.get("P_O_V_BLC_MAPPING_LIST");

			List<CountByActivitySummaryMod> sortedList = new ArrayList<>();
			List<CountByActivitySummaryMod> list = new ArrayList<CountByActivitySummaryMod>(uniqueBls.values());
	
			/*Collections.sort(list, new Comparator<CountByActivitySummaryMod>() {
				public int compare(CountByActivitySummaryMod mod1, CountByActivitySummaryMod mod2) {
					if (mod1 != null && mod2 != null) {
						if (mod1.getBlType() != null && mod2.getBlType() != null) {
							return mod1.getBlType().compareTo(mod2.getBlType()) * -1;

						} else {
							return 0;
						}
					} else {
						return 0;
					}
				}
			});*/
			int index=0;
			for (CountByActivitySummaryMod newMod : list) {
				index++;
				newMod.setSeq(String.valueOf(index));
			}
			return list;
			// return new ArrayList<CountByActivitySummaryMod>(uniqueBls.values());

		}
	}

	/**
	 * Inner class for Mapping the database data to java object.
	 * 
	 * @author Cognis Solution
	 *
	 */
	class BlCountByActivitySummaryDetaileMapper implements RowMapper {

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
		@Override
		public CountByActivitySummaryMod mapRow(ResultSet rs, int rowNum) throws SQLException {

			if (uniqueBls.containsKey(rs.getString("PK_BL_NO"))) {
				return uniqueBls.get(rs.getString("PK_BL_NO"));

			}
			CountByActivitySummaryMod model = new CountByActivitySummaryMod();
			uniqueBls.put(rs.getString("PK_BL_NO"), model);

			model.setSeq(String.valueOf(seq++));
			model.setBlNum(rs.getString("PK_BL_NO"));
			model.setBlType(rs.getString("BL_TYPE"));
			model.setConfirmBl(rs.getString("DEX_STATUS"));
			model.setBlPrintStatus(rs.getString("BL_PRINT_STATUS"));
			model.setGeneratedInvoices(rs.getString("GENERATED_INVOICES"));
			model.setPrintedInvoices(rs.getString("PRINTED_INVOICES"));
			model.setUnreleaseBl(rs.getString("BL_RELEASED_FLAG"));
			model.setSpecialRelease(rs.getString("SPECIAL_RELEASE_REQUESTED"));
			model.setManifestedBl(rs.getString("MANIFESTED_BL"));
			model.setConfirmBl(rs.getString("CONFIRM_BL"));
			return model;

		}
	}
}
