package br.com.sisfie.entidade;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;
import br.com.arquitetura.util.DateUtil;

@Entity
@Table(name = "inscricao_curso", catalog = "SISFIE")
@Audited
public class InscricaoCurso extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_inscricao_curso", unique = true, nullable = false)
	@SequenceGenerator(name = "InscricaoCurso", sequenceName = "inscricao_curso_id_inscricao_curso_seq", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "InscricaoCurso")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_candidato", nullable = false)
	private Candidato candidato;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_curso", nullable = false)
	private Curso curso;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_situacao", nullable = false)
	private Situacao situacao;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_turma", nullable = false)
	private Turma turma;

	@Temporal(TemporalType.TIMESTAMP)
	@Column(name = "dt_cadastro", nullable = false, length = 13)
	private Date dtCadastro;

	@Column(name = "num_inscricao")
	private String inscricao;

	@Column(name = "ano_homologacao")
	private Integer anoHomologacao;
	
	@Column(name = "flg_parceiro")
	private Boolean flgParceiro;
	
	@Column(name = "flg_instrutor")
	private Boolean flgInstrutor;

	@OneToMany(mappedBy = "inscricaoCurso", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private Set<StatusInscricao> statusInscricoes = new HashSet<StatusInscricao>(0);

	@OneToMany(mappedBy = "inscricaoCurso", fetch = FetchType.LAZY)
	private List<InscricaoComprovante> comprovantes = new ArrayList<InscricaoComprovante>();
	
	@OneToMany(mappedBy = "inscricaoCurso", fetch = FetchType.LAZY)
	private List<InscricaoDocumento> documentos = new ArrayList<InscricaoDocumento>();

	@OneToMany(mappedBy = "inscricaoCurso", fetch = FetchType.LAZY)
	private Set<InscricaoInfoComplementar> inscricaoInfoComplemento = new HashSet<InscricaoInfoComplementar>(0);
	
	@OneToMany(mappedBy = "inscricaoCurso", fetch = FetchType.LAZY)
	private Set<SelecaoOficina> selecaoOficina = new HashSet<SelecaoOficina>(0);
	
	@OneToMany(mappedBy = "inscricaoCurso", fetch = FetchType.LAZY)
	private Set<Frequencia> frequencias = new HashSet<Frequencia>(0);

	@Transient
	private String dtCadastroFormat;

	@ManyToOne
	@JoinColumn(name = "id_ultimo_status_inscricao", nullable = true)
	private StatusInscricao ultimoStatus;

	public InscricaoCurso() {
	}

	public InscricaoCurso(Integer id) {
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

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public Situacao getSituacao() {
		return situacao;
	}

	public void setSituacao(Situacao situacao) {
		this.situacao = situacao;
	}

	public Date getDtCadastro() {
		return dtCadastro;
	}

	public void setDtCadastro(Date dtCadastro) {
		this.dtCadastro = dtCadastro;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getDtCadastroFormat() {
		if (dtCadastro != null) {
			return DateUtil.getDataHora(dtCadastro, "dd/MM/yyyy HH:mm");
		}
		return dtCadastroFormat;
	}

	public void setDtCadastroFormat(String dtCadastroFormat) {
		this.dtCadastroFormat = dtCadastroFormat;
	}

	public Set<StatusInscricao> getStatusInscricoes() {
		return statusInscricoes;
	}

	public void setStatusInscricoes(Set<StatusInscricao> statusInscricoes) {
		this.statusInscricoes = statusInscricoes;
	}

	public StatusInscricao getUltimoStatus() {
		return ultimoStatus;
	}

	public void setUltimoStatus(StatusInscricao ultimoStatus) {
		this.ultimoStatus = ultimoStatus;
	}

	public List<InscricaoComprovante> getComprovantes() {
		return comprovantes;
	}

	public void setComprovantes(List<InscricaoComprovante> comprovantes) {
		this.comprovantes = comprovantes;
	}

	public String getInscricao() {
		return inscricao;
	}

	public void setInscricao(String inscricao) {
		this.inscricao = inscricao;
	}

	public Integer getAnoHomologacao() {
		return anoHomologacao;
	}

	public void setAnoHomologacao(Integer anoHomologacao) {
		this.anoHomologacao = anoHomologacao;
	}

	public Set<InscricaoInfoComplementar> getInscricaoInfoComplemento() {
		return inscricaoInfoComplemento;
	}

	public void setInscricaoInfoComplemento(Set<InscricaoInfoComplementar> inscricaoInfoComplemento) {
		this.inscricaoInfoComplemento = inscricaoInfoComplemento;
	}

	public Turma getTurma() {
		return turma;
	}

	public void setTurma(Turma turma) {
		this.turma = turma;
	}

	public Set<SelecaoOficina> getSelecaoOficina() {
		return selecaoOficina;
	}

	public void setSelecaoOficina(Set<SelecaoOficina> selecaoOficina) {
		this.selecaoOficina = selecaoOficina;
	}

	public List<InscricaoDocumento> getDocumentos() {
		return documentos;
	}

	public void setDocumentos(List<InscricaoDocumento> documentos) {
		this.documentos = documentos;
	}

	public Boolean getFlgParceiro() {
		return flgParceiro;
	}

	public void setFlgParceiro(Boolean flgParceiro) {
		this.flgParceiro = flgParceiro;
	}

	public Set<Frequencia> getFrequencias() {
		return frequencias;
	}

	public void setFrequencias(Set<Frequencia> frequencias) {
		this.frequencias = frequencias;
	}

	public Boolean getFlgInstrutor() {
		return flgInstrutor;
	}

	public void setFlgInstrutor(Boolean flgInstrutor) {
		this.flgInstrutor = flgInstrutor;
	}

}
