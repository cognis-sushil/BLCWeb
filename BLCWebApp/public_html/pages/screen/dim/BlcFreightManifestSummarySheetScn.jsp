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
<body id="dim205">
	
	<jsp:include page='../../include/header.jsp'>
		<jsp:param name="pageHeader" value="Freight Manifest Summary Sheet" />
	</jsp:include>
	
	<form id="dimFreightSummarySheetForm">
	<!-- Start of Search Area -->
		<rcl:area id="s0-header" title="Search" areaMode="search"  collapsible="true" >
			<div class="container-fluid">
			<!--start container -->
			<div class="row">
			
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
				<rcl:date id="s0-etaDate" label="ETA Date">
				</rcl:date>
			</div>
			</div>
			<!-- end container -->
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
   	  sendPostRequest("rclws/blcArrivalNotice/getReportUrl", dataPost, function(data) {
   		 URLConstant["REPORT_URL"] = 'http://' +data[0]+'/reports/rwservlet?';   
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

		
			
			var pattern =/^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;
			 
	  		 if(dataPost.etaDate!= '' && !pattern.test(dataPost.etaDate)){
				rutOpenMessageBox("Warning", "Please Enter valid ETA Date",
	            null, null);
				return;
			 }
			
			
			console.log(dataPost, "data")
			sendPostRequest(
					"rclws/blcFreightManifestSummarySheet/search",
					dataPost,
					function(data) {
						console.log(data.length, "array");
						debugger;
						if (data[0].status) {							
								var dataPost = getDataAreaToObject("s0-header");
								var setDataInPopUp = URLConstant.REPORT_URL
										+ "repenvp&report=dimp_frt_man_summ.rep"
										+"&P_SERVICE="+ dataPost.service 
										+ "&P_VESSEL="+ dataPost.vessel 
										+ "&P_VOYAGE="+ dataPost.voyage
										+ "&P_DIRECTION="+ dataPost.direction
										+ "&p_pol="+dataPost.pol
										+"&p_eta="+dataPost.etaDate
										+"&P_user_code=" + "${userData.userId}"
								+"&p_header=Y&P_report_description=Freight%20Manifest%20Summary%20Sheet";
							

							
							window.open(setDataInPopUp, 'PrintWindow','width=900,height=570,resizable=yes,scrollbars=yes,toolbar=no');
						} else {
							rutOpenMessageBox("Warning",data[0].message,	null, null, '');
						}

					})

		}
	}
</script>
</html>