/* Copyright (c) 2020 RCL| All Rights Reserved*/
package com.rclgroup.dolphin.web.model.blc;
import javax.xml.bind.annotation.XmlRootElement;

import com.rclgroup.dolphin.web.utils.blc.Constants;
import com.rclgroup.dolphin.web.utils.blc.Utils;


/**
 * Used to hold data of BlCountByActivitySummary page.
 * @author Cognis Solution
 */
@XmlRootElement
public class CountByActivitySummaryMod extends BaseInputMod {
	private static final long serialVersionUID = 1L;
	
	private String id;
	private String service;
	private String vessel;
	private String voyage;
	private String direction;
	private String pol;
	private String etdFrom;
	private String etdTo;
	private String podEtd;
	private String polEtd;
	private String podEta;
	private String noOfBL;
	private String blType;
	private String noOfConformBl="0";
	private String noOfPrintedBl="0";
	private String noOfGenratedInvoices="0";
	private String noOfPrintedInvoice="0";
	private String noOfManifestedBl="0";
	private String noOfUnreleaseBl="0";
	private String noOfSpecialRelease="0";
	private String bLType;
	private String blNum;
	private String confirmBl;
	private String blPrintStatus;
	private String generatedInvoices;
	private String printedInvoices;
	private String manifestedBl;
	private String unreleaseBl;
	private String specialRelease;
    private String userID;
    private String line;
	private String agent;
    private String trade;
    
    public String getEtdFrom() {
		return etdFrom;
	}

	public void setEtdFrom(String etdFrom) {
		this.etdFrom = etdFrom;
	}

	public String getEtdTo() {
		return etdTo;
	}

	public void setEtdTo(String etdTo) {
		this.etdTo = etdTo;
	}

    public String getLine() {
		return line;
	}

	public void setLine(String line) {
		this.line = line;
	}

	public String getAgent() {
		return agent;
	}

	public void setAgent(String agent) {
		this.agent = agent;
	}

	public String getTrade() {
		return trade;
	}

	public void setTrade(String trade) {
		this.trade = trade;
	}
	
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

	public String getPodEtd() {
		return podEtd;
	}

	public void setPodEtd(String podEtd) {
		this.podEtd = podEtd;
	}

	public String getPolEtd() {
		return polEtd;
	}

	public void setPolEtd(String polEtd) {
		this.polEtd = polEtd;
	}

	public String getPodEta() {
		return podEta;
	}

	public void setPodEta(String podEta) {
		this.podEta = podEta;
	}

	public String getBlType() {
		blType = Utils.setBillType(blType);
		return blType;
	}

	public void setBlType(String blType) {
		this.blType = blType;
	}

	public String getNoOfConformBl() {
		return noOfConformBl;
	}

	public void setNoOfConformBl(String noOfConformBl) {
		this.noOfConformBl = noOfConformBl;
	}

	public String getNoOfPrintedBl() {
		return noOfPrintedBl;
	}

	public void setNoOfPrintedBl(String noOfPrintedBl) {
		this.noOfPrintedBl = noOfPrintedBl;
	}

	public String getNoOfGenratedInvoices() {
		return noOfGenratedInvoices;
	}

	public void setNoOfGenratedInvoices(String noOfGenratedInvoices) {
		this.noOfGenratedInvoices = noOfGenratedInvoices;
	}

	public String getNoOfPrintedInvoice() {
		return noOfPrintedInvoice;
	}

	public void setNoOfPrintedInvoice(String noOfPrintedInvoice) {
		this.noOfPrintedInvoice = noOfPrintedInvoice;
	}

	public String getNoOfManifestedBl() {
		return noOfManifestedBl;
	}

	public void setNoOfManifestedBl(String noOfManifestedBl) {
		this.noOfManifestedBl = noOfManifestedBl;
	}

	public String getNoOfUnreleaseBl() {
		return noOfUnreleaseBl;
	}

	public void setNoOfUnreleaseBl(String noOfUnreleaseBl) {
		this.noOfUnreleaseBl = noOfUnreleaseBl;
	}

	public String getSpecialRelease() {
		if (Constants.YES.equalsIgnoreCase(specialRelease))
			return Constants.YES_STRING;
		else
			return Constants.NO_STRING;

	}

	public void setSpecialRelease(String specialRelease) {
		this.specialRelease = specialRelease;
	}

	public String getNoOfBL() {
		return noOfBL;
	}

	public void setNoOfBL(String noOfBL) {
		this.noOfBL = noOfBL;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getConfirmBl() {
		if (confirmBl == null)
			confirmBl = "No";
		confirmBl = (confirmBl.equalsIgnoreCase("Y")) ? "Yes" : "No";
		return confirmBl;
	}

	public void setConfirmBl(String confirmBl) {
		this.confirmBl = confirmBl;
	}

	public String getBlPrintStatus() {
		if (blPrintStatus == null)
			blPrintStatus = "No";
		
		blPrintStatus = (blPrintStatus.equalsIgnoreCase("R")) ? "Yes" : "No";
		return blPrintStatus;
	}

	public void setBlPrintStatus(String blPrintStatus) {
		this.blPrintStatus = blPrintStatus;
	}

	public String getGeneratedInvoices() {
		if (Constants.YES.equalsIgnoreCase(generatedInvoices))
			return Constants.YES_STRING;
		else
			return Constants.NO_STRING;

	}

	public void setGeneratedInvoices(String generatedInvoices) {
		this.generatedInvoices = generatedInvoices;
	}

	public String getPrintedInvoices() {
		if (Constants.YES.equalsIgnoreCase(printedInvoices))
			return Constants.YES_STRING;
		else
			return Constants.NO_STRING;
	}

	public void setPrintedInvoices(String printedInvoices) {
		this.printedInvoices = printedInvoices;
	}

	public String getUnreleaseBl() {
		if (Constants.YES.equalsIgnoreCase(unreleaseBl))
			return Constants.YES_STRING;
		else
			return Constants.NO_STRING;
	}

	public void setUnreleaseBl(String unreleaseBl) {
		this.unreleaseBl = unreleaseBl;
	}

	public String getBlNum() {
		return blNum;
	}

	public void setBlNum(String blNum) {
		this.blNum = blNum;
	}

	public String getNoOfSpecialRelease() {
		return noOfSpecialRelease;
	}

	public void setNoOfSpecialRelease(String noOfSpecialRelease) {
		this.noOfSpecialRelease = noOfSpecialRelease;
	}

	public String getManifestedBl() {
		if (manifestedBl == null)
			manifestedBl = "No";
		manifestedBl = (manifestedBl.equalsIgnoreCase("Y")) ? "Yes" : "No";
		return manifestedBl;
	}

	public void setManifestedBl(String manifestedBl) {
		this.manifestedBl = manifestedBl;
	}

	public String getbLType() {
		bLType = Utils.setBillTypeAsString(bLType);
		return bLType;
	}

	public void setbLType(String bLType) {
		this.bLType = bLType;
	}

	@Override
	public String toString() {
		return "CountByActivitySummaryMod [id=" + id + ", service=" + service + ", vessel=" + vessel + ", voyage="
				+ voyage + ", direction=" + direction + ", pol=" + pol + ", etdFrom=" + etdFrom + ", etdTo=" + etdTo
				+ ", podEtd=" + podEtd + ", polEtd=" + polEtd + ", podEta=" + podEta + ", noOfBL=" + noOfBL
				+ ", blType=" + blType + ", noOfConformBl=" + noOfConformBl + ", noOfPrintedBl=" + noOfPrintedBl
				+ ", noOfGenratedInvoices=" + noOfGenratedInvoices + ", noOfPrintedInvoice=" + noOfPrintedInvoice
				+ ", noOfManifestedBl=" + noOfManifestedBl + ", noOfUnreleaseBl=" + noOfUnreleaseBl
				+ ", noOfSpecialRelease=" + noOfSpecialRelease + ", bLType=" + bLType + ", blNum=" + blNum
				+ ", confirmBl=" + confirmBl + ", blPrintStatus=" + blPrintStatus + ", generatedInvoices="
				+ generatedInvoices + ", printedInvoices=" + printedInvoices + ", manifestedBl=" + manifestedBl
				+ ", unreleaseBl=" + unreleaseBl + ", specialRelease=" + specialRelease + ", userID=" + userID
				+ ", line=" + line + ", agent=" + agent + ", trade=" + trade + "]";
	}

	
}
