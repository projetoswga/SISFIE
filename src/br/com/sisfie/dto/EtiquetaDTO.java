package br.com.sisfie.dto;

public class EtiquetaDTO {
	

	private String nomeCompleto;
	private String inscricao;

	public EtiquetaDTO(String nomeCompleto, String inscricao) {
		super();
		this.nomeCompleto = nomeCompleto;
		this.inscricao = inscricao;
	}

	public EtiquetaDTO(){
		
	}
	public String getNomeCompleto() {
		return nomeCompleto;
	}

	public void setNomeCompleto(String nomeCompleto) {
		this.nomeCompleto = nomeCompleto;
	}

	public String getInscricao() {
		return inscricao;
	}

	public void setInscricao(String inscricao) {
		this.inscricao = inscricao;
	}
}
