package br.com.sisfie.bean;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import org.primefaces.context.RequestContext;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.entidade.Entidade;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.service.UniversalManager;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.CriptoUtil;

@ManagedBean(name = "trocarSenhaBean")
@ViewScoped
public class TrocarSenhaBean extends BaseBean<Entidade<Integer>> {

	private static final long serialVersionUID = 1L;

	private String senhaT1;
	private String senhaT2;

	@ManagedProperty(value = "#{login}")
	private LoginBean loginBean;

	public TrocarSenhaBean() {
		senhaT1 = "";
		senhaT2 = "";
	}

	public String save() {
		try {

			if (senhaT1 == null || senhaT1.trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("Nova Senha", Constantes.CAMPO_OBRIGATORIO);
				return "";
			}

			if (senhaT1.length() < 6) {
				FacesMessagesUtil.addErrorMessage("Nova Senha", " Deve ter mais de 6 caracteres ");
				return "";
			}
			if (senhaT1.equals(Constantes.SENHA_DEFAULT)) {
				FacesMessagesUtil.addErrorMessage("Nova Senha ", " Não pode ser igual a senha inicial.");
				return "";
			}
			if (senhaT2 == null || senhaT2.trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("Confirmação", Constantes.CAMPO_OBRIGATORIO);
				return "";
			}

			Usuario user = loginBean.getModel();

			if (!senhaT1.equals(senhaT2)) {
				FacesMessagesUtil.addErrorMessage("", Constantes.AMBAS_SENHAS_IDENTICAS);
				return "";
			}

			user.setSenha(CriptoUtil.getCriptografia(senhaT1));
			Usuario userClone = (Usuario) user.clone();
			this.universalManager.save(userClone);
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_SALVAR);
			ExcecaoUtil.tratarExcecao(e);
			return "";
		}

		// Abri o popup.
		RequestContext requestContext = RequestContext.getCurrentInstance();
		requestContext.execute("confirmation.show()");
		return SUCCESS;

	}

	public String redirecionarPrincipal() {
		return redirect("/pages/principal.jsf");
	}

	public String getQualifiedName() {
		return "Usuário";
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public UniversalManager getUniversalManager() {
		return universalManager;
	}

	public void setUniversalManager(UniversalManager universalManager) {
		this.universalManager = universalManager;
	}

	@Override
	public void verificarAcesso() {

	}

	@Override
	public Usuario createModel() {
		return null;
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public String getSenhaT1() {
		return senhaT1;
	}

	public void setSenhaT1(String senhaT1) {
		this.senhaT1 = senhaT1;
	}

	public String getSenhaT2() {
		return senhaT2;
	}

	public void setSenhaT2(String senhaT2) {
		this.senhaT2 = senhaT2;
	}

}
