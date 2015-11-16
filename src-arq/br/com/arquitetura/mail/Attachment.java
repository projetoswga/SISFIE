package br.com.arquitetura.mail;

public interface Attachment {

	String getContentAsString();

	String getContentType();

	Disposition getDisposition();

	String getName();

}
