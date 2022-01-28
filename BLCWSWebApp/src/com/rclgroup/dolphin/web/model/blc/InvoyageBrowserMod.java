/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.model.blc;
/* ----------------------------------- Change Log ----------------------------------
##   DD/MM/YY          -User-              -TaskRef-            -ShortDescription-
1    022/04/20        Akash Gupta         Initial Version
-----------------------------------------------------------------------------------
*/

import javax.xml.bind.annotation.XmlRootElement;

import com.rclgroup.dolphin.web.util.RutDate;
import com.rclgroup.dolphin.web.utils.blc.Utils;
@XmlRootElement
public class InvoyageBrowserMod extends BaseInputMod{
	 
	private static final long serialVersionUID = 1L;
	private String select;
	private String port;
	private String terminal;
	private String invoyageBrowser;
	private String exptInvoyage;
	private String portSeq;
	private String service;
	private String vessel;
	private String voyage;
	private String direction;
	private String directionAsString;
	private String eta;
	private String etaForSgsin;
	private String userID;
	public String getSelect() {
		return select;
	}
	public void setSelect(String select) {
		this.select = select;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getTerminal() {
		return terminal;
	}
	public void setTerminal(String terminal) {
		this.terminal = terminal;
	}
	public String getInvoyageBrowser() {
		return invoyageBrowser;
	}
	public void setInvoyageBrowser(String invoyageBrowser) {
		this.invoyageBrowser = invoyageBrowser;
	}
	public String getExptInvoyage() {
		return exptInvoyage;
	}
	public void setExptInvoyage(String exptInvoyage) {
		this.exptInvoyage = exptInvoyage;
	}
	public String getPortSeq() {
		return portSeq;
	}
	public void setPortSeq(String portSeq) {
		this.portSeq = portSeq;
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
	public String getDirection() {
		return direction;
	}
	public void setDirection(String direction) {
		this.direction = direction;
	}
	public String getEta() {
		eta = RutDate.toDateFormatFromYYYYMMDD(eta);
		return eta;
	}

	public void setEta(String eta) {
		this.eta = eta;
	}
	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getDirectionAsString() {
		directionAsString = Utils.getDirectionAsString(direction);
		return directionAsString;
	}

	public void setDirectionAsString(String direction) {
		this.directionAsString = direction;
	}
	@Override
	public String toString() {
		return "InvoyageBrowserMod [select=" + select + ", port=" + port + ", terminal=" + terminal
				+ ", invoyageBrowser=" + invoyageBrowser + ", exptInvoyage=" + exptInvoyage + ", portSeq=" + portSeq
				+ ", service=" + service + ", vessel=" + vessel + ", voyage=" + voyage + ", direction=" + direction
				+ ", etaForSgsin=" + etaForSgsin + ", userID=" + userID + "]";
	}
	public String getEtaForSgsin() {
		return etaForSgsin;
	}
	public void setEtaForSgsin(String etaForSgsin) {
		this.etaForSgsin = etaForSgsin;
	}
}
