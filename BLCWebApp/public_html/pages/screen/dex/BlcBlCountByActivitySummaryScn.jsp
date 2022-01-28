<!--
-----------------------------------------------------------------------------------------------------------
BlcCountByActivitySummaryScn.jsp
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
<head>

<title>B/L Count By Activity Summary</title>

</head>
<body id="dex201" >
	<jsp:include page='../../include/header.jsp'>
		<jsp:param name="pageHeader" value="B/L Count By Activity" />
	</jsp:include>

	<style type="text/css">
		.listsearch {
			margin-bottom: 0px;
			font-weight: 500;
			word-wrap: break-word;
		}

		 
</style>
	<form id="blCountActiveityForm">
		<rcl:area id="s0-header" title="Search" areaMode="search" collapsible="true" >
			<div class="row">
				<!--start row 1 -->
				
 				<jsp:include page="../../include/commonLookUp.jsp"></jsp:include>

				<rcl:select id="s0-direction" label="Direction"
					classes="div(col-2) ctr(dtlField)" selectTable="Direction" emptyDisplay="All"/>

				<rcl:text id="s0-pol" label="POL" classes="div(col-2)"
					check="upc len(5)"
					lookup="tbl(VRL_PORT) rco(CODE NAME) rid(s0-pol) sco(CODE) sva(s0-pol) sop(LIKE)"
					iconClick="rutLookupByKey('VRL_PORT','CODE NAME','s0-pol','CODE','s0-pol','LIKE','s0-pol');">
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

	</form>
	<!-- end search area -->

	
		<rcl:area id="t0-area" title="Summary" 	classes="div(container-fluid vertical__scroll )"  areaMode="table" collapsible="true" >
			<!--start container -->
			<div class="row border" >
			 <div id="t-t0-seq" class="col-0x75 text-center" 	style="font-weight: bold;">No</div>
				<div id="t-t0-noOfBL" class="col-0x75" 	style="font-weight: bold;">No.of B/L</div>
				<div id="t-t0-blType" class="col-1x25" style="font-weight: bold;">B/L Type#</div>
				<div id="t-noofconformbl" class="col-0x75 mr-5" style="font-weight: bold;">No of Confirmed B/L</div>
				<div id="t-noofprintedbl" class="col-0x75 mr-5" style="font-weight: bold; ">No of Printed B/L</div>
				<div id="t-noofmanifestedbl" class="col-1x25 mr-4" style="font-weight: bold; ">No of B/L(With generated invoices)</div>
				<div id="t-noofprintedinvoice" class="col-1x25 mr-4" style="font-weight: bold; ">No of B/L(With printed invoices)</div>
				<div id="t-noofmanifestedbl" class="col-1x25 mr-2" style="font-weight: bold; ">No of Manifested B/L</div>
				<div id="t-noofunreleasebl" class="col-1x25 mr-0" style="font-weight: bold; ">No of Unreleased B/L</div>
				<div id="t-noOfSpecialRelease" class="col-1x25" style="font-weight: bold;">No of Special Release</div>
			</div>
			<div class='tblArea tblAreaPadding' style="overflow-y:auto;">
				<div id="t0-row" class="tblRow  row pt-1 ">
					<div class="container-fluid">
						<div class="row gridRow selectData">

							<!-- start table row -->
							<div class="col-0x75 text-center" >
								<p id="t0-seq" class="listsearch"></p>
							</div>
							<div class="col-0x75 text-center">
								<p id="t0-noOfBL" class="listsearch blactivity"	 onclick="getInfo(1,this)"></p>
							</div>

							<div class="col-1x25">
								<p id="t0-blType" class="listsearch select" ></p>
							</div>
							<div class="col-0x75 text-right">
								<p id="t0-noOfConformBl" class="listsearch blactivity" onclick="getInfo(2,this)"></p>
							</div>
							<div class="col-0x75 ml-0 text-right">
								<p id="t0-noOfPrintedBl" class="listsearch blactivity mr-4" 	 onclick="getInfo(3,this)"></p>

							</div>
							<div class="col-1x25 ml-5 text-right">
								<p id="t0-noOfGenratedInvoices" class="listsearch blactivity"
									onclick="getInfo(4,this)" ></p>
							</div>
							<div class="col-1x5 ml-3 text-right">
								<p id="t0-noOfPrintedInvoice" class="listsearch blactivity"
									onclick="getInfo(5,this)" ></p>

							</div>
							<div class="col-1 ml-3 text-right">
								<p id="t0-noOfManifestedBl" class="listsearch blactivity" 	 onclick="getInfo(6,this)"></p>
							</div>
							<div class="col-1x25 ml-3 text-right ">
								<p id="t0-noOfUnreleaseBl" class="listsearch blactivity" 	 onclick="getInfo(7,this)"></p>
							</div>
							<div class="col-1x25 text-right">
								<p id="t0-noOfSpecialRelease" class="listsearch blactivity"  onclick="getInfo(8,this)"></p>
							</div>
						</div>
						<!-- end table row -->
					</div>
				</div>
			</div>
			<div id="t0-paging" class="container-fluid pl-0 pr-0"></div>
		</rcl:area>
	 
	<!-- end table area -->
	<script>
	function reset(){
	      rptClearDisplay('t0-area');
          rptAddData('t0-area', []);
          rut.packForRclServlet = false; //ensure that dialogFlow is not packed for servlet but for local use, this is required only, when you have no server
    
	}
	function getInfo(id,obj){
		var blType;
		debugger;
		if($(obj).html()!=0){
			var idOfCalledElement = obj.id;
            idOfCalledElement  =  idOfCalledElement[idOfCalledElement.length -1]
			$(".select").each(function() {
    	    	  var blId   = this.id;
    	    	   blId =   blId.substring(10, blId.length);
    	    		 if (blId == idOfCalledElement) {
    	    			 blType = $($(this).parent().parent().children()[2]).find("p").html();

    	    	}

    	    });
			
			var srv = $("#s0-service").val();
			var vsl = $("#s0-vessel").val();
			var vog = $("#s0-voyage").val();
			var dir = $("#s0-direction").val();
			var pol = $("#s0-pol").val();
			var etdFrom = $("#s0-etdFrom").val();
			var etdTo = $("#s0-etdTo").val();
			
			var dataPost = getDataAreaToObject("s0-header");
			dataPost["etdFrom"] = etdFrom;
			dataPost["etdTo"] = etdTo;
			dataPost["id"]=id;
			dataPost["blType"]=blType
			var href=  window.location.protocol+"//"+location.hostname+':'+window.location.port+"/BLCWebApp/RrcStandardSrv?service=ui.blc.dex.BlCountByActivityDetailSvc"
			console.log("href "+ href);
			var type = '2Tab';
			var rclp = new rutDialogFlow(type , href);
			rclp.packForRclServlet = true;
			rclp.addToField('trg' , 'variable' ,null , 'BlcBlCountByActivityDetail',
					'src','variable' , null , dataPost);
			rclp.openPage();
		}
	}

         $(document).ready(
             function() {
            	 $('.listsearch')
					.addClass(
							'rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField')
    
	             rptTableInit('t0-area');
     });
         
      function backProcessUrl(){
        		alert('back');
        }
         
	 function find() {
    	 validate();
     }
     

  	function validate() {
  		 
  		var msg = [];
  		var dataPost = getDataAreaToObject("s0-header");
  		
  		var StartDate = $("#s0-etdFrom").val();
  		var StartDateArr = StartDate.split("/");
  		var StartDateF = new Date(StartDateArr[2], StartDateArr[1],StartDateArr[0]);

  		var StopDate = $("#s0-etdTo").val();
  		var StopDateArr = StopDate.split("/");
  		var StopDateF = new Date(StopDateArr[2], StopDateArr[1],StopDateArr[0]);
  		
  		var diff =StopDateF -StartDateF;
		var divident= ( 24 * 60 * 60 * 1000);  //To convert date in days
		var days = diff /divident;
  			  if( ($("#s0-etdFrom").val() != "") && ($("#s0-etdTo").val() != "") ){
  				if (StopDateF < StartDateF){
  					msg.push("*B/L Creation Date To cannot be less than B/L Creation Date From <br>");
  					  }
  				
  				else if(!(0<=days  && days <=60)){
  					msg.push("*B/L Creation Date To cannot be exceed 60 days than B/L Creation Date From <br>");
  	  				}
				  
  			  }else if (  (dataPost.vessel == "" ) || (dataPost.voyage == "") ) {
  				msg.push("Either Vessel and Voyage is mandatory, or ETD Date range is mandatory");
  			
  			} 

  		 
  			if(msg.length != 0){
  				rutOpenMessageBox("Warning", msg.toString().replace(/,/g, ''), null, null, '');
  			}else{
  		
  				
  				 
  				 
  				rptClearDisplay('t0-area');
  	             rptAddData('t0-area', []);  	
  	             
  	            var etdFrom = $("#s0-etdFrom").val();
  				var etdTo = $("#s0-etdTo").val();
  				
  				var dataPost = getDataAreaToObject("s0-header");
  				dataPost["etdFrom"] = etdFrom;
  				dataPost["etdTo"] = etdTo;
  	             console.log(dataPost,"data")
  	             settingTable("t0-area");
  	             sendPostRequest("rclws/blCountByActivitySummary/search", dataPost,function(data) {
  	                     console.log(data.length, "array");
  	                     
  	                     rptAddData('t0-area', data);
  	                     rptDisplayTable('t0-area');
  	                     
  	                   $.each($(".blactivity"),function(index,obj)
 	                    		{
  	                	   console.log($(obj).html())
  	                	   if($(obj).html()==0){
  	                		 $(obj).removeClass("blactivity");
  	                	   }
 	                     // console.log(obj)
 	                       
 	                  }); 
  	                 })
  			}
  		}


         
         function settingTable(isvalue) {
         var settings = getTableSettings(isvalue);
         settings.paging.pageSize = 15;
         }

         
     </script>
</body>
</html>