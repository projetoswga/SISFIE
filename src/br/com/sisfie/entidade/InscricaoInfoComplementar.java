package br.com.sisfie.entidade;

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "INSCRICAO_INFOR_COMPLEMENTAR", catalog = "SISFIE")
@Audited
public class InscricaoInfoComplementar extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "ID_INSCR_INFOR_COMPLEMENTAR", unique = true, nullable = false)
	@SequenceGenerator(name = "InscricaoInfoComplementar", sequenceName = "inscricao_infor_complementar_id_inscr_infor_complementar_seq", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "InscricaoInfoComplementar")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_INSCRICAO_CURSO", nullable = false)
	private InscricaoCurso inscricaoCurso;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_ORGAO", nullable = false)
	private Orgao orgao;

	@Column(name = "NUM_EMPENHO")
	private String numeroEmpenho;

	@Column(name = "END_ORGAO_COMPLETO")
	private String enderecoOrgaoComplemento;

	@Column(name = "CNPJ")
	private String cnpj;

	@Column(name = "CONTATO")
	private String contato;

	@Column(name = "TEL_SETOR_FINANC")
	private String telefoneFinanceiro;

	public InscricaoInfoComplementar() {
	}

	public InscricaoInfoComplementar(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public Orgao getOrgao() {
		return orgao;
	}

	public void setOrgao(Orgao orgao) {
		this.orgao = orgao;
	}

	public String getNumeroEmpenho() {
		return numeroEmpenho;
	}

	public void setNumeroEmpenho(String numeroEmpenho) {
		this.numeroEmpenho = numeroEmpenho;
	}

	public String getEnderecoOrgaoComplemento() {
		return enderecoOrgaoComplemento;
	}

	public void setEnderecoOrgaoComplemento(String enderecoOrgaoComplemento) {
		this.enderecoOrgaoComplemento = enderecoOrgaoComplemento;
	}

	public String getCnpj() {
		return cnpj;
	}

	public void setCnpj(String cnpj) {
		this.cnpj = cnpj;
	}

	public String getContato() {
		return contato;
	}

	public void setContato(String contato) {
		this.contato = contato;
	}

	public String getTelefoneFinanceiro() {
		return telefoneFinanceiro;
	}

	public void setTelefoneFinanceiro(String telefoneFinanceiro) {
		this.telefoneFinanceiro = telefoneFinanceiro;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
