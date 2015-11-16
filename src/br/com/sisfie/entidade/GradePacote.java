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

/**
 * The persistent class for the grade_pacote database table.
 * 
 */
@Entity
@Table(name = "grade_pacote", catalog = "SISFIE")
@Audited
public class GradePacote extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_grade_pacote", unique = true, nullable = false)
	@SequenceGenerator(name = "gradePacote", allocationSize = 1, sequenceName = "grade_pacote_id_grade_pacote_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "gradePacote")
	private Integer id;

	// bi-directional many-to-one association to Horario
	@ManyToOne
	@JoinColumn(name = "id_horario")
	private Horario horario;

	// bi-directional many-to-one association to PacoteOficina
	@ManyToOne
	@JoinColumn(name = "id_pacote_oficina")
	private PacoteOficina pacoteOficina;

	// bi-directional many-to-one association to Turma
	@ManyToOne
	@JoinColumn(name = "id_turma")
	private Turma turma;

	public GradePacote() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Horario getHorario() {
		return this.horario;
	}

	public void setHorario(Horario horario) {
		this.horario = horario;
	}

	public PacoteOficina getPacoteOficina() {
		return this.pacoteOficina;
	}

	public void setPacoteOficina(PacoteOficina pacoteOficina) {
		this.pacoteOficina = pacoteOficina;
	}

	public Turma getTurma() {
		return this.turma;
	}

	public void setTurma(Turma turma) {
		this.turma = turma;
	}
}