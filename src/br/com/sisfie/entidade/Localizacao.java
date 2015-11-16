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
@Table(name = "localizacao", catalog = "SISFIE")
@Audited
public class Localizacao extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_localizacao", unique = true, nullable = false)
	@SequenceGenerator(name = "Localizacao", allocationSize = 1, sequenceName = "localizacao_id_localizacao_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Localizacao")
	private Integer id;

	@Column(name = "den_localizacao", nullable = false)
	private String descricao;

	@Column(name = "desc_localizacao")
	private String detalhamento;

	public Localizacao() {
	}

	public Localizacao(Integer id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public String getDetalhamento() {
		return detalhamento;
	}

	public void setDetalhamento(String detalhamento) {
		this.detalhamento = detalhamento;
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
