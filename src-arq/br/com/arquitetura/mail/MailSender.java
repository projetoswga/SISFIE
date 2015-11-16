package br.com.arquitetura.mail;

public interface MailSender {

	void send(Mail mail);

	void send(Mail[] mails);

}