package br.com.sisfie.dto;

public class CredenciamentoDTO {

	public CredenciamentoDTO(){
		
	}
	
	public CredenciamentoDTO(String ordem, String inscricao,
			String nomeCompleto, String orgao) {
		super();
		this.ordem = ordem;
		this.inscricao = inscricao;
		this.nomeCompleto = nomeCompleto;
		this.orgao = orgao;
	}

	private String ordem;
	private String inscricao;
	private String nomeCompleto;
	private String orgao;

	public String getOrdem() {
		return ordem;
	}

	public void setOrdem(String ordem) {
		this.ordem = ordem;
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
}
