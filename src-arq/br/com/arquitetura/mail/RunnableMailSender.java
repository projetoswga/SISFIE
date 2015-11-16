package br.com.arquitetura.mail;

import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.MimeMessage;

public class RunnableMailSender extends AbstractMailSender {

	public RunnableMailSender() {
		super();
	}

	public RunnableMailSender(final String smtpServer) {
		super(smtpServer);
	}

	public RunnableMailSender(final String smtpServer, final int smtpPort) {
		super(smtpServer, smtpPort);
	}

	public RunnableMailSender(final String smtpServer, final int smtpPort, final String user, final String password) {
		super(smtpServer, smtpPort, user, password);
	}

	@Override
	protected void send(final Mail message, final Session session) {
		try {
			MimeMessage mimeMessage = MailHelper.toMimeMessage(message, session);
			Transport transport = MailHelper.getTransport(session, this.getSmtpServer(), this.getSmtpPort(),
					this.getUser(), this.getPassword());
			Runnable runnable = new RunnableMailSenderHelper(mimeMessage, transport);
			Thread thread = new Thread(runnable);
			thread.start();
		} catch (MessagingException e) {
			throw new MailException(e);
		}
	}

	public static class RunnableMailSenderHelper implements Runnable {

		private MimeMessage mimeMessage;

		private Transport transport;

		public RunnableMailSenderHelper(final MimeMessage mimeMessage, final Transport transport) {
			super();
			this.mimeMessage = mimeMessage;
			this.transport = transport;
		}

		@Override
		public void run() {
			try {
				MailHelper.send(this.mimeMessage, this.transport);
			} catch (MessagingException e) {
				throw new MailException(e);
			}
		}

	}

}
