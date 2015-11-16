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
 * The persistent class for the grade_oficina database table.
 * 
 */
@Entity
@Table(name = "inscricao_grade", catalog = "SISFIE")
@Audited
public class InscricaoGrade extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_inscricao_grade", unique = true, nullable = false)
	@SequenceGenerator(name = "inscricaoGrade", allocationSize = 1, sequenceName = "inscricao_grade_id_inscricao_grade_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "inscricaoGrade")
	private Integer id;

	@ManyToOne
	@JoinColumn(name = "id_inscricao_curso")
	private InscricaoCurso inscricaoCurso;

	@ManyToOne
	@JoinColumn(name = "id_grade_oficina")
	private GradeOficina gradeOficina;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public GradeOficina getGradeOficina() {
		return gradeOficina;
	}

	public void setGradeOficina(GradeOficina gradeOficina) {
		this.gradeOficina = gradeOficina;
	}

}