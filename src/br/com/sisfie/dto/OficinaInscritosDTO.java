package br.com.sisfie.dto;

import br.com.sisfie.entidade.Oficina;

public class OficinaInscritosDTO {

	private Oficina oficina;
	private Integer qtdInscritos;

	public OficinaInscritosDTO() {
		oficina = new Oficina();
	}

	public Oficina getOficina() {
		return oficina;
	}

	public void setOficina(Oficina oficina) {
		this.oficina = oficina;
	}

	public Integer getQtdInscritos() {
		return qtdInscritos;
	}

	public void setQtdInscritos(Integer qtdInscritos) {
		this.qtdInscritos = qtdInscritos;
	}

}
