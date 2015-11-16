package br.com.arquitetura.bean;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.RequestScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

import br.com.arquitetura.excecao.ExcecaoUtil;

@ManagedBean(name = "sair")
@RequestScoped
public class Sair {

	public void logout() {
		try {
			HttpSession session = (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(false);

			session.invalidate();

			FacesContext.getCurrentInstance().getExternalContext().redirect("login.jsf");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

}
