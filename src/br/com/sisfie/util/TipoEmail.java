package br.com.sisfie.util;

public enum TipoEmail {

	INSTRUTOR("I"), PARCEIRO("P"), PRIVADO("R");

	private String tipo;

	private TipoEmail(String tipo) {
		this.tipo = tipo;
	}

	public String getTipo() {
		return tipo;
	}

	public void setTipo(String tipo) {
		this.tipo = tipo;
	}

}
