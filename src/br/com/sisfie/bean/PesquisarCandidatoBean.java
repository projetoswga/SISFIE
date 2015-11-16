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
import javax.faces.event.AjaxBehaviorEvent;

import org.primefaces.context.RequestContext;
import org.primefaces.model.LazyDataModel;
import org.primefaces.model.SortOrder;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.dto.CandidatoDTO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Municipio;
import br.com.sisfie.entidade.Orgao;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.Uf;
import br.com.sisfie.service.CandidatoService;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.OrgaoService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.CpfUtil;
import br.com.sisfie.util.CriptoUtil;
import br.com.sisfie.util.PasswordUtil;

@ManagedBean(name = "pesquisarCandidatoBean")
@ViewScoped
public class PesquisarCandidatoBean extends PaginableBean<Candidato> {

	private static final long serialVersionUID = 5445591701683101198L;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	@ManagedProperty(value = "#{candidatoService}")
	protected CandidatoService candidatoService;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{OrgaoService}")
	protected OrgaoService orgaoService;

	private Curso curso;
	private CandidatoDTO dto;
	private List<Uf> UfOrgaos;
	private List<Municipio> municipioOrgaos;
	private List<Curso> cursos;
	private List<Status> status;
	private Candidato candidatoSelect;
	private Date dataHj;
	private Orgao orgaoSelecionado;
	private Integer idUfEnderecoSelecionado;
	private List<Uf> UfEnderecos;
	private Integer idUfOrgaoSelecionado;
	private Integer idMunicipioSelecionado;
	private List<Municipio> municipioEnderecos;
	private Integer idMunicipioEnderecoSelecionado;
	private boolean alterarEmail;
	private String confirmacaoEmail;
	private boolean solicitarPesquisa;
	private int rowCount;

	public PesquisarCandidatoBean() {
		dto = new CandidatoDTO();
		UfOrgaos = new ArrayList<Uf>();
		municipioOrgaos = new ArrayList<Municipio>();
		cursos = new ArrayList<Curso>();
		status = new ArrayList<Status>();
		candidatoSelect = new Candidato();
		dataHj = new Date();
		orgaoSelecionado = new Orgao();
		UfEnderecos = new ArrayList<Uf>();
		municipioEnderecos = new ArrayList<Municipio>();
		curso = new Curso();
	}

	@SuppressWarnings("unchecked")
	@PostConstruct
	public void carregarTela() {
		try {

			if (UfOrgaos.isEmpty()) {
				UfOrgaos = universalManager.getAll(Uf.class);
				Collections.sort(UfOrgaos, new Comparator<Uf>() {
					@Override
					public int compare(Uf o1, Uf o2) {
						return o1.getSigla().trim().compareTo(o2.getSigla());
					}
				});
			}

			if (UfEnderecos.isEmpty()) {
				UfEnderecos = universalManager.getAll(Uf.class);
				Collections.sort(UfEnderecos, new Comparator<Uf>() {
					@Override
					public int compare(Uf o1, Uf o2) {
						return o1.getSigla().trim().compareTo(o2.getSigla());
					}
				});
			}

			if (cursos.isEmpty()) {
				try {
					cursos = universalManager.getAll(Curso.class);
				} catch (Exception e) {
					ExcecaoUtil.tratarExcecao(e);
				}
				Collections.sort(cursos, new Comparator<Curso>() {
					@Override
					public int compare(Curso o1, Curso o2) {
						return o1.getTitulo().trim().compareTo(o2.getTitulo());
					}
				});
			}

			if (status.isEmpty()) {
				try {
					status = universalManager.getAll(Status.class);
				} catch (Exception e) {
					ExcecaoUtil.tratarExcecao(e);
				}
				Collections.sort(status, new Comparator<Status>() {
					@Override
					public int compare(Status o1, Status o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
			}

			// Carregando o candidato quando edição
			setModel((Candidato) getSessionMap().remove("candidato"));
			if (getModel() != null) {
				setModel((Candidato) universalManager.get(Candidato.class, getModel().getId()));
				idUfEnderecoSelecionado = getModel().getMunicipioEndereco().getUf().getId();
				idUfOrgaoSelecionado = getModel().getMunicipioOrgao().getUf().getId();
				carregarMunicipios(idMunicipioEnderecoSelecionado, Boolean.TRUE);
				carregarMunicipios(idMunicipioSelecionado, Boolean.FALSE);
				idMunicipioEnderecoSelecionado = getModel().getMunicipioEndereco().getId();
				idMunicipioSelecionado = getModel().getMunicipioOrgao().getId();
				orgaoSelecionado = getModel().getOrgao();
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		Curso a = new Curso();
		a.setTitulo(query);
		try {
			List<Curso> listaBanco = cursoService.recuperarCursos(a);
			if (listaBanco != null && !listaBanco.isEmpty()) {
				for (Curso curso : listaBanco) {
					if ((curso.getUsuario().getId().equals(loginBean.getModel().getId()) && acessoBean
							.verificarAcesso("ROLE_CURSO_GERENCIAR"))
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

	public void copiarIdCurso() {
		dto.setIdCurso(curso.getId());
	}

	public void changeUF(AjaxBehaviorEvent evt) {
		if (idUfOrgaoSelecionado != null) {
			carregarMunicipios(idUfOrgaoSelecionado, Boolean.FALSE);
		} else {
			carregarMunicipios(dto.getIdUfOrgaoSelecionado(), Boolean.FALSE);
		}
	}

	public void changeUFEndereco(AjaxBehaviorEvent evt) {
		if (idUfEnderecoSelecionado != null) {
			carregarMunicipios(idUfEnderecoSelecionado, Boolean.TRUE);
		} else {
			carregarMunicipios(dto.getIdUfEnderecoSelecionado(), Boolean.TRUE);
		}
	}

	@SuppressWarnings("unchecked")
	private void carregarMunicipios(Integer idUf, Boolean isEndereco) {
		Municipio municipio = new Municipio();
		municipio.setUf(new Uf(idUf));
		try {
			if (isEndereco) {
				municipioEnderecos = universalManager.listBy(municipio);
			} else {
				municipioOrgaos = universalManager.listBy(municipio);
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

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

	public void pesquisar() {
		try {
			solicitarPesquisa = Boolean.TRUE;
			getLazyDataModel();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@Override
	public LazyDataModel<Candidato> getLazyDataModel() {
		if (lazyDataModel == null && solicitarPesquisa)

			lazyDataModel = new LazyDataModel<Candidato>() {

				private static final long serialVersionUID = -3128388997477577261L;

				@SuppressWarnings("rawtypes")
				@Override
				public List<Candidato> load(int first, int pageSize, String sortField, SortOrder sortOrder, Map filters) {
					// Reduzindo o contador depois de filtrado
					try {
						rowCount = candidatoService.countCandidato(dto).intValue();
						lazyDataModel.setRowCount(rowCount);
						List<Candidato> list = candidatoService.paginateCandidato(first, pageSize, dto);
						return list;
					} catch (Exception e) {
						ExcecaoUtil.tratarExcecao(e);
					}
					return null;
				}
			};
		solicitarPesquisa = Boolean.FALSE;
		return lazyDataModel;
	}

	public void resetarSenha() {
		String senhaGerada = PasswordUtil.gerarPassword(6);
		candidatoSelect.setFlgPrimeiroAcesso(true);
		candidatoSelect.setSenha(CriptoUtil.getCriptografia(senhaGerada));
		try {
			candidatoService.save(candidatoSelect, senhaGerada);
			RequestContext context = RequestContext.getCurrentInstance();
			context.execute("popAviso.show();");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@SuppressWarnings("unchecked")
	public boolean validarCampos() throws Exception {
		// validar se existe (@ ou -) no nome completo
		if (getModel().getNome() != null && !getModel().getNome().isEmpty()) {
			for (int i = 0; i < getModel().getNome().length(); i++) {
				Character letra = getModel().getNome().charAt(i);
				switch (letra.charValue()) {
				case '@':
				case '-':
					FacesMessagesUtil.addErrorMessage("Caracteres inválidos!", "Não é permitido '@' nem '-' no mome completo.");
					return false;
				default:
					break;
				}
			}
		}
		// Validar email institucuional unique
		if (alterarEmail) {
			Candidato candidato = new Candidato();
			candidato.setEmailInstitucional(getModel().getEmailInstitucional().trim());
			List<Candidato> lista = universalManager.listBy(candidato, false);
			if (lista != null && !lista.isEmpty() && !lista.get(0).getId().equals(getModel().getId())) {
				FacesMessagesUtil.addErrorMessage("Email Institucional ", " Já cadastrado");

			}
			if (!getModel().getEmailInstitucional().trim().equals(confirmacaoEmail)) {
				FacesMessagesUtil.addErrorMessage("Confirmação do Email Institucional ", "Inválida");
				return false;
			}
		}
		if (orgaoSelecionado == null || orgaoSelecionado.getId() == null) {
			FacesMessagesUtil.addErrorMessage("Orgão ", Constantes.CAMPO_OBRIGATORIO);
			return false;
		}

		// valida se tem cpf ou doc estrangeiro
		if (getModel().getNacionalidadeBrasil()) {
			if (getModel().getCpf() == null || getModel().getCpf().isEmpty()) {
				FacesMessagesUtil.addErrorMessage("CPF ", Constantes.CAMPO_OBRIGATORIO);
				return false;
			}
			String cpf = getModel().getCpf().trim().replaceAll("[()-.]", "");
			// Validar CPF
			if (!CpfUtil.isValidCPF(cpf)) {
				FacesMessagesUtil.addErrorMessage("CPF ", "Inválido");
				return false;
			}

		} else {
			if (getModel().getDocEstrangeiro() == null || getModel().getDocEstrangeiro().isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Documento Estrangeiro ", Constantes.CAMPO_OBRIGATORIO);
				return false;
			}
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	public String carregarCandidato() {
		getSessionMap().put("candidato", getModel());
		return redirect("editarCandidato.jsf");
	}

	public String alterarCandidato() {
		try {
			if (!validarCampos()) {
				return "";
			}
			retirarMascaras();

			if (orgaoSelecionado != null && orgaoSelecionado.getId() == null) {
				getModel().setOrgao(null);
			} else {
				getModel().setOrgao(orgaoSelecionado);
			}
			getModel().setMunicipioEndereco(new Municipio(idMunicipioEnderecoSelecionado));
			getModel().setMunicipioOrgao(new Municipio(idMunicipioSelecionado));
			getModel().getMunicipioEndereco().setUf(new Uf(idUfEnderecoSelecionado));
			getModel().getMunicipioOrgao().setUf(new Uf(idUfOrgaoSelecionado));
			universalManager.save(getModel());
			FacesMessagesUtil.addInfoMessage("","Candidato alterado com sucesso.");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		return redirect("pesquisarCandidato");
	}

	public void retirarMascaras() {
		// retira mascara
		if (getModel().getCep() != null && !getModel().getCep().trim().equals("")) {
			getModel().setCep(getModel().getCep().trim().replaceAll("[()-.]", ""));
		}
		// retira mascara
		if (getModel().getTelCelular() != null && !getModel().getTelCelular().trim().equals("")) {
			getModel().setTelCelular(getModel().getTelCelular().trim().replaceAll("[()-]", ""));
		}
		// retira mascara
		if (getModel().getTelComercial() != null && !getModel().getTelComercial().trim().equals("")) {
			getModel().setTelComercial(getModel().getTelComercial().trim().replaceAll("[()-]", ""));
		}
		// retira mascara
		if (getModel().getTelResidencial() != null && !getModel().getTelResidencial().trim().equals("")) {
			getModel().setTelResidencial(getModel().getTelResidencial().trim().replaceAll("[()-]", ""));
		}
		// retira mascara
		if (getModel().getCpf() != null && !getModel().getCpf().trim().equals("")) {
			getModel().setCpf(getModel().getCpf().trim().replaceAll("[()-.]", ""));
		}
	}

	public void limparCampo() {
		if (getModel().getNacionalidadeBrasil()) {
			getModel().setDocEstrangeiro(null);
		} else {
			getModel().setCpf(null);
		}
	}

	public void limparCampoPesquisa() {
		if (dto.getNacionalidadeBrasil()) {
			dto.setDocEstrangeiro(null);
		} else {
			dto.setCpf(null);
		}
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {
		// acessoBean.bloquearTela("ROLE_PESQUISAR_CANDIDATO");
	}

	@Override
	public Candidato createModel() {
		return new Candidato();
	}

	@Override
	public String getQualifiedName() {
		return "Candidato";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public CandidatoService getCandidatoService() {
		return candidatoService;
	}

	public void setCandidatoService(CandidatoService candidatoService) {
		this.candidatoService = candidatoService;
	}

	public CandidatoDTO getDto() {
		return dto;
	}

	public void setDto(CandidatoDTO dto) {
		this.dto = dto;
	}

	public List<Uf> getUfOrgaos() {
		return UfOrgaos;
	}

	public void setUfOrgaos(List<Uf> ufOrgaos) {
		UfOrgaos = ufOrgaos;
	}

	public List<Municipio> getMunicipioOrgaos() {
		return municipioOrgaos;
	}

	public void setMunicipioOrgaos(List<Municipio> municipioOrgaos) {
		this.municipioOrgaos = municipioOrgaos;
	}

	public List<Curso> getCursos() {
		return cursos;
	}

	public void setCursos(List<Curso> cursos) {
		this.cursos = cursos;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public List<Status> getStatus() {
		return status;
	}

	public void setStatus(List<Status> status) {
		this.status = status;
	}

	public Candidato getCandidatoSelect() {
		return candidatoSelect;
	}

	public void setCandidatoSelect(Candidato candidatoSelect) {
		this.candidatoSelect = candidatoSelect;
	}

	public Date getDataHj() {
		return dataHj;
	}

	public void setDataHj(Date dataHj) {
		this.dataHj = dataHj;
	}

	public Orgao getOrgaoSelecionado() {
		return orgaoSelecionado;
	}

	public void setOrgaoSelecionado(Orgao orgaoSelecionado) {
		this.orgaoSelecionado = orgaoSelecionado;
	}

	public Integer getIdUfEnderecoSelecionado() {
		return idUfEnderecoSelecionado;
	}

	public void setIdUfEnderecoSelecionado(Integer idUfEnderecoSelecionado) {
		this.idUfEnderecoSelecionado = idUfEnderecoSelecionado;
	}

	public List<Uf> getUfEnderecos() {
		return UfEnderecos;
	}

	public void setUfEnderecos(List<Uf> ufEnderecos) {
		UfEnderecos = ufEnderecos;
	}

	public Integer getIdUfOrgaoSelecionado() {
		return idUfOrgaoSelecionado;
	}

	public void setIdUfOrgaoSelecionado(Integer idUfOrgaoSelecionado) {
		this.idUfOrgaoSelecionado = idUfOrgaoSelecionado;
	}

	public Integer getIdMunicipioSelecionado() {
		return idMunicipioSelecionado;
	}

	public void setIdMunicipioSelecionado(Integer idMunicipioSelecionado) {
		this.idMunicipioSelecionado = idMunicipioSelecionado;
	}

	public List<Municipio> getMunicipioEnderecos() {
		return municipioEnderecos;
	}

	public void setMunicipioEnderecos(List<Municipio> municipioEnderecos) {
		this.municipioEnderecos = municipioEnderecos;
	}

	public Integer getIdMunicipioEnderecoSelecionado() {
		return idMunicipioEnderecoSelecionado;
	}

	public void setIdMunicipioEnderecoSelecionado(Integer idMunicipioEnderecoSelecionado) {
		this.idMunicipioEnderecoSelecionado = idMunicipioEnderecoSelecionado;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public boolean isAlterarEmail() {
		return alterarEmail;
	}

	public void setAlterarEmail(boolean alterarEmail) {
		this.alterarEmail = alterarEmail;
	}

	public String getConfirmacaoEmail() {
		return confirmacaoEmail;
	}

	public void setConfirmacaoEmail(String confirmacaoEmail) {
		this.confirmacaoEmail = confirmacaoEmail;
	}

	public boolean isSolicitarPesquisa() {
		return solicitarPesquisa;
	}

	public void setSolicitarPesquisa(boolean solicitarPesquisa) {
		this.solicitarPesquisa = solicitarPesquisa;
	}

	public OrgaoService getOrgaoService() {
		return orgaoService;
	}

	public void setOrgaoService(OrgaoService orgaoService) {
		this.orgaoService = orgaoService;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public int getRowCount() {
		return rowCount;
	}

	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}

}
