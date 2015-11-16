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
@Table(name = "homologacao", catalog = "SISFIE")
@Audited
public class Homologacao extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;
	public static final Integer CONFIRMACAO_PAGAMENTO = 1;
	public static final Integer CONFIRMACAO_CHEFE = 2;
	public static final Integer CONFIRMACAO_VIA_GRU = 3;
	public static final Integer CONFIRMACAO_NOTA_EMPENHO = 4;

	@Id
	@Column(name = "id_homologacao", unique = true, nullable = false)
	@SequenceGenerator(name = "Homologacao", allocationSize = 1, sequenceName = "homologacao_id_homologacao_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Homologacao")
	private Integer id;

	@Column(name = "dsc_homologacao", nullable = false)
	private String descricao;

	@Column(name = "flg_ativo", nullable = false)
	private Boolean flgAtivo;

	public Homologacao() {
	}

	public Homologacao(Integer id) {
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
