package br.com.sisfie.bean;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.sisfie.entidade.Atuacao;

@ManagedBean(name = "atuacaoBean")
@ViewScoped
public class AtuacaoBean extends PaginableBean<Atuacao> {

	private static final long serialVersionUID = -8294188998250807722L;

	public AtuacaoBean() {
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
	public Atuacao createModel() {
		return new Atuacao();
	}

	@Override
	public String getQualifiedName() {
		return "Atuação";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}
}
