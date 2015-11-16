package br.com.sisfie.entidade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
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
@Table(name = "esfera_curso", catalog = "SISFIE")
@Audited
public class EsferaCurso extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_esfera_curso", unique = true, nullable = false)
	@SequenceGenerator(name = "EsferaCurso", allocationSize = 1, sequenceName = "esfera_curso_id_esfera_curso_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "EsferaCurso")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_curso", nullable = false)
	private Curso curso;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_esfera_gov", nullable = false)
	private EsferaGoverno esferaGoverno;

	public EsferaCurso() {
	}

	public EsferaCurso(Integer id) {
		this.id = id;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public EsferaGoverno getEsferaGoverno() {
		return esferaGoverno;
	}

	public void setEsferaGoverno(EsferaGoverno esferaGoverno) {
		this.esferaGoverno = esferaGoverno;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
