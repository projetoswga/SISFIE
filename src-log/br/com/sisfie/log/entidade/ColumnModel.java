package br.com.sisfie.log.entidade;

import java.io.Serializable;

public class ColumnModel implements Serializable {

	private static final long serialVersionUID = 1L;
	
	private String header;
	private String property;
	private String subProperty;

	public String getHeader() {
		return header;
	}

	public void setHeader(String header) {
		this.header = header;
	}

	public String getProperty() {
		return property;
	}

	public void setProperty(String property) {
		this.property = property;
	}

	public String getSubProperty() {
		return subProperty;
	}

	public void setSubProperty(String subProperty) {
		this.subProperty = subProperty;
	}
}
