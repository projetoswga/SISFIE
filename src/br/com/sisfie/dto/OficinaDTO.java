package br.com.sisfie.dto;

public class OficinaDTO {
	
	private String desHorario;
	private String nomOficina;
	private String desLocalSala;
	
	public OficinaDTO() {
	}
	
	public OficinaDTO(String desHorario, String nomOficina, String desLocalSala) {
		super();
		this.desHorario = desHorario;
		this.nomOficina = nomOficina;
		this.desLocalSala = desLocalSala;
	}

	public String getDesHorario() {
		return desHorario;
	}
	public void setDesHorario(String desHorario) {
		this.desHorario = desHorario;
	}
	public String getNomOficina() {
		return nomOficina;
	}
	public void setNomOficina(String nomOficina) {
		this.nomOficina = nomOficina;
	}
	public String getDesLocalSala() {
		return desLocalSala;
	}
	public void setDesLocalSala(String desLocalSala) {
		this.desLocalSala = desLocalSala;
	}
}