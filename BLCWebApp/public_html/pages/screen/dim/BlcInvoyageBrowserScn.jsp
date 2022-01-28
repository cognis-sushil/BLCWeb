
<div id="invoyageBrowserLog" tabindex="-1" role="dialog"
	style="display:none;height: auto; width: auto; top: 20%; left: 10%;"
	class="ui-dialog ui-corner-all ui-widget ui-widget-content ui-front ui-dialog-buttons ui-draggable"
	aria-describedby="t99Lookup-dlg">
	<div
		class="ui-dialog-titlebar ui-corner-all ui-widget-header ui-helper-clearfix ui-draggable-handle">
		<span class="ui-dialog-title">Invoyage Browser</span>
		<button type="button"
			class="ui-button ui-corner-all ui-widget ui-button-icon-only ui-dialog-titlebar-close"
			title="Close" onclick="cancelBrowser()">
			<span class="ui-button-icon ui-icon ui-icon-closethick"></span> <span
				class="ui-button-icon-space"> </span>Close
		</button>
	</div>
	<div id="t78Lookup-dlg" class="ui-dialog-content ui-widget-content"
		style="width: auto; min-height: 63px; max-height: none; height: auto; overflow: hidden;">
		<div style="padding: 2px;">
			<B><p id="setPortVoyage"></p></B>
		</div>
		<div>
			<div id="t78HeaderRow" class="rcl-lkHeader">
				<p class="rcl-lkHeaderRow" style="width: 1080px;">
					<span class="rcl-lkHeaderCell" style="width: 3%;">No</span> <span
						class="rcl-lkHeaderCell" style="width: 5%;">Port</span> <span
						class="rcl-lkHeaderCell" style="width: 8%;">Terminal</span> <span
						class="rcl-lkHeaderCell" style="width: 10%;">In voyage</span> <span
						class="rcl-lkHeaderCell" style="width: 13%;">Exception In
						Voyage</span> <span class="rcl-lkHeaderCell" style="width: 8%;">Port
						Seq</span> <span class="rcl-lkHeaderCell " style="width: 10%;">Service</span>
					<span class="rcl-lkHeaderCell" style="width: 10%;">Vessel</span> <span
						class="rcl-lkHeaderCell" style="width: 10%;">Voyage</span> <span
						class="rcl-lkHeaderCell" style="width: 10%;">Direction</span> <span
						class="rcl-lkHeaderCell" style="width: 8%;">ETA</span>
						<span
						class="rcl-lkHeaderCell invoyageBrowserSelectAll" style="width: 5%;"> 
						
					</span>
				</p>
			</div>
			<div class="tblHeader">
				<rcl:area id="t78area" title="inVoyage Browser" collapsible='Y'
					areaMode="table" buttonList="select" onClickList="closeBrowser">
					<div class="row border"
						style="margin-right: 0px; margin-left: 0px; display: none;">
					</div>
					<div class="tblArea" style="margin-bottom: 10px; margin-top: -9px;overflow-y:hidden;overflow-x:hidden;">
						<div id="t78row" class="tblRow  row "
							style="padding-bottom: 0px; margin-bottom: -6px;">
							<div class="container-fluid" style="width: 1080px;">
								<div class="row gridRow selectData">
									<div style="width: 3%; border: #6A7896 1px solid;">
										<p id="t78seq" class="listsearch"></p>
									</div>
									<div style="width: 5%; border: #6A7896 1px solid;">
										<p id="t78port" class="listsearch"></p>
									</div>
									<div style="width: 8%; border: #6A7896 1px solid;">
										<p id="t78terminal" class="listsearch"></p>
									</div>
									<div style="width: 10%; border: #6A7896 1px solid;">
										<p id="t78invoyageBrowser" class="listsearch"></p>
									</div>
									<div style="width: 13%; border: #6A7896 1px solid;">
										<p id="t78exptInvoyage" class="listsearch"></p>
									</div>
									<div style="width: 8%; border: #6A7896 1px solid;">
										<p id="t78portSeq" class="listsearch ml-3"></p>
									</div>
									<div style="width: 10%; border: #6A7896 1px solid;">
										<p id="t78service" class="listsearch"></p>
									</div>
									<div style="width: 10%; border: #6A7896 1px solid;">
										<p id="t78vessel" class="listsearch"></p>
									</div>
									<div style="width: 10%; border: #6A7896 1px solid;">
										<p id="t78voyage" class="listsearch"></p>
									</div>
									<div style="width: 10%; border: #6A7896 1px solid;">
										<p id="t78directionAsString" class="listsearch"></p>
									</div>
									<div style="width: 8%; border: #6A7896 1px solid;">
										<p id="t78eta" class="listsearch"></p>
									</div>
									<div style="width: 5%; height: -1%; border: #6A7896 1px solid;" class="t78SELECTBOX">
										
									</div>
								</div>
							</div>
						</div>
					</div>
					<div id="t78paging" class="container-fluid pl-0 pr-0"
						style="margin-bottom: 5px;" data-pageSize="10"></div>

				</rcl:area>
			</div>
		</div>
	</div>
</div>
<script>
	var isVoyageBrowserClick=false;
	var getRowBrowser = [];
	var inVoyageResponse=[];
	
	function getVoyageServcieVessleVoyage(){		
		inVoyageBrowserService = "";
		inVoyageBrowserVessel = "";
		inVoyageBrowserVoyage = "";
		inVoyageBrowserDirection="";
		var service="";
    	var vessel="";
    	var voyage="";
    	var direction="";
		if(getRowBrowser.length){
	    	 for(var i=0;i<getRowBrowser.length;i++){
	    		 	var index = parseInt(getRowBrowser[i]);
	    		 	index--;
	    		 	if(i==0){
	    		 		service=inVoyageResponse[index].service;
	    		 		vessel=inVoyageResponse[index].vessel;
	    		 		voyage=inVoyageResponse[index].voyage;
	    		 		direction=inVoyageResponse[index].direction;
	    		 	}else{
	    		 	
	    		 		service+=","+inVoyageResponse[index].service;
	    		 		vessel+=","+inVoyageResponse[index].vessel;
	    		 		voyage+=","+inVoyageResponse[index].voyage;
	    		 		direction+=","+inVoyageResponse[index].direction;
	    		 	}   	
	    	inVoyageBrowserService=service;
	    	inVoyageBrowserVessel=vessel;
	    	inVoyageBrowserVoyage=voyage;
	    	inVoyageBrowserDirection=direction;
	    	
	    	  
	    	 }
	   	 } 
	   
	     
	}
	$(document).ready(function() {
		
		$('.listsearch').addClass('rcl-standard-form-control rcl-standard-textbox rcl-standard-font tblField');
	});

	function onVoyageBrowser() {
		var invoyage = $("#s0-inVoyage").val();
		if (invoyage == '') {
			rutOpenMessageBox("Warning", "*In voyage# is mandatory", null,null, '');
		} else {
			var port = $("#s0-port").val();
			var etaForSgsin = $("#s0-etaForSgsin").val();
			$("body").append('<div class="loading"></div>');
			var searchData = {
				"port" : port,
				"invoyageBrowser" : invoyage,
				"etaForSgsin" : etaForSgsin
			};
			if(isVoyageBrowserClick==false){				
				$(".t78SELECTBOX").html('<input id="t78SELECTBOX" type="checkbox" value="N" style="width: 19px; margin-top: 2px; position: absolute;" onclick="unCheckBrowser()">');
				$(".invoyageBrowserSelectAll").html('<input class="tblField" type="checkbox" style="position: absolute; margin-top: 2px;" id="t78select-all" onclick="checkAllBrowser()">');
			 	rptTableInit("t78area");
			 	
			}
			isVoyageBrowserClick = true;
			sendPostRequest("rclws/blcInvoyageBrowser/search",searchData,
					function(response) {
						inVoyageResponse = response;
						$("body").find('.loading').remove();						
						if (response) {
							$("#setPortVoyage").html("Port :" + port + "<br />  In voyage :"+ invoyage);
							$("#invoyageBrowserLog").show();
							$("#t78areaHeader").hide();
							rptClearDisplay("t78area");
							rptAddData("t78area", response);
							rptDisplayTable("t78area");
							var ofPageBrowser = $('#t78pgIndicator').val().split(' ')[3];
							if (ofPageBrowser > 6) {
								ofPageBrowser = 7;
							}
							for (let i = 0; i < ofPageBrowser; i++) {
								if (i == 0) {
									var element = document.getElementById("t78pgPrevious");
									element.setAttribute('onclick',"rptGotoPage('t78area','previous');unCheckAllBrowser();");
									var element = document.getElementById("t78pgFirst");
									element.setAttribute('onclick',"rptGotoPage('t78area','first');unCheckAllBrowser();");
								} else if (i == (ofPageBrowser - 1)) {
									var element = document.getElementById("t78pgNext");
									element.setAttribute('onclick',	"rptGotoPage('t78area','next');unCheckAllBrowser();");
									var element = document.getElementById("t78pgLast");
									element.setAttribute('onclick',"rptGotoPage('t78area','last');unCheckAllBrowser();");

								} else {
									var element = document.getElementById("t78pg" + i);
									element.setAttribute('onclick',
											"rptGotoPage('t78area'," + i+ ");unCheckAllBrowser();");
								}
							}
							unCheckAllBrowser();

						} else {
							rutOpenMessageBox("Warning",
									response.resultMessage, null, null, '');
						}

					})
		}
	}
	
	function unCheckBrowser() {
		if (document.getElementById("t78select-all").checked == true) {
			getRowBrowser = [];
		}
		var data = rptGetDataFromDisplayAll("t78area");
		var check = true;
		var page = $('#t78pgIndicator').val().split(' ')[1];
		for (let i = 0; i < data.length; i++) {
			var checkBox = document.getElementById("t78SELECTBOX-"
					+ ((10 * (page - 1)) + i));
			var checkPutBrowser = getRowBrowser.indexOf(data[i].seq);
			if (checkBox.checked == false) {
				check = false;
				if (getRowBrowser.length != 0) {
					if (checkPutBrowser >= 0) {
						getRowBrowser.splice(getRowBrowser
								.indexOf(data[i].seq), 1);
					}
				}
			} else {
				if (getRowBrowser.length == 0) {
					getRowBrowser.push(data[i].seq);
				} else if (checkPutBrowser < 0) {
					getRowBrowser.push(data[i].seq);
				}
			}
		}
		//console.log("ROW : "+getRowBrowser);
		if (getRowBrowser.length > 10) {
			rutOpenMessageBox("Warning",
					"* Can not select Invoyage greater than or equal to 10",
					null, null, '');
			document.getElementById("t78SELECTBOX-" + (getRowBrowser[10] - 1)).checked = false;
			getRowBrowser.splice(getRowBrowser.indexOf(getRowBrowser[11]), 1);
			check = false;
		}
		document.getElementById("t78select-all").checked = check;
	}
	
	function checkAllBrowser() {
		getRowBrowser = [];
		var data = rptGetDataFromDisplayAll("t78area");
		var checkBox = document.getElementById("t78select-all");
		var page = $('#t78pgIndicator').val().split(' ')[1];
		//console.log("length : "+ data.length);
		if (checkBox.checked == true) {
			for (let i = 0; i < data.length; i++) {
				document.getElementById("t78SELECTBOX-"
						+ ((10 * (page - 1)) + i)).checked = true;
				var text = $("#t78seq-" + ((10 * (page - 1)) + i)).text();
				getRowBrowser.push(text);
			}
		} else {
			for (let i = 0; i < data.length; i++) {
				document.getElementById("t78SELECTBOX-"
						+ ((10 * (page - 1)) + i)).checked = false;

			}

		}
	}

	function unCheckAllBrowser() {
		//Renumber the page buttons
		var data = rptGetDataFromDisplayAll("t78area");
		var defaultPage = false;
		var page = $('#t78pgIndicator').val().split(' ')[1];
		var to = $('#t78pgIndicator').val().split(' ')[3];

		var basePage = (Math.floor((page - 2) / 4) * 4) + 1;
		if (to > 6) {
			if (basePage < 5) {
				basePage = 1;
			}
		} else {
			basePage = 1;
		}
		for (let i = 1; i < 6; i++) {
			var element = document.getElementById("t78pg" + i);
			element.setAttribute('onclick', "rptGotoPage('t78area',"
					+ ((basePage - 1) + i) + ");unCheckAllBrowser();");

		}
		for (let i = 0; i < data.length; i++) {
			var text = $("#t78seq-" + ((10 * (page - 1)) + i)).text();
			for (let x = 0; x < getRowBrowser.length; x++) {
				if (getRowBrowser[x] == text) {
					document.getElementById("t78SELECTBOX-"
							+ ((10 * (page - 1)) + i)).checked = true;
				}
			}

		}
		var getRowBrowserCheck = [];
		for (let x = 0; x < getRowBrowser.length; x++) {
			getRowBrowserCheck.push(getRowBrowser[x]);
		}
		//console.log("getRowBrowser.length : "+ getRowBrowser.length);
		if (getRowBrowserCheck.length == data.length) {
			for (let i = (page - 1) * 10; i < (page * 10); i++) {
				for (let x = 0; x < getRowBrowserCheck.length; x++) {
					if (getRowBrowserCheck[x] == (i + 1)) {
						getRowBrowserCheck.splice(getRowBrowserCheck
								.indexOf(getRowBrowserCheck[x]), 1);
					}
				}
			}
			//console.log("getRowBrowserCheck.length : "+ getRowBrowserCheck.length);
			if (getRowBrowserCheck.length == 0) {
				defaultPage = true;
			}

		}

		document.getElementById("t78select-all").checked = defaultPage;
	}
	function closeBrowser() {
		if(getRowBrowser.length==0){
			rutOpenMessageBox("Warning",
					"* At least one select checkbox should be checked ",
					null, null, '');	
			return ;
		}
		$("#invoyageBrowserLog").hide();
	}
	function cancelBrowser(){
		getRowBrowser=[];
		$("#invoyageBrowserLog").hide();
		
	}
	
	
	
	function dragElement(elmnt) {
	  var pos1 = 0, pos2 = 0, pos3 = 0, pos4 = 0;
	  if (document.getElementById(elmnt.id + "header")) {
	    // if present, the header is where you move the DIV from:
	    document.getElementById(elmnt.id + "header").onmousedown = dragMouseDown;
	  } else {
	    // otherwise, move the DIV from anywhere inside the DIV:
	    elmnt.onmousedown = dragMouseDown;
	  }

	  function dragMouseDown(e) {
	    e = e || window.event;
	    e.preventDefault();
	    // get the mouse cursor position at startup:
	    pos3 = e.clientX;
	    pos4 = e.clientY;
	    document.onmouseup = closeDragElement;
	    // call a function whenever the cursor moves:
	    document.onmousemove = elementDrag;
	  }

	  function elementDrag(e) {
	    e = e || window.event;
	    e.preventDefault();
	    // calculate the new cursor position:
	    pos1 = pos3 - e.clientX;
	    pos2 = pos4 - e.clientY;
	    pos3 = e.clientX;
	    pos4 = e.clientY;
	    // set the element's new position:
	    elmnt.style.top = (elmnt.offsetTop - pos2) + "px";
	    elmnt.style.left = (elmnt.offsetLeft - pos1) + "px";
	  }

	  function closeDragElement() {
	    // stop moving when mouse button is released:
	    document.onmouseup = null;
	    document.onmousemove = null;
	  }
	}
	dragElement(document.getElementById("invoyageBrowserLog"));

</script>