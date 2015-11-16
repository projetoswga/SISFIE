package br.com.arquitetura.util;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import br.com.arquitetura.excecao.ExcecaoUtil;

public class ThreadEnviarEmail extends Thread {

	private JavaMailSender simpleMailSender;

	private String assunto;
	private String texto;
	private String to;
	private String from;
	private boolean usarHtml;

	public ThreadEnviarEmail(JavaMailSender simpleMailSender, String assunto, String texto, String to, String from, boolean usarHtml) {
		try {
			this.simpleMailSender = simpleMailSender;
			this.assunto = assunto;
			this.texto = texto;
			this.to = to;
			this.from = from;
			this.usarHtml = usarHtml;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	public void run() {
		try {

			MimeMessage messagem = simpleMailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(messagem, true);
			helper.setTo(to);
			helper.setFrom(from);
			helper.setSubject(assunto);

			helper.setText(texto, usarHtml);
			simpleMailSender.send(messagem);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public JavaMailSender getSimpleMailSender() {
		return simpleMailSender;
	}

	public void setSimpleMailSender(JavaMailSender simpleMailSender) {
		this.simpleMailSender = simpleMailSender;
	}

	public String getAssunto() {
		return assunto;
	}

	public void setAssunto(String assunto) {
		this.assunto = assunto;
	}

	public String getTexto() {
		return texto;
	}

	public void setTexto(String texto) {
		this.texto = texto;
	}

	public String getTo() {
		return to;
	}

	public void setTo(String to) {
		this.to = to;
	}

	public String getFrom() {
		return from;
	}

	public void setFrom(String from) {
		this.from = from;
	}

	public boolean isUsarHtml() {
		return usarHtml;
	}

	public void setUsarHtml(boolean usarHtml) {
		this.usarHtml = usarHtml;
	}

}
