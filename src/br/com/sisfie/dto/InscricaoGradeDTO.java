package br.com.sisfie.dto;

import java.util.ArrayList;
import java.util.List;

import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.ProfessorEvento;
import br.com.sisfie.entidade.Sala;
import br.com.sisfie.entidade.Turma;

public class InscricaoGradeDTO {

	private Horario horario;
	private Turma turma;
	private Sala sala;
	private ProfessorEvento professorEvento;
	private Oficina oficina;
	private List<InscricaoCurso> listaInscricaoCursos;
	private List<InscricaoGradeDTO> listaInscricaoGradePorHorario;

	public InscricaoGradeDTO() {
		horario = new Horario();
		turma = new Turma();
		sala = new Sala();
		professorEvento = new ProfessorEvento();
		oficina = new Oficina();
		listaInscricaoCursos = new ArrayList<InscricaoCurso>();
		listaInscricaoGradePorHorario= new ArrayList<InscricaoGradeDTO>();
	}

	public Horario getHorario() {
		return horario;
	}

	public void setHorario(Horario horario) {
		this.horario = horario;
	}

	public Turma getTurma() {
		return turma;
	}

	public void setTurma(Turma turma) {
		this.turma = turma;
	}

	public Sala getSala() {
		return sala;
	}

	public void setSala(Sala sala) {
		this.sala = sala;
	}

	public ProfessorEvento getProfessorEvento() {
		return professorEvento;
	}

	public void setProfessorEvento(ProfessorEvento professorEvento) {
		this.professorEvento = professorEvento;
	}

	public Oficina getOficina() {
		return oficina;
	}

	public void setOficina(Oficina oficina) {
		this.oficina = oficina;
	}

	public List<InscricaoCurso> getListaInscricaoCursos() {
		return listaInscricaoCursos;
	}

	public void setListaInscricaoCursos(List<InscricaoCurso> listaInscricaoCursos) {
		this.listaInscricaoCursos = listaInscricaoCursos;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((horario == null) ? 0 : horario.hashCode());
		result = prime * result + ((oficina == null) ? 0 : oficina.hashCode());
		result = prime * result + ((professorEvento == null) ? 0 : professorEvento.hashCode());
		result = prime * result + ((sala == null) ? 0 : sala.hashCode());
		result = prime * result + ((turma == null) ? 0 : turma.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		InscricaoGradeDTO other = (InscricaoGradeDTO) obj;
		if (horario == null) {
			if (other.horario != null)
				return false;
		} else if (!horario.equals(other.horario))
			return false;
		if (oficina == null) {
			if (other.oficina != null)
				return false;
		} else if (!oficina.equals(other.oficina))
			return false;
		if (professorEvento == null) {
			if (other.professorEvento != null)
				return false;
		} else if (!professorEvento.equals(other.professorEvento))
			return false;
		if (sala == null) {
			if (other.sala != null)
				return false;
		} else if (!sala.equals(other.sala))
			return false;
		if (turma == null) {
			if (other.turma != null)
				return false;
		} else if (!turma.equals(other.turma))
			return false;
		return true;
	}

	public List<InscricaoGradeDTO> getListaInscricaoGradePorHorario() {
		return listaInscricaoGradePorHorario;
	}

	public void setListaInscricaoGradePorHorario(List<InscricaoGradeDTO> listaInscricaoGradePorHorario) {
		this.listaInscricaoGradePorHorario = listaInscricaoGradePorHorario;
	}
}
