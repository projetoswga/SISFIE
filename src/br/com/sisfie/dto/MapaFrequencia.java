package br.com.sisfie.dto;

public class MapaFrequencia {

	private String data;
	private String presenca;

	public MapaFrequencia() {
	}

	public MapaFrequencia(String data, String presenca) {
		super();
		this.data = data;
		this.presenca = presenca;
	}

	public MapaFrequencia(String data, Character presenca) {
		super();
		this.data = data;
		this.presenca = Character.toString(presenca);
	}

	public String getData() {
		return data;
	}

	public void setData(String data) {
		this.data = data;
	}

	public String getPresenca() {
		return presenca;
	}

	public void setPresenca(String presenca) {
		this.presenca = presenca;
	}
}
