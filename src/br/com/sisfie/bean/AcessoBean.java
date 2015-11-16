package br.com.sisfie.bean;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;

import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.sisfie.entidade.Funcionalidade;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.AcessoService;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "acessoBean")
@SessionScoped
public class AcessoBean implements Serializable {

	private static final long serialVersionUID = 2627221638662214161L;

	private String contextPath;

	@ManagedProperty(value = "#{acessoServiceImpl}")
	private AcessoService acessoService;

	private List<Funcionalidade> funcionalidades;

	public boolean verificarAcesso(String role) {
		if (role == null || role.isEmpty()) {
			return false;
		}
		for (Funcionalidade func : getFuncionalidades()) {
			if (func.getRole() != null) {
				if (func.getRole().trim().equalsIgnoreCase(role.trim())) {
					return true;
				}
			}
		}

		return false;
	}

	public void bloquearTela(String role) {
		try {
			boolean acesso = false;
			if (role == null || role.isEmpty()) {
				acesso = false;
			}
			role = role.trim();
			for (Funcionalidade func : getFuncionalidades()) {
				if (func.getRole() != null) {
					if (func.getRole().trim().equalsIgnoreCase(role.trim())) {
						acesso = true;
						break;
					}
				}
			}
			if (!acesso) {
				FacesContext context = FacesContext.getCurrentInstance();

				ServletContext servletContext = (ServletContext) context.getExternalContext().getContext();

				String path = servletContext.getContextPath();

				context.getExternalContext().redirect(path + "/pages/acesso-invalido.jsf");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	public List<Funcionalidade> getFuncionalidades() {
		try {

			if (funcionalidades == null || funcionalidades.isEmpty()) {
				Usuario user = (Usuario) getSessionMap().get(Constantes.USUARIO_SESSAO);
				if (user == null) {
					throw new Exception();
				}
				funcionalidades = acessoService.carregarFuncionalidades(user);
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return funcionalidades;
	}

	public void setFuncionalidades(List<Funcionalidade> funcionalidades) {
		this.funcionalidades = funcionalidades;
	}

	public AcessoService getAcessoService() {
		return acessoService;
	}

	public void setAcessoService(AcessoService acessoService) {
		this.acessoService = acessoService;
	}

	private Map getSessionMap() {
		if (FacesContext.getCurrentInstance() != null && FacesContext.getCurrentInstance().getExternalContext().getSessionMap() != null) {
			return FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		} else {
			return null;
		}
	}

	public String getContextPath() {
		if (contextPath == null || contextPath.equals("")) {
			contextPath = Constantes.CONTEXT_PATH;
		}
		return contextPath;
	}

	public void setContextPath(String contextPath) {
		this.contextPath = contextPath;
	}
}
