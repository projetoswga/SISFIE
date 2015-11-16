package br.com.sisfie.bean;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.sisfie.entidade.Atuacao;
import br.com.sisfie.entidade.SetorResponsavelEsaf;

@ManagedBean(name = "setorResponsavelBean")
@ViewScoped
public class SetorResponsavelBean extends PaginableBean<SetorResponsavelEsaf> {

	private static final long serialVersionUID = -8294188998250807722L;

	public SetorResponsavelBean() {
	}

	@Override
	@PostConstruct
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_ATUACAO");
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public SetorResponsavelEsaf createModel() {
		return new SetorResponsavelEsaf();
	}

	@Override
	public String getQualifiedName() {
		return "Setor Responsável ESAF";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}
}
