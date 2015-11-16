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
@Table(name = "situacao_d", catalog = "SISFIE")
@Audited
public class Situacao extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	public static final Integer ESPERA = 1;
	public static final Integer INSCRITO = 2;

	
	@Id
	@Column(name = "id_situacao", unique = true, nullable = false)
	@SequenceGenerator(name = "Situacao", allocationSize = 1, sequenceName = "situacao_d_id_situacao_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Situacao")
	private Integer id;

	@Column(name = "dsc_situacao", nullable = false)
	private String descricao;

	@Column(name = "flg_ativo", nullable = false)
	private Boolean flgAtivo;

	public Situacao() {
	}

	public Situacao(Integer id) {
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
