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
@Table(name = "opcao_lista_candidato", catalog = "SISFIE")
@Audited
public class OpcaoListaCandidato extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;
	
	public static final Integer LISTA_ESPERA_REGIAO = 1;
	public static final Integer LISTA_ESPERA_GERAL = 2;
	public static final Integer NAO_POSSUI_LISTA_ESPERA = 3;

	@Id
	@Column(name = "id_opcao_lista_cand", unique = true, nullable = false)
	@SequenceGenerator(name = "OpcaoListaCandidato", allocationSize = 1, sequenceName = "opcao_lista_candidato_id_opcao_lista_cand_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "OpcaoListaCandidato")
	private Integer id;

	@Column(name = "dsc_opcao_list_cand", nullable = false)
	private String descricao;

	@Column(name = "flg_ativo", nullable = false)
	private Boolean flgAtivo;

	public OpcaoListaCandidato() {
	}

	public OpcaoListaCandidato(Integer id) {
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
