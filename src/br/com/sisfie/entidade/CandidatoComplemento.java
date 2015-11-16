package br.com.sisfie.entidade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "candidato_complemento", catalog = "SISFIE")
@Audited
public class CandidatoComplemento extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_candidato_complemento", unique = true, nullable = false)
	@SequenceGenerator(name = "CandidatoComplemento", sequenceName = "candidato_complemento_id_candidato_complemento_seq", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "CandidatoComplemento")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_candidato")
	private Candidato candidato;

	// numero do banco
	@Column(name = "num_banco")
	private String banco;

	@Column(name = "ag_banco")
	private String agencia;

	@Column(name = "cc_banco")
	private String contaCorrente;

	// es-ensino superior em - ensino medio
	// ef = ensino fundamental
	// me - mestrado do - doutorado
	// pd - pos doutorado
	@Column(name = "cod_educacional")
	private String codEducacional;

	// curso de formação da faculdade.
	@Column(name = "den_curso_educ")
	private String nomeCurso;

	@Column(name = "DSC_EXPERIENCIA_ATUAL", columnDefinition = "text")
	private String experienciaProfissionalAtual;

	@Column(name = "DSC_EXPERIENCIA_ANTER", columnDefinition = "text")
	private String experienciaProfissionalAnterior;

	@Column(name = "den_instituicao_educ")
	private String nomeInstituicao;

	public CandidatoComplemento() {
	}

	public CandidatoComplemento(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Candidato getCandidato() {
		return candidato;
	}

	public void setCandidato(Candidato candidato) {
		this.candidato = candidato;
	}

	public String getBanco() {
		return banco;
	}

	public void setBanco(String banco) {
		this.banco = banco;
	}

	public String getAgencia() {
		return agencia;
	}

	public void setAgencia(String agencia) {
		this.agencia = agencia;
	}

	public String getContaCorrente() {
		return contaCorrente;
	}

	public void setContaCorrente(String contaCorrente) {
		this.contaCorrente = contaCorrente;
	}

	public String getCodEducacional() {
		return codEducacional;
	}

	public void setCodEducacional(String codEducacional) {
		this.codEducacional = codEducacional;
	}

	public String getNomeCurso() {
		return nomeCurso;
	}

	public void setNomeCurso(String nomeCurso) {
		this.nomeCurso = nomeCurso;
	}

	public String getNomeInstituicao() {
		return nomeInstituicao;
	}

	public void setNomeInstituicao(String nomeInstituicao) {
		this.nomeInstituicao = nomeInstituicao;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getExperienciaProfissionalAtual() {
		return experienciaProfissionalAtual;
	}

	public void setExperienciaProfissionalAtual(String experienciaProfissionalAtual) {
		this.experienciaProfissionalAtual = experienciaProfissionalAtual;
	}

	public String getExperienciaProfissionalAnterior() {
		return experienciaProfissionalAnterior;
	}

	public void setExperienciaProfissionalAnterior(String experienciaProfissionalAnterior) {
		this.experienciaProfissionalAnterior = experienciaProfissionalAnterior;
	}

}
