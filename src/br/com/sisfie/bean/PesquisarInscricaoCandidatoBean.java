package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import org.hibernate.Hibernate;
import org.primefaces.model.LazyDataModel;
import org.primefaces.model.SortOrder;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.DateUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Orgao;
import br.com.sisfie.entidade.Situacao;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.OrgaoService;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "pesquisarInscricaoCandidatoBean")
@ViewScoped
public class PesquisarInscricaoCandidatoBean extends PaginableBean<InscricaoCurso> {

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	@ManagedProperty(value = "#{OrgaoService}")
	protected OrgaoService orgaoService;

	private static final long serialVersionUID = -5254133636351416681L;
	private Integer cancelada;
	private Integer homologada;
	private Integer paga;
	private boolean solicitarPesquisa;
	private boolean mostrarBotaoHomologar;
	private boolean mostrarBotaoIsentar;
	private InscricaoCurso[] inscricoes;
	private String textoCancelar;
	private Integer countInscricao;
	private Curso cursoAutoComplete;
	private Integer idStatus;
	private List<Status> listaStatus;
	private List<Curso> cursos;
	private boolean semSelecaoOficina;

	public PesquisarInscricaoCandidatoBean() {
		inscricoes = null;
		lazyDataModel = getLazyDataModel();
		if (getModel().getCandidato() == null) {
			getModel().setCandidato(new Candidato());
		}
		if (getModel().getCurso() == null) {
			getModel().setCurso(new Curso());
		}
		cursoAutoComplete = new Curso();
		listaStatus = new ArrayList<Status>();
		cursos = new ArrayList<Curso>();
	}

	@SuppressWarnings("unchecked")
	@PostConstruct
	public void carregarStatus() {
		setListaStatus(universalManager.getAll(Status.class));
	}

	public List<Orgao> completeOrgao(String query) {
		List<Orgao> sugestoes = new ArrayList<Orgao>();
		try {
			sugestoes = orgaoService.pesquisarOrgao(query);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;

	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		Curso a = new Curso();
		a.setTitulo(query);
		try {
			List<Curso> listaBanco = cursoService.recuperarCursos(a);
			if (listaBanco != null && !listaBanco.isEmpty()) {
				for (Curso curso : listaBanco) {
					if (curso.getUsuario().getId().equals(loginBean.getModel().getId())
							|| acessoBean.verificarAcesso("ROLE_PESQ_ACESSO_GERAL")
							|| loginBean.getModel().getPerfil().getDescricao().equals(Constantes.PERFIL_SISFIE)) {
						sugestoes.add(curso);
					}
				}
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;

	}

	public void pesquisar() {
		try {
			solicitarPesquisa = Boolean.TRUE;
			mostrarBotaoHomologar = Boolean.TRUE;
			mostrarBotaoIsentar = Boolean.TRUE;
			removerMascaras();
			getLazyDataModel();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void removerMascaras() {
		if (getModel().getCurso().getCodigo() != null && !getModel().getCurso().getCodigo().isEmpty()) {
			getModel().getCurso().setCodigo(getModel().getCurso().getCodigo().trim().replaceAll("[.]", ""));
		}
	}

	@Override
	public LazyDataModel<InscricaoCurso> getLazyDataModel() {
		if (lazyDataModel == null && solicitarPesquisa)

			lazyDataModel = new LazyDataModel<InscricaoCurso>() {

				private static final long serialVersionUID = -3128388997477577261L;

				@SuppressWarnings("rawtypes")
				@Override
				public List<InscricaoCurso> load(int first, int pageSize, String sortField, SortOrder sortOrder, Map filters) {
					// Reduzindo o contador depois de filtrado
					try {
						countInscricao = inscricaoCursoService.countPesquisaInscricaoCandidato(getModel(), idStatus, cursos,
								semSelecaoOficina).intValue();
						lazyDataModel.setRowCount(countInscricao);
						List<InscricaoCurso> lista = inscricaoCursoService.paginatePesquisaInscricaoCandidato(first, pageSize, getModel(),
								idStatus, cursos, semSelecaoOficina);
						return lista;
					} catch (Exception e) {
						ExcecaoUtil.tratarExcecao(e);
					}
					return null;
				}

			};
		solicitarPesquisa = Boolean.FALSE;
		return lazyDataModel;
	}

	public void desfazerCancelamento() {
		try {
			setModel((InscricaoCurso) universalManager.get(InscricaoCurso.class, getModel().getId()));
			StatusInscricao si = new StatusInscricao(new InscricaoCurso(getModel().getId()), new Usuario(loginBean.getModel().getId()),
					new Status(getPenultimoStatus().getStatus().getId()), new Date());

			cursoService.desfazerCancelamento(getModel(), si);
			FacesMessagesUtil.addInfoMessage(" ", "Cancelamento desfeito " + ConstantesARQ.COM_SUCESSO);
			setModel(createModel());
			getModel().setCandidato(new Candidato());
			inscricoes = null;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@SuppressWarnings("unchecked")
	private StatusInscricao getPenultimoStatus() throws Exception {
		StatusInscricao statusInscricao = new StatusInscricao();
		statusInscricao.setInscricaoCurso(new InscricaoCurso(getModel().getId()));
		List<StatusInscricao> listaStatusInscricoes = universalManager.listBy(statusInscricao);
		Collections.sort(listaStatusInscricoes, new Comparator<StatusInscricao>() {
			@Override
			public int compare(StatusInscricao o1, StatusInscricao o2) {
				return o1.getId().compareTo(o2.getId());
			}
		});
		return listaStatusInscricoes.get(listaStatusInscricoes.size() - 2);
	}

	public void cancelarInscricao() {
		try {
			if (textoCancelar == null || textoCancelar.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Corpo Email", Constantes.CAMPO_OBRIGATORIO);
				return;
			}
			
			setModel((InscricaoCurso) universalManager.get(InscricaoCurso.class, getModel().getId()));
			StatusInscricao si = new StatusInscricao(new InscricaoCurso(getModel().getId()), new Usuario(loginBean.getModel().getId()),
					new Status(Status.CANCELADO), new Date());

			cursoService.cancelarInscricao(getModel(), textoCancelar, si);
			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), "Cancelanda " + ConstantesARQ.COM_SUCESSO);
			setModel(createModel());
			getModel().setCandidato(new Candidato());
			inscricoes = null;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void desfazerHormologacao() {
		try {
			setModel((InscricaoCurso) universalManager.get(InscricaoCurso.class, getModel().getId()));
			StatusInscricao si = new StatusInscricao(new InscricaoCurso(getModel().getId()), new Usuario(loginBean.getModel().getId()),
					new Status(getPenultimoStatus().getStatus().getId()), new Date());

			cursoService.desfazerHomologacao(getModel(), si);
			FacesMessagesUtil.addInfoMessage(" ", "Homologação desfeita " + ConstantesARQ.COM_SUCESSO);
			setModel(createModel());
			getModel().setCurso(new Curso());
			getModel().setCandidato(new Candidato());
			inscricoes = null;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void popularCampos(Integer idStatus) {
		InscricaoCurso inscricaoCurso = (InscricaoCurso) universalManager.get(InscricaoCurso.class, getModel().getId());
		getModel().setCurso(inscricaoCurso.getCurso());
		getModel().setDtCadastro(inscricaoCurso.getDtCadastro());
		getModel().setInscricao(inscricaoCurso.getInscricao());
		getModel().setAnoHomologacao(inscricaoCurso.getAnoHomologacao());

		Hibernate.initialize(getModel().getCandidato());
		Hibernate.initialize(getModel().getCandidato().getOrgao());
		Hibernate.initialize(getModel().getCurso());

		getModel().setSituacao(new Situacao(Situacao.INSCRITO));
	}

	public void homologar() {
		try {
			if (inscricoes != null && inscricoes.length > 0) {
				for (InscricaoCurso inscricaoCurso : inscricoes) {

					inscricaoCurso = (InscricaoCurso) universalManager.get(InscricaoCurso.class, inscricaoCurso.getId());
					
					StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()), loginBean.getModel(),
							new Status(Status.HOMOLOGADO), new Date());

					inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
					inscricaoCurso.getStatusInscricoes().add(statusInscricao);
					// Coloca o ano que a inscricao foi homologada.
					// Isso é feito para gerar o numero da inscricao.
					Integer anoAtual = Integer.valueOf(DateUtil.getDataHora(new Date(), "yyyy"));
					inscricaoCurso.setAnoHomologacao(anoAtual);

					cursoService.homologarCurso((InscricaoCurso) inscricaoCurso.clone());
				}
				FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), "Homologada " + ConstantesARQ.COM_SUCESSO);
			} else {
				FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), "Para homologar é necessário selecionar um registro da lista!");
			}
			setModel(createModel());
			getModel().setCurso(new Curso());
			getModel().setCandidato(new Candidato());
			inscricoes = null;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void isentar() {
		try {
			if (inscricoes != null && inscricoes.length > 0) {
				for (InscricaoCurso inscricaoCurso : inscricoes) {

					StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()), loginBean.getModel(),
							new Status(Status.PRESENCA_CONFIRMADA), new Date());

					inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
					inscricaoCurso.getStatusInscricoes().add(statusInscricao);

					inscricaoCursoService.isentarInscricao((InscricaoCurso) inscricaoCurso.clone());
				}
				FacesMessagesUtil.addInfoMessage("", "Isenção realizada " + ConstantesARQ.COM_SUCESSO);
			} else {
				FacesMessagesUtil.addErrorMessage("", "Para isentar uma inscrição é necessário selecionar um registro da lista!");
			}
			setModel(createModel());
			getModel().setCurso(new Curso());
			getModel().setCandidato(new Candidato());
			inscricoes = null;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {
	}

	@Override
	public InscricaoCurso createModel() {
		return new InscricaoCurso();
	}

	@Override
	public String getQualifiedName() {
		return "Inscrição";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}

	public InscricaoCurso[] getInscricoes() {
		return inscricoes;
	}

	public void setInscricoes(InscricaoCurso[] inscricoes) {
		this.inscricoes = inscricoes;
	}

	public boolean isSolicitarPesquisa() {
		return solicitarPesquisa;
	}

	public void setSolicitarPesquisa(boolean solicitarPesquisa) {
		this.solicitarPesquisa = solicitarPesquisa;
	}

	public Integer getCancelada() {
		return cancelada;
	}

	public void setCancelada(Integer cancelada) {
		this.cancelada = cancelada;
	}

	public Integer getHomologada() {
		return homologada;
	}

	public void setHomologada(Integer homologada) {
		this.homologada = homologada;
	}

	public Integer getPaga() {
		return paga;
	}

	public void setPaga(Integer paga) {
		this.paga = paga;
	}

	public boolean isMostrarBotaoHomologar() {
		return mostrarBotaoHomologar;
	}

	public void setMostrarBotaoHomologar(boolean mostrarBotaoHomologar) {
		this.mostrarBotaoHomologar = mostrarBotaoHomologar;
	}

	public String getTextoCancelar() {
		return textoCancelar;
	}

	public void setTextoCancelar(String textoCancelar) {
		this.textoCancelar = textoCancelar;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public Integer getCountInscricao() {
		return countInscricao;
	}

	public void setCountInscricao(Integer countInscricao) {
		this.countInscricao = countInscricao;
	}

	public Curso getCursoAutoComplete() {
		return cursoAutoComplete;
	}

	public void setCursoAutoComplete(Curso cursoAutoComplete) {
		this.cursoAutoComplete = cursoAutoComplete;
	}

	public Integer getIdStatus() {
		return idStatus;
	}

	public void setIdStatus(Integer idStatus) {
		this.idStatus = idStatus;
	}

	public List<Status> getListaStatus() {
		return listaStatus;
	}

	public void setListaStatus(List<Status> listaStatus) {
		this.listaStatus = listaStatus;
	}

	public OrgaoService getOrgaoService() {
		return orgaoService;
	}

	public void setOrgaoService(OrgaoService orgaoService) {
		this.orgaoService = orgaoService;
	}

	public boolean isMostrarBotaoIsentar() {
		return mostrarBotaoIsentar;
	}

	public void setMostrarBotaoIsentar(boolean mostrarBotaoIsentar) {
		this.mostrarBotaoIsentar = mostrarBotaoIsentar;
	}

	public boolean isSemSelecaoOficina() {
		return semSelecaoOficina;
	}

	public void setSemSelecaoOficina(boolean semSelecaoOficina) {
		this.semSelecaoOficina = semSelecaoOficina;
	}

	public List<Curso> getCursos() {
		return cursos;
	}

	public void setCursos(List<Curso> cursos) {
		this.cursos = cursos;
	}
}
