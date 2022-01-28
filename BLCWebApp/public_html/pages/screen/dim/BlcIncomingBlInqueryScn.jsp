<!--
-----------------------------------------------------------------------------------------------------------
BlcIncomingBlInqueryScn.jsp
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
      <title>Incoming B/L Inquiry </title>
  
   </head>
   <body id="dim206">
   <style type="text/css">
   	
 
   </style>
     <jsp:include page='../../include/header.jsp'>
		<jsp:param name="pageHeader" value="Incoming B/L Inquiry" />
	</jsp:include>
      
      
      <form id="blInquery">
         <rcl:area id="s0-header" title="Search" areaMode="search"  collapsible="true" >
            <!--start container -->
            <div class="container-fluid">
            <div class="row">
               <!--start row 1 -->
                
                 <jsp:include page="../../include/commonLookUp.jsp">
                 	 <jsp:param value="req" name="req"/> 
                 </jsp:include>
                                  	
                 
                 <rcl:select id="s0-direction" label="Direction" classes="div(col-2) ctr(dtlField)" selectTable="Direction" emptyDisplay="All"/>
            	 <rcl:text id="s0-pol" label="POL" classes="div(col-2)" check="upc len(5)" lookup="tbl(VRL_PORT) rco(CODE NAME) rid(s0-pol) sco(CODE) sva(s0-pol) sop(LIKE)" 
               iconClick="rutLookupByKey('VRL_PORT','CODE NAME','s0-pol','CODE','s0-pol','LIKE','s0-pol');">
               </rcl:text>
               <rcl:text id="s0-pod" label="POD" classes="div(col-2)" check="upc len(5)" lookup="tbl(VRL_PORT) rco(CODE NAME) rid(s0-pod) sco(CODE) sva(s0-pod) sop(LIKE)" 
               iconClick="rutLookupByKey('VRL_PORT','CODE NAME','s0-pod','CODE','s0-pod','LIKE','s0-pod');">
             </rcl:text>
              
            </div>
            <div class="row">
               <rcl:date id="s0-etd" label="ETD" classes="div(col-2)"></rcl:date>
               <rcl:date id="s0-eta" label="ETA" classes="div(col-2)"></rcl:date>
            </div>
            <!-- end row1 -->
            <div class="row">
               <!--start row 2 -->
            </div>
            <!-- end row2 -->
            </div>
            <!-- end container  -->
         </rcl:area>
      </form>
      <!-- end search area -->
      <div class="tblHeader">
         <rcl:area id="t0-area" title="B/L Inquiry List" classes="div(container-fluid pl-1 pr-1)"  areaMode="table" collapsible="true">
            <div class="row border">
               <!--start container -->
               <div class="col-1 text-center " style="font-weight: bold;">No</div>
               <div class="col-1" style="font-weight: bold;">Service</div>
               <div class="col-1" style="font-weight: bold;">Vessel</div>
               <div class="col-1" style="font-weight: bold;">Voyage</div>
               <div class="col-1" style="font-weight: bold;">Direction</div>
               <div class="col-1" style="font-weight: bold;">POL</div>
               <div class="col-1" style="font-weight: bold;">POT</div>
               <div class="col-1x25" style="font-weight: bold;">ETD</div>
               <div class="col-1x25" style="font-weight: bold;">ETA</div>
               <div class="col-1" style="font-weight: bold;">POD</div>
               <div  style="font-weight: bold;"># of Incoming B/Ls</div>
            </div>
            <div class='tblArea tblAreaPadding' style="overflow-x: hidden;overflow-y: scroll;max-height: 50vh;"> 
               <div id="t0-row" class="tblRow  row">
                  <div class="container-fluid">
                     <div class="row gridRow selectData">
                     <div class=" col-1 ml-1 text-center">
                           <p id="t0-seq"  class="listsearch" > </p>
                        </div>
                        <div class=" col-1">
                           <p id="t0-service"  class="listsearch" > </p>
                        </div>
                        <div class=" col-1">
                           <p  id="t0-vessel"   class="listsearch" > </p>
                        </div>
                        <div class=" col-1">
                           <p id="t0-voyage" class="listsearch" > </p>
                        </div>
                        <div class=" col-1 ml-0">
                           <p id="t0-directionAsString"  class="listsearch" > </p>
                        </div>
                        <div class=" col-1 ml-0">
                           <p id="t0-pol" class="listsearch" > </p>
                        </div>
                        <div class=" col-1 ml-0">
                           <p id="t0-pot"  class="listsearch" > </p>
                        </div>
                        <div class=" col-1x25 ml-1">
                           <p id="t0-podEtd"  class="listsearch" > </p>
                        </div>
                        <div class=" col-1x25 ml-0">
                           <p id="t0-podEta" class="listsearch" > </p>
                        </div>
                        <div class=" col-1 ml-0">
                           <p  id="t0-pod" class="listsearch" > </p>
                        </div>
                        <div class="col-1 ml-1 text-right" >
                           <p id="t0-bls" class="listsearch mr-4" > </p>
                        </div>
                     </div>
                     <!-- end table row -->
                  </div>
               </div>
            </div>
            <!-- end container -->
           <div id="t0-paging" class="container-fluid pl-0 pr-0" data-pageSize="15" ></div>
         </rcl:area>
      </div>
      <!-- end table area -->
   </body>
   <script>
      
   $(document).ready(function() {

	    $('.listsearch').addClass('rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField')

	    rptTableInit('t0-area');
	    rut.packForRclServlet = false;
	});

	/**
	* This method is used to clear data 
	**/
	function reset() {
	    rptClearDisplay('t0-area');
	    rptAddData('t0-area', []);
	}

	/**
	* This method is used to search data base on user input data  
	**/

	function find() {
		
		 var searchData =  getDataAreaToObject("s0-header");
		 var pattern =/^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;
		 
		 var pattern =/^([0-9]{2})\/([0-9]{2})\/([0-9]{4})$/;
		 var searchData =  getDataAreaToObject("s0-header");
  		 if(searchData.eta!= '' && !pattern.test(searchData.eta)){
			rutOpenMessageBox("Warning", "Please Enter valid ETA Date",
            null, null);
			return;
		 }
		 
		 if(searchData.etd!= '' && !pattern.test(searchData.etd)){
			rutOpenMessageBox("Warning", "Please Enter valid  ETD Date",
            null, null);
			return;
		 }
		  
	    rptClearDisplay('t0-area');
	    rptAddData('t0-area', []);
	    if (((searchData.vessel == "") || (searchData.voyage == ""))&& (searchData.pol == "")&& (searchData.pod == "")&& (searchData.etd == "")&& (searchData.eta == "")) {
    		rutOpenMessageBox("Warning", "*Vessel and Voyage or POL or POD or ETA or ETD is mandatory",null, null);
        	}else{
	    sendPostRequest("rclws/blcIncomingBlInquery/search", searchData, function(data) {
	        console.log(data.length, "array");
	        rptAddData('t0-area', data);
	        rptDisplayTable('t0-area');
	    })
    
	} 
	}
</script>
</html>