package br.com.sisfie.bean;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.sisfie.entidade.Area;

@ManagedBean(name = "areaBean")
@ViewScoped
public class AreaBean extends PaginableBean<Area> {

	private static final long serialVersionUID = -8294188998250807722L;

	public AreaBean() {
	}
	

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	@PostConstruct
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_AREA");
	}

	@Override
	public Area createModel() {
		return new Area();
	}

	@Override
	public String getQualifiedName() {
		return "Área";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}
}
