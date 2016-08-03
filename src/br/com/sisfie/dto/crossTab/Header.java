package br.com.sisfie.dto.crossTab;

import java.io.Serializable;

public class Header implements Serializable {

	
	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String label;
	private Integer posicao;

	public Header(String label, Integer posicao) {
		super();
		this.label = label;
		this.posicao = posicao;
	}

	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}

	public Integer getPosicao() {
		return posicao;
	}

	public void setPosicao(Integer posicao) {
		this.posicao = posicao;
	}
	
	@Override
	public String toString() {
		return getLabel();
	}
}
