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
}
