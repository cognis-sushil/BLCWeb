<!--
-----------------------------------------------------------------------------------------------------------
BlcArrivalNoticeScn.jsp
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
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<%@include file="../../include/RcmInclude.jsp"%>
<jsp:include page="../../include/commonInclude.jsp"></jsp:include>
<c:set var="userData" value="${sessionScope.userData}" />
<head>

<title>Arrival Notice</title>

</head>
<body id="dim204">
	<style type="text/css">
.col-0x35 {
	flex: 0 0 2.8%;
	max-width: 2.8%;
}

.listsearch-Browser {
	margin-bottom: 0px;
	font-weight: 500;
	word-wrap: break-word;
}
</style>
	<jsp:include page='../../include/header.jsp'>
		<jsp:param name="pageHeader" value="Arrival Notice" />
	</jsp:include>
	<form id="arrivalNotice">
		<rcl:area id="s0-header" title="Search" areaMode="search"
			collapsible="true">
			<div class="row">
				<!--start row 1    -->

				<rcl:select check="req" id="s0-searchBy" label="Search By"
					classes="div(col-2)" options="required"
					optionsList="Default Invoyage#" valueList="Default Invoyage#"
					defaultValue="Default">
				</rcl:select>


				<rcl:text id="s0-blNo" label="B/L#" classes="div(col-sm-2)"
					check="len(17) upc" icon="fa-search" iconClick="lookupBl()" />

				<input type="hidden" id="s0-service" class="searchField" /> <input
					type="hidden" id="s0-direction" class="searchField" />

				<rcl:text id="s0-vessel" label="Vessel" classes="div(col-sm-2)"
					check="req len(10) upc" icon="fa-search" iconClick="lookupVessel()" />


				<rcl:text id="s0-voyage" label="Voyage" classes="div(col-sm-2)"
					check="req len(10) upc" icon="fa-search" iconClick="lookupVoyage()" />


				<rcl:date id="s0-etaDate" label="ETA Date" classes="div(col-2)"></rcl:date>

				<rcl:text id="s0-pod" label="POD" classes="div(col-2)"
					check="upc len(5)"
					lookup="tbl(VRL_PORT) rco(CODE NAME) rid(s0-pod) sco(CODE) sva(s0-pod) sop(LIKE)"
					iconClick="rutLookupByKey('VRL_PORT','CODE NAME','s0-pod','CODE','s0-pod','LIKE','s0-pod');">

				</rcl:text>

			</div>
			<!-- end row  -->
			<div class="row">
				<!--start row 2 -->
				<div class=" col-sm-2">
					<rcl:text id="s0-port" label="Port" classes="div(col-1.5)"
						check="dis len(3)"></rcl:text>
					<label class="rcl-standard-font " for="s0-port"></label>
					<div class="rcl-standard-font"></div>
				</div>

				<rcl:text id="s0-inVoyage" label="In Voyage#" classes="div(col-2)"
					check="upc" icon="fa-search" iconClick="lookupInVoyage()" />

				<rcl:date id="s0-etaForSgsin" label="" classes="div(col-2)"></rcl:date>

				<div class="col-sm-2 mt-3">
					<button id="s0-inVoyageBrowser" type="button"
						class="rcl-standard-button" onclick="onVoyageBrowser()">
						InVoyage&nbsp;Browser</button>
				</div>



				<rcl:select id="s0-socCoc" label="SOC/COC/Both" classes="div(col-2)"
					selectTable="SocCoc" emptyDisplay="Both">
				</rcl:select>



			</div>
			<!-- end row  -->
			<!-- end of area footer -->
			<!-- end row -->

		</rcl:area>
	</form>
	<rcl:area id="h1-header" title="Print Setup" areaMode="detail"
		collapsible="true">
		<div class="row">
			<!--start row 1 -->

			<rcl:text id="h0-language" classes="div(col-2)"
				label="Language Code " check="upc len(10)"
				lookup="tbl(VR_BLC_LANGUAGE) rco(PK_CODE DESCRIPTION) rid(h0-language h0-languageCode) sco(PK_CODE) sva(h0-language) tit(Language Lookup)"
				iconClick="rutLookupByKey('VR_BLC_LANGUAGE','PK_CODE DESCRIPTION','h0-language h0-languageCode','PK_CODE','h0-language','','h0-language');">

			</rcl:text>
			<rcl:text id="h0-languageCode" classes="div(col-2)"
				label="Language Name" check="upc len(10)">
			</rcl:text>
			<div class="  col-1x5" style="margin-top: 12px;">
				<label id="t0-service " class="rcl-standard-font " for="t0-service">
					Include charges </label> <input id="h0-select" type="checkbox"
					name="includeCharges" style="position: absolute;"
					class="rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField"
					checked>
			</div>
			<div class="  col-1x5" style="margin-top: 12px;">
				<label id="t0-vessel " class="rcl-standard-font " for="t0-vessel">
					Print Terminal </label> <input id="h0-select" type="checkbox"
					name="printTerminal" style="position: absolute;"
					class="rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField">
			</div>
			<div class="  col-1x55" style="margin-top: 12px;">
				<label id="t0-voyage" class="rcl-standard-font " for="t0-voyage">
					Print Import Pickup Area </label> <input id="h0-select" type="checkbox"
					name="printImportPickupArea" style="position: absolute;"
					class="rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField">
			</div>


		</div>
	</rcl:area>
	<div class="tblHeader">
		<rcl:area id="t0-area" title="B/L List"
			classes="div(container-fluid pl-1 pr-1)" areaMode="table"
			collapsible="true">
			<div class="row border">
				<div id="t-seq" class="col-0x5 pb-0 pl-1 pr-1"
					style="font-weight: bold; text-align: right;">No</div>
				<div id="t-bl" class="col-1x25 ml-2" style="font-weight: bold;">B/L#</div>
				<div id="t-blId" class="col-0x5 mr-1" style="font-weight: bold;">B/L
					ID</div>
				<div id="t-blType" class="col-0x5 " style="font-weight: bold;">B/L
					Type</div>
				<div id="t-creationOffice" class="col-0x75 mr-1 ml-1"
					style="font-weight: bold;">B/L Creation Office</div>
				<div id="t-sc" class=" col-0x25 mr-2 ml-2"
					style="font-weight: bold;">COS/ SOC</div>
				<div id="t-outStatus" class=" col-0x5 mr-1"
					style="font-weight: bold;">Out Status</div>
				<div id="t-inSTatus" class="col-0x5 mr-2 ml-1"
					style="font-weight: bold;">In Status</div>
				<div id="t-vessel" class="col-0x5 ml-2 mr-1"
					style="font-weight: bold;">Vessel</div>
				<div id="t-voyage" class="col-0x5 ml-2" style="font-weight: bold;">Voyage</div>
				<div id="t-eta" class="col-0x75 ml-1" style="font-weight: bold;">ETA</div>
				<div id="t-por" class=" col-0x5 pr-0" style="font-weight: bold;">POR</div>
				<div id="t-pol" class=" col-0x5 pr-0" style="font-weight: bold;">POL</div>
				<div id="t-pot" class=" col-0x5 mr-1" style="font-weight: bold;">POT</div>
				<div id="t-pod" class=" col-0x5 pr-0 ml-1"
					style="font-weight: bold;">POD</div>
				<div id="t-del" class=" col-0x5 pr-0 mr-1"
					style="font-weight: bold;">DEL</div>
				<div id="t-shiptype" class="  col-0x25 mr-4"
					style="font-weight: bold;">Ship Type</div>
				<div id="t-printed" class="  col-0x5 mr-1"
					style="font-weight: bold;">Printed</div>
				<div id="t-datePrinted" class=" col-0x75 ml-1"
					style="font-weight: bold;">Date Printed</div>
				<div class="col-0x25  ml-2" style="font-weight: bold;">
					Select <input id="t0-select" class="tblField" type="checkbox"
						value="" onclick="selectAll(this)">
				</div>
			</div>
			<div class='tblArea tblAreaPadding' style="overflow-y: auto;">
				<div id="t0-row" class="tblRow  row pt-1">
					<div class="container-fluid">
						<div class="row gridRow selectData">
							<!-- start table row -->
							<div class="col-0x5 text-right">
								<p id="t0-seq" class="listsearch"></p>
							</div>
							<div class="col-1x25 ml-2">
								<p id="t0-blNo" class="listsearch"></p>
							</div>
							<div class="  col-0x5 mr-1">
								<p id="t0-blid" class="listsearch"></p>
							</div>
							<div class="  col-0x5">
								<p id="t0-bltype" class="listsearch"></p>
							</div>
							<div class="   col-0x75 mr-1 ml-1">
								<p id="t0-creationoffice" class="listsearch"></p>
							</div>
							<div class=" col-0x25 mr-2 ml-2">
								<p id="t0-sc" class="listsearch"></p>
							</div>
							<div class="   col-0x5 mr-1">
								<p id="t0-outstatus" class="listsearch"></p>
							</div>
							<div class="col-0x5 mr-2 ml-1">
								<p id="t0-instatus" class="listsearch"></p>
							</div>
							<div class=" col-0x5 ml-2 mr-1">
								<p id="t0-vessel" class="listsearch"></p>
							</div>
							<div class="  col-0x5 ml-2">
								<p id="t0-voyage" class="listsearch"></p>
							</div>
							<div class="col-0x75 ml-1">
								<p id="t0-eta" class="listsearch"></p>
							</div>
							<div class="    col-0x5 ml-0">
								<p id="t0-por" class="listsearch"></p>
							</div>
							<div class="   col-0x5 ml-0">
								<p id="t0-pol" class="listsearch"></p>
							</div>
							<div class="  col-0x5 ml-1">
								<p id="t0-pot" class="listsearch"></p>
							</div>
							<div class="  col-0x5 ml-1">
								<p id="t0-pod" class="listsearch"></p>
							</div>
							<div class="   col-0x5 mr-1">
								<p id="t0-del" class="listsearch"></p>
							</div>
							<div class="  col-0x25 mr-4">
								<p id="t0-shiptype" class="listsearch"></p>
							</div>
							<div class="col-0x5 ml-1 text-center">
								<p id="t0-printed" class="listsearch"></p>
							</div>
							<div class="col-0x75 ml-1">
								<p id="t0-dateprinted" class="listsearch"></p>
							</div>

							<div class="col-0x25 ml-2 checkBoxRow">								
								
							</div>
						</div>
						<!-- end table row -->
					</div>
				</div>
			</div>
			<div class=" " style="display: none" id="s0-printArrivalNotices">
				<button id="s0-printArrivalNotice" type="button"
					class="rcl-standard-button " onclick="printArrivalNotice();">Print
					Arrival Notice</button>
			</div>
			<div id="t0-paging" class="container-fluid pl-0 pr-0"
				data-pageSize="15"></div>

			 
		</rcl:area>
	</div>
	
	<!-- end container -->
	<script>
		var selectedRow=[];
		var responseSearchData=[];
		var isFindClick=false;
		var port;
		var inVoyageBrowserService = null;
		var inVoyageBrowserVessel = null;
		var inVoyageBrowserVoyage = null;
		var inVoyageBrowserDirection = null;
		var flag = false;
		var flagForChekBox = false;

		$(document)	.ready(	function() {
							$('.listsearch').addClass('rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField');
							$('.listsearch').addClass('rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField');
							removeEmtryOptions("s0-searchBy");

							rut.packForRclServlet = false;
							getPort();
							getURLForReport();

													});

		function getURLForReport() {
			var dataPost = {};

			sendPostRequest("rclws/blcArrivalNotice/getReportUrl", dataPost,
					function(data) {
						URLConstant["REPORT_URL"] = 'http://' + data[0]
								+ '/reports/rwservlet?';
						PATHConstant["REPORT_FOLDER_PATH"] = data[1];

					})
		}

		function getPort() {
			var dataPost = {};
			sendPostRequest("rclws/blcArrivalNotice/getPort", dataPost,
					function(data) {
						port = data[0].etaPort;
						$("#s0-port").val(port);
						var etaforSgsin = "ETA for " + port;
						$("#s0-etaForSgsin").prev("label").text(etaforSgsin);
					})
		}

		function find() {
			
			getVoyageServcieVessleVoyage();	
			
			//To resolve the code review comments
			if(isFindClick==false){
				$(".checkBoxRow").html('<input type="checkbox" name="t11selectAll" id="t11select" class="selectChild listsearch" onclick="deSelect()">');
				rptTableInit('t0-area');
				$(".rptPgBtn").on("click",function() {
					debugger;
					$("#t0-select").prop("checked", false);
					 var page = $('#t0-pgIndicator').val().split(' ')[1];
				    	var to = $('#t0-pgIndicator').val().split(' ')[3];
				    	var data = rptGetDataFromDisplayAll("t0-area");
				    	var count=0;
				    	for (let i = 0; i < data.length; i++) {
							  var text = $("#t0-seq-"+((15*(page-1))+i)).text();
							  if(  selectedRow.indexOf(parseInt(text))!=-1){   
								   
									  count++;
									  document.getElementById("t11select-"+((15*(page-1))+i)).checked = true;	 
								  
							  }
							  
						}
				    	
				    	if(count==15){
				    		$("#t0-select").prop("checked", true);
				    	}
				 	 	 
				});

				 

			} 
						 
			isFindClick=true;
			var blNo = $('#s0-blNo').val();
			$("#t0-select").prop("checked", false);			
			
			var dataPost = getDataAreaToObject("s0-header");
					
			var searchBy = $("#s0-searchBy").val();
			if (searchBy == "Invoyage#"){				
				if (inVoyageBrowserVessel == "" || inVoyageBrowserVessel == null) {
					var msg = "*NoService/Vessel/Voyage/Direction is selected from Invoyage Browser";
					rutOpenMessageBox("Warning", msg.toString().replace(/,/g, ''),
							null, null);
					return ;
					
				}					

				dataPost['service'] = inVoyageBrowserService;
				dataPost['vessel'] = inVoyageBrowserVessel;
				dataPost['voyage'] = inVoyageBrowserVoyage;
				dataPost['direction'] = inVoyageBrowserDirection;
				sendPostRequest("rclws/blcArrivalNotice/searchForInVoyageBrowser",	dataPost,function(data) {
							console.log(data.length, "array");
							rptClearDisplay('t0-area');
							rptAddData('t0-area', []);
							rptAddData('t0-area', data);
							rptDisplayTable('t0-area');
							//$(".checkBoxRow").html('<input type="checkbox" name="t11selectAll" class="selectChild listsearch" onclick="deSelect()">');
							if (data.length > 0) {
								$("#s0-printArrivalNotices").attr("style",	"display: flex; justify-content: flex-end; width: 100%;");								
							}
						})

			} else {

				if (((dataPost.vessel == "") || (dataPost.voyage == ""))
						&& (dataPost.blNo == "")) {
					rutOpenMessageBox("Warning","*Vessel and Voyage or B/L# is mandatory", null,null);
				} else {
					sendPostRequest(
							"rclws/blcArrivalNotice/search",
							dataPost,
							function(data) {
								console.log(data.length, "array");
								rptClearDisplay('t0-area');
								rptAddData('t0-area', []);
								rptAddData('t0-area', data);
								rptDisplayTable('t0-area');
								 
								selectedRow=[];
								responseSearchData=data;
								if (data.length > 0) {
									$("#s0-printArrivalNotices").attr("style","display: flex; justify-content: flex-end; width: 100%;");
								}
								//$(".checkBoxRow").html('<input type="checkbox" name="t11selectAll" class="selectChild listsearch" onclick="deSelect()">');
							})
				}
			}
		}
 

		$(document).ready(function() {
							$("#s0-inVoyage").prop("disabled", true);
							$("#s0-etaForSgsin").prop("disabled", true);
							$("#s0-inVoyageBrowser").prop("disabled", true);
							$("#s0-inVoyageBrowser").removeClass(
									"rcl-standard-button");
							$("#s0-inVoyage").parents().first().next()
									.addClass("disblePointer-i-icon");
							$("#h0-languageCode").prop("disabled", true);
						});

		document.getElementById('s0-searchBy').onchange = function() {
			var searchBy = $("#s0-searchBy").val();
			getRowBrowser=[];
			if (searchBy == "Invoyage#") {
				document.getElementById("s0-vessel").disabled = true;
				document.getElementById("s0-voyage").disabled = true;
				document.getElementById("s0-inVoyage").disabled = false;
				document.getElementById("s0-etaForSgsin").disabled = false;
				$("#s0-inVoyage").val('');
				$("#s0-etaForSgsin").val('');
				$("#s0-vessel").val('');
				$("#s0-voyage").val('');
				$("#s0-etaForSgsin").val('');
				$("#s0-inVoyageBrowser").prop("disabled", false);
				$("#s0-inVoyageBrowser").addClass("rcl-standard-button");
				$("#s0-inVoyage").parents().first().next().removeClass(	"disblePointer-i-icon");
				$("#s0-voyage").parents().first().next().addClass("disblePointer-i-icon");
				$("#s0-vessel").parents().first().next().addClass("disblePointer-i-icon");
			} else {
				document.getElementById("s0-vessel").disabled = false;
				document.getElementById("s0-voyage").disabled = false;
				document.getElementById("s0-inVoyage").disabled = true;
				document.getElementById("s0-etaForSgsin").disabled = true;
				$("#s0-inVoyageBrowser").prop("disabled", true);
				$("#s0-inVoyageBrowser").removeClass("rcl-standard-button");
				$("#s0-vessel").val('');
				$("#s0-voyage").val('');
				$("#s0-inVoyage").val('');
				inVoyageBrowserService = "";
				inVoyageBrowserVessel = "";
				inVoyageBrowserVoyage = "";
				inVoyageBrowserDirection = "";
				$("#s0-voyage").parents().first().next().removeClass("disblePointer-i-icon");
				$("#s0-vessel").parents().first().next().removeClass("disblePointer-i-icon");
				$("#s0-inVoyage").parents().first().next().addClass(	"disblePointer-i-icon");
				flag = false;

			}
		}

		function deSelect() {
			 
			$("#t0-select").prop("checked", false);

			var i = 0;
			$(".rptEvenRow .selectChild").each(function(index) {
				if ($(this).prop("checked")) {
					i = i + 1;
				}
			});

			$(".rptOddRow .selectChild").each(function(index) {
				if ($(this).prop("checked")) {
					i = i + 1;
				}
			});
			if (i == $(".selectChild").length - 1) {
				$("#t0-select").prop("checked", true);
			}
			
			
			var data = rptGetDataFromDisplayAll("t0-area");
	 	 	  var check = true;
	 	 	  var page = $('#t0-pgIndicator').val().split(' ')[1];
	 	 	  debugger;
	 	 	 for (let i = 0; i < data.length; i++) {
	 	 			var rowIdAry = data[i].rowId.split('-'); // PONPIC1 PowerTable rowId is not reset to Zero after sort, we must use current rowId
	 				//var checkBox = document.getElementById("t11select-"+((15*(page-1))+i));
	 	 			var checkBox = document.getElementById("t11select-"+rowIdAry[2]);
	 				var checkPut = selectedRow.indexOf(parseInt(data[i].seq));
	 				if(checkBox.checked == false){
	 					check = false;
	 					if(selectedRow.length != 0){
	 						if(checkPut >= 0 ){
	 							selectedRow.splice( selectedRow.indexOf(parseInt(data[i].seq)), 1 );
	 						}
	 					}
	 				}else{
	 					if(selectedRow.length == 0){
	 						selectedRow.push(parseInt(data[i].seq));
	 					}else if(checkPut < 0 ){
	 						if(selectedRow.indexOf(parseInt(data[i].seq))==-1)
	 						selectedRow.push(parseInt(data[i].seq));	 
	 					}	
	 				}
	 		  }
		}

		function selectAll(obj) {
			debugger;
			
			var searchData = rptGetDataFromDisplayAll("t0-area");
			$(".selectChild").prop("checked", $("#t0-select").prop("checked"));
			if ($("#t0-select").prop("checked")) {
				flagForChekBox = true;
				for (let i = 0; i < searchData.length; i++) {
	 				var rowIdAry = searchData[i].rowId.split('-'); // PONPIC1 PowerTable rowId is not reset to Zero after sort, we must use current rowId
					document.getElementById("t11select-"+(rowIdAry[2])).checked = true;
					var text = $("#t0-seq-"+(rowIdAry[2])).text();  
					
					//document.getElementById("t11select-"+((15 *(page-1))+i)).checked = true;
					//var text = $("#t11rowNum-"+((15*(page-1))+i)).text();  
					selectedRow.push(parseInt(text));
				}
			}else{
				
				for (let i = 0; i < searchData.length; i++) {
	 				var rowIdAry = searchData[i].rowId.split('-'); // PONPIC1 PowerTable rowId is not reset to Zero after sort, we must use current rowId
	 				document.getElementById("t11select-"+(rowIdAry[2])).checked = false;
	 				var text = $("#t0-seq-"+(rowIdAry[2])).text(); 
	 				selectedRow.splice(selectedRow.indexOf(parseInt(text)),1)
	 				//document.getElementById("t11select-"+((15 *(page-1))+i)).checked = false;
	 			}
			}
		}

		function printArrivalNotice() {
			var i = selectedRow.length;

			if (i != 0) {

				var msg = "Selected BL count "
						+ i
						+ " is more than setup limit 0, System can be slow due to bulk data printing? OK/Cancel";
				rutOpenMessageBox("Warning", msg.toString().replace(/,/g, ''),
						null, null, printArrivalNoticeOk, "Cancel", '')
			} else {
				rutOpenMessageBox("Warning", "Select at least one BL", null,
						null)
			}
		}

		function printArrivalNoticeOk() {
			var includeCharges = "N";
			var printTerminal = "N";
			var prntImtPkupArea = "N";
			var bl;
			debugger;
			if ($("input[name~='includeCharges']").prop("checked"))
				includeCharges = "Y";
			if ($("input[name~='printTerminal']").prop("checked"))
				printTerminal = "Y";
			if ($("input[name~='printImportPickupArea']").prop("checked"))
				prntImtPkupArea = "Y";
			var arrayOfSelectedBL = []
			 
			for(var i=0;i<responseSearchData.length;i++){
					var obj=responseSearchData[i];
					if(selectedRow.indexOf(parseInt(obj.seq))!=-1){
						arrayOfSelectedBL.push("'"+obj.blNo+ "'");
					}
			}
			if (arrayOfSelectedBL.length != 0) {
				var printVoyageBrowserUrl = URLConstant.REPORT_URL
						+ "repenvp&report=dimp_arrival_notice.rep"
						+ "&p_billno=("
						+ encodeURI(arrayOfSelectedBL.join(",")) + ")"
						+ "&p_charges=" + includeCharges + "&p_terminal="
						+ printTerminal + "&p_header=Y&p_pickup="
						+ prntImtPkupArea
						+ "&p_eta=&p_report_description=Arrival%20Notice"
						+ "&p_user_code=" + "${userData.userId}" + "&p_path="
						+ PATHConstant.REPORT_FOLDER_PATH;
				window
						.open(printVoyageBrowserUrl, 'PrintWindow',
								'width=900,height=570,resizable=yes,scrollbars=yes,toolbar=no');

				var sendData = getDataAreaToObject("s0-header");
				sendData["blNo"] = bl;
				sendPostRequest("rclws/blcArrivalNotice/update", sendData,
						function(data) {
						})
			}
		}

		
		 
		$("#s0-reset").click(function() {
			inVoyageBrowserVessel="";
    		 inVoyageBrowserVoyage="";
    		 inVoyageBrowserDirection="";
			 getRowBrowser=[];			 
			$("#s0-port").val(port);
			$("#s0-vessel").prop("disabled", false);
			$("#s0-voyage").prop("disabled", false);
			$("#s0-voyage").parents().first().next().removeClass("disblePointer-i-icon");
			$("#s0-vessel").parents().first().next().removeClass("disblePointer-i-icon");
			$("#s0-inVoyage").parents().first().next().addClass("disblePointer-i-icon");
			$("#s0-inVoyageBrowser").prop("disabled", true);
			$("#s0-inVoyageBrowser").removeClass("rcl-standard-button");
			$("#s0-inVoyage").prop("disabled", true);
			$("#s0-etaForSgsin").prop("disabled", true);
			inVoyageBrowserService = "";
			inVoyageBrowserVessel = "";
			inVoyageBrowserVoyage = "";
			inVoyageBrowserDirection = "";
			flag = false;
	  });
		
	</script>


</body>

<%@ include file="BlcInvoyageBrowserScn.jsp" %>  
</html>