package br.com.sisfie.bean;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.sisfie.entidade.Area;
import br.com.sisfie.entidade.CampoPreenchimento;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "principalBean")
@ViewScoped
public class PrincipalBean extends BaseBean<Usuario> {

	private static final long serialVersionUID = -7355462417028175561L;

	@Override
	@PostConstruct
	public void verificarAcesso() {
	}

	public void teste() throws Exception {
		Area area = new Area();
		area.setDescricao("Descricao");
		area.setDetalhamento("Detalhamento");
		area.setFlgAtivo(true);
		universalManager.save(area);
	}

	public void teste2() throws Exception {
		CampoPreenchimento campo = new CampoPreenchimento();

		campo.setDescricao("descricao");
		campo.setFlgAtivo(true);
		universalManager.save(campo);
	}

	public String loginTimeOut() {
		try {
			HttpSession session = (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(false);
			session.invalidate();
			FacesContext.getCurrentInstance().getExternalContext().getSessionMap().put("mostrarMsgSession", true);
			FacesContext.getCurrentInstance().getExternalContext().redirect("/" + Constantes.CONTEXT_PATH + "/login.jsf");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return "/pages/login.jsf?faces-redirect=true";

	}

	public void principalTemplate() {
		try {
			FacesContext.getCurrentInstance().getExternalContext().redirect("/" + Constantes.CONTEXT_PATH + "/pages/principal.jsf");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	@Override
	public Usuario createModel() {
		return null;
	}

	@Override
	public String getQualifiedName() {
		return null;
	}

	@Override
	public boolean isFeminino() {
		return false;
	}
}
