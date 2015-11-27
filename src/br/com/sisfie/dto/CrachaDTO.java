package br.com.sisfie.dto;

import java.util.List;

public class CrachaDTO extends AlunoDTO {
	private String nomeCracha;
	private List<OficinaDTO> oficinas;

	public CrachaDTO() {
	}

	public CrachaDTO(String inscricao, String nomeCompleto, String orgao, String nomeCracha, List<OficinaDTO> oficinas) {
		super(inscricao, nomeCompleto, orgao);
		this.nomeCracha = nomeCracha;
		this.oficinas = oficinas;
	}

	public String getNomeCracha() {
		return nomeCracha;
	}

	public void setNomeCracha(String nomeCracha) {
		this.nomeCracha = nomeCracha;
	}

	public List<OficinaDTO> getOficinas() {
		return oficinas;
	}

	public void setOficinas(List<OficinaDTO> oficinas) {
		this.oficinas = oficinas;
	}
}
