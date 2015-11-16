package br.com.arquitetura.bean;

import java.io.Serializable;
import java.util.Map;

import javax.faces.bean.ManagedProperty;
import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;

import org.springframework.dao.DataIntegrityViolationException;

import br.com.arquitetura.entidade.Entidade;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.service.UniversalManager;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.bean.AcessoBean;

@SuppressWarnings("rawtypes")
public abstract class BaseBean<T extends Entidade> implements Serializable {

	private static final long serialVersionUID = -5987110148555555502L;

	protected static final String ERROR = "error";

	protected static final String SUCCESS = "success";

	@ManagedProperty(value = "#{universalManager}")
	public UniversalManager universalManager;

	@ManagedProperty(value = "#{acessoBean}")
	protected AcessoBean acessoBean;

	private T model;

	public BaseBean() {
		super();
		this.model = this.createModel();
	}

	/**
	 * "/pages/cadastrar-pessoa.jsf?faces-redirect=true";
	 * 
	 * @return
	 */
	protected String redirect(String pagina) {
		return pagina + ConstantesARQ.FACES_REDIRECT;
	}

	public abstract void verificarAcesso();

	public abstract T createModel();

	public abstract String getQualifiedName();

	public abstract boolean isFeminino();

	public final T getModel() {
		return model;
	}

	public final void setModel(T model) {
		this.model = model;
	}

	public UniversalManager getUniversalManager() {
		return universalManager;
	}

	public void setUniversalManager(UniversalManager universalManager) {
		this.universalManager = universalManager;
	}

	@SuppressWarnings("unchecked")
	public String load() {
		try {
			model = (T) this.universalManager.get(this.model.getClass(), this.model.getId());
			// FacesMessagesUtil.addInfoMessage(this.getQualifiedName(),
			// this.getLoadMessage() + " " + ConstantesARQ.COM_SUCESSO);
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_CARREGAR);
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		return SUCCESS;

	}

	public String save() {
		try {
			this.universalManager.save(model);
			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), this.getSaveMessage() + " " + ConstantesARQ.COM_SUCESSO);
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_SALVAR);
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		this.model = this.createModel();
		return SUCCESS;
	}

	public String delete() {
		try {
			this.universalManager.remove(this.model.getClass(), this.model.getId());
			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), this.getRemoveMessage() + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException dive) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_EXCLUIR_DEPENDENCIA);
			return ERROR;
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_EXCLUIR);
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		this.model = this.createModel();
		return SUCCESS;
	}

	public String delete(Class clazz, Integer id) {
		try {
			this.universalManager.remove(clazz, id);
			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), this.getRemoveMessage() + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException dive) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_EXCLUIR_DEPENDENCIA);
			return ERROR;
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_EXCLUIR);
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		this.model = this.createModel();
		return SUCCESS;
	}

	protected String getRemoveMessage() {
		return isFeminino() ? ConstantesARQ.REMOVIDA : ConstantesARQ.REMOVIDO;
	}

	protected String getSaveMessage() {
		return isFeminino() ? ConstantesARQ.SALVA : ConstantesARQ.SALVO;
	}

	protected String getLoadMessage() {
		return isFeminino() ? ConstantesARQ.CARREGADA : ConstantesARQ.CARREGADO;
	}

	public String getRequiredMessage() {
		return ConstantesARQ.CAMPO_OBRIGATORIO;
	}

	protected Map getSessionMap() {
		if (FacesContext.getCurrentInstance() != null && FacesContext.getCurrentInstance().getExternalContext().getSessionMap() != null) {
			return FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		} else {
			return null;
		}
	}

	public String getContextPath() {
		ServletContext servletContext = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();

		return servletContext.getContextPath();
	}

	public String getEmptyMessage() {
		return ConstantesARQ.EMPTY_MESSAGE;
	}

	public String getPaginacao() {
		return ConstantesARQ.PAGINACAO;
	}

	public AcessoBean getAcessoBean() {
		return acessoBean;
	}

	public void setAcessoBean(AcessoBean acessoBean) {
		this.acessoBean = acessoBean;
	}

}
