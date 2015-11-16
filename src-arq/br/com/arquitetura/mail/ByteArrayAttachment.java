package br.com.arquitetura.mail;

public class ByteArrayAttachment extends AttachmentBean {

	public ByteArrayAttachment(final String name, final String contentType, final byte[] bytes) {
		this(name, contentType, bytes, Disposition.ATTACHMENT);
	}

	public ByteArrayAttachment(final String name, final String contentType, final byte[] bytes,
			final Disposition disposition) {
		super();
		this.setName(name);
		this.setContentType(contentType);
		this.setContentAsString(new String(bytes));
		this.setDisposition(disposition);
	}

}
