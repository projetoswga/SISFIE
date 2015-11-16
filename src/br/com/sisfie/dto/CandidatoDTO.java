package br.com.sisfie.dto;

import java.util.Date;

import br.com.sisfie.entidade.Orgao;

public class CandidatoDTO {

	private String nome;
	private String inscricao;
	private String emailInstitucional;
	private Date dtNascimento;
	private Orgao orgaoSelecionado;
	private Integer idStatus;
	private Integer idCurso;
	private Integer idSetor;
	private Integer idUfOrgaoSelecionado;
	private Integer idMunicipioSelecionado;
	private Integer idUfEnderecoSelecionado;
	private Integer idMunicipioEnderecoSelecionado;
	private Boolean nacionalidadeBrasil = Boolean.TRUE;
	private String docEstrangeiro;
	private String cpf;

	public CandidatoDTO() {
		orgaoSelecionado = new Orgao();
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getEmailInstitucional() {
		return emailInstitucional;
	}

	public void setEmailInstitucional(String emailInstitucional) {
		this.emailInstitucional = emailInstitucional;
	}

	public Date getDtNascimento() {
		return dtNascimento;
	}

	public void setDtNascimento(Date dtNascimento) {
		this.dtNascimento = dtNascimento;
	}

	public Integer getIdCurso() {
		return idCurso;
	}

	public void setIdCurso(Integer idCurso) {
		this.idCurso = idCurso;
	}

	public Integer getIdUfOrgaoSelecionado() {
		return idUfOrgaoSelecionado;
	}

	public void setIdUfOrgaoSelecionado(Integer idUfOrgaoSelecionado) {
		this.idUfOrgaoSelecionado = idUfOrgaoSelecionado;
	}

	public Integer getIdMunicipioSelecionado() {
		return idMunicipioSelecionado;
	}

	public void setIdMunicipioSelecionado(Integer idMunicipioSelecionado) {
		this.idMunicipioSelecionado = idMunicipioSelecionado;
	}

	public Orgao getOrgaoSelecionado() {
		return orgaoSelecionado;
	}

	public void setOrgaoSelecionado(Orgao orgaoSelecionado) {
		this.orgaoSelecionado = orgaoSelecionado;
	}

	public Integer getIdStatus() {
		return idStatus;
	}

	public void setIdStatus(Integer idStatus) {
		this.idStatus = idStatus;
	}

	public String getInscricao() {
		return inscricao;
	}

	public void setInscricao(String inscricao) {
		this.inscricao = inscricao;
	}

	public String getDocEstrangeiro() {
		return docEstrangeiro;
	}

	public void setDocEstrangeiro(String docEstrangeiro) {
		this.docEstrangeiro = docEstrangeiro;
	}

	public String getCpf() {
		return cpf;
	}

	public void setCpf(String cpf) {
		this.cpf = cpf;
	}

	public Boolean getNacionalidadeBrasil() {
		return nacionalidadeBrasil;
	}

	public void setNacionalidadeBrasil(Boolean nacionalidadeBrasil) {
		this.nacionalidadeBrasil = nacionalidadeBrasil;
	}

	public Integer getIdUfEnderecoSelecionado() {
		return idUfEnderecoSelecionado;
	}

	public void setIdUfEnderecoSelecionado(Integer idUfEnderecoSelecionado) {
		this.idUfEnderecoSelecionado = idUfEnderecoSelecionado;
	}

	public Integer getIdMunicipioEnderecoSelecionado() {
		return idMunicipioEnderecoSelecionado;
	}

	public void setIdMunicipioEnderecoSelecionado(
			Integer idMunicipioEnderecoSelecionado) {
		this.idMunicipioEnderecoSelecionado = idMunicipioEnderecoSelecionado;
	}

	public Integer getIdSetor() {
		return idSetor;
	}

	public void setIdSetor(Integer idSetor) {
		this.idSetor = idSetor;
	}

}
