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
@Table(name = "codigo_livro_anual", catalog = "SISFIE")
@Audited
public class CodigoLivroAnual extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;
	@Id
	@Column(name = "ID_COD_ANUAL", unique = true, nullable = false)
	@SequenceGenerator(name = "codigo", sequenceName = "codigo_livro_anual_id_cod_anual_seq",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "codigo")
	private Integer id;

	@Column(name = "ano", nullable = false)
	private Integer ano;

	@Column(name = "codigo" )
	private Integer codigo;

	
	public CodigoLivroAnual() {
	}
	

	public CodigoLivroAnual(Integer id, Integer ano, Integer codigo) {
		super();
		this.id = id;
		this.ano = ano;
		this.codigo = codigo;
	}


	public CodigoLivroAnual(Integer id) {
		this.id = id;
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

	public Integer getAno() {
		return ano;
	}

	public void setAno(Integer ano) {
		this.ano = ano;
	}

	public Integer getCodigo() {
		return codigo;
	}

	public void setCodigo(Integer codigo) {
		this.codigo = codigo;
	}

	
}
