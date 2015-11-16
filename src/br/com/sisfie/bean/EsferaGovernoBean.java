package br.com.sisfie.bean;

import java.util.Map;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.sisfie.entidade.EsferaGoverno;

@ManagedBean(name = "esferaGovernoBean")
@ViewScoped
public class EsferaGovernoBean extends PaginableBean<EsferaGoverno> {

	private static final long serialVersionUID = -6235961319165346125L;

	public EsferaGovernoBean() {
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {
	}

	@Override
	public EsferaGoverno createModel() {
		return new EsferaGoverno();
	}

	@Override
	public String getQualifiedName() {
		return "Esfera de Governo";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}

}
