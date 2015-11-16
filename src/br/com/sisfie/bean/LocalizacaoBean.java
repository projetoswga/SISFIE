package br.com.sisfie.bean;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.sisfie.entidade.Localizacao;

@ManagedBean(name = "localizacaoBean")
@ViewScoped
public class LocalizacaoBean extends PaginableBean<Localizacao>{

	private static final long serialVersionUID = -1946111115213215571L;
	
	

	public LocalizacaoBean() {
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	@PostConstruct
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_LOCALIZACAO");
	}

	@Override
	public Localizacao createModel() {
		return new Localizacao();
	}

	@Override
	public String getQualifiedName() {
		return "Local Realização";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

}
