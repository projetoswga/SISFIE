package br.com.sisfie.entidade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "esfera_governo", catalog = "SISFIE")
@Audited
public class EsferaGoverno extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_esfera_gov", unique = true, nullable = false)
	@SequenceGenerator(name = "EsferaGoverno", allocationSize = 1, sequenceName = "esfera_governo_id_esfera_gov_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "EsferaGoverno")
	private Integer id;

	@Column(name = "dsc_esfera_gov", nullable = false)
	private String descricao;

	@Column(name = "flg_ativo", nullable = false)
	private Boolean flgAtivo;
	
	@SuppressWarnings("unused")
	@Transient
	private String ativoFormat;

	public EsferaGoverno() {
	}

	public EsferaGoverno(Integer id) {
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

	public String getAtivoFormat() {
		if (flgAtivo != null && flgAtivo) {
			return "Sim";
		} else {
			return "Não";
		}
	}

	public void setAtivoFormat(String ativoFormat) {
		this.ativoFormat = ativoFormat;
	}

}
