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
@Table(name = "area", catalog = "SISFIE")
@Audited
public class Area extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;
	@Id
	@Column(name = "id_area", unique = true, nullable = false)
	@SequenceGenerator(name = "area_seq", sequenceName = "area_id_area_seq", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "area_seq")
	private Integer id;

	@Column(name = "den_area", nullable = false)
	private String descricao;

	@Column(name = "desc_area", columnDefinition = "text")
	private String detalhamento;

	@Column(name = "flg_ativo")
	private Boolean flgAtivo;

	@SuppressWarnings("unused")
	@Transient
	private String ativoFormat;

	public Area() {
	}

	public Area(Integer id) {
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
