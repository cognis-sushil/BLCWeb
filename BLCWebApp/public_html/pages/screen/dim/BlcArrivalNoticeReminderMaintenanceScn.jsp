<!--
-----------------------------------------------------------------------------------------------------------
BlcArrivalNoticeReminderMaintenanceScn.jsp
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
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<%@include file="../../include/RcmInclude.jsp"%>
<jsp:include page="../../include/commonInclude.jsp"></jsp:include>
<head>
<title>Arrival Notice Reminder Maintenance</title>

</head>
<body id="dim208">
	<jsp:include page='../../include/header.jsp'>
		<jsp:param name="pageHeader" value="Arrival Notice Maintenance" />
	</jsp:include>
	<form id="arrivalNoticeMain">
		<rcl:area id="s0-header" classes="div(container-fluid pl-1 pr-1)"
			title="Search" areaMode="search" collapsible="true">
			<!--start container -->
			<div class="row">
				<!--start row 1 -->

				<rcl:text id="s0-blNo" label="B/L#" classes="div(col-sm-2)"
					check="upc" icon="fa-search" iconClick="lookupBl()" />

				<rcl:text id="t0-opCode" label="Op.Code" name="Op Code"
					classes="div(col-2)"
					lookup="tbl(VRL_OPCODE) rco(OPERATOR_CODE) rid(t0-opCode) sco(OPERATOR_CODE) sva(t0-opCode) sop(LIKE)">
				</rcl:text>
				<rcl:select id="s0-socCoc" label="SOC/COC/Both" classes="div(col-2)"
					optionsList="SOC COC" valueList="S C" emptyDisplay="Both">
				</rcl:select>

				<div class="col-1" style="text-align: center;">
					<label for="t0-includeCharges">Include Charges </label> <input
						id="t0-includeCharges" type="checkbox" name="Include Charges"
						class="rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField"
						checked>
				</div>
			</div>
			<!-- end row1 -->


			<!-- end container  -->
		</rcl:area>
	</form>
	<!-- end search area -->
	<rcl:area id="t0-area" title="B/L List"
		classes="div(container-fluid pl-1 pr-1)" areaMode="table"
		collapsible="true">
		<div class="row border">
			<div class=" col-0x25 text-center">							 
			</div>
			<div id="t-seq" class="col-0x5 text-center "
				style="font-weight: bold;">No</div>
			<div id="t-bl" class="col-1x25" style="font-weight: bold;">BL#</div>
			<div id="t-issueOffice" class="col-1x25" style="font-weight: bold;">Issue
				Office</div>
			<div id="t-pol" class="col-1" style="font-weight: bold;">POl</div>
			<div id="t-opCode" class="col-1x25" style="font-weight: bold;">Op.Code</div>
			<div id="t-sc" class="col-1" style="font-weight: bold;">S/C</div>
			<div id="t-inStatus" class="col-1x25" style="font-weight: bold;">In
				Status</div>
			<div id="t-eta" class="col-1x25" style="font-weight: bold;">
				ETA</div>
			<div class=" col-0x25 text-center">							 
			</div>
			<div id="t-printed" class="col-0x5" style="font-weight: bold;">Printed</div>
			<div class=" col-0x25 text-center">							 
			</div>
			<div id="t-datePrinted" class="col-1x25" style="font-weight: bold;">Date
				Printed</div>
			<div id="t-select" class="col-0x25" style="font-weight: bold;">
				Select <input id="s0-select" type="checkbox" onclick="selectAll()" />
			</div>
		</div>
		<div class='tblArea tblAreaPadding'
			style="overflow-x: hidden; overflow-y: scroll; max-height: 50vh;">
			<div id="t0-row" class="tblRow  row pt-1">
				<div class="container-fluid">
					<div class="row gridRow selectData">
						<!-- start table row -->
						<div class=" col-0x25 text-center">							 
						</div>
						<div class=" col-0x5 text-center">
							<p id="t0-seq" class="listsearch"></p>
						</div>
						<div class="col-1x25">
							<p id="t0-blNo" class="listsearch"></p>
						</div>
						<div class="col-1x25 ml-1">
							<p id="t0-issueOffice" class="listsearch"></p>
						</div>
						<div class="col-1 ml-0">
							<p id="t0-pol" class="listsearch"></p>
						</div>
						<div class=" col-1x25 ml-1">
							<p id="t0-opCode" class="listsearch"></p>
						</div>
						<div class="col-1 ml-0">
							<p id="t0-socCoc" class="listsearch"></p>
						</div>
						<div class="col-1x25 ml-0">
							<p id="t0-inStatus" class="listsearch"></p>
						</div>
						<div class="col-1x25 ml-0">
							<p id="t0-podEta" class="listsearch"></p>
						</div>
						<div class=" col-0x25 text-center">							 
						</div>
						<div class="col-0x5 ml-0 text-center">
							<p id="t0-numberOfTimeArravalPrinted" class="listsearch"></p>
						</div>
						<div class=" col-0x25 text-center">							 
						</div>
						<div class="col-1x25 ml-1">
							<p id="t0-lastDateArrivalPrinted" class="listsearch mr-5"></p>
						</div>
						<div class="col-0x25 ml-1">
							<input type="checkbox" name="select" onclick="deSelect()"
								class="selectChild rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField">
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- end table row -->
		<div style="display: none" id="t0-printArrivalNotices">
			<button id="t0-printArrivalNotice" type="button"
				class="rcl-standard-button " onclick="printArrivalNoticeReminder();">Print
				Arrival Notice Reminder</button>
		</div>

		<div class=" col-sm-2 mt-3"></div>

		<div id="t0-paging" class="container-fluid pl-0 pr-0"
			data-pageSize="15"></div>
	</rcl:area>
	<!-- end table area -->
</body>
<script>
var rclp =${param.rclp};


    	      var defaultSearchData = {
        	          "service":rclp.to[0].value.srv,
        	          "vessel":rclp.to[0].value.vsl,
        	          "voyage":rclp.to[0].value.vog,
        	          "direction":rclp.to[0].value.dir,
        	          "pol":rclp.to[0].value.pol,
        	          "pot":rclp.to[0].value.pot, 
        	          "pod":rclp.to[0].value.pod, 
        	          "podEtd":rclp.to[0].value.etd,
        	          "podEta":rclp.to[0].value.eta,
        	          "blNo"  :rclp.to[0].value.blNo 
        	      };
	   		 function getTableData() {
    	     sendPostRequest("rclws/blcArrivalNoticeMaintenance/editBl", defaultSearchData, function(data) { 
    	          console.log(data, "array");
    	          debugger;
    	          rptAddData('t0-area', data);
    	          rptDisplayTable('t0-area');
    	          if(data.length>0){
						$("#t0-printArrivalNotices").attr("style", "display: flex; justify-content: flex-end; width: 100%;"); } 
    	      })
    	  }
		   	  
      $(document).ready(function(){
    	  $('.listsearch').addClass('rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField');
    	  rptTableInit('t0-area');
    	  $("#h1-back").on("click",rutBack);
            getTableData();
            getURLForReport();
  	});

    function getURLForReport(){ 
  	  var dataPost = {};
  	  sendPostRequest("rclws/blcArrivalNotice/getReportUrl", dataPost, function(data) {
  		 URLConstant["REPORT_URL"] = 'http://' +data[0]+'/reports/rwservlet?';   
		  PATHConstant["REPORT_FOLDER_PATH"] = data[1];
		    })
        }
      function find() {
    	  $("#s0-select"). prop("checked", false);
          rptClearDisplay('t0-area');
          rptAddData('t0-area', []);     	
          debugger;
          var dataPost = getDataAreaToObject("s0-header");
          for(var key in defaultSearchData){
              if(key!="blNo"){
        	  dataPost[key]=defaultSearchData[key];	
          }}
          console.log(dataPost,"data")
          settingTable("t0-area");
          sendPostRequest("rclws/blcArrivalNoticeMaintenance/search", dataPost, function(data) { 
          console.log(data.length, "array");
                 $("#loading").hide();
                 rptAddData('t0-area', data);
                 rptDisplayTable('t0-area');
                 
             })
      }

      function printArrivalNoticeReminder(){
    	  
      	var bl;
  		var arrayOfSelectedBL=[]
  		 $(".selectChild").each(function( index ) {
  			if($( this ).prop("checked")){
  		      bl= $($( this ).parent().parent().children()[2]).find("p").html()
  		      if(bl !== ""){
  			 arrayOfSelectedBL.push("'"+bl+"'"); }
  			  console.log( index + ": " + bl);
  			}
  		}); 
   		debugger;
   		var includeCharges="N";
   		if( $('#t0-includeCharges').prop("checked")){ 
   	   		includeCharges ="Y";
   	   		}
   		if(arrayOfSelectedBL.length !=0){
			var printArrivalNoticeReportUrl = URLConstant.REPORT_URL
					+ "repenvp&report=dimp_arrival_notice.rep"
					+"&p_billno=("+ encodeURI(arrayOfSelectedBL.join(",")) +")"
					+"&p_header=Y&p_charges="+includeCharges+"&p_report_description=Arrival%20Notice%20Reminder"
					+"&p_user_code="+ "${userData.userId}"
					+"&p_path="+PATHConstant.REPORT_FOLDER_PATH
					+"&p_reminder=Y";
		window.open(printArrivalNoticeReportUrl, 'PrintWindow','width=900,height=570,resizable=yes,scrollbars=yes,toolbar=no');
		//var obj =  {bl: bl} ;
		 var dataPost = getDataAreaToObject("s0-header");
		 dataPost["blNo"] = bl;
		 sendPostRequest("rclws/blcArrivalNotice/update", dataPost, function(data) {
	       })
   		
  	}else{
  		rutOpenMessageBox("Warning", "Select at least one BL",
				null, null)
	}}
      
      function selectAll(){
  		$(".selectChild").prop("checked", $("#s0-select").prop("checked"));
  		}
      
      function settingTable(isvalue) {
			var settings = getTableSettings(isvalue);
			settings.paging.pageSize = 15;
		}
      
      function deSelect() {
			
			$("#s0-select").prop("checked", false);
			
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
			if(i==$(".selectChild").length-1){
				$("#s0-select").prop("checked", true);
			}
		}

      

       </script>
</html>