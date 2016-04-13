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
@Table(name = "orgao_curso", catalog = "SISFIE")
@Audited
public class OrgaoCurso extends Entidade<Integer> {
	
	private static final long serialVersionUID = 2563200211584857862L;
	
	@Id
	@Column(name = "id_orgao_curso", unique = true, nullable = false)
	@SequenceGenerator(name = "OrgaoCurso", allocationSize = 1, sequenceName = "orgao_curso_id_orgao_curso_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "OrgaoCurso")
	private Integer id;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_curso", nullable = false)
	private Curso curso;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_orgao", nullable = false)
	private Orgao orgao;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public Orgao getOrgao() {
		return orgao;
	}

	public void setOrgao(Orgao orgao) {
		this.orgao = orgao;
	}
}
