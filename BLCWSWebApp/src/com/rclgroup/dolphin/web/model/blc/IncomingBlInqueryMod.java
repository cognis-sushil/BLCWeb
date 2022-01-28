/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.model.blc;
/* ----------------------------------- Change Log ----------------------------------
##   DD/MM/YY       -User-              -TaskRef-            -ShortDescription-
1    04/04/20        Chandu             Initial Version
-----------------------------------------------------------------------------------
*/
import javax.xml.bind.annotation.XmlRootElement;

import com.rclgroup.dolphin.web.util.RutDate;
import com.rclgroup.dolphin.web.utils.blc.Utils;

/**
 * Used to hold data of BlcIncomingBlInquery page.
 * @author Cognis Solution
 */

@XmlRootElement
public class IncomingBlInqueryMod extends BaseInputMod{
	private static final long serialVersionUID = 1L;
	
	private String service;
	private String vessel;
	private String voyage;
	private String direction;
	private String directionAsString;
	private String pol;
	private String pot;
	private String podEtd;
	private String polEtd;
	private String podEta;
	private String eta;
	private String etd;
	private String pod;
	private String bls;
	private String userID;
		
		public String getUserID() {
			return userID;
		}

		public void setUserID(String userID) {
			this.userID = userID;
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

	public String getDirectionAsString() {
		directionAsString = Utils.getDirectionAsString(direction);
		return directionAsString;
	}

	public void setDirectionAsString(String direction) {
		this.directionAsString = direction;
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
		podEtd = RutDate.toDateFormatFromYYYYMMDD(podEtd);
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
	
	public String getEta() {
		return eta;
	}

	public void setEta(String eta) {
		this.eta = eta;
	}

	public String getEtd() {
		return etd;
	}

	public void setEtd(String etd) {
		this.etd = etd;
	}


	public String getPod() {
		return pod;
	}

	public void setPod(String pod) {
		this.pod = pod;
	}

	public String getBls() {
		return bls;
	}

	public void setBls(String bls) {
		this.bls = bls;
	}

	@Override
	public String toString() {
		super.toString();
		return "BlcIncomingBlInqueryModel [service=" + service + ", vessel=" + vessel + ", voyage=" + voyage
				+ ", direction=" + direction + ", directionAsString=" + directionAsString + ", pol=" + pol + ", pot="
				+ pot + ", podEtd=" + podEtd + ", polEtd=" + polEtd + ", podEta=" + podEta + ", eta=" + eta + ", etd="
				+ etd + ", pod=" + pod + ", bls=" + bls + ", userID=" + userID + "]";
	}


}
