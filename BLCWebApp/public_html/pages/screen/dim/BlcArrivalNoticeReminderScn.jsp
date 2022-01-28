<!--
-----------------------------------------------------------------------------------------------------------
BlcArrivalNoticeReminderScn.jsp
-------------------------------------------------------------------------------------------------------------
Copyright RCL Public Co., Ltd. 2018
-------------------------------------------------------------------------------------------------------------
Author Author Cognis Solution 1/04/2020
- Change Log ------------------------------------------------------------------------------------------------
## DD/MM/YY -User-     -TaskRef-         -Short Description
1   1/04/20           Akash Gupta           Initial Version
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

<title>Arrival Notice Reminder</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
</head>
<body id="dim209">
	<jsp:include page='../../include/header.jsp'>
		<jsp:param name="pageHeader" value="Arrival Notice Reminder" />
	</jsp:include>
	<form id="arrivalNoticeReminder">
		<rcl:area id="s0-header" title="Search" areaMode="search" 	collapsible="true" >

			<div class="row">
				<!--start row 1 -->
				<rcl:select id="s0-searchBy" label="Search By" classes="div(col-2)" check="req"
					optionsList="Default Invoyage#" valueList="Default Invoyage#"
					defaultValue="Default">
				</rcl:select>

				 <jsp:include page="../../include/commonLookUp.jsp">
				        <jsp:param name="req" value="req" />
				 </jsp:include>
				
				<rcl:select id="s0-direction" label="Direction"
					classes="div(col-2) ctr(dtlField)" selectTable="Direction" emptyDisplay="All"></rcl:select> 
			</div>
			<!-- end row  -->
			<!--start row 2 -->
			<div class="row">	
				<div class="col-sm-2">
					<div>
						<rcl:text id="s0-port" label="Port " classes="div(col-1.5)"
							check="dis len(3)"></rcl:text>
					</div>
					<label class="rcl-standard-font " for="s0-port"></label>
					<div class="rcl-standard-font"></div>
				</div>
				
				<rcl:text id="s0-inVoyage" label="In Voyage#" classes="div(col-2)"
				check="upc" icon="fa-search"
				iconClick="lookupInVoyage()"/>
				
				<rcl:date id="s0-etaForSgsin" label=""
					classes="div(col-2)"><!-- ETA for SGSIN -->
				</rcl:date>
				<div class="col-sm-2 mt-3">
				<button id="s0-inVoyageBrowser" type="button"
				class="rcl-standard-button" onclick="onVoyageBrowser()">
				InVoyage&nbsp;Browser</button> 
				
				
 		</div>
			</div>
			<!-- end row  -->
			<div class="row">
				<!--start row 2 -->
			</div>
			<!-- end row2 -->
			<!-- end container  -->
		</rcl:area>
	</form>
	<!-- end search area -->
	<rcl:area id="t0-area" title="Arrival Notice Reminder List"
		classes="div(container-fluid pl-1 pr-1)" 
		areaMode="table" collapsible="true" >


		<div class="row border">
			<div id="t-seq" class="col-1"
				style="font-weight: bold; margin-left: 10px;">No</div>
			<div id="t-service" class="col-1x25" style="font-weight: bold;">Service</div>
			<div id="t-vessel" class="col-1x25" style="font-weight: bold;">Vessel</div>
			<div id="t-voyage" class="col-1x25" style="font-weight: bold;">Voyage</div>
			<div id="t-directionAsString" class="col-1x25"
				style="font-weight: bold;">Direction</div>
			<div id="t-pol" class="col-1x25" style="font-weight: bold;">POL</div>
			<div id="t-pot" class="col-1x25" style="font-weight: bold;">POT</div>
			<div id="t-etd" class="col-1x25" style="font-weight: bold;">ETD</div>
			<div id="t-eta" class="col-1" style="font-weight: bold;">ETA</div>
			<div id="t-pod" class="col-0x75" style="font-weight: bold;">POD</div>
		</div>
		<div class='tblArea'  style="overflow-y:auto;"> 
			<div id="t0-row" class="tblRow  row pt-1">
				<div class="container-fluid">
					<div class="row gridRow selectData">
						<!-- start table row -->
						<div class=" col-1">
							<p id="t0-seq" class="listsearch" ></p>
						</div>
						<div class=" col-1x25">
							<p id="t0-service" class="listsearch" ></p>
						</div>
						<div class="col-1x25">
							<p id="t0-vessel" class="listsearch" ></p>
						</div>
						<div class="col-1x25">
							<p id="t0-voyage" class="listsearch" ></p>
						</div>
						<div class="col-1x25">
							<p id="t0-directionAsString" class="listsearch" ></p>
						</div>
						<div class="col-1x25">
							<p id="t0-pol" class="listsearch" ></p>
						</div>
						<div class="col-1x25">
							<p id="t0-pot" class="listsearch" ></p>
						</div>
						<div class="col-1x25 ml-1">
							<p id="t0-polEtd" class="listsearch" ></p>
						</div>
						<div class="col-1">
							<p id="t0-podEta" class="listsearch" ></p>
						</div>
						<div class="col-0x75">
							<p id="t0-pod" class="listsearch" ></p>
						</div>
						<div style="display: none;">
							<p id="t0-blNo" class="listsearch" ></p>
						</div>
						<div>
							<i class="selectChild fas fa-edit" id="t0-element"
								style="padding-top: 3px;" onclick="viewBlList(this.id);"></i>
						</div>
					</div>
					<!-- end table row   -->
				</div>
			</div>
		</div>
	 	<!-- end container -->

		<div id="t0-paging" class="container-fluid pl-0 pr-0" data-pageSize="15" ></div>
	</rcl:area>
	<!-- end table area -->

	<!-- end container -->
	<script>
	  var port;
	  var inVoyageBrowserService=null;
	  var inVoyageBrowserVessel=null;
	  var inVoyageBrowserVoyage=null;
	  var inVoyageBrowserDirection=null;
      var flag = false;
		$(document).ready(function() {
							$('.listsearch').addClass('rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField');
							rptTableInit('t0-area');
							removeEmtryOptions("s0-searchBy"); 
							rut.packForRclServlet = false;
							var dataPost = {};
							 
							sendPostRequest("rclws/blcArrivalNoticeReminder/searchPort",dataPost, function(data) {
										console.log(data.length, "array");
										port = data[0].port; 
										$("#s0-port").val(port);
										var etaforSgsin = "ETA for "+port;
							 		    $("#s0-etaForSgsin").prev("label").text(etaforSgsin);
									})
						});

		function viewBlList(argId) {
			var srv;
			var vsl;
			var vog;
			var dir;
			var pol;
			var pot;
			var etd;
			var eta;
			var pod;
			var blNo;
			debugger;

			$('.selectChild').each(
					function() {

						if (this.id == argId) {
							srv = $($(this).parent().parent().children()[1]).find("p").html()
							vsl = $($(this).parent().parent().children()[2]).find("p").html()
							vog = $($(this).parent().parent().children()[3]).find("p").html()
							dir = $($(this).parent().parent().children()[4]).find("p").html()
							pol = $($(this).parent().parent().children()[5]).find("p").html()
							pot = $($(this).parent().parent().children()[6]).find("p").html()
							etd = $($(this).parent().parent().children()[7]).find("p").html()
							eta = $($(this).parent().parent().children()[8]).find("p").html()
							pod = $($(this).parent().parent().children()[9]).find("p").html()
							blNo = $($(this).parent().parent().children()[10]).find("p").html()
							// alert('bls ' +bls);
						}

					});
		

			var dataPost ={'srv': srv,'vsl' : vsl, 'vog' : vog, 'dir': dir, 'pol': pol , 'pot' : pot, 'etd' : etd, 'eta' : eta,'pod':pod, 'blNo': blNo};
			var href=  window.location.protocol+"//"+location.hostname+':'+window.location.port+"/BLCWebApp/RrcStandardSrv?service=ui.blc.dim.ArrivalNoticeReminderMaintenanceSvc"
			console.log("href "+ href);
			var type = '2Tab';
			var rclp = new rutDialogFlow(type , href);
			rclp.packForRclServlet = true;
			rclp.addToField('trg' , 'variable' ,null , 'BlcArrivalNoticeReminderMaintenance','src','variable' , null , dataPost);
			rclp.openPage();
			
		}

		
		function find() {
			getVoyageServcieVessleVoyage();		
			rptClearDisplay('t0-area');
			rptAddData('t0-area', []);
			var dataPost = getDataAreaToObject("s0-header");
			
			settingTable("t0-area");
			var searchBy = $("#s0-searchBy").val();
			  
			if (searchBy == "Invoyage#"){				
				if (inVoyageBrowserVessel == "" || inVoyageBrowserVessel == null) {
					var msg = "*NoService/Vessel/Voyage/Direction is selected from Invoyage Browser";
					rutOpenMessageBox("Warning", msg.toString().replace(/,/g, ''),
							null, null);
					return ;
					
				}
			 
				var pattern =/^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;				 
				if(dataPost.etaForSgsin!= '' && !pattern.test(dataPost.etaForSgsin)){
					rutOpenMessageBox("Warning", "Please Enter valid ETA Date",
				         null, null);
					return;
				}
				dataPost['service'] = inVoyageBrowserService;
				dataPost['vessel'] = inVoyageBrowserVessel;
				dataPost['voyage'] = inVoyageBrowserVoyage;
				dataPost['direction'] = inVoyageBrowserDirection;
				
	    	    sendPostRequest("rclws/blcArrivalNoticeReminder/searchForInVoyageBrowser", dataPost, function(data) {
	    	    	        console.log(data.length, "array");
	    	    	        rptAddData('t0-area', data);
	    	    	        rptDisplayTable('t0-area');
	    	       }) 
			   } else{
				   		if(dataPost.direction==null){
				   			dataPost.direction="";
				   		}
	    	    	 if ((dataPost.vessel == "") || (dataPost.voyage == "") ) {
	    					rutOpenMessageBox("Warning", "*Vessel and Voyage is mandatory",	null, null, '');
	    				} else {
			             sendPostRequest("rclws/blcArrivalNoticeReminder/search", dataPost, function(data) {
					       
						console.log(data.length, "array");
						rptAddData('t0-area', data);
						rptDisplayTable('t0-area');

					})
		     }
		   }	 
		 } 	    

		function settingTable(isvalue) {
			var settings = getTableSettings(isvalue);
			settings.paging.pageSize = 15;
		}

		$(document).ready(function() {
                    document.getElementById("s0-inVoyage").disabled = true;
					document.getElementById("s0-etaForSgsin").disabled = true;
					//$("#s0-inVoyage").parents().first().next().addClass("disblePointer-i-icon")
					$( "#s0-inVoyageBrowser" ).prop("disabled", true );
					$( "#s0-inVoyageBrowser" ).removeClass("rcl-standard-button");
				});

				

		document.getElementById('s0-searchBy').onchange = function() {
			getRowBrowser=[];
			var searchBy = $("#s0-searchBy").val();
			if (searchBy == "Invoyage#") {
				document.getElementById("s0-service").disabled = true;
				document.getElementById("s0-vessel").disabled = true;
				document.getElementById("s0-voyage").disabled = true;
				 $("#s0-direction").prop("disabled", true);
				document.getElementById("s0-inVoyage").disabled = false;
				document.getElementById("s0-etaForSgsin").disabled = false;
				$("#s0-service").parents().first().next().addClass("disblePointer-i-icon");
				$("#s0-voyage").parents().first().next().addClass("disblePointer-i-icon");
				$("#s0-vessel").parents().first().next().addClass("disblePointer-i-icon");
				$("#s0-inVoyage").parents().first().next().removeClass("disblePointer-i-icon");
				$("#s0-inVoyage").val('');
				$("#s0-etaForSgsin").val('');
				$("#s0-vessel").val('');
				$("#s0-voyage").val('');
				$("#s0-service").val('');
				$( "#s0-inVoyageBrowser" ).prop("disabled", false );
				$("#s0-inVoyageBrowser").addClass("rcl-standard-button");
			}

			else {
				document.getElementById("s0-service").disabled = false;
				document.getElementById("s0-vessel").disabled = false;
				document.getElementById("s0-voyage").disabled = false;
				$("#s0-service").parents().first().next().removeClass("disblePointer-i-icon")
				$("#s0-voyage").parents().first().next().removeClass("disblePointer-i-icon")
				$("#s0-vessel").parents().first().next().removeClass("disblePointer-i-icon")
				document.getElementById("s0-inVoyage").disabled = true;
				document.getElementById("s0-etaForSgsin").disabled = true;
				$("#s0-inVoyage").parents().first().next().addClass("disblePointer-i-icon")
				$("#s0-etaForSgsin").parents().first().next().addClass("disblePointer-i-icon")
				$("#s0-vessel").val('');
				$("#s0-voyage").val('');
				$("#s0-inVoyage").val('');
				$("#s0-etaForSgsin").val('');
				$('#t0-inVoyageBrowserDataSrv').val('');
         		$('#t0-inVoyageBrowserDataVes').val('');
         		$('#t0-inVoyageBrowserDataVoy').val('');
				$( "#s0-inVoyageBrowser" ).prop( "disabled", true );
				$( "#s0-inVoyageBrowser" ).removeClass("rcl-standard-button");
				$("#s0-direction").prop("disabled", false);
				inVoyageBrowserService="";
         		 inVoyageBrowserVessel="";
         		 inVoyageBrowserVoyage="";
         		inVoyageBrowserDirection="";
         		flag = false;
			}
		}


		 

		 $( "#s0-reset" ).click(function() {
			 inVoyageBrowserVessel="";
     		 inVoyageBrowserVoyage="";
     		 inVoyageBrowserDirection="";
			 getRowBrowser=[];
			 $("#s0-port").val(port);
			 $("#s0-service").prop("disabled", false);
			 $("#s0-vessel").prop("disabled", false);
    		 $("#s0-voyage").prop("disabled", false);
    		 $("#s0-service").parents().first().next().removeClass("disblePointer-i-icon")
	         $("#s0-voyage").parents().first().next().removeClass("disblePointer-i-icon");
	         $("#s0-vessel").parents().first().next().removeClass("disblePointer-i-icon");
	         $("#s0-inVoyage").parents().first().next().addClass("disblePointer-i-icon");
    		 $("#s0-inVoyageBrowser").prop("disabled", true);
    		 $("#s0-inVoyageBrowser").removeClass("rcl-standard-button");
	         $("#s0-inVoyage").prop("disabled", true);
	         $("#s0-etaForSgsin").prop("disabled", true); 
	         $("#s0-direction").prop("disabled", false);
	         inVoyageBrowserService="";
      		 inVoyageBrowserVessel="";
      		 inVoyageBrowserVoyage="";
      		inVoyageBrowserDirection="";
      		flag = false;
    		});
	</script>

<%@ include file="BlcInvoyageBrowserScn.jsp" %>  

</body>
</html>