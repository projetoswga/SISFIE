package br.com.sisfie.dto;

import java.util.ArrayList;
import java.util.List;

public class AlunoDTO {

	private String inscricao;
	private String nomeCompleto;
	private String orgao;
	private String totalFaltas;
	private List<MapaFrequencia> mapaFrequencia = new ArrayList<MapaFrequencia>();

	public AlunoDTO() {
	}

	public AlunoDTO(String inscricao, String nomeCompleto, String orgao) {
		super();
		this.inscricao = inscricao;
		this.nomeCompleto = nomeCompleto;
		this.orgao = orgao;
	}

	public String getInscricao() {
		return inscricao;
	}

	public void setInscricao(String inscricao) {
		this.inscricao = inscricao;
	}

	public String getNomeCompleto() {
		return nomeCompleto;
	}

	public void setNomeCompleto(String nomeCompleto) {
		this.nomeCompleto = nomeCompleto;
	}

	public String getOrgao() {
		return orgao;
	}

	public void setOrgao(String orgao) {
		this.orgao = orgao;
	}

	public String getTotalFaltas() {
		return totalFaltas;
	}

	public void setTotalFaltas(String totalFaltas) {
		this.totalFaltas = totalFaltas;
	}

	public List<MapaFrequencia> getMapaFrequencia() {
		return mapaFrequencia;
	}

	public void setMapaFrequencia(List<MapaFrequencia> mapaFrequencia) {
		this.mapaFrequencia = mapaFrequencia;
	}
}