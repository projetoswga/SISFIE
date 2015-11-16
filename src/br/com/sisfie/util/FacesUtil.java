package br.com.sisfie.util;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URI;

import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

public class FacesUtil {

	public static String path() {
		FacesContext context = FacesContext.getCurrentInstance();
		ServletContext servletContext = (ServletContext) context.getExternalContext().getContext();
		return servletContext.getContextPath();
	}

	public static void redirecionarCaminhoCompleto(String caminho) throws IOException {
		String url = "";
		if (caminho.contains("?faces-redirect=true")) {
			url = FacesUtil.path() + caminho;
		} else {
			url = FacesUtil.path() + caminho + "?faces-redirect=true";
		}

		FacesContext.getCurrentInstance().getExternalContext().redirect(url);
	}

	public static void logout() {
		HttpSession session = (HttpSession) FacesContext.getCurrentInstance().getExternalContext().getSession(false);
		session.invalidate();
	}

	public static String getApplicationURI() throws Exception {
		URI uri = new URI(FacesContext.getCurrentInstance().getExternalContext().getRequestScheme(), null, FacesContext
				.getCurrentInstance().getExternalContext().getRequestServerName(), FacesContext.getCurrentInstance().getExternalContext()
				.getRequestServerPort(), FacesContext.getCurrentInstance().getExternalContext().getRequestContextPath() + "/", null, null);
		return uri.toASCIIString();
	}

	public static String lerAquivo(InputStream stream) throws Exception {
		StringBuilder texto = new StringBuilder();
		BufferedReader in = new BufferedReader(new InputStreamReader(stream));
		while (in.ready()) {
			texto.append(in.readLine());
		}
		in.close();
		return texto.toString();
	}

}
