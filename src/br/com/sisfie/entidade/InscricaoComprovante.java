package br.com.sisfie.entidade;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.net.URL;
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
import br.com.sisfie.util.Constantes;

@Entity
@Table(name = "inscricao_comprovante", catalog = "SISFIE")
@Audited
public class InscricaoComprovante extends Entidade<Integer> {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_inscricao_comprovante", unique = true, nullable = false)
	@SequenceGenerator(name = "InscricaoComprovante", allocationSize = 1, sequenceName = "inscricao_comprovante_id_inscricao_comprovante_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "InscricaoComprovante")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_inscricao_curso", nullable = false)
	private InscricaoCurso inscricaoCurso;

	@Temporal(TemporalType.DATE)
	@Column(name = "dt_cadastro", nullable = false, length = 13)
	private Date dtCadastro;

	@Column(name = "nom_arquivo", nullable = false)
	private String nome;

	@Column(name = "nom_tipo", nullable = false)
	private String tipo;

	@Column(name = "URL_COMPROVANTE")
	private String urlImagem;

	@Transient
	private byte[] imgComprovante;

	@Transient
	private StreamedContent content;

	public InscricaoComprovante() {
	}

	public InscricaoComprovante(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDtCadastro() {
		return dtCadastro;
	}

	public void setDtCadastro(Date dtCadastro) {
		this.dtCadastro = dtCadastro;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public byte[] getImgComprovante() {
		return imgComprovante;
	}

	public void setImgComprovante(byte[] imgComprovante) {
		this.imgComprovante = imgComprovante;
	}

	public StreamedContent getContent() throws SQLException {
		try {

			if(Constantes.ATIVA_IMG_LINK){
				/*
				 * Conforme solicitação do SERPRO as imagens serão acessadas via link
				 */
				if (nome != null && !nome.isEmpty()) {
					/*
					 * Ex: http://localhost:8080/SISFIE/resources/design/imagem/+cabecalho.jpg
					 */
					InputStream is = new URL(Constantes.PATH_LINK_IMG + nome).openStream();
					content = new DefaultStreamedContent(is, this.getTipo(), this.getNome());
				}
			}else{
				File file = new File(urlImagem);
				InputStream is = new FileInputStream(file);
				content = new DefaultStreamedContent(is, this.getTipo(), this.getNome());
			}
			

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return content;
	}

	public String getUrlImagem() {
		return urlImagem;
	}

	public void setUrlImagem(String urlImagem) {
		this.urlImagem = urlImagem;
	}
}
