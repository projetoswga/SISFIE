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
@Table(name = "EMAIL_CURSO_PRIVADO", catalog = "SISFIE")
@Audited
public class EmailCursoPrivado extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "ID_EMAIL_CURSO", unique = true, nullable = false)
	@SequenceGenerator(name = "email_curso", allocationSize = 1, sequenceName = "email_curso_privado_id_email_curso_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "email_curso")
	private Integer id;

	@Column(name = "DSC_EMAIL", nullable = false)
	private String email;
	
	@Column(name = "DSC_TIPO")
	private String tipo;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_CURSO")
	private Curso curso;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
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

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

}
