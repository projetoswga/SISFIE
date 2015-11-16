package br.com.sisfie.dto;

import java.util.ArrayList;
import java.util.List;

import br.com.sisfie.entidade.Candidato;

public class CandidatosInscritosDTO {

	private String periodo;
	private String nomeOrgao;
	private String codCurso;
	private String nomeCurso;
	private String local;
	private String turma;
	private Integer idCurso;
	private String instrutores;
	private String caminho;

	private List<DetailCandidatosInscritosDTO> listaDetailCandidatosInscritosDTOs;
	
	public CandidatosInscritosDTO() {
		listaDetailCandidatosInscritosDTOs = new ArrayList<DetailCandidatosInscritosDTO>();
	}

	public String getPeriodo() {
		return periodo;
	}

	public void setPeriodo(String periodo) {
		this.periodo = periodo;
	}

	public String getNomeOrgao() {
		return nomeOrgao;
	}

	public void setNomeOrgao(String nomeOrgao) {
		this.nomeOrgao = nomeOrgao;
	}

	public String getCodCurso() {
		return codCurso;
	}

	public void setCodCurso(String codCurso) {
		this.codCurso = codCurso;
	}

	public String getNomeCurso() {
		return nomeCurso;
	}

	public void setNomeCurso(String nomeCurso) {
		this.nomeCurso = nomeCurso;
	}

	public String getLocal() {
		return local;
	}

	public void setLocal(String local) {
		this.local = local;
	}

	public String getTurma() {
		return turma;
	}

	public void setTurma(String turma) {
		this.turma = turma;
	}

	public List<DetailCandidatosInscritosDTO> getListaDetailCandidatosInscritosDTOs() {
		return listaDetailCandidatosInscritosDTOs;
	}

	public void setListaDetailCandidatosInscritosDTOs(List<DetailCandidatosInscritosDTO> listaDetailCandidatosInscritosDTOs) {
		this.listaDetailCandidatosInscritosDTOs = listaDetailCandidatosInscritosDTOs;
	}


	public Integer getIdCurso() {
		return idCurso;
	}

	public void setIdCurso(Integer idCurso) {
		this.idCurso = idCurso;
	}

	public String getInstrutores() {
		return instrutores;
	}

	public void setInstrutores(String instrutores) {
		this.instrutores = instrutores;
	}

	public String getCaminho() {
		return caminho;
	}

	public void setCaminho(String caminho) {
		this.caminho = caminho;
	}

}
