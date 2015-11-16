package br.com.sisfie.entidade;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.sql.SQLException;
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
import javax.persistence.Transient;

import org.hibernate.envers.Audited;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;

import br.com.arquitetura.entidade.Entidade;
import br.com.arquitetura.excecao.ExcecaoUtil;

@Entity
@Table(name = "inscricao_documento", catalog = "SISFIE")
@Audited
public class InscricaoDocumento extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_inscricao_documento", unique = true, nullable = false)
	@SequenceGenerator(name = "InscricaoDocumento", sequenceName = "inscricao_documento_id_inscricao_documento_seq", allocationSize = 1)
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "InscricaoDocumento")
	private Integer id;

	@Temporal(TemporalType.DATE)
	@Column(name = "dt_cadastro")
	private Date dtCadastro;

	@Column(name = "nom_arquivo")
	private String nomArquivo;

	@Column(name = "nom_tipo")
	private String nomTipo;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_inscricao_curso")
	private InscricaoCurso inscricaoCurso;

	@Column(name = "URL_DOCUMENTO")
	private String urlImagem;

	@Transient
	private byte[] imgDocumento;

	@Transient
	private StreamedContent content;

	public InscricaoDocumento() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDtCadastro() {
		return this.dtCadastro;
	}

	public void setDtCadastro(Date dtCadastro) {
		this.dtCadastro = dtCadastro;
	}

	public String getNomArquivo() {
		return this.nomArquivo;
	}

	public void setNomArquivo(String nomArquivo) {
		this.nomArquivo = nomArquivo;
	}

	public String getNomTipo() {
		return this.nomTipo;
	}

	public void setNomTipo(String nomTipo) {
		this.nomTipo = nomTipo;
	}

	public InscricaoCurso getInscricaoCurso() {
		return this.inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public void setContent(StreamedContent content) {
		this.content = content;
	}

	public StreamedContent getContent() throws SQLException {
		try {
			
			if(imgDocumento != null){
				InputStream is = new ByteArrayInputStream(imgDocumento);
				content = new DefaultStreamedContent(is, this.getNomTipo(), this.getNomArquivo());
			}else if (urlImagem != null) {
				File file = new File(urlImagem);
				InputStream is = new FileInputStream(file);
				content = new DefaultStreamedContent(is, this.getNomTipo(), this.getNomArquivo());
			}
			
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return content;
	}

	public byte[] getImgDocumento() {
		return imgDocumento;
	}

	public void setImgDocumento(byte[] imgDocumento) {
		this.imgDocumento = imgDocumento;
	}

	public String getUrlImagem() {
		return urlImagem;
	}

	public void setUrlImagem(String urlImagem) {
		this.urlImagem = urlImagem;
	}

}