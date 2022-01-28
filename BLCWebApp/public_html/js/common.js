
function getUserDataFromHeader(){
	var referrer = document.referrer;
	 
	return rptGetDataFromSingleArea("h3-hidden");
}

(function ($) {
	$.fn.serializeFormJSON = function () {

		var o = {};
		var a = this.serializeArray();
		$.each(a, function () {
			if (o[this.name]) {
				if (!o[this.name].push) {
					o[this.name] = [o[this.name]];
				}
				o[this.name].push(this.value || '');
			} else {
				o[this.name] = this.value || '';
			}
		});
		return o;
	};
})(jQuery);
/**
	Note this method is used to send ajax post request
	paramter : url menas url where user want to send request
	data     : data which user want to send to server 
*/
function sendPostRequest(url, data, sucessFunction, errorFunction) {
	url="/BLCWSWebApp/"+url;
	$( "body" ).append('<div class="loading"></div>');
	$("body").find('.loading').remove();
	$( "body" ).append('<div class="loading"></div>');
	data["browserData"]=getUserDataFromHeader();
	debugger;
	$.ajax({
		method: "POST",		
		async: true,
		cache: false,
		url: url,
		data: JSON.stringify(data),
		contentType: "application/json;",
		traditional: true,
		dataType: 'json',
		
		success: function (dataResponse) {
			$("body").find('.loading').remove();
			
			if(dataResponse.data.length !=0){
				if(dataResponse.status===true){
				sucessFunction.apply(this, [dataResponse.data]);
				}else{
					dialogFadeout("Internal Server Error");
				 }
			}else{
				rutOpenMessageBox("Warning", "No data found", null, null, '');
			}
			
		},
		error: function (error, textStatus, jqXHR) {
			//process error msg
			$("body").find('.loading').remove();
			handleAjaxError(error)
			//errorFunction.apply(this, [data]);
		},
	});

}
/**
	Note this method is used to send ajax get request
	paramter : url menas url where user want to send request
	data     : data which user want to send to server 
*/

function sendGetRequest(url, data, sucessFunction, errorFunction) {
	url="/BLCWSWebApp/"+url;
	data["browserData"]=getUserDataFromHeader();
	$( "body" ).append('<div class="loading"></div>');
	$("body").find('.loading').remove();
	$( "body" ).append('<div class="loading"></div>');
	$.ajax({
		method: "GET",
		url: url,
		data: data,
		contentType: "application/json;",
		traditional: true,
		dataType: 'json',
		success: function (data) {
			$("body").find('.loading').remove();
			sucessFunction.apply(this, [data]);
		},
		error: function (error, textStatus, jqXHR) {
			 
			$("body").find('.loading').remove();
			handleAjaxError(error)
			//errorFunction.apply(this, [data]);
		}
	});

}


  

function GetURLParameter(sParam) {
	var sPageURL = window.location.search.substring(1);
	var sURLVariables = sPageURL.split('&');
	for (var i = 0; i < sURLVariables.length;i++) {
		var sParameterName = sURLVariables[i].split('=');
		if (sParameterName[0] == sParam) {
			return decodeURIComponent(sParameterName[1]);
		}
	}
}
  
function closeWindow(){
	window.location.href="logout.do";
}
 

function formateNumber(grandTotal){
	if(grandTotal){
	return (grandTotal).toFixed(2).replace(/\d(?=(\d{3})+\.)/g, '$&,');
	}else {
	return "";
	}
	}

	 
 
	
	function handleAjaxError(error){
		console.log()
		if(error.statusText =="Internal Server Error"){
			dialogFadeout("Internal Server Error");
		}
		else
		{
			if(error.responseText){
				dialogFadeout(error.responseText);
			}
		}
	    return { $_success: false };
	}
	
	
	
	 function lookupSerVesVoy(){
			var rowData = rptGetDataFromSingleArea("s0-header");
			var rco = "SERVICE VESSEL VOYAGE HIDE_DIRECTION";
			var rid = "s0-service s0-vessel s0-voyage s0-direction";
			var sco = "SERVICE VESSEL VOYAGE";
			var sva = "s0-service s0-vessel s0-voyage";
			var sop = "LIKE";
	
			
			rutOpenLookupTable('VRL_BKG_BOOKING_CTR_SERV', rco, rid, sco.trim(), sva.trim(), sop.trim(), "Service/Vessel/Voyage/Direction Lookup");
		}
	 
	 function onClickClose(){
		// alert("close");
		 window.close();
		}
      
	 function removeEmtryOptions(elementId) {
			var x = document.getElementById(elementId);
			x.remove(0);
		} 
	 
	 
	 function lookupBl(){
			var rowData = rptGetDataFromSingleArea("s0-header");
				var rco = "BL_NO";
				var rid = "s0-blNo";
				var sco = "";
				var sva = "";
				var sop = "";
				var getstrAter = "";
				console.log(rowData.blNo.length);

				if (rowData.blNo.trim() != "") {
					if (rowData.blNo.length >= 13 && rowData.blNo.length <= 17) {
						sco += " BL_NO";
						sva += "s0-blNo";
						sop += " = ";
						console.log("inside length");
						console.log("SVA = " + sva);
					} else {
						getstrAter = "*Bl Number should be between 13 to 17";
					}
				} else {
					sco += " HIDE_ISSUE_DATE";
					sva += "'" + rutGetDate('today', -180, 'num') + "'";
					sop = " >";
					console.log("inside date");
				}

				if (getstrAter != "") {
					dialogGeneric("Warning", getstrAter, "Ok");
				} else {
					rutOpenLookupTable('VRL_BL', rco, rid, sco.trim(), sva, sop
							.trim(), "BL Lookup");
				}
			}


	 
	 function lookupInVoyage(){
			var rowData = rptGetDataFromSingleArea("s0-header");
				var rco = "IN_VOYAGE ETA_DATE";
				var rid = "s0-inVoyage s0-etaForSgsin";
				var sco = "";
				var sva = "";
				var sop = "";
				var getstrAter = "";
				console.log(rowData.inVoyage.length);

				if (rowData.inVoyage.trim() != "") {
					if (rowData.inVoyage.length <= 10) {
						sco += " IN_VOYAGE";
						sva += "s0-inVoyage";
						sop += " LIKE";
						console.log("inside length");
						console.log("SVA = " + sva);
					} 
				} else {
					sco += " ETA_DATE";
					sva += "'" + rutGetDate('today', -540, 'num') + "'";
					sop = " >";
					console.log("inside date");
				}

				if (getstrAter != "") {
					dialogGeneric("Warning", getstrAter, "Ok");
				} else {
					rutOpenLookupTable('VRL_BL_INVOYAGE', rco, rid, sco.trim(), sva, sop
							.trim(), "InVoyage  Lookup");
				}
			}

	 
	 function lookupVessel(){
			var rowData = rptGetDataFromSingleArea("s0-header");
				var rco = "SERVICE VESSEL VOYAGE HIDE_DIRECTION";
				var rid = "s0-service s0-vessel s0-voyage s0-direction";
				var sco = "";
				var sva = "";
				var sop = "";
				var getstrAter = "";
				//console.log(rowData.blNo.length);

				if (rowData.vessel.trim() != "") {
					
						sco += "VESSEL";
						sva += "s0-vessel";
						sop += "  LIKE";
						
						
						if (rowData.voyage) {
							
							sco += " VOYAGE";
							sva += " s0-voyage";
							sop += " LIKE";
							
						}
							
							if(rowData.service){
								sco += " SERVICE";
								sva += " s0-service";
								sop += " LIKE";
							}
					
				} else {
					sco += "HIDE_ETA_DATE";
					sva += "'" + rutGetDate('today', -540, 'num') + "'";
					sop = " >";
					console.log("inside date");
				}

				if (getstrAter != "") {
					dialogGeneric("Warning", getstrAter, "Ok");
				} else {
					
					console.log("rco  " +rco);	
					console.log("rid  " +rid);
					console.log("sco.trim()  " +sco.trim());
					console.log("sva  " +sva);
					console.log("sop.trim()  " +sop.trim());
					rutOpenLookupTable('VRL_BL_VESSEL_SCHEDULE_ALL', rco, rid, sco.trim(), sva, sop.trim(), "Service/Vessel/Voyage/Direction Lookup");
				}
			}

	 function lookupVoyage(){
			var rowData = rptGetDataFromSingleArea("s0-header");
				var rco = "SERVICE VESSEL VOYAGE HIDE_DIRECTION";
				var rid = "s0-service s0-vessel s0-voyage s0-direction";
				var sco = "";
				var sva = "";
				var sop = "";
				var getstrAter = "";
				//console.log(rowData.blNo.length);

				if (rowData.voyage.trim() != "") {
					
						sco += " VOYAGE";
						sva += "s0-voyage";
						sop += " LIKE";
						
						
						if(rowData.vessel){
							sco += " VESSEL";
							sva += " s0-vessel";
							sop += " LIKE";
						}
						if(rowData.service){
							sco += " SERVICE";
							sva += " s0-service";
							sop += " LIKE";
						}
					
				} else {
					sco += "HIDE_ETA_DATE";
					sva += "'" + rutGetDate('today', -540, 'num') + "'";
					sop = " >";
					console.log("inside date");
				}

				if (getstrAter != "") {
					dialogGeneric("Warning", getstrAter, "Ok");
				} else {
					rutOpenLookupTable('VRL_BL_VESSEL_SCHEDULE_ALL', rco, rid, sco.trim(), sva, sop.trim(), "Service/Vessel/Voyage/Direction Lookup");
					
				}
			}
	 
	 function lookupService(){
			var rowData = rptGetDataFromSingleArea("s0-header");
				var rco = "SERVICE VESSEL VOYAGE HIDE_DIRECTION";
				var rid = "s0-service s0-vessel s0-voyage s0-direction";
				var sco = "";
				var sva = "";
				var sop = "";
				var getstrAter = "";
				//console.log(rowData.blNo.length);

				if (rowData.service.trim() != "") {
					
						sco += "SERVICE";
						sva += "s0-service";
						sop += " LIKE";
						
						if (rowData.voyage) {
							
							sco += " VOYAGE";
							sva += " s0-voyage";
							sop += " LIKE";
							
						}	
							if(rowData.vessel){
								sco += " VESSEL";
								sva += " s0-vessel";
								sop += " LIKE";
							}
					
				} else {
					sco += "HIDE_ETA_DATE";
					sva += "'" + rutGetDate('today', -540, 'num') + "'";
					sop = " >";
					console.log("inside date");
				}

				if (getstrAter != "") {
					dialogGeneric("Warning", getstrAter, "Ok");
				} else {
					rutOpenLookupTable('VRL_BL_VESSEL_SCHEDULE_ALL', rco, rid, sco.trim(), sva, sop.trim(), "Service/Vessel/Voyage/Direction Lookup");
				}
			}
	 
	 
	 $(document).ready(function(){
		 $( "body" ).append('<div class="loading"></div>'); 
		
		 $("body").find('.loading').remove();
	 
	 });
      
	 
	 
	 /*
	     * Date Format 1.2.3
	     * (c) 2007-2009 Steven Levithan <stevenlevithan.com>
	     * MIT license
	     *
	     * Includes enhancements by Scott Trenda <scott.trenda.net>
	     * and Kris Kowal <cixar.com/~kris.kowal/>
	     *
	     * Accepts a date, a mask, or a date and a mask.
	     * Returns a formatted version of the given date.
	     * The date defaults to the current date/time.
	     * The mask defaults to dateFormat.masks.default.
	     */

	    var dateFormat = function () {
	        var    token = /d{1,4}|m{1,4}|yy(?:yy)?|([HhMsTt])\1?|[LloSZ]|"[^"]*"|'[^']*'/g,
	            timezone = /\b(?:[PMCEA][SDP]T|(?:Pacific|Mountain|Central|Eastern|Atlantic) (?:Standard|Daylight|Prevailing) Time|(?:GMT|UTC)(?:[-+]\d{4})?)\b/g,
	            timezoneClip = /[^-+\dA-Z]/g,
	            pad = function (val, len) {
	                val = String(val);
	                len = len || 2;
	                while (val.length < len) val = "0" + val;
	                return val;
	            };
	    
	        // Regexes and supporting functions are cached through closure
	        return function (date, mask, utc) {
	            var dF = dateFormat;
	    
	            // You can't provide utc if you skip other args (use the "UTC:" mask prefix)
	            if (arguments.length == 1 && Object.prototype.toString.call(date) == "[object String]" && !/\d/.test(date)) {
	                mask = date;
	                date = undefined;
	            }
	    
	            // Passing date through Date applies Date.parse, if necessary
	            date = date ? new Date(date) : new Date;
	            if (isNaN(date)) throw SyntaxError("invalid date");
	    
	            mask = String(dF.masks[mask] || mask || dF.masks["default"]);
	    
	            // Allow setting the utc argument via the mask
	            if (mask.slice(0, 4) == "UTC:") {
	                mask = mask.slice(4);
	                utc = true;
	            }
	    
	            var    _ = utc ? "getUTC" : "get",
	                d = date[_ + "Date"](),
	                D = date[_ + "Day"](),
	                m = date[_ + "Month"](),
	                y = date[_ + "FullYear"](),
	                H = date[_ + "Hours"](),
	                M = date[_ + "Minutes"](),
	                s = date[_ + "Seconds"](),
	                L = date[_ + "Milliseconds"](),
	                o = utc ? 0 : date.getTimezoneOffset(),
	                flags = {
	                    d:    d,
	                    dd:   pad(d),
	                    ddd:  dF.i18n.dayNames[D],
	                    dddd: dF.i18n.dayNames[D + 7],
	                    m:    m + 1,
	                    mm:   pad(m + 1),
	                    mmm:  dF.i18n.monthNames[m],
	                    mmmm: dF.i18n.monthNames[m + 12],
	                    yy:   String(y).slice(2),
	                    yyyy: y,
	                    h:    H % 12 || 12,
	                    hh:   pad(H % 12 || 12),
	                    H:    H,
	                    HH:   pad(H),
	                    M:    M,
	                    MM:   pad(M),
	                    s:    s,
	                    ss:   pad(s),
	                    l:    pad(L, 3),
	                    L:    pad(L > 99 ? Math.round(L / 10) : L),
	                    t:    H < 12 ? "a"  : "p",
	                    tt:   H < 12 ? "am" : "pm",
	                    T:    H < 12 ? "A"  : "P",
	                    TT:   H < 12 ? "AM" : "PM",
	                    Z:    utc ? "UTC" : (String(date).match(timezone) || [""]).pop().replace(timezoneClip, ""),
	                    o:    (o > 0 ? "-" : "+") + pad(Math.floor(Math.abs(o) / 60) * 100 + Math.abs(o) % 60, 4),
	                    S:    ["th", "st", "nd", "rd"][d % 10 > 3 ? 0 : (d % 100 - d % 10 != 10) * d % 10]
	                };
	    
	            return mask.replace(token, function ($0) {
	                return $0 in flags ? flags[$0] : $0.slice(1, $0.length - 1);
	            });
	        };
	    }();
	    
	    // Some common format strings
	    dateFormat.masks = {
	        "default":      "ddd mmm dd yyyy HH:MM:ss",
	        shortDate:      "m/d/yy",
	        mediumDate:     "mmm d, yyyy",
	        longDate:       "mmmm d, yyyy",
	        fullDate:       "dddd, mmmm d, yyyy",
	        shortTime:      "h:MM TT",
	        mediumTime:     "h:MM:ss TT",
	        longTime:       "h:MM:ss TT Z",
	        isoDate:        "yyyy-mm-dd",
	        isoTime:        "HH:MM:ss",
	        isoDateTime:    "yyyy-mm-dd'T'HH:MM:ss",
	        isoUtcDateTime: "UTC:yyyy-mm-dd'T'HH:MM:ss'Z'"
	    };
	    
	    // Internationalization strings
	    dateFormat.i18n = {
	        dayNames: [
	            "Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat",
	            "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"
	        ],
	        monthNames: [
	            "Jan", "Feb", "Mar", "Apr", "May", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec",
	            "January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"
	        ]
	    };
	    
	    // For convenience...
	    Date.prototype.format = function (mask, utc) {
	        return dateFormat(this, mask, utc);
	    };




