package br.com.sisfie.dto;

import java.util.Date;

public class CursoDTO {

	private String codigo;
	private String titulo;
	private Integer idArea;
	private Integer idLocal;
	private Integer idSetor;
	private Date dtRealizacaoInicio;
	private Date dtRealizacaoFim;

	public String getCodigo() {
		return codigo;
	}

	public void setCodigo(String codigo) {
		this.codigo = codigo;
	}

	public String getTitulo() {
		return titulo;
	}

	public void setTitulo(String titulo) {
		this.titulo = titulo;
	}

	public Integer getIdArea() {
		return idArea;
	}

	public void setIdArea(Integer idArea) {
		this.idArea = idArea;
	}

	public Integer getIdLocal() {
		return idLocal;
	}

	public void setIdLocal(Integer idLocal) {
		this.idLocal = idLocal;
	}

	public Date getDtRealizacaoInicio() {
		return dtRealizacaoInicio;
	}

	public void setDtRealizacaoInicio(Date dtRealizacaoInicio) {
		this.dtRealizacaoInicio = dtRealizacaoInicio;
	}

	public Date getDtRealizacaoFim() {
		return dtRealizacaoFim;
	}

	public void setDtRealizacaoFim(Date dtRealizacaoFim) {
		this.dtRealizacaoFim = dtRealizacaoFim;
	}

	public Integer getIdSetor() {
		return idSetor;
	}

	public void setIdSetor(Integer idSetor) {
		this.idSetor = idSetor;
	}
	

}
