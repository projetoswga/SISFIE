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
 * The persistent class for the distribuicao_sof_grade database table.
 * 
 */
@Entity
@Table(name = "distribuicao_sof_grade", catalog = "SISFIE")
@Audited
public class DistribuicaoSofGrade extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_distribuicao_sof_grade", unique = true, nullable = false)
	@SequenceGenerator(name = "distribuicaoSofGrade", allocationSize = 1, sequenceName = "distribuicao_sof_grade_id_distribuicao_sof_grade_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "distribuicaoSofGrade")
	private Integer id;

	@Column(name = "ind_conflito")
	private Boolean indConflito = new Boolean(false);

	// bi-directional many-to-one association to GradeOficina
	@ManyToOne
	@JoinColumn(name = "id_grade_oficina")
	private GradeOficina gradeOficina;

	// bi-directional many-to-one association to SelecaoOficina
	@ManyToOne
	@JoinColumn(name = "id_selecao_oficina")
	private SelecaoOficina selecaoOficina;

	public DistribuicaoSofGrade() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Boolean getIndConflito() {
		return this.indConflito;
	}

	public void setIndConflito(Boolean indConflito) {
		this.indConflito = indConflito;
	}

	public GradeOficina getGradeOficina() {
		return this.gradeOficina;
	}

	public void setGradeOficina(GradeOficina gradeOficina) {
		this.gradeOficina = gradeOficina;
	}

	public SelecaoOficina getSelecaoOficina() {
		return this.selecaoOficina;
	}

	public void setSelecaoOficina(SelecaoOficina selecaoOficina) {
		this.selecaoOficina = selecaoOficina;
	}

}