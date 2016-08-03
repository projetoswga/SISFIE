package br.com.sisfie.dto.crossTab;

import java.io.Serializable;

public class CrossTab implements Serializable {

	// Nome das Colunas
	private Header header;
	// Nome Das lInhas
	private Integer row;
	// informação a ser populada
	private String info;

	public CrossTab(Header header, Integer row, String info) {
		super();
		this.header = header;
		this.row = row;
		this.info = info;

	}

	public Header getHeader() {
		return header;
	}

	public void setHeader(Header header) {
		this.header = header;
	}

	public String getInfo() {
		return info;
	}

	public void setInfo(String info) {
		this.info = info;
	}

	public Integer getRow() {
		return row;
	}

	public void setRow(Integer row) {
		this.row = row;
	}

}
