/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.model.blc;
/* ----------------------------------- Change Log ----------------------------------
	##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    01/04/20           Sidhart              Initial Version
-----------------------------------------------------------------------------------
*/

import javax.xml.bind.annotation.XmlRootElement;

import com.rclgroup.dolphin.web.util.RutDate;

/**
 * Used to hold data of BlcArrivalNotice page.
 * @author Cognis Solution
 */
@XmlRootElement
public class ArrivalNoticeMod  extends BaseInputMod{
	private static final long serialVersionUID = 1L;
	private String searchBy;
	private String blNo;
	private String vessel;
	private String voyage;
	private String etaDate;
	private String inVoyage;
	private String etaPort;
	private String pod;
	private String socCoc;
	private String blid;
	private String bltype;
	private String creationoffice;
	private String sc;
	private String outstatus;
	private String instatus;
	private String eta;
	private String por;
	private String pol;
	private String pot;
	private String del;
	private String shiptype;
	private String printed;
	private String dateprinted;
	private String select;
	private String service;
    private String userID;
    private String direction;
    private String port;
    
	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getSearchBy() {
		return searchBy;
	}

	public void setSearchBy(String searchBy) {
		this.searchBy = searchBy;
	}

	

	public String getVessel() {
		return vessel;
	}

	public void setVessel(String vessel) {
		this.vessel = vessel;
	}

	public String getVoyage() {
		return voyage;
	}

	public void setVoyage(String voyage) {
		this.voyage = voyage;
	}

	public String getEtaDate() {
		return etaDate;
	}

	public void setEtaDate(String etaDate) {
		this.etaDate = etaDate;
	}

	public String getInVoyage() {
		return inVoyage;
	}

	public void setInVoyage(String inVoyage) {
		this.inVoyage = inVoyage;
	}

	public String getEtaPort() {
		return etaPort;
	}

	public void setEtaPort(String etaPort) {
		this.etaPort = etaPort;
	}

	public String getPod() {
		return pod;
	}

	public void setPod(String pod) {
		this.pod = pod;
	}

	public String getSocCoc() {
		//socCoc = Utils.getSOC(socCoc);
		return socCoc;
	}

	public void setSocCoc(String socCoc) {
		this.socCoc = socCoc;
	}

	public String getBlid() {
		return blid;
	}

	public void setBlid(String blid) {
		this.blid = blid;
	}

	public String getBltype() {
		return bltype;
	}

	public void setBltype(String bltype) {
		this.bltype = bltype;
	}

	public String getCreationoffice() {
		return creationoffice;
	}

	public void setCreationoffice(String creationoffice) {
		this.creationoffice = creationoffice;
	}

	public String getSc() {
		return sc;
	}

	public void setSc(String sc) {
		this.sc = sc;
	}

	public String getOutstatus() {
		return outstatus;
	}

	public void setOutstatus(String outstatus) {
		this.outstatus = outstatus;
	}

	public String getInstatus() {
		return instatus;
	}

	public void setInstatus(String instatus) {
		this.instatus = instatus;
	}

	public String getEta() {
		eta = RutDate.toDateFormatFromYYYYMMDD(eta);
		return eta;
	}

	public void setEta(String eta) {
		this.eta = eta;
	}

	public String getPor() {
		return por;
	}

	public void setPor(String por) {
		this.por = por;
	}

	public String getPol() {
		return pol;
	}

	public void setPol(String pol) {
		this.pol = pol;
	}

	public String getPot() {
		
		return pot;
	}

	public void setPot(String pot) {
		this.pot = pot;
	}

	public String getDel() {
		return del;
	}

	public void setDel(String del) {
		this.del = del;
	}

	public String getShiptype() {
		return shiptype;
	}

	public void setShiptype(String shiptype) {
		this.shiptype = shiptype;
	}

	public String getPrinted() {
		
		return printed;
	}

	public void setPrinted(String printed) {
		this.printed = printed;
	}

	public String getDateprinted() {
		dateprinted=	RutDate.toDateFormatFromYYYYMMDD(dateprinted);
		return dateprinted;
	}

	public void setDateprinted(String dateprinted) {
		this.dateprinted = dateprinted;
	}

	public String getSelect() {
		return select;
	}

	public void setSelect(String select) {
		this.select = select;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
	}

	public String getBlNo() {
		return blNo;
	}

	public void setBlNo(String blNo) {
		this.blNo = blNo;
	}
	

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}


	
	@Override
	public String toString() {
		return "ArrivalNoticeMod [searchBy=" + searchBy + ", blNo=" + blNo + ", vessel=" + vessel + ", voyage=" + voyage
				+ ", etaDate=" + etaDate + ", inVoyage=" + inVoyage + ", etaPort=" + etaPort + ", pod=" + pod
				+ ", socCoc=" + socCoc + ", blid=" + blid + ", bltype=" + bltype + ", creationoffice=" + creationoffice
				+ ", sc=" + sc + ", outstatus=" + outstatus + ", instatus=" + instatus + ", eta=" + eta + ", por=" + por
				+ ", pol=" + pol + ", pot=" + pot + ", del=" + del + ", shiptype=" + shiptype + ", printed=" + printed
				+ ", dateprinted=" + dateprinted + ", select=" + select + ", service=" + service + ", userID=" + userID
				+ "]";
	}

	

}
