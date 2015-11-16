package br.com.arquitetura.mail;

import java.io.Serializable;
import java.util.Collection;

public interface Mail extends Serializable {

	Collection<Attachment> getAttach();

	Collection<String> getBcc();

	Collection<String> getCc();

	String getFrom();

	boolean isHtml();

	Collection<String> getReplyTo();

	String getSubject();

	String getText();

	Collection<String> getTo();

}