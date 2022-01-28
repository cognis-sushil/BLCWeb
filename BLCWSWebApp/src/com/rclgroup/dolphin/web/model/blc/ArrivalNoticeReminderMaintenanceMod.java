/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.model.blc;
/* --------------------Change Log ------------------------------------------------
	##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    01/04/20           Sushil            Initial Version
----------------------------------------------------------------------------------
*/

import javax.xml.bind.annotation.XmlRootElement;

import com.rclgroup.dolphin.web.util.RutDate;
import com.rclgroup.dolphin.web.utils.blc.Utils;

/**
 * Used to hold data of BlcArrivalNoticeReminderMaintenance page.
 * 
 * @author Cognis Solution
 */
@XmlRootElement
public class ArrivalNoticeReminderMaintenanceMod extends BaseInputMod {
	private static final long serialVersionUID = 1L;
	private String blNo;
	private String opCode;
	private String socCoc;
	private String userID;
	private String searchBy;
	private String service;
	private String vessel;
	private String voyage;
	private String inVoyage;
	private String etaSgsin;
	private String etaForSgsin;
	private String direction;
	private String directionAsString;
	private String pol;
	private String pot;
	private String podEtd;
	private String polEtd;
	private String podEta;
	private String pod;
	private String issueOffice;
	private String numberOfTimeArravalPrinted;
	private String lastDateArrivalPrinted;
	private String forFsc;
	private String principalCode;
	private String inStatus;

	public String getIssueOffice() {
		return issueOffice;
	}

	public void setIssueOffice(String issueOffice) {
		this.issueOffice = issueOffice;
	}

	public String getNumberOfTimeArravalPrinted() {
		return numberOfTimeArravalPrinted;
	}

	public void setNumberOfTimeArravalPrinted(String numberOfTimeArravalPrinted) {
		this.numberOfTimeArravalPrinted = numberOfTimeArravalPrinted;
	}

	public String getLastDateArrivalPrinted() {
		lastDateArrivalPrinted = RutDate.toDateFormatFromYYYYMMDD(lastDateArrivalPrinted);
		return lastDateArrivalPrinted;
	}

	public void setLastDateArrivalPrinted(String lastDateArrivalPrinted) {
		this.lastDateArrivalPrinted = lastDateArrivalPrinted;
	}

	public String getOpCode() {
		return opCode;
	}

	public void setOpCode(String opCode) {
		this.opCode = opCode;
	}

	public String getSocCoc() {
		// socCoc = Utils.getSOC(socCoc);
		return socCoc;
	}

	public void setSocCoc(String socCoc) {
		this.socCoc = socCoc;
	}

	public String getDirection() {
		return direction;
	}

	public void setDirection(String direction) {
		this.direction = direction;
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

	public String getPodEtd() {
		return podEtd;
	}

	public void setPodEtd(String podEtd) {
		this.podEtd = podEtd;
	}

	public String getPolEtd() {
		polEtd = RutDate.toDateFormatFromYYYYMMDD(polEtd);
		return polEtd;
	}

	public void setPolEtd(String polEtd) {
		this.polEtd = polEtd;
	}

	public String getPodEta() {
		podEta = RutDate.toDateFormatFromYYYYMMDD(podEta);
		return podEta;
	}

	public void setPodEta(String podEta) {
		this.podEta = podEta;
	}

	public String getPod() {
		return pod;
	}

	public void setPod(String pod) {
		this.pod = pod;
	}

	public String getBlNo() {
		return blNo;
	}

	public void setBlNo(String bls) {
		this.blNo = bls;
	}

	public String getSearchBy() {
		return searchBy;
	}

	public void setSearchBy(String searchBy) {
		this.searchBy = searchBy;
	}

	public String getService() {
		return service;
	}

	public void setService(String service) {
		this.service = service;
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

	public String getInVoyage() {
		return inVoyage;
	}

	public void setInVoyage(String inVoyage) {
		this.inVoyage = inVoyage;
	}

	public String getEtaSgsin() {
		return etaSgsin;
	}

	public void setEtaSgsin(String etaSgsin) {
		this.etaSgsin = etaSgsin;
	}

	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getEtaForSgsin() {
		return etaForSgsin;
	}

	public void setEtaForSgsin(String etaForSgsin) {
		this.etaForSgsin = etaForSgsin;
	}

	public String getDirectionAsString() {
		directionAsString = Utils.getDirectionAsString(direction);
		return directionAsString;
	}

	public void setDirectionAsString(String directionAsString) {
		this.directionAsString = directionAsString;
	}

	public String getForFsc() {
		return forFsc;
	}

	public void setForFsc(String forFsc) {
		this.forFsc = forFsc;
	}

	public String getPrincipalCode() {
		return principalCode;
	}

	public void setPrincipalCode(String principalCode) {
		this.principalCode = principalCode;
	}


	public String getInStatus() {
		return inStatus;
	}

	public void setInStatus(String instatus) {
		this.inStatus = instatus;
	}
   
	@Override
	public String toString() {
		return "ArrivalNoticeReminderMaintenanceMod [blNo=" + blNo + ", opCode=" + opCode + ", socCoc=" + socCoc
				+ ", userID=" + userID + ", searchBy=" + searchBy + ", service=" + service + ", vessel=" + vessel
				+ ", voyage=" + voyage + ", inVoyage=" + inVoyage + ", etaSgsin=" + etaSgsin + ", etaForSgsin="
				+ etaForSgsin + ", direction=" + direction + ", directionAsString=" + directionAsString + ", pol=" + pol
				+ ", pot=" + pot + ", podEtd=" + podEtd + ", polEtd=" + polEtd + ", podEta=" + podEta + ", pod=" + pod
				+ ", bls=" + blNo + ", issueOffice=" + issueOffice + ", numberOfTimeArravalPrinted="
				+ numberOfTimeArravalPrinted + ", lastDateArrivalPrinted=" + lastDateArrivalPrinted + ", forFsc="
				+ forFsc + ", principalCode=" + principalCode + ", browserData=" + browserData + ", " + "getOpCode()="
				+ getOpCode() + ", getSocCoc()=" + getSocCoc() + ", getUserID()=" + getUserID() + ", getSearchBy()="
				+ getSearchBy() + ", getService()=" + getService() + ", getVessel()=" + getVessel() + ", getVoyage()="
				+ getVoyage() + ", getInVoyage()=" + getInVoyage() + ", getEtaSgsin()=" + getEtaSgsin()
				+ ", getEtaForSgsin()=" + getEtaForSgsin() + ", getDirection()=" + getDirection()
				+ ", getDirectionAsString()=" + getDirectionAsString() + ", getPol()=" + getPol() + ", getPot()="
				+ getPot() + ", getPodEtd()=" + getPodEtd() + ", getPolEtd()=" + getPolEtd() + ", getPodEta()="
				+ getPodEta() + ", getPod()=" + getPod() + ", getBls()=" + getBlNo() + ", getIssueOffice()="
				+ getIssueOffice() + ", getNumberOfTimeArravalPrinted()=" + getNumberOfTimeArravalPrinted()
				+ ", getLastDateArrivalPrinted()=" + getLastDateArrivalPrinted() + ", getForFsc()=" + getForFsc()
				+ ", getPrincipalCode()=" + getPrincipalCode() + ", getBrowserData()=" + getBrowserData()
				+ ", getSeq()=" + getSeq() + ", getClass()=" + getClass() + ", hashCode()=" + hashCode()
				+ ", toString()=" + super.toString() + "]";
	}
}