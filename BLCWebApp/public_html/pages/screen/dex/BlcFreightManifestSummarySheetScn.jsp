<!--
-----------------------------------------------------------------------------------------------------------
BlcFreightManifestSummarySheetScn.jsp
-------------------------------------------------------------------------------------------------------------
Copyright RCL Public Co., Ltd. 2018
-------------------------------------------------------------------------------------------------------------
Author Author Cognis Solution 1/04/2020
- Change Log ------------------------------------------------------------------------------------------------
## DD/MM/YY -User-     -TaskRef-      -Short Description
1   1/04/20       Akash Gupta           Initial Version
-----------------------------------------------------------------------------------------------------------
-->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="true" autoFlush="true"
	errorPage="/pages/error/RcmErrorPage.jsp"%>
<%@ taglib prefix="rcl" uri="/WEB-INF/custom.tld"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<c:set var="userData" value="${sessionScope.userData}" />
<!DOCTYPE html>
<html>
<meta charset="UTF-8">               
<%@include file="../../include/RcmInclude.jsp"%>

<jsp:include page="../../include/commonInclude.jsp"></jsp:include>
<head>
<title>Freight Manifest Summary Sheet</title>

</head>
<body id ="dex202">
	<jsp:include page='../../include/header.jsp'>
		<jsp:param name="pageHeader" value="Freight Manifest Summary Sheet" />
	</jsp:include>
	<form id="freightSummarySheet">
		<rcl:area id="s0-header" title="Search" areaMode="search" 	collapsible="true" >
			<!--start container -->
			<div class="row" >
			
				   <jsp:include page="../../include/commonLookUp.jsp">
				   <jsp:param name="req" value="req" />
				   </jsp:include>

				<rcl:select id="s0-direction" label="Direction"
					classes="div(col-2) ctr(dtlField)" selectTable="Direction" emptyDisplay="All"/>


				<rcl:text id="s0-pol" label="POL" classes="div(col-2)"
					check="upc len(5)"
					lookup="tbl(VRL_PORT) rco(CODE NAME) rid(s0-pol) sco(CODE) sva(s0-pol) sop(LIKE)"
					iconClick="rutLookupByKey('VRL_PORT','CODE NAME','s0-pol','CODE','s0-pol','LIKE','s0-pol');">
				</rcl:text>
			</div>
			<!-- end row1 -->
			<div class="row">
				<!--start row 2 -->
			</div>
			<!-- end row2 -->
		</rcl:area>
	</form>
	<!-- end search area -->
</body>
<script>
	$(document).ready(
			function() {
				/* rptTableInit('t0-area'); */
				document.getElementById('s0-reset').addEventListener('click',
						function() {
							rptClearDisplay('t0-area');
							rptAddData('t0-area', []);
						});
				rut.packForRclServlet = false; //ensure that dialogFlow is not packed for servlet but for local use, this is required only, when you have no server
				getURLForReport();
				});

	 function getURLForReport(){ 
	   	  var dataPost = {};
	   	  debugger;
	   	  sendPostRequest("rclws/blcArrivalNotice/getReportUrl", dataPost, function(data) {
	   		 URLConstant["REPORT_URL"] = 'http://' +data[0]+'/reports/rwservlet?';   
	   		console.log("1   "+ 'URLConstant["REPORT_URL"]   '+ URLConstant["REPORT_URL"] );
			    })
	         }
		 

	 

	function find() {
		var msg = [];
		var dataPost = getDataAreaToObject("s0-header");
		if ((dataPost.vessel == "") || (dataPost.voyage == "") ) {
			msg.push("*Vessel and Voyage is mandatory");
		}

		if (msg.length != 0) {
			rutOpenMessageBox("Warning", msg.toString().replace(/,/g, ''),	null, null, '');
		} else {

			var dataPost = getDataAreaToObject("s0-header");
			console.log(dataPost, "data")
			sendPostRequest(
					"rclws/blcFreightManifestSummarySheet/search",	dataPost,
					function(data) {
						console.log(data, "array");	
						debugger;	
						if (data[0].status) {	
								
								var dataPost = getDataAreaToObject("s0-header");
								var setDataInPopUp = URLConstant.REPORT_URL
										+ "repenvp&report=dexp_frt_man_summ.rep"
										+"&P_SERVICE="+ dataPost.service 
										+ "&P_VESSEL="+ dataPost.vessel 
										+ "&P_VOYAGE="+ dataPost.voyage
										+ "&P_DIRECTION="+ dataPost.direction
										+ "&p_pol="+dataPost.pol
										+"&P_user_code=" + "${userData.userId}"
								+"&p_header=Y&P_report_description=Freight%20Manifest%20Summary%20Sheet";
										console.log("2   "+'setDataInPopUp '+setDataInPopUp);	
							window.open(setDataInPopUp, 'PrintWindow','width=900,height=570,resizable=yes,scrollbars=yes,toolbar=no');
						} else {
							rutOpenMessageBox("Warning",data[0].message,	null, null, '');
						}

					})

		}
	}
</script>
</html>