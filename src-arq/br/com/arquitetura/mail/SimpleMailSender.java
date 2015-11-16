package br.com.arquitetura.mail;

import java.io.Serializable;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;

public class SimpleMailSender extends AbstractMailSender implements Serializable {

	public SimpleMailSender() {
		super();
	}

	public SimpleMailSender(final String smtpServer) {
		super(smtpServer);
	}

	public SimpleMailSender(final String smtpServer, final int smtpPort) {
		super(smtpServer, smtpPort);
	}

	public SimpleMailSender(final String smtpServer, final int smtpPort, final String user, final String password) {
		super(smtpServer, smtpPort, user, password);
	}

	@Override
	protected void send(final Mail message, final Session session) {
		try {
			MimeMessage mimeMessage = MailHelper.toMimeMessage(message, session);
			Transport transport = MailHelper.getTransport(session, this.getSmtpServer(), this.getSmtpPort(),
					this.getUser(), this.getPassword());
			MailHelper.send(mimeMessage, transport);
		} catch (MessagingException e) {
			throw new MailException(e);
		}
	}

}
