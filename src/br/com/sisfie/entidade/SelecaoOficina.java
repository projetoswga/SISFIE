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

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

/**
 * The persistent class for the selecao_oficina database table.
 * 
 */
@Entity
@Table(name = "selecao_oficina", catalog = "SISFIE")
@Audited
public class SelecaoOficina extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_selecao_oficina", unique = true, nullable = false)
	@SequenceGenerator(name = "selecaoOficina", allocationSize = 1, sequenceName = "selecao_oficina_id_selecao_oficina_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "selecaoOficina")
	private Integer id;

	@Column(name = "num_ordem_selecao")
	private Integer numOrdemSelecao;

	// bi-directional many-to-one association to DistribuicaoSofGrade
	@OneToMany(mappedBy = "selecaoOficina")
	private Set<DistribuicaoSofGrade> distribuicaoSofGrades;

	// bi-directional many-to-one association to InscricaoCurso
	@ManyToOne
	@JoinColumn(name = "id_inscricao_curso")
	private InscricaoCurso inscricaoCurso;

	// bi-directional many-to-one association to Oficina
	@ManyToOne
	@JoinColumn(name = "id_oficina")
	private Oficina oficina;

	public SelecaoOficina() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Integer getNumOrdemSelecao() {
		return this.numOrdemSelecao;
	}

	public void setNumOrdemSelecao(Integer numOrdemSelecao) {
		this.numOrdemSelecao = numOrdemSelecao;
	}

	public Set<DistribuicaoSofGrade> getDistribuicaoSofGrades() {
		return this.distribuicaoSofGrades;
	}

	public void setDistribuicaoSofGrades(Set<DistribuicaoSofGrade> distribuicaoSofGrades) {
		this.distribuicaoSofGrades = distribuicaoSofGrades;
	}

	public InscricaoCurso getInscricaoCurso() {
		return this.inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public Oficina getOficina() {
		return this.oficina;
	}

	public void setOficina(Oficina oficina) {
		this.oficina = oficina;
	}

}