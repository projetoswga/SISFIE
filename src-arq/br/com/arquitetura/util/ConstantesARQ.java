package br.com.arquitetura.util;

import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ResourceBundle;

import javax.faces.context.FacesContext;
import javax.servlet.http.HttpServletRequest;

import br.com.arquitetura.excecao.ExcecaoUtil;

/**
 * 
 * @author Igor Galv�o
 * 
 */
public class ConstantesARQ {

	private static HttpServletRequest request;

	private static ResourceBundle bundle = ResourceBundle.getBundle("constantes", FacesContext.getCurrentInstance().getViewRoot()
			.getLocale());

	public static String getString(String key) {
		return bundle.getString(key);
	}

	public static Object getObject(String key) {
		return bundle.getObject(key);
	}

	public static String EMAIL_GESTOR = getString("email_gestor");
	public static String TELEFONE_GESTOR = getString("telefone_gestor");

	/**
	 * Configura��o do email de erro
	 */
	public static boolean ENVIAR_EMAIL_ERRO = Boolean.valueOf(getString("enviar_email_erro"));
	public static String EMAIL_ERRO = getString("email_erro");
	public static String ASSUNTO_EMAIL_ERRO = getString("assunto_email_erro");

	public static String REMOVIDO = getString("removido");
	public static String REMOVIDA = getString("removida");
	public static String CARREGADO = getString("carregado");
	public static String CARREGADA = getString("carregada");
	public static String SALVO = getString("salvo");
	public static String SALVA = getString("salva");
	public static String ERRO_EXCLUIR = getString("erro_excluir");
	public static String ERRO_EXCLUIR_DEPENDENCIA = getString("erro_excluir_dependencia");

	public static String ERRO_CARREGAR = getString("erro_carregar");
	public static String ERRO_SALVAR = getString("erro_salvar");
	public static String COM_SUCESSO = getString("com_sucesso");
	public static String CAMPO_OBRIGATORIO = getString("campo_obrigatorio");

	public static String FACES_REDIRECT = getString("faces_redirect");

	public static String PAGINACAO = getString("paginacao");
	public static String EMPTY_MESSAGE = getString("empty_message");
	public static String JA_ADICIONADO = getString("ja_adicionado");

	public static String ENDERECO_SERVIDOR_COM_PATH = getCaminhoAplicacao();

	public static String CONTEXT_PATH = getContextPath();

	// Devolve ip:porta/path
	public static String getCaminhoAplicacao() {
		InetAddress addr = null;
		try {
			addr = InetAddress.getLocalHost();

		} catch (UnknownHostException e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		String path = getRequest().getContextPath();
		String ip = addr.getHostAddress();
		if (ip.trim().equals("10.48.30.98")) {
			ip = ip.replace("10.48.30.98", "177.70.21.254");
		}
		Integer porta = getRequest().getLocalPort();

		return "http://"+ip + ":" + porta.toString() + path;
	}

	// Devolve Context Path sem Barra
	private static String getContextPath() {
		String path = getRequest().getContextPath().replaceAll("[/]", "");
		return path;
	}

	public static HttpServletRequest getRequest() {
		if (request == null) {
			request = (HttpServletRequest) FacesContext.getCurrentInstance().getExternalContext().getRequest();
		}
		return request;
	}

	public static void setRequest(HttpServletRequest request) {
		ConstantesARQ.request = request;
	}

}
