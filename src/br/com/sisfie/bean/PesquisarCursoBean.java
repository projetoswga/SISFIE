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
import javax.faces.model.SelectItem;

import org.primefaces.model.LazyDataModel;
import org.primefaces.model.SortOrder;
import org.springframework.dao.DataIntegrityViolationException;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ComboUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.DateUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.dto.CursoDTO;
import br.com.sisfie.entidade.Area;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Localizacao;
import br.com.sisfie.entidade.SetorResponsavelEsaf;
import br.com.sisfie.service.CursoService;

@ManagedBean(name = "pesquisarCursoBean")
@ViewScoped
public class PesquisarCursoBean extends PaginableBean<Curso> {

	private static final long serialVersionUID = 1L;

	// service
	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	private CursoDTO dto;
	private List<Area> areas;
	private List<Localizacao> locais;
	private Curso cursoSelect;
	private Integer idSetor;

	private List<SelectItem> setores;

	public PesquisarCursoBean() {
		dto = new CursoDTO();
		areas = new ArrayList<Area>();
		locais = new ArrayList<Localizacao>();

	}

	@SuppressWarnings("unchecked")
	@PostConstruct
	public void carregarTela() {
		try {
			verificarAcesso();
			setores = ComboUtil.getItens(universalManager.getAll(SetorResponsavelEsaf.class));
			if (areas.isEmpty()) {
				Area area = new Area();
				area.setFlgAtivo(true);
				areas = universalManager.listBy(area);
				Collections.sort(areas, new Comparator<Area>() {
					@Override
					public int compare(Area o1, Area o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
			}
			if (locais.isEmpty()) {
				locais = universalManager.getAll(Localizacao.class);
				Collections.sort(locais, new Comparator<Localizacao>() {
					@Override
					public int compare(Localizacao o1, Localizacao o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
			}

			Collections.sort(setores, new Comparator<SelectItem>() {
				@Override
				public int compare(SelectItem o1, SelectItem o2) {
					return o1.getLabel().compareTo(o2.getLabel());
				}
			});

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	public String delete() {
		try {
			cursoService.deleteCurso(cursoSelect);
			cursoSelect = new Curso();
			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), this.getRemoveMessage() + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException dive) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_EXCLUIR_DEPENDENCIA);
			return ERROR;
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_EXCLUIR);
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		return SUCCESS;
	}

	public void pesquisar() {
		try {
			removerMascaras();
			getLazyDataModel();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void removerMascaras() {
		if (dto.getCodigo() != null && !dto.getCodigo().isEmpty()) {
			dto.setCodigo(dto.getCodigo().trim().replaceAll("[.]", ""));
		}
	}

	@SuppressWarnings("unchecked")
	public String loadCurso() {
		getSessionMap().put("idCurso", cursoSelect.getId());

		return redirect("cadastrarCurso.jsf");

	}

	@SuppressWarnings("unchecked")
	public String clonarCurso() {
		getSessionMap().put("idCurso", cursoSelect.getId());
		getSessionMap().put("clone", true);

		return redirect("cadastrarCurso.jsf");

	}

	@SuppressWarnings("unchecked")
	public String visualizarCurso() {
		getSessionMap().put("idCurso", cursoSelect.getId());

		return redirect("visualizarCurso.jsf");

	}

	@SuppressWarnings("unchecked")
	public String gerenciarCurso() {
		getSessionMap().put("idCursoGerenciar", cursoSelect.getId());

		return redirect("gerenciarCurso.jsf");

	}

	@SuppressWarnings("unchecked")
	public String gerenciarCursoComOficina() {
		getSessionMap().put("idCursoGerenciar", cursoSelect.getId());

		return redirect("gerenciarCursoComOficina.jsf");

	}

	@Override
	public LazyDataModel<Curso> getLazyDataModel() {
		if (lazyDataModel == null)

			lazyDataModel = new LazyDataModel<Curso>() {

				private static final long serialVersionUID = 2595093445602418759L;

				@SuppressWarnings("rawtypes")
				@Override
				public List<Curso> load(int first, int pageSize, String sortField, SortOrder sortOrder, Map filters) {
					try {
						int rowCount = cursoService.countCurso(dto).intValue();
						lazyDataModel.setRowCount(rowCount);
						List<Curso> list = cursoService.paginateCurso(first, pageSize, dto);
						for (Curso curso : list) {
							boolean criador = false;
							if (curso.getUsuario().getId().equals(loginBean.getModel().getId())) {
								criador = true;
							} else {
								criador = false;
							}

							if ((criador && acessoBean.verificarAcesso("ROLE_CURSO_EDITAR"))
									|| acessoBean.verificarAcesso("ROLE_PESQ_ACESSO_GERAL")) {
								curso.setPodeEditar(true);
							} else {
								curso.setSomenteVisualizar(true);
								curso.setPodeEditar(false);
							}

							if ((criador && acessoBean.verificarAcesso("ROLE_CURSO_GERENCIAR_PESQ"))
									|| acessoBean.verificarAcesso("ROLE_PESQ_ACESSO_GERAL")) {
								curso.setPodeGerenciar(true);
							} else {
								curso.setPodeGerenciar(false);
							}

							if (curso.getDtInicioInscricao().getTime() > DateUtil.getDateSemHora(new Date()).getTime()) {
								if ((criador && acessoBean.verificarAcesso("ROLE_CURSO_REMOVER"))
										|| acessoBean.verificarAcesso("ROLE_PESQ_ACESSO_GERAL")) {
									curso.setPodeExcluir(true);
								} else {
									curso.setPodeExcluir(false);
								}
							} else {
								curso.setPodeExcluir(false);
							}
						}
						return list;
					} catch (Exception e) {
						ExcecaoUtil.tratarExcecao(e);
					}
					return null;
				}
			};
		return lazyDataModel;
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_CURSO_PESQUISAR");
	}

	@Override
	public Curso createModel() {
		return null;
	}

	@Override
	public String getQualifiedName() {
		return "Curso";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public CursoDTO getDto() {
		return dto;
	}

	public void setDto(CursoDTO dto) {
		this.dto = dto;
	}

	public List<Area> getAreas() {
		return areas;
	}

	public void setAreas(List<Area> areas) {
		this.areas = areas;
	}

	public List<Localizacao> getLocais() {
		return locais;
	}

	public void setLocais(List<Localizacao> locais) {
		this.locais = locais;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public Curso getCursoSelect() {
		return cursoSelect;
	}

	public void setCursoSelect(Curso cursoSelect) {
		this.cursoSelect = cursoSelect;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public List<SelectItem> getSetores() {
		return setores;
	}

	public void setSetores(List<SelectItem> setores) {
		this.setores = setores;
	}

	public Integer getIdSetor() {
		return idSetor;
	}

	public void setIdSetor(Integer idSetor) {
		this.idSetor = idSetor;
	}
}