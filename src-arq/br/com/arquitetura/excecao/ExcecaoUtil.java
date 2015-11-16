package br.com.arquitetura.excecao;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.util.Date;

import javax.faces.context.FacesContext;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.DateUtil;
import br.com.arquitetura.util.StringUtil;
import br.com.arquitetura.util.ThreadEnviarEmail;
import br.com.sisfie.util.Constantes;

/**
 * Classe usada para tratamento de excecao<br>
 * <li>Escreve o erro no log</li> <li>Direciona para tela de erro
 * <b>error.jsf</b></li>
 * 
 * @author Igor Galvao
 */
public class ExcecaoUtil {

	private static Log log = LogFactory.getLog(ExcecaoUtil.class);

	/**
	 * Escreve informacoes da excecao no log e direciona para pagina de erro.
	 * 
	 * @param Exception
	 *            e
	 */

	public ExcecaoUtil() {
	}

	public static void tratarExcecao(Exception e) {
		if (e == null) {
			log.error("Data Hora:" + DateUtil.getDataHora(new java.util.Date(), "dd/MM/yyyy HH:mm:ss"));
			log.error("-->Excecao ocorrida nula");
			return;
		}

		log.error("Data Hora:" + DateUtil.getDataHora(new java.util.Date(), "dd/MM/yyyy HH:mm:ss"));
		log.error("Excecao do tipo: " + e.getClass().getSimpleName());
		log.error("printStackTrace", e);
		try {
			if (FacesContext.getCurrentInstance() != null
					&& FacesContext.getCurrentInstance().getExternalContext() != null) {

				FacesContext context = FacesContext.getCurrentInstance();

				ServletContext servletContext = (ServletContext) context.getExternalContext().getContext();

				String path = servletContext.getContextPath();

				FacesContext.getCurrentInstance().getExternalContext().redirect(path + "/pages/error.jsf");

				HttpServletRequest request = (HttpServletRequest) FacesContext.getCurrentInstance()
						.getExternalContext().getRequest();
				String ip = StringUtil.getRequestIP(request);

				String pagina = context.getViewRoot().getViewId();

				if (!ip.trim().equals("127.0.0.1") && ConstantesARQ.ENVIAR_EMAIL_ERRO) {
					log.error("=====================================================================");
					log.error("Email com erro enviado para : " + ConstantesARQ.EMAIL_ERRO);
					log.error("=====================================================================");
					ExcecaoUtil excecao = new ExcecaoUtil();
					excecao.enviarEmail(printStackTraceToString(e, path, pagina, ip));
				}

			} else {
				log.error("Data Hora:" + DateUtil.getDataHora(new java.util.Date(), "dd/MM/yyyy HH:mm:ss"));
				log.error("-->Excecao ocorrida fora do Context JSF");
			}
		} catch (IOException ioe) {
			log.error("Data Hora:" + DateUtil.getDataHora(new java.util.Date(), "dd/MM/yyyy HH:mm:ss"));
			log.error("-->Nâo foi possivel redirecionar para tela: error.jsf");
			log.error("", ioe);
		} finally {
			e = null;
		}
	}

	private void enviarEmail(String error) {
		ServletContext context = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
		WebApplicationContext springContext = WebApplicationContextUtils.getWebApplicationContext(context);

		JavaMailSender mailSender = (JavaMailSender) springContext.getBean("mailSender");

		Thread thread = new ThreadEnviarEmail(mailSender, ConstantesARQ.ASSUNTO_EMAIL_ERRO, error,
				ConstantesARQ.EMAIL_ERRO, Constantes.EMAIL_SISTEMA, true);
		thread.start();
	}

	private static String printStackTraceToString(Exception e, String path, String pagina, String ip) {
		StringWriter sw = new StringWriter();
		PrintWriter pw = new PrintWriter(sw);
		e.printStackTrace(pw);

		return "<font color='red'>IP: " + ip + "<br>Pagina:  " + pagina + "<br>SISTEMA: " + path + "<br/>Data e Hora: "
				+ DateUtil.getDataHora(new Date(), "dd/MM/yyyy HH:mm:ss") + "</font><br/><br/>" + "------<br/>"
				+ sw.toString() + "------<br/>";
	}
}
