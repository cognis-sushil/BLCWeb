package com.rclgroup.dolphin.web.model.blc;

import java.io.Serializable;

import com.rclgroup.dolphin.web.auth.BrowserData;

public class BaseInputMod implements Serializable {

	
	private static final long serialVersionUID = 1L;
	
	protected BrowserData browserData;
    
	private String seq;
	public BrowserData getBrowserData() {
		return this.browserData;
	}

	public void setBrowserData(BrowserData browserData) {
		this.browserData = browserData;
	}

	public String getSeq() {
		return seq;
	}

	public void setSeq(String seq) {
		this.seq = seq;
	}

	@Override
	public String toString() {
		return "BaseInputMod [browserData=" + browserData + ", seq=" + seq + "]";
	}
	
}
