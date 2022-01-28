<!--
-----------------------------------------------------------------------------------------------------------
BlcBlCountByActivityDetailScn.jsp
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

<title>B/L Count By Activity</title>


</head>
<style type="text/css">
.tblArea {
	padding-left: 0;
}
</style>

<body id="dex200">
	<jsp:include page='../../include/header.jsp'>
		<jsp:param name="pageHeader" value="B/L Count By Activity" />
	</jsp:include>
	<rcl:area id="s0-header" title="Search" areaMode="search" collapsible="true" >
			<div class="row">
				<!--start row 1 -->
				
 				<jsp:include page="../../include/commonLookUp.jsp"></jsp:include>

				<rcl:select id="s0-direction" label="Direction"
					classes="div(col-2) ctr(dtlField)" selectTable="Direction" emptyDisplay="All"/>

				<rcl:text id="s0-pol" label="POL" classes="div(col-2)"
					check="upc len(5)"
					lookup="tbl(VRL_PORT) rco(CODE NAME) rid(s0-pol) sco(CODE) sva(s0-pol)"
					autoLookup="Y">
				</rcl:text>
				
			</div>
			<!-- end row  -->
			<!--start row 2 -->
			<div class="row">
				
				<rcl:date id="s0-etdFrom" label="ETD From" name="etdFrom" classes="div(col-2)">
				</rcl:date>
				<rcl:date id="s0-etdTo" label="ETD To" name="etdTo" classes="div(col-2)">
				</rcl:date>
			</div>
			<!-- end row  -->
		</rcl:area>
	<rcl:area id="t0-area" title="Details" areaMode="table" collapsible="true"
		useHeader="true">
		<div class="row border">
			<div class="col-0x5 mr-0"
				style="font-weight: bold; text-align: center;">No</div>
			<div class="col-1x5 mr-0" style="font-weight: bold;">BL#</div>
			<div class="col-0x75 mr-5" style="font-weight: bold;">B/L Type</div>
			<div class="col-1 mr-4" style="font-weight: bold;">Confirmed
				B/L</div>
			<div class="col-0x75 mr-4" style="font-weight: bold;">Printed
				B/L</div>
			<div class="col-1x5 mr-4" style="font-weight: bold;">Genrated
				invoices</div>
			<div class="col-1 mr-4" style="font-weight: bold;">Printed
				invoices</div>
			<div class="col-1 mr-4" style="font-weight: bold;">Manifested
				B/L</div>
			<div class="col-1 mr-4" style="font-weight: bold;">Released
				B/L</div>
			<div class="col-1 mr-4" style="font-weight: bold;">Special
				Release</div>
		</div>
		<div class='tblArea' >
			<div id="t0-row" class="tblRow  row pt-1">
				<div class="container-fluid">
					<div class="row gridRow selectData">
						<!-- start table row -->
						<div class="col-0x5 mr-0" style="text-align: center;">
							<p id="t0-seq" class="listsearch"></p>
						</div>
						<div class="col-1x5 mr-0">
							<p id="t0-blNum" class="listsearch"></p>
						</div>
						<div class="col-0x75 mr-5">
							<p id="t0-blType" class="listsearch"></p>
						</div>
						<div class="col-1 mr-4">
							<p id="t0-confirmBl" class="listsearch"></p>
						</div>
						<div class="col-0x75 mr-4">
							<p id="t0-blPrintStatus" class="listsearch"></p>
						</div>
						<div class="col-1x5 mr-4">
							<p id="t0-generatedInvoices" class="listsearch"></p>
						</div>
						<div class="col-1 mr-4">
							<p id="t0-printedInvoices" class="listsearch"></p>
						</div>
						<div class="col-1 mr-4">
							<p id="t0-manifestedBl" class="listsearch"></p>
						</div>
						<div class="col-1 mr-4">
							<p id="t0-unreleaseBl" class="listsearch"></p>
						</div>
						<div class="col-1 mr-4">
							<p id="t0-specialRelease" class="listsearch"></p>
						</div>
						<!-- end table row -->
					</div>
				</div>
			</div>
		</div>

	</rcl:area>
	<!-- end table area -->
	<div id="t0-paging" class="container-fluid pl-0 pr-0" data-pageSize="15"></div>

	<script>
	 var rclp =${param.rclp};
      var id = rclp.to[0].value.id
      var srv = rclp.to[0].value.service
      var vsl = rclp.to[0].value.vessel
   	  var vog = rclp.to[0].value.voyage
   	  var dir = rclp.to[0].value.direction
   	  var pol = rclp.to[0].value.pol
   	  var etdFrom = rclp.to[0].value.etdFrom
   	  var etdTo = rclp.to[0].value.etdTo
   	  var blType =rclp.to[0].value.blType
   	   	  
    	  $(document).ready(function() {
    		  $('.listsearch').addClass('rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField')
    	      rptTableInit('t0-area');    	      
    	      rut.packForRclServlet = true;
    	      detail();
    	      $("#s0-find").css("background-color", "#cccc");
    	      $("#s0-find").addClass("disblePointer-i-icon");
    	      $("#s0-reset").css("background-color", "#cccc");
    	      $("#s0-reset").addClass("disblePointer-i-icon");
    	      $("#h1-back").on("click",rutBack);
    	  });

   	  /**
   	  	used to get detail BL count Activity base on service,vessel,voyage etc.
   	  	Note : This method is getting called at load of the page
   	  **/
    	  function detail() {
   	  		
	   	  	$("#s0-service").val(srv);
			$("#s0-vessel").val(vsl);
			$("#s0-voyage").val(vog);
			$("#s0-direction").val(dir);
			$("#s0-pol").val(pol);
			$("#s0-etdFrom").val(etdFrom);
			$("#s0-etdTo").val(etdTo);
    	      var searchData = {
    	          "id": id,
    	          "service":srv,
    	          "vessel":vsl,
    	          "voyage":vog,
    	          "direction":dir,
    	          "pol":pol,
    	          "etdFrom":etdFrom,
	              "etdTo":etdTo,
	              "bLType":blType
    	      };
    	      debugger;
    	      sendPostRequest("rclws/blCountByActivitySummary/detail", searchData, function(data) {
    	          console.log(data, "array");
    	          rptAddData('t0-area', data);
    	          rptDisplayTable('t0-area');  	        

    	      })
    	  }


</script>
</body>
</html>