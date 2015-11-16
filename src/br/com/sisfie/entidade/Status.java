package br.com.sisfie.entidade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "status_d", catalog = "SISFIE")
@Audited
public class Status extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	// Status para inscricao
	public static final Integer AGUARDANDO_VAGA = 11;
	public static final Integer AGUARDANDO_VAGA_PRIORIDADE = 13;

	public static final Integer PRE_INSCRITO = 10;
	public static final Integer AGUARDANDO_COMPROVANTE = 1;
	public static final Integer AGUARDANDO_HOMOLOGACAO = 16;
	public static final Integer AGUARDANDO_ACEITE_INSCRICAO = 17;


	public static final Integer CONFIRMADO_PELO_CHEFE = 8;
	public static final Integer INVALIDAR_COMPROVANTE = 14;

	public static final Integer AGUARDANDO_VALIDACAO_COMPROVANTE = 15;

	public static final Integer HOMOLOGADO = 12;
	public static final Integer CANCELADO = 2;

	public static final Integer PRESENCA_CONFIRMADA = 3;

	// Status para curso
	public static final Integer EM_ANDAMENTO = 4;
	public static final Integer CADASTRADO = 5;
	public static final Integer FINALIZADO_CURSO = 6;
	public static final Integer SUSPENSO = 7;
	public static final Integer FINALIZADA_INSCRICAO = 9;

	@Id
	@Column(name = "id_status", unique = true, nullable = false)
	@SequenceGenerator(name = "Status", allocationSize = 1, sequenceName = "status_d_id_status_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Status")
	private Integer id;

	@Column(name = "dsc_status", nullable = false)
	private String descricao;

	@Column(name = "flg_ativo", nullable = false)
	private Boolean flgAtivo;

	public Status() {
	}

	public Status(Integer id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Boolean getFlgAtivo() {
		return flgAtivo;
	}

	public void setFlgAtivo(Boolean flgAtivo) {
		this.flgAtivo = flgAtivo;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
