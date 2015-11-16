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
@Table(name = "uf", catalog = "SISFIE")
@Audited
public class Uf extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_uf", unique = true, nullable = false)
	@SequenceGenerator(name = "Uf", allocationSize = 1, sequenceName = "uf_id_uf_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Uf")
	private Integer id;

	@Column(name = "sigla", nullable = false)
	private String sigla;

	@Column(name = "descricao", nullable = false)
	private String descricao;

	public Uf() {
	}

	public Uf(Integer id) {
		this.id = id;
	}

	public String getSigla() {
		return sigla;
	}

	public void setSigla(String sigla) {
		this.sigla = sigla;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
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
