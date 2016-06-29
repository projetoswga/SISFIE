package br.com.sisfie.bean;

import java.io.File;
import java.io.FileOutputStream;
import java.util.Date;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.UploadedFile;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.ModeloDocumento;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.ImagemUtil;

@ManagedBean(name = "areaBean")
@ViewScoped
public class AreaBean extends PaginableBean<ModeloDocumento> {

	private static final long serialVersionUID = -8294188998250807722L;
	private UploadedFile file;
	private String filename;
	
	
	private FileUploadEvent event;
	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	public CursoService getCursoService() {
		return cursoService;
	}


	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}


	public AreaBean() {
	}
	

	@Override
	public Map<String, String> getFilters() {
		return null;
	}
	public void anexarArquivo(FileUploadEvent event) {
		try {
			 filename = ImagemUtil.criarNomeArquivo(event.getFile().getFileName(), null);

			this.event = event;
			
			
			// Força a criação do arquivo no file system

			FacesMessagesUtil.addInfoMessage(" ", "Clique em salvar para concluir o modelo de documento");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	
	public void saveModel(){
		try{
			if(getModel().getSigla().equals("")){
				FacesMessagesUtil.addErrorMessage("Campo Sigla é obrigatório.");
				return;
			}
			ModeloDocumento documento = getModel();
			documento.setFlgAtivo(Boolean.TRUE);
			documento.setDataCadastro(new Date());
			documento.setNome(filename);
			documento.setNomTipo(event.getFile().getContentType());
//			documento.setFlgAtivo();
			
			String os = System.getProperty("os.name");
			/* Descobre se linux ou windows */
			if (os.contains("win") || os.trim().toLowerCase().contains("windows") || os.trim().toLowerCase().contains("win")) {
				documento.setUrl(Constantes.PATH_IMG_WINDOWS + filename);
			} else {
				documento.setUrl(Constantes.PATH_IMG_LINUX + filename);
			}

//			documento.setInscricaoCurso(new InscricaoCurso(inscricaoCursoSelecionado.getId()));
			documento.setModeloDoc(event.getFile().getContents());
		FileOutputStream fos = new FileOutputStream(new File(documento.getUrl()));
		
		fos.write(event.getFile().getContents());
		fos.close();
		cursoService.saveAnexo(documento);
		setModel(new ModeloDocumento());
		FacesMessagesUtil.addInfoMessage(" ", "Arquivo " + event.getFile().getFileName() + " adicionado com sucesso!");
		}catch(Exception e){
			ExcecaoUtil.tratarExcecao(e);
			FacesMessagesUtil.addErrorMessage("Erro ao realizar operação " + e.getMessage());
			e.printStackTrace();
		}
		
	}
	
	public void ativacaoModelo(ModeloDocumento modelo){
		try {
			if(modelo!=null){
				if(modelo.getFlgAtivo()){
					modelo.setFlgAtivo(Boolean.FALSE);
					modelo.setImageAtivo("icone-cancelar.png");
				}else{
					modelo.setFlgAtivo(Boolean.TRUE);
					modelo.setImageAtivo("icone-finalizar.png");
				}
				universalManager.save(modelo);
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}
	
	@Override
	@PostConstruct
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_AREA");
	}

	@Override
	public ModeloDocumento createModel() {
		return new ModeloDocumento();
	}

	@Override
	public String getQualifiedName() {
		return "Modelo Documento";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}


	public UploadedFile getFile() {
		return file;
	}


	public void setFile(UploadedFile file) {
		this.file = file;
	}


	public String getFilename() {
		return filename;
	}


	public void setFilename(String filename) {
		this.filename = filename;
	}

	public FileUploadEvent getEvent() {
		return event;
	}


	public void setEvent(FileUploadEvent event) {
		this.event = event;
	}


	
	
	
	
}
