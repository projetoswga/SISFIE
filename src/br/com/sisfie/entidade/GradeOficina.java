package br.com.sisfie.entidade;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

/**
 * The persistent class for the grade_oficina database table.
 * 
 */
@Entity
@Table(name = "grade_oficina", catalog = "SISFIE")
@Audited
public class GradeOficina extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_grade_oficina", unique = true, nullable = false)
	@SequenceGenerator(name = "gradeOficina", allocationSize = 1, sequenceName = "grade_oficina_id_grade_oficina_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "gradeOficina")
	private Integer id;

	// bi-directional many-to-one association to DistribuicaoSofGrade
	@OneToMany(mappedBy = "gradeOficina")
	private Set<DistribuicaoSofGrade> distribuicaoSofGrades;

	// bi-directional many-to-one association to Candidato
	@ManyToOne
	@JoinColumn(name = "id_professor_evento")
	private ProfessorEvento professorEvento;

	// bi-directional many-to-one association to Oficina
	@ManyToOne
	@JoinColumn(name = "id_oficina")
	private Oficina oficina;

	// bi-directional many-to-one association to Sala
	@ManyToOne
	@JoinColumn(name = "id_sala")
	private Sala sala;

	// bi-directional many-to-one association to Turma
	@ManyToOne
	@JoinColumn(name = "id_turma")
	private Turma turma;

	// bi-directional many-to-one association to Horario
	@ManyToOne
	@JoinColumn(name = "id_horario")
	private Horario horario;

	@Transient
	private Long vagasDisponiveis;

	public GradeOficina() {
	}

	public GradeOficina(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Set<DistribuicaoSofGrade> getDistribuicaoSofGrades() {
		return this.distribuicaoSofGrades;
	}

	public void setDistribuicaoSofGrades(Set<DistribuicaoSofGrade> distribuicaoSofGrades) {
		this.distribuicaoSofGrades = distribuicaoSofGrades;
	}

	public Oficina getOficina() {
		return this.oficina;
	}

	public void setOficina(Oficina oficina) {
		this.oficina = oficina;
	}

	public Sala getSala() {
		return this.sala;
	}

	public void setSala(Sala sala) {
		this.sala = sala;
	}

	public Turma getTurma() {
		return this.turma;
	}

	public void setTurma(Turma turma) {
		this.turma = turma;
	}

	public Long getVagasDisponiveis() {
		return vagasDisponiveis;
	}

	public void setVagasDisponiveis(Long vagasDisponiveis) {
		this.vagasDisponiveis = vagasDisponiveis;
	}

	public ProfessorEvento getProfessorEvento() {
		return professorEvento;
	}

	public void setProfessorEvento(ProfessorEvento professorEvento) {
		this.professorEvento = professorEvento;
	}

	public Horario getHorario() {
		return horario;
	}

	public void setHorario(Horario horario) {
		this.horario = horario;
	}

}