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
import br.com.arquitetura.util.Combo;

@Entity
@Table(name = "setor_responsavel_esaf", catalog = "SISFIE")
@Audited
public class SetorResponsavelEsaf extends Entidade<Integer> implements Combo {

	private static final long serialVersionUID = 1L;
	@Id
	@Column(name = "id_setor_responsavel_esaf", unique = true, nullable = false)
	@SequenceGenerator(name = "setor_responsavel_esaf_seq", sequenceName = "setor_responsavel_esaf_id_setor_responsavel_esaf_seq", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "setor_responsavel_esaf_seq")
	private Integer id;

	@Column(name = "nome_setor", nullable = false)
	private String nome;

	@Column(name = "sigla", nullable = false)
	private String sigla;

	@Column(name = "flg_ativo")
	private Boolean flgAtivo;

	@Transient
	private String ativoFormat;

	public SetorResponsavelEsaf() {
	}

	public SetorResponsavelEsaf(Integer id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getSigla() {
		return sigla;
	}

	public void setSigla(String sigla) {
		this.sigla = sigla;
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

	@Override
	public String getValue() {
		return nome;
	}

}
