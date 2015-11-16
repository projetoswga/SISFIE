package br.com.arquitetura.mail;

import java.io.IOException;
import java.io.InputStream;

public class InputStreamAttachment extends AttachmentBean {

	public InputStreamAttachment(final String name, final String contentType, final InputStream inputStream) {
		this(name, contentType, inputStream, Disposition.ATTACHMENT);
	}

	public InputStreamAttachment(final String name, final String contentType, final InputStream inputStream,
			final Disposition disposition) {
		super();

		try {
			byte[] bytes = new byte[inputStream.available()];
			inputStream.read(bytes);

			this.setName(name);
			this.setContentType(contentType);
			this.setContentAsString(new String(bytes));
			this.setDisposition(disposition);
		} catch (IOException e) {
			throw new MailException(e);
		}
	}

}
