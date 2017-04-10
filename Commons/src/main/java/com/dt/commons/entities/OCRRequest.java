package com.dt.commons.entities;

public class OCRRequest {
	private String identifier;
	private byte[] image;

	public OCRRequest(String identifier, byte[] image) {
		this.identifier = identifier;
		this.image = image;
	}
	
	public String getIdentifier() {
		return identifier;
	}
	public void setIdentifier(String identifier) {
		this.identifier = identifier;
	}
	public byte[] getImage() {
		return image;
	}
	public void setImage(byte[] image) {
		this.image = image;
	}
}
