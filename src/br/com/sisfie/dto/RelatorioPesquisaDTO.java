package br.com.sisfie.dto;

import java.util.Date;

import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Orgao;
import br.com.sisfie.entidade.Turma;

public class RelatorioPesquisaDTO {

	private Curso curso;
	private Orgao orgaoCandidato;
	private Orgao orgaoSolicitante;
	private Date dataInicial;
	private Date dataFinal;
	private Turma turma;
	private Integer idSituacaoInscricao;
	private Integer idUfOrgaoSelecionado;
	private Integer idMunicipioSelecionado;
	private Integer idUfEnderecoSelecionado;
	private Integer idMunicipioEnderecoSelecionado;

	public RelatorioPesquisaDTO(Curso curso, Orgao orgaoSolicitante, Orgao orgaoCandidato, Date dataInicial, Date dataFinal,
			Turma turma, Integer idSituacaoInscricao, Integer idUfOrgaoSelecionado, Integer idMunicipioSelecionado,
			Integer idUfEnderecoSelecionado, Integer idMunicipioEnderecoSelecionado) {
		this.curso = curso;
		this.orgaoCandidato = orgaoCandidato;
		this.orgaoSolicitante = orgaoSolicitante;
		this.dataFinal = dataFinal;
		this.dataInicial = dataInicial;
		this.turma = turma;
		this.idSituacaoInscricao = idSituacaoInscricao;
		this.idUfOrgaoSelecionado = idUfOrgaoSelecionado;
		this.idMunicipioSelecionado = idMunicipioSelecionado;
		this.idUfEnderecoSelecionado = idUfEnderecoSelecionado;
		this.idMunicipioEnderecoSelecionado = idMunicipioEnderecoSelecionado;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public Orgao getOrgaoCandidato() {
		return orgaoCandidato;
	}

	public void setOrgaoCandidato(Orgao orgaoCandidato) {
		this.orgaoCandidato = orgaoCandidato;
	}

	public Orgao getOrgaoSolicitante() {
		return orgaoSolicitante;
	}

	public void setOrgaoSolicitante(Orgao orgaoSolicitante) {
		this.orgaoSolicitante = orgaoSolicitante;
	}

	public Date getDataInicial() {
		return dataInicial;
	}

	public void setDataInicial(Date dataInicial) {
		this.dataInicial = dataInicial;
	}

	public Date getDataFinal() {
		return dataFinal;
	}

	public void setDataFinal(Date dataFinal) {
		this.dataFinal = dataFinal;
	}

	public Turma getTurma() {
		return turma;
	}

	public void setTurma(Turma turma) {
		this.turma = turma;
	}

	public Integer getIdSituacaoInscricao() {
		return idSituacaoInscricao;
	}

	public void setIdSituacaoInscricao(Integer idSituacaoInscricao) {
		this.idSituacaoInscricao = idSituacaoInscricao;
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

	public Integer getIdUfEnderecoSelecionado() {
		return idUfEnderecoSelecionado;
	}

	public void setIdUfEnderecoSelecionado(Integer idUfEnderecoSelecionado) {
		this.idUfEnderecoSelecionado = idUfEnderecoSelecionado;
	}

	public Integer getIdMunicipioEnderecoSelecionado() {
		return idMunicipioEnderecoSelecionado;
	}

	public void setIdMunicipioEnderecoSelecionado(Integer idMunicipioEnderecoSelecionado) {
		this.idMunicipioEnderecoSelecionado = idMunicipioEnderecoSelecionado;
	}

}
