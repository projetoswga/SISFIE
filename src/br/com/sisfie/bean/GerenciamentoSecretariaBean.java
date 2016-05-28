package br.com.sisfie.bean;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoCursoCertificado;
import br.com.sisfie.entidade.ModeloDocumento;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.FrequenciaService;
import br.com.sisfie.service.SecretariaService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.CriptoUtil;

@ManagedBean(name = "gerenciamentoSecretariaBean")
@ViewScoped
public class GerenciamentoSecretariaBean extends PaginableBean<InscricaoCursoCertificado> {

	private static final long serialVersionUID = -8294188998250807722L;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{frequenciaService}")
	protected FrequenciaService frequenciaService;
	
	@ManagedProperty(value = "#{secretariaService}")
	protected SecretariaService secretariaService;

	List<InscricaoCursoCertificado> listaInscricaoCursoCertificados;
	private List<InscricaoCurso> listaInscricoesAprovadas;
	private InscricaoCurso [] inscricoesSelecionadas;
	private List<Curso> listaArquivosFrequencia;
	private List<ModeloDocumento> modeloCertificados;
	private boolean exibirConteudo;
	private Integer idModeloDocumento;
	private Curso curso;
	
	public GerenciamentoSecretariaBean() {
		listaInscricaoCursoCertificados = new ArrayList<>();
		listaInscricoesAprovadas = new ArrayList<>();
		listaArquivosFrequencia = new ArrayList<>();
		modeloCertificados = new ArrayList<>();
		curso = new Curso();
	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		Curso curso = new Curso();
		curso.setTitulo(query);
		try {
			sugestoes = cursoService.recuperarCursos(curso);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return sugestoes;
	}

	@SuppressWarnings("unchecked")
	public void carregarListas() {
		listaInscricoesAprovadas = new ArrayList<>();
		listaArquivosFrequencia = new ArrayList<>();
		List<InscricaoCurso> listaInscricoesReprovadas = new ArrayList<>();
		
		if (modeloCertificados == null || modeloCertificados.isEmpty()){
			modeloCertificados = universalManager.getAll(ModeloDocumento.class);
		}
		
		List<InscricaoCurso> listaCandidatoConfirmados = cursoService.carregarListaCandidatoConfirmados(curso);

		exibirConteudo = frequenciaService.carregarListas(listaInscricoesAprovadas, listaInscricoesReprovadas, listaArquivosFrequencia,
				listaCandidatoConfirmados, curso);
		
		if (listaInscricoesAprovadas != null && !listaInscricoesAprovadas.isEmpty()){
			List<Integer> idsInscricoesAprovadas = new ArrayList<>();
			for (InscricaoCurso inscricaoCurso : listaInscricoesAprovadas) {
				idsInscricoesAprovadas.add(inscricaoCurso.getId());
			}
			listaInscricaoCursoCertificados = new ArrayList<>();
			listaInscricaoCursoCertificados = secretariaService.recuperarInscricoesJaHomologadas(idsInscricoesAprovadas);
			for (InscricaoCursoCertificado inscricaoCursoCertificado : listaInscricaoCursoCertificados) {
				if (idsInscricoesAprovadas.contains(inscricaoCursoCertificado.getInscricaoCurso().getId())){
					listaInscricoesAprovadas.remove(inscricaoCursoCertificado.getInscricaoCurso());
				}
			}
		}
	}
	
	public void baixarArquivoFrequencia(Integer id, String tipo) {
		try {
			String url = Constantes.URL_COMPROVANTE + "loadImagemBD?idImagemDownload=" + id + "&tipo=" + tipo;
			FacesContext.getCurrentInstance().getExternalContext().redirect(url);
		} catch (IOException e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}
	
	public void salvarHomologacao(){
		try {
			if (idModeloDocumento == null || idModeloDocumento == 0){
				FacesMessagesUtil.addErrorMessage("", "Nenhum modelo de certificado informado!");
				return;
			}
			if (inscricoesSelecionadas == null || inscricoesSelecionadas.length == 0){
				FacesMessagesUtil.addErrorMessage("", "Nenhuma inscrição selecionada!");
				return;
			}
			for (InscricaoCurso inscricaoCurso : inscricoesSelecionadas) {
				InscricaoCursoCertificado inscricaoCursoCertificado = new InscricaoCursoCertificado();
				inscricaoCursoCertificado.setFlgHomologado(true);
				inscricaoCursoCertificado.setModeloDocumento(new ModeloDocumento(idModeloDocumento));
				inscricaoCursoCertificado.setKeyAutenticacao(CriptoUtil.getCriptografia(inscricaoCurso.getInscricao()));
				inscricaoCursoCertificado.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));
				universalManager.save(inscricaoCursoCertificado);
				if (listaInscricaoCursoCertificados == null){
					listaInscricaoCursoCertificados = new ArrayList<>();
				}
				inscricaoCursoCertificado = (InscricaoCursoCertificado) universalManager.get(InscricaoCursoCertificado.class, inscricaoCursoCertificado.getId());
				listaInscricaoCursoCertificados.add(inscricaoCursoCertificado);
				listaInscricoesAprovadas.remove(inscricaoCurso);
			}
			FacesMessagesUtil.addInfoMessage("", "Inscrições homologadas com sucesso!");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	@PostConstruct
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_AREA");
	}

	@Override
	public InscricaoCursoCertificado createModel() {
		return new InscricaoCursoCertificado();
	}

	@Override
	public String getQualifiedName() {
		return "Certificado";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public List<InscricaoCurso> getListaInscricoesAprovadas() {
		return listaInscricoesAprovadas;
	}

	public void setListaInscricoesAprovadas(List<InscricaoCurso> listaInscricoesAprovadas) {
		this.listaInscricoesAprovadas = listaInscricoesAprovadas;
	}

	public List<Curso> getListaArquivosFrequencia() {
		return listaArquivosFrequencia;
	}

	public void setListaArquivosFrequencia(List<Curso> listaArquivosFrequencia) {
		this.listaArquivosFrequencia = listaArquivosFrequencia;
	}

	public FrequenciaService getFrequenciaService() {
		return frequenciaService;
	}

	public void setFrequenciaService(FrequenciaService frequenciaService) {
		this.frequenciaService = frequenciaService;
	}

	public boolean isExibirConteudo() {
		return exibirConteudo;
	}

	public void setExibirConteudo(boolean exibirConteudo) {
		this.exibirConteudo = exibirConteudo;
	}

	public List<ModeloDocumento> getModeloCertificados() {
		return modeloCertificados;
	}

	public void setModeloCertificados(List<ModeloDocumento> modeloCertificados) {
		this.modeloCertificados = modeloCertificados;
	}

	public SecretariaService getSecretariaService() {
		return secretariaService;
	}

	public void setSecretariaService(SecretariaService secretariaService) {
		this.secretariaService = secretariaService;
	}

	public List<InscricaoCursoCertificado> getListaInscricaoCursoCertificados() {
		return listaInscricaoCursoCertificados;
	}

	public void setListaInscricaoCursoCertificados(List<InscricaoCursoCertificado> listaInscricaoCursoCertificados) {
		this.listaInscricaoCursoCertificados = listaInscricaoCursoCertificados;
	}

	public InscricaoCurso[] getInscricoesSelecionadas() {
		return inscricoesSelecionadas;
	}

	public void setInscricoesSelecionadas(InscricaoCurso[] inscricoesSelecionadas) {
		this.inscricoesSelecionadas = inscricoesSelecionadas;
	}

	public Integer getIdModeloDocumento() {
		return idModeloDocumento;
	}

	public void setIdModeloDocumento(Integer idModeloDocumento) {
		this.idModeloDocumento = idModeloDocumento;
	}
}
