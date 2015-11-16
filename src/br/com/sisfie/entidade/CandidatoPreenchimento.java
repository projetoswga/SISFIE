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
@Table(name = "candidato_preenchimento", catalog = "SISFIE")
@Audited
public class CandidatoPreenchimento extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_candidado_preenchimento", unique = true, nullable = false)
	@SequenceGenerator(name = "CandidatoPreenchimento", allocationSize = 1, sequenceName = "candidato_preenchimento_id_candidado_preenchimento_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CandidatoPreenchimento")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_campo_preenchimento", nullable = false)
	private CampoPreenchimento campoPreenchimento;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_curso", nullable = false)
	private Curso curso;

	public CandidatoPreenchimento() {
	}

	public CandidatoPreenchimento(Integer id) {
		this.id = id;
	}

	public CampoPreenchimento getCampoPreenchimento() {
		return campoPreenchimento;
	}

	public void setCampoPreenchimento(CampoPreenchimento campoPreenchimento) {
		this.campoPreenchimento = campoPreenchimento;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
