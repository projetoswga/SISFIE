package br.com.sisfie.util;

import br.com.arquitetura.util.ConstantesARQ;

public class Constantes extends ConstantesARQ {

	public static final String USUARIO_SESSAO = getString("usuario_sessao");

	public static String SENHA_ATUAL_NAO_CONFERE = getString("senha_atual_nao_confere");
	public static String AMBAS_SENHAS_IDENTICAS = getString("ambas_senhas_identicas");

	public static String EMAIL_SISTEMA = getString("email_sistema");
	public static String SENHA_DEFAULT = getString("senha_default");
	public static String PERFIL_SISFIE = getString("perfil_sisfie");
	public static String HTML = getString("HTML_JASPER");
	public static String PDF = getString("PDF_JASPER");
	public static String EXCEL = getString("EXCEL_JASPER");

	public static String PATH_IMG_WINDOWS = getString("path_img_windows");
	public static String PATH_IMG_LINUX = getString("path_img_linux");
	public static String PATH_LINK_IMG = getString("path_link_img");
	public static Boolean ATIVA_IMG_LINK = new Boolean(getString("ativa_img_link").trim());

	public static String URL_COMPROVANTE = getString("urlComprovante");
}
