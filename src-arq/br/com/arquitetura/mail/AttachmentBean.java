package br.com.arquitetura.mail;

abstract class AttachmentBean implements Attachment {

	private String name;

	private String contentType;

	private String contentAsString;

	private Disposition disposition;

	public AttachmentBean() {
		super();
	}

	@Override
	public String getName() {
		return this.name;
	}

	void setName(final String name) {
		this.name = name;
	}

	@Override
	public String getContentType() {
		return this.contentType;
	}

	void setContentType(final String contentType) {
		this.contentType = contentType;
	}

	@Override
	public String getContentAsString() {
		return this.contentAsString;
	}

	void setContentAsString(final String contentAsString) {
		this.contentAsString = contentAsString;
	}

	@Override
	public Disposition getDisposition() {
		return this.disposition;
	}

	public void setDisposition(final Disposition disposition) {
		this.disposition = disposition;
	}

}
