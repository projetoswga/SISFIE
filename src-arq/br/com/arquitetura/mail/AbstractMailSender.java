package br.com.arquitetura.mail;

import java.util.Properties;

import javax.mail.Session;

public abstract class AbstractMailSender implements MailSender {

	public static final String PROTOCOL = "smtp";

	public static final int DEFAULT_SMTP_PORT = 25;

	private static final long TIMEOUT = 15000;

	private String smtpServer;

	private int smtpPort = AbstractMailSender.DEFAULT_SMTP_PORT;

	private String user;

	private String password;

	private boolean debug;

	public AbstractMailSender() {
		super();
	}

	public AbstractMailSender(final String smtpServer) {
		super();
		this.smtpServer = smtpServer;
	}

	public AbstractMailSender(final String smtpServer, final int smtpPort) {
		super();
		this.smtpServer = smtpServer;
		this.smtpPort = smtpPort;
	}

	public AbstractMailSender(final String smtpServer, final int smtpPort, final String user, final String password) {
		super();
		this.smtpServer = smtpServer;
		this.smtpPort = smtpPort;
		this.user = user;
		this.password = password;
	}

	@Override
	public void send(final Mail mail) {
		this.send(mail, this.getSession());
	}

	@Override
	public void send(final Mail[] mails) {
		for (Mail mail : mails) {
			this.send(mail, this.getSession());
		}
	}

	protected abstract void send(final Mail mail, final Session session);

	// Aux
	private Session getSession() {
		Properties properties = new Properties();
		properties.put("mail.debug", Boolean.toString(this.debug));
		properties.put("mail.smtp.host", this.smtpServer);
		properties.put("mail.smtp.port", Integer.toString(this.smtpPort));
		properties.put("mail.smtp.timeout", Long.toString(AbstractMailSender.TIMEOUT));
		properties.put("mail.smtp.connectiontimeout", Long.toString(AbstractMailSender.TIMEOUT));
		if (this.user != null && !this.user.isEmpty()) {
			properties.put("mail.smtp.auth", "true");
		}
		return Session.getDefaultInstance(properties);
	}

	// Getters and Setters
	public String getSmtpServer() {
		return this.smtpServer;
	}

	public void setSmtpServer(final String smtpServer) {
		this.smtpServer = smtpServer;
	}

	public int getSmtpPort() {
		return this.smtpPort;
	}

	public void setSmtpPort(final int smtpPort) {
		this.smtpPort = smtpPort;
	}

	public String getUser() {
		return this.user;
	}

	public void setUser(final String user) {
		this.user = user;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(final String password) {
		this.password = password;
	}

	public boolean isDebug() {
		return this.debug;
	}

	public void setDebug(final boolean debug) {
		this.debug = debug;
	}

}
