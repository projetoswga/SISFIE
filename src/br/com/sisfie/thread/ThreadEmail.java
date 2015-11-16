package br.com.sisfie.thread;

import java.util.ArrayList;
import java.util.List;

import javax.mail.internet.MimeMessage;

import org.springframework.mail.MailSendException;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;

import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.util.Constantes;

public class ThreadEmail extends Thread {

	private JavaMailSender simpleMailSender;

	private InscricaoCurso[] inscricoes;

	private String assunto;

	private String corpoEmail;

	private String emailResponsavel;

	private EmailCursoPrivado[] emailCursoPrivado;

	private boolean cursoPrivado;

	public ThreadEmail(JavaMailSender simpleMailSender, InscricaoCurso[] inscricoes, String assunto, String corpoEmail,
			String emailResponsavel) {
		this.simpleMailSender = simpleMailSender;
		this.inscricoes = inscricoes;
		this.assunto = assunto;
		this.corpoEmail = corpoEmail;
		this.emailResponsavel = emailResponsavel;
	}

	public ThreadEmail(JavaMailSender simpleMailSender, EmailCursoPrivado[] emailCursoPrivado, String assunto,
			String corpoEmail, String emailResponsavel, boolean cursoPrivado) {
		this.simpleMailSender = simpleMailSender;
		this.assunto = assunto;
		this.corpoEmail = corpoEmail;
		this.emailResponsavel = emailResponsavel;
		this.emailCursoPrivado = emailCursoPrivado;
		this.cursoPrivado = cursoPrivado;

	}

	public void run() {
		List<String> emailsNaoEnviados = new ArrayList<String>();
		List<String> emailsEnviados = new ArrayList<String>();
		try {
			if(cursoPrivado){
				for (EmailCursoPrivado obj : emailCursoPrivado) {
					MimeMessage messagem = simpleMailSender.createMimeMessage();
					MimeMessageHelper helper = new MimeMessageHelper(messagem, true);
					helper.setTo(obj.getEmail());
					helper.setFrom(Constantes.EMAIL_SISTEMA);
					helper.setSubject(assunto);

					helper.setText(corpoEmail, true);
					try {
						simpleMailSender.send(messagem);
						emailsEnviados.add(obj.getEmail());
					} catch (MailSendException e) {
						emailsNaoEnviados.add(obj.getEmail());
					}
				}
			}else{
				for (InscricaoCurso obj : inscricoes) {
					MimeMessage messagem = simpleMailSender.createMimeMessage();
					MimeMessageHelper helper = new MimeMessageHelper(messagem, true);
					helper.setTo(obj.getCandidato().getEmailInstitucional());
					helper.setFrom(Constantes.EMAIL_SISTEMA);
					helper.setSubject(assunto);

					helper.setText(corpoEmail, true);
					try {
						simpleMailSender.send(messagem);
						emailsEnviados.add(obj.getCandidato().getEmailInstitucional());
					} catch (MailSendException e) {
						emailsNaoEnviados.add(obj.getCandidato().getEmailInstitucional());
					}
				}
			}

			// Envia email para o responsável avisando se tudo de certo.
			MimeMessage messagem = simpleMailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(messagem, true);
			helper.setTo(emailResponsavel);
			helper.setFrom(Constantes.EMAIL_SISTEMA);
			helper.setSubject("[SISFIE] - Envio de mala direta");

			StringBuilder msg = new StringBuilder();
			msg.append("<b><font color=\"blue\">Emails enviados com sucesso:</font> </b> <br/><br/>");
			for (String email : emailsEnviados) {
				msg.append(email + "<br/>");
			}
			msg.append("<br/>");
			msg.append("<br/>");
			if (emailsNaoEnviados != null && !emailsNaoEnviados.isEmpty()) {
				msg.append("<b><font color=\"red\">Emails não enviados:</font> </b> <br/><br/>");
				for (String email : emailsNaoEnviados) {
					msg.append(email + "<br/>");
				}
				msg.append("<br/>");
			}

			helper.setText(msg.toString(), true);
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

	public InscricaoCurso[] getInscricoes() {
		return inscricoes;
	}

	public void setInscricoes(InscricaoCurso[] inscricoes) {
		this.inscricoes = inscricoes;
	}

	public String getAssunto() {
		return assunto;
	}

	public void setAssunto(String assunto) {
		this.assunto = assunto;
	}

	public String getCorpoEmail() {
		return corpoEmail;
	}

	public void setCorpoEmail(String corpoEmail) {
		this.corpoEmail = corpoEmail;
	}

	public String getEmailResponsavel() {
		return emailResponsavel;
	}

	public void setEmailResponsavel(String emailResponsavel) {
		this.emailResponsavel = emailResponsavel;
	}

	public boolean isCursoPrivado() {
		return cursoPrivado;
	}

	public void setCursoPrivado(boolean cursoPrivado) {
		this.cursoPrivado = cursoPrivado;
	}

	public EmailCursoPrivado[] getEmailCursoPrivado() {
		return emailCursoPrivado;
	}

	public void setEmailCursoPrivado(EmailCursoPrivado[] emailCursoPrivado) {
		this.emailCursoPrivado = emailCursoPrivado;
	}

}
