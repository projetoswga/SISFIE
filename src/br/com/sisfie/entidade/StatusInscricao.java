package br.com.sisfie.entidade;

import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "status_inscricao", catalog = "SISFIE")
@Audited
public class StatusInscricao extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_status_inscricao", unique = true, nullable = false)
	@SequenceGenerator(name = "StatusInscricao", allocationSize = 1, sequenceName = "status_inscricao_id_status_inscricao_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "StatusInscricao")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_inscricao_curso", nullable = false)
	private InscricaoCurso inscricaoCurso;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_usuario", nullable = false)
	private Usuario usuario;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_status", nullable = false)
	private Status status;

	@Temporal(TemporalType.DATE)
	@Column(name = "dt_atualizacao", nullable = false, length = 13)
	private Date dtAtualizacao;

	public StatusInscricao(InscricaoCurso inscricaoCurso, Usuario usuario, Status status, Date dtAtualizacao) {
		this.inscricaoCurso = inscricaoCurso;
		this.usuario = usuario;
		this.status = status;
		this.dtAtualizacao = dtAtualizacao;
	}
	
	public StatusInscricao (Integer id){
		this.id = id;
	}
	
	public StatusInscricao() {
	}

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

	public Usuario getUsuario() {
		return usuario;
	}

	public void setUsuario(Usuario usuario) {
		this.usuario = usuario;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public Date getDtAtualizacao() {
		return dtAtualizacao;
	}

	public void setDtAtualizacao(Date dtAtualizacao) {
		this.dtAtualizacao = dtAtualizacao;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
