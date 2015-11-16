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
@Table(name = "campo_preenchimento", catalog = "SISFIE")
@Audited
public class CampoPreenchimento extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;
	
	public static final Integer DADOS_BANCARIO = 1;
	public static final Integer NIVEL_ENSINO = 2;
	public static final Integer EXPERIENCIA_PROFISSIONAL = 3;
	
	@Id
	@Column(name = "id_campo_preenchimento", unique = true, nullable = false)
	@SequenceGenerator(name = "CampoPreenchimento", sequenceName = "campo_preenchimento_id_campo_preenchimento_seq",allocationSize=1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CampoPreenchimento")
	private Integer id;

	@Column(name = "dsc_campo_preenchimento", nullable = false)
	private String descricao;

	@Column(name = "flg_ativo", nullable = false)
	private Boolean flgAtivo;

	public CampoPreenchimento() {
	}

	public CampoPreenchimento(Integer id) {
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

}
