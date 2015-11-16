package br.com.arquitetura.envers;

import java.util.Date;

import javax.faces.context.ExternalContext;
import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.envers.RevisionListener;

import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.util.Constantes;

public class CustomListener implements RevisionListener {

	private static final String X_FORWARDED_FOR = "X-Forwarded-For";

	@Override
	public void newRevision(Object revisionEntity) {

		ExternalContext context = FacesContext.getCurrentInstance().getExternalContext();
		HttpSession session = (HttpSession) context.getSession(false);
		Usuario us = (Usuario) session.getAttribute(Constantes.USUARIO_SESSAO);

		RevInfo rev = (RevInfo) revisionEntity;
		rev.setDataAlteracao(new Date());
		if (us != null && us.getId() != null) {
			rev.setNomeUsuario(us.getNome());
			rev.setIdUsuario(us.getId());
		} else {
			rev.setNomeUsuario("externo");
		}
		rev.setIp(this.getRequestIP());

	}

	public String getRequestIP() {
		HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();

		// Recuperando o IP passando pelo proxy
		String address = request.getHeader(X_FORWARDED_FOR);

		if (address != null) {
			if (address.indexOf(',') != -1) {
				address = address.split(",")[0];
			}
			return address;
		}

		// Senao, recupera o IP remoto
		return request.getRemoteAddr();
	}
}