package br.com.sisfie.bean;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.sisfie.entidade.AreaConhecimento;

@ManagedBean(name = "areaConhecimentoBean")
@ViewScoped
public class AreaConhecimentoBean extends PaginableBean<AreaConhecimento> {

	private static final long serialVersionUID = -8294188998250807722L;

	public AreaConhecimentoBean() {
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	@PostConstruct
	public void verificarAcesso() {
		// acessoBean.bloquearTela("ROLE_AREA_CONHECIMENTO");
	}

	@Override
	public AreaConhecimento createModel() {
		return new AreaConhecimento();
	}

	@Override
	public String getQualifiedName() {
		return "Área de Conhecimento";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}
}
