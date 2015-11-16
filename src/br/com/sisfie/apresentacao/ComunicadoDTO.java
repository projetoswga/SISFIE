package br.com.sisfie.apresentacao;

public class ComunicadoDTO {

	private String canditado;
	private String coordenador;
	private String dataInicio;
	private String status;
	private String curso;
	private String dtFim;
	private boolean anexo;

	public ComunicadoDTO(String canditado, String coordenador, String dataInicio, String status) {
		this.canditado = canditado;
		this.coordenador = coordenador;
		this.dataInicio = dataInicio;
		this.status = status;
	}

	public ComunicadoDTO(String canditado,String curso, String dataInicio, String dtFim, boolean anexo, String status) {
		this.canditado = canditado;
		this.curso = curso;
		this.dataInicio = dataInicio;
		this.dtFim = dtFim;
		this.anexo = anexo;
		this.status = status;
	}

	public String getCanditado() {
		return canditado;
	}

	public void setCanditado(String canditado) {
		this.canditado = canditado;
	}

	public String getCoordenador() {
		return coordenador;
	}

	public void setCoordenador(String coordenador) {
		this.coordenador = coordenador;
	}

	public String getDataInicio() {
		return dataInicio;
	}

	public void setDataInicio(String dataInicio) {
		this.dataInicio = dataInicio;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getCurso() {
		return curso;
	}

	public void setCurso(String curso) {
		this.curso = curso;
	}

	public String getDtFim() {
		return dtFim;
	}

	public void setDtFim(String dtFim) {
		this.dtFim = dtFim;
	}

	public boolean isAnexo() {
		return anexo;
	}

	public void setAnexo(boolean anexo) {
		this.anexo = anexo;
	}
}
