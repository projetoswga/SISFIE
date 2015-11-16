package br.com.sisfie.bean;

import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import org.primefaces.model.LazyDataModel;
import org.primefaces.model.SortOrder;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Funcionalidade;
import br.com.sisfie.service.AcessoService;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "funcionalidadeBean")
@ViewScoped
public class FuncionalidadeBean extends PaginableBean<Funcionalidade> {

	private static final long serialVersionUID = 1L;

	private Funcionalidade filho;

	@ManagedProperty(value = "#{acessoServiceImpl}")
	public AcessoService acessoService;

	public FuncionalidadeBean() {
		filho = new Funcionalidade();
	}

	@Override
	@PostConstruct
	public void verificarAcesso() {
		carregarTela();
	}

	public void carregarTela() {
		Boolean save = (Boolean) getSessionMap().remove("saveFuncionalidade");
		if (save != null && save) {
			FacesMessagesUtil.addInfoMessage("Funcionalidade ", this.getSaveMessage() + " " + ConstantesARQ.COM_SUCESSO);
		}
	}

	/**
	 * Métodos dos Filhos
	 */
	public void adicionarAcao() {
		try {

			if (filho.getNome() == null || filho.getNome().trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("Ação ", Constantes.CAMPO_OBRIGATORIO);
				return;
			}
			if (filho.getRole() == null || filho.getRole().trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("ROLE ", Constantes.CAMPO_OBRIGATORIO);
				return;
			}

			filho.setRole(filho.getRole().toUpperCase());
			filho.setPai(getModel());
			getModel().getFilhos().add(filho);
			filho = new Funcionalidade();
			FacesMessagesUtil.addInfoMessage("Ação", " adicionada" + " " + ConstantesARQ.COM_SUCESSO);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void deleteAcao() {
		try {
			// Registro Persistido
			if (filho != null && filho.getId() != null) {
				getModel().getFilhosExcluir().add(filho);
			}
			getModel().getFilhos().remove(filho);
			filho = new Funcionalidade();
			FacesMessagesUtil.addInfoMessage("Ação ", this.getRemoveMessage() + " " + ConstantesARQ.COM_SUCESSO);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	/**
	 * FIM Métodos dos Filhos
	 */

	/**
	 * Métodos do PAI
	 */
	@Override
	public String save() {
		try {
			if (getModel().getNome() == null || getModel().getNome().trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("Funcionalidade ", Constantes.CAMPO_OBRIGATORIO);
				return "";
			}
			if (getModel().getRole() == null || getModel().getRole().trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("ROLE ", Constantes.CAMPO_OBRIGATORIO);
				return "";
			}

			getModel().setRole(getModel().getRole().toUpperCase());

			// Retira os espacos das roles
			getModel().setRole(getModel().getRole().replaceAll(" ", ""));
			for (Funcionalidade funcFilho : getModel().getFilhos()) {
				funcFilho.setRole(funcFilho.getRole().replaceAll(" ", ""));
			}
			acessoService.salvarFuncionalidade(getModel());
			FacesMessagesUtil.addInfoMessage("Funcionalidade", this.getSaveMessage() + " " + ConstantesARQ.COM_SUCESSO);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		getSessionMap().put("saveFuncionalidade", true);

		return redirect("funcionalidade.jsf");
	}

	@Override
	public String load() {
		try {
			setModel((Funcionalidade) universalManager.get(Funcionalidade.class, getModel().getId()));
			getModel().setFilhos(acessoService.carregarFilhos(getModel().getId()));
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return SUCCESS;
	}

	@Override
	public String delete() {
		try {
			getModel().setFilhos(acessoService.carregarFilhos(getModel().getId()));
			acessoService.excluirFuncionalidade(getModel());
			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), this.getRemoveMessage() + " " + ConstantesARQ.COM_SUCESSO);
			filho = new Funcionalidade();
			setModel(createModel());
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return SUCCESS;
	}

	/**
	 * FIM Métodos do PAI
	 */

	@SuppressWarnings("unchecked")
	public LazyDataModel<Funcionalidade> getLazyDataModel() {
		try {
			if (lazyDataModel == null)
				lazyDataModel = new LazyDataModel() {

					private static final long serialVersionUID = 2595093445602418759L;

					@Override
					public List load(int first, int pageSize, String sortField, SortOrder sortOrder, Map filters) {
						try {
							boolean sort = false;
							if (sortOrder.equals(SortOrder.DESCENDING)) {
								sort = true;
							}

							int rowCount = acessoService.getCount(getModel(), filters).intValue();
							lazyDataModel.setRowCount(rowCount);

							List<Funcionalidade> lista = acessoService.paginate(first, pageSize, getModel(), filters, sortField, sort);
							return lista;
						} catch (Exception e) {
							ExcecaoUtil.tratarExcecao(e);
						}
						return null;
					}
				};

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return lazyDataModel;
	}

	public AcessoService getAcessoService() {
		return acessoService;
	}

	public void setAcessoService(AcessoService acessoService) {
		this.acessoService = acessoService;
	}

	public Funcionalidade getFilho() {

		return filho;
	}

	public void setFilho(Funcionalidade filho) {
		this.filho = filho;
	}

	@Override
	public Funcionalidade createModel() {
		return new Funcionalidade();
	}

	@Override
	public String getQualifiedName() {
		return "Funcionalidade";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

}
