package br.com.sisfie.dto;

import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;

public class ParceirosDTO {
	
	public static final Integer TODOS = 0;
	public static final Integer INSCRITO = 1;
	public static final Integer NAO_INSCRITO = 2;

	private Curso curso;
	private Candidato candidato;
	private String email;
	private Integer inscrito;
	
	public ParceirosDTO() {
		curso = new Curso();
		candidato = new Candidato();
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public Candidato getCandidato() {
		return candidato;
	}

	public void setCandidato(Candidato candidato) {
		this.candidato = candidato;
	}

	public Integer getInscrito() {
		return inscrito;
	}

	public void setInscrito(Integer inscrito) {
		this.inscrito = inscrito;
	}
}
