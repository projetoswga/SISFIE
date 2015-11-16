package br.com.sisfie.bean;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.sisfie.entidade.Cargo;

@ManagedBean(name = "cargoBean")
@ViewScoped
public class CargoBean extends PaginableBean<Cargo> {

	private static final long serialVersionUID = -507533115478637909L;

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	@PostConstruct
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_CARGO");
	}

	@Override
	public Cargo createModel() {
		return new Cargo();
	}

	@Override
	public String getQualifiedName() {
		return "Cargo";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

}
