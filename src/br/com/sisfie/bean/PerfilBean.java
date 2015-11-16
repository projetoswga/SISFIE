package br.com.sisfie.bean;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.sisfie.entidade.Perfil;

@ManagedBean(name = "perfilBean")
@ViewScoped
public class PerfilBean extends PaginableBean<Perfil> {

	private static final long serialVersionUID = 1L;

	public PerfilBean() {
	}

	@Override
	@PostConstruct
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_PERFIL");
	}

	@Override
	public Perfil createModel() {
		return new Perfil();
	}

	@Override
	public String getQualifiedName() {
		return "Perfil";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

}
