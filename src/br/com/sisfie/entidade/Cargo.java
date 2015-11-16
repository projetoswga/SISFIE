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
@Table(name = "CARGO", catalog = "SISFIE")
@Audited
public class Cargo extends Entidade<Integer> {

	private static final long serialVersionUID = -5152126917909583763L;
	
	@Id
	@Column(name = "ID_CARGO", unique = true, nullable = false)
	@SequenceGenerator(name = "Cargo", sequenceName = "cargo_id_cargo_seq",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Cargo")
	private Integer id;
	
	@Column(name = "DSC_CARGO", nullable = false)
	private String descricao;
	
	@Column(name = "FLG_ATIVO", nullable = false)
	private Boolean flgAtivo;
	
	@SuppressWarnings("unused")
	@Transient
	private String ativoFormat;

	public Cargo() {
	}

	public Cargo( Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDescricao() {
		return this.descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public Boolean getFlgAtivo() {
		return this.flgAtivo;
	}

	public void setFlgAtivo(Boolean flgAtivo) {
		this.flgAtivo = flgAtivo;
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
