package br.com.sisfie.entidade;

import java.util.Date;

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
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "inscricao_curso_certificado", catalog = "SISFIE")
@Audited
public class InscricaoCursoCertificado extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;
	@Id
	@Column(name = "id_insc_curso_certificado", unique = true, nullable = false)
	@SequenceGenerator(name = "inscricao_curso_certificado_id_insc_curso_certificado_seq", sequenceName = "inscricao_curso_certificado_id_insc_curso_certificado_seq", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "inscricao_curso_certificado_id_insc_curso_certificado_seq")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_modelo_documento")
	private ModeloDocumento modeloDocumento;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_inscricao_curso")
	private InscricaoCurso inscricaoCurso;

	@Column(name = "key_autenticacao", columnDefinition = "text")
	private String keyAutenticacao;

	@Column(name = "flg_homologado")
	private Boolean flgHomologado;

	@Column(name = "codigo_livro")
	private Integer codigoLivro;

	@Column(name = "cont_programatico_docente", columnDefinition = "text")
	private String conteudoProgramaticoDocente;

	@Column(name = "cont_programatico_participante", columnDefinition = "text")
	private String conteudoProgramaticoParticipante;
	@Column(name = "diretor", columnDefinition = "text")
	private String diretor;

	@Temporal(TemporalType.DATE)
	@Column(name = "dt_publ_livro", length = 13)
	private Date dataPublicacaoLivro;
	@Column(name = "ano")
	private Integer ano;

	public InscricaoCursoCertificado() {
	}

	public InscricaoCursoCertificado(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public ModeloDocumento getModeloDocumento() {
		return modeloDocumento;
	}

	public void setModeloDocumento(ModeloDocumento modeloDocumento) {
		this.modeloDocumento = modeloDocumento;
	}

	public String getKeyAutenticacao() {
		return keyAutenticacao;
	}

	public void setKeyAutenticacao(String keyAutenticacao) {
		this.keyAutenticacao = keyAutenticacao;
	}

	public Boolean getFlgHomologado() {
		return flgHomologado;
	}

	public void setFlgHomologado(Boolean flgHomologado) {
		this.flgHomologado = flgHomologado;
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public Integer getCodigoLivro() {
		return codigoLivro;
	}

	public void setCodigoLivro(Integer codigoLivro) {
		this.codigoLivro = codigoLivro;
	}

	public String getConteudoProgramaticoDocente() {
		return conteudoProgramaticoDocente;
	}

	public void setConteudoProgramaticoDocente(String conteudoProgramaticoDocente) {
		this.conteudoProgramaticoDocente = conteudoProgramaticoDocente;
	}

	public String getConteudoProgramaticoParticipante() {
		return conteudoProgramaticoParticipante;
	}

	public void setConteudoProgramaticoParticipante(String conteudoProgramaticoParticipante) {
		this.conteudoProgramaticoParticipante = conteudoProgramaticoParticipante;
	}

	public Date getDataPublicacaoLivro() {
		return dataPublicacaoLivro;
	}

	public void setDataPublicacaoLivro(Date dataPublicacaoLivro) {
		this.dataPublicacaoLivro = dataPublicacaoLivro;
	}

	public String getDiretor() {
		return diretor;
	}

	public void setDiretor(String diretor) {
		this.diretor = diretor;
	}

	public Integer getAno() {
		return ano;
	}

	public void setAno(Integer ano) {
		this.ano = ano;
	}
	
	
	
}
