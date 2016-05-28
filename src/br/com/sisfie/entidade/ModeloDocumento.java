package br.com.sisfie.entidade;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "modelo_documento", catalog = "SISFIE")
@Audited
public class ModeloDocumento extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;
	@Id
	@Column(name = "id_modelo_documento", unique = true, nullable = false)
	@SequenceGenerator(name = "modelo_documento_id_modelo_documento_seq", sequenceName = "modelo_documento_id_modelo_documento_seq", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "modelo_documento_id_modelo_documento_seq")
	private Integer id;

	@Column(name = "nome", nullable = false)
	private String nome;

	@Column(name = "url", nullable = false, columnDefinition = "text")
	private String url;

	@Column(name = "nom_tipo", nullable = false)
	private String nomTipo;

	@Column(name = "sigla")
	private String sigla;

	@Column(name = "flg_ativo", nullable = false)
	private Boolean flgAtivo;

	@Column(name = "ativo")
	private Boolean ativo;

	@Temporal(TemporalType.DATE)
	@Column(name = "dt_cadastro", nullable = false, length = 13)
	private Date dataCadastro;

	@Transient
	private String ativoFormat;

	public ModeloDocumento() {
	}

	public ModeloDocumento(Integer id) {
		this.id = id;
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

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getNomTipo() {
		return nomTipo;
	}

	public void setNomTipo(String nomTipo) {
		this.nomTipo = nomTipo;
	}

	public String getSigla() {
		return sigla;
	}

	public void setSigla(String sigla) {
		this.sigla = sigla;
	}

	public Boolean getAtivo() {
		return ativo;
	}

	public void setAtivo(Boolean ativo) {
		this.ativo = ativo;
	}

	public Date getDataCadastro() {
		return dataCadastro;
	}

	public void setDataCadastro(Date dataCadastro) {
		this.dataCadastro = dataCadastro;
	}

}
