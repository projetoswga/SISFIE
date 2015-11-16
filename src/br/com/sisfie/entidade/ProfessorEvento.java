package br.com.sisfie.entidade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "professor_evento", catalog = "SISFIE")
@Audited
public class ProfessorEvento extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_professor_evento", unique = true, nullable = false)
	@SequenceGenerator(name = "professor_evento_seq", sequenceName = "professor_evento_id_professor_evento_seq", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "professor_evento_seq")
	private Integer id;

	@ManyToOne
	@JoinColumn(name = "id_candidato")
	private Candidato candidato;

	@ManyToOne
	@JoinColumn(name = "id_curso")
	private Curso curso;

	public ProfessorEvento() {
	}

	public ProfessorEvento(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Candidato getCandidato() {
		return this.candidato;
	}

	public void setCandidato(Candidato candidato) {
		this.candidato = candidato;
	}

	public Curso getCurso() {
		return this.curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

}
