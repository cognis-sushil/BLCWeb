package com.rclgroup.dolphin.web.model.blc;

import javax.xml.bind.annotation.XmlRootElement;

@XmlRootElement
public class FreightManifestSummarySheetMod extends BaseInputMod{
	private static final long serialVersionUID = 1L;
	private String service;
	private String vessel;
	private String voyage;
	private String dir;
	private String pol;
	private String etaDate;	
	private String message; 
	private boolean status;
	
	
	public String getEtaDate() {
		return etaDate;
	}
	public void setEtaDate(String etaDate) {
		this.etaDate = etaDate;
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
	public String getDir() {
		return dir;
	}
	public void setDir(String dir) {
		this.dir = dir;
	}
	public String getPol() {
		return pol;
	}
	public void setPol(String pol) {
		this.pol = pol;
	}
	
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	public boolean isStatus() {
		return status;
	}
	public void setStatus(boolean status) {
		this.status = status;
	}
	@Override
	public String toString() {
		return "BlcDexpFreightManifestSummarySheetMod [service=" + service + ", vessel=" + vessel + ", voyage=" + voyage
				+ ", dir=" + dir + ", pol=" + pol + "]";
	}

	

}
