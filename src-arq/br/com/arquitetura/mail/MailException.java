package br.com.arquitetura.mail;

public class MailException extends RuntimeException {

	private static final long serialVersionUID = -8592044670688941896L;

	public MailException(final Throwable cause) {
		super(cause);
	}

}
