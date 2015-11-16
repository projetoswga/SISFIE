package br.com.sisfie.bean;

import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpSession;

import org.hibernate.Hibernate;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.context.SecurityContextHolder;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Funcionalidade;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.AcessoService;
import br.com.sisfie.service.LoginService;
import br.com.sisfie.service.UsuarioService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.CriptoUtil;
import br.com.sisfie.util.PasswordUtil;

@ManagedBean(name = "login")
@SessionScoped
public class LoginBean extends BaseBean<Usuario> {

	private static final long serialVersionUID = 1L;

	private String userName;

	private String email;

	private String password;

	private String senhaAnterior;

	private String senha;

	private String senha2;

	@ManagedProperty(value = "#{loginManager}")
	private AuthenticationManager am;

	@ManagedProperty(value = "#{loginService}")
	private LoginService loginService;

	@ManagedProperty(value = "#{acessoServiceImpl}")
	protected AcessoService acessoService;
	@ManagedProperty(value = "#{usuarioService}")
	protected UsuarioService usuarioService;

	private boolean mostrarMsgInvalidate;

	@Override
	public void verificarAcesso() {
	}

	public void verificarSessionInvalidate() {
		Boolean mostrar = (Boolean) getSessionMap().remove("mostrarMsgSession");
		if (mostrar != null && mostrar) {
			mostrarMsgInvalidate = true;
		} else {
			mostrarMsgInvalidate = false;
		}
	}

	public String logar() {
		try {

			if (getModel().getLogin() == null || getModel().getLogin().equals("")) {
				FacesMessagesUtil.addErrorMessage("Login ", Constantes.CAMPO_OBRIGATORIO);
				return "";
			}
			if (getModel().getSenha() == null || getModel().getSenha().equals("")) {
				FacesMessagesUtil.addErrorMessage("Senha ", Constantes.CAMPO_OBRIGATORIO);
				return "";
			}

			Authentication request = new UsernamePasswordAuthenticationToken(getModel().getLogin().trim(), getModel().getSenha().trim());
			Authentication result = am.authenticate(request);
			SecurityContextHolder.getContext().setAuthentication(result);

			this.setModel(getUsuarioLogando());
			Hibernate.initialize(getModel().getPerfil());
			getSessionMap().put(Constantes.USUARIO_SESSAO, getModel());

		} catch (DisabledException e) {
			FacesMessagesUtil.addErrorMessage("Login ", " Usuário desabilitado");
			return "";
		} catch (AuthenticationException e) {
			// verifica se a senha ta errada ou se é por causa do que nao tem
			// funcionalidades

			Usuario u = getUsuarioLogando();
			if (u == null) {
				FacesMessagesUtil.addErrorMessage("Login ", " Usuário ou senha inválidos");
				return "";
			}

			if (!u.getSenha().equals(CriptoUtil.getCriptografia(getModel().getSenha()))) {
				FacesMessagesUtil.addErrorMessage("Login ", " Usuário ou senha inválidos");
				return "";
			}

			List<Funcionalidade> funcionalidades = acessoService.carregarFuncionalidades(u);
			if (funcionalidades == null || funcionalidades.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Usuário ", " Não tem permissão para acessar o sistema ");
				return "";
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		if (getModel().getSenha() != null && getModel().getSenha().trim().equals(CriptoUtil.getCriptografia(Constantes.SENHA_DEFAULT))) {
			return redirect("/pages/trocarSenha.jsf");
		} else {
			return redirect("/pages/principal.jsf");
		}

	}

	public Usuario getUsuarioLogando() {
		Usuario us = null;
				
		try {

			//List<Usuario> listaAcesso = universalManager.(us, false);
			us = usuarioService.carregaUsuarioPorLogin(getModel().getLogin());
			
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return us;

	}

	public String saveDadosAlterarSenha() {
		try {
			boolean temErroValidacao = false;

			if (userName == null || userName.trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("Usuário ", Constantes.CAMPO_OBRIGATORIO);
				temErroValidacao = true;
			}

			if (senhaAnterior == null || senhaAnterior.trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("Senha Atual ", Constantes.CAMPO_OBRIGATORIO);
				temErroValidacao = true;

			}
			if (senha == null || senha.trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("Nova Senha ", Constantes.CAMPO_OBRIGATORIO);
				temErroValidacao = true;

			}
			if (senha.length() < 6) {
				FacesMessagesUtil.addErrorMessage("Nova Senha ", " Deve ter mais de 6 caracteres ");
				temErroValidacao = true;
			}
			if (senha2 == null || senha2.trim().equals("")) {
				FacesMessagesUtil.addErrorMessage("Confirmação ", Constantes.CAMPO_OBRIGATORIO);
				temErroValidacao = true;
			}

			if (temErroValidacao) {
				return "";
			}

			if (senha.equals(Constantes.SENHA_DEFAULT)) {
				FacesMessagesUtil.addErrorMessage("Nova Senha ", " Não pode ser igual a senha inicial.");
				return "";
			}

			Usuario user = new Usuario();
			user.setLogin(userName);
			List<Usuario> lista = universalManager.listBy(user, false);

			if (lista == null || lista.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Login ", "Não Cadastrado");
				return "";
			}

			user = lista.get(0);
			if (!user.getSenha().equalsIgnoreCase(CriptoUtil.getCriptografia(senhaAnterior))) {
				FacesMessagesUtil.addErrorMessage("", Constantes.SENHA_ATUAL_NAO_CONFERE);
				temErroValidacao = true;
			}
			if (!senha.equals(senha2)) {
				FacesMessagesUtil.addErrorMessage("", Constantes.AMBAS_SENHAS_IDENTICAS);
				temErroValidacao = true;
			}

			if (temErroValidacao) {
				return "";
			}

			user.setSenha(CriptoUtil.getCriptografia(senha));
			Usuario userClone = (Usuario) user.clone();
			this.universalManager.save(userClone);
			limpar();
			FacesMessagesUtil.addInfoMessage("Senha", "Alterada " + ConstantesARQ.COM_SUCESSO);
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_SALVAR);
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}

		return SUCCESS;
	}

	public void limparCandidatos() {

	}

	public String sendMail() {
		try {
			boolean temErroValidacao = false;

			if (userName == null || userName.equals("")) {
				FacesMessagesUtil.addErrorMessage("Login ", Constantes.CAMPO_OBRIGATORIO);
				temErroValidacao = true;
			}
			if (email == null || email.equals("")) {
				FacesMessagesUtil.addErrorMessage("E-mail ", Constantes.CAMPO_OBRIGATORIO);
				temErroValidacao = true;
			}

			if (temErroValidacao) {
				return "";
			}

			Usuario user = new Usuario();
			user.setLogin(userName);
			user.setEmail(email);
			List<Usuario> lista = universalManager.listBy(user, false);

			if (lista == null || lista.isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "Dados não conferem");
				return "";
			} else {
				user = lista.get(0);

				String passwordNv = PasswordUtil.gerarPassword(6);
				user.setSenha(CriptoUtil.getCriptografia(passwordNv));

				SimpleMailMessage message = new SimpleMailMessage();

				message.setFrom(Constantes.EMAIL_SISTEMA);
				message.setTo(user.getEmail());

				message.setSubject("Sistema SISFIE - Informação sobre senha do usuário " + user.getLogin());
				message.setText("A sua nova senha é:  " + passwordNv + "\n\n\n\n");

				Usuario userClone = (Usuario) user.clone();
				loginService.esqueciSenha(userClone, message);
				FacesMessagesUtil.addInfoMessage("E-mail Enviado " + ConstantesARQ.COM_SUCESSO);
			}
			limpar();
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Login ", "Usuário Inválido");
			ExcecaoUtil.tratarExcecao(e);
		}
		return "success";
	}

	public void limpar() {
		this.senha = "";
		this.senha2 = "";
		this.senhaAnterior = "";
		this.userName = "";
		this.email = "";
	}

	public void loginTimeOut() {
		try {
			HttpSession session = (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(false);
			session.invalidate();
			FacesContext.getCurrentInstance().getExternalContext().redirect("/" + Constantes.CONTEXT_PATH + "/login.jsf");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	@Override
	public Usuario createModel() {
		return new Usuario();
	}

	@Override
	public String getQualifiedName() {
		return "Usuário";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public AuthenticationManager getAm() {
		return am;
	}

	public void setAm(AuthenticationManager am) {
		this.am = am;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getSenhaAnterior() {
		return senhaAnterior;
	}

	public void setSenhaAnterior(String senhaAnterior) {
		this.senhaAnterior = senhaAnterior;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public String getSenha2() {
		return senha2;
	}

	public void setSenha2(String senha2) {
		this.senha2 = senha2;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public LoginService getLoginService() {
		return loginService;
	}

	public void setLoginService(LoginService loginService) {
		this.loginService = loginService;
	}

	public AcessoService getAcessoService() {
		return acessoService;
	}

	public void setAcessoService(AcessoService acessoService) {
		this.acessoService = acessoService;
	}

	public boolean isMostrarMsgInvalidate() {
		return mostrarMsgInvalidate;
	}

	public void setMostrarMsgInvalidate(boolean mostrarMsgInvalidate) {
		this.mostrarMsgInvalidate = mostrarMsgInvalidate;
	}

	public UsuarioService getUsuarioService() {
		return usuarioService;
	}

	public void setUsuarioService(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;
	}

}
