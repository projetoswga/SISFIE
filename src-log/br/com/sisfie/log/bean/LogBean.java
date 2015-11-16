package br.com.sisfie.log.bean;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.entidade.Entidade;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.service.UniversalManager;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.log.base.LogBase;
import br.com.sisfie.log.entidade.LogCandidato;

@ManagedBean
@ViewScoped
@SuppressWarnings("unchecked")
public class LogBean extends BaseBean<Entidade<Integer>> {

	private static final long serialVersionUID = 1L;

	private LogBase log;

	@ManagedProperty(value = "#{universalManager}")
	public UniversalManager universalManager;

	public LogBean() {

	}

	@PostConstruct
	public void carregar() {
		try {
			log = LogCandidato.class.newInstance();
			log.setObjects(universalManager.getAll(Candidato.class));
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	public UniversalManager getUniversalManager() {
		return universalManager;
	}

	public void setUniversalManager(UniversalManager universalManager) {
		this.universalManager = universalManager;
	}

	@Override
	public void verificarAcesso() {
	}

	@Override
	public Entidade<Integer> createModel() {
		return null;
	}

	@Override
	public String getQualifiedName() {
		return null;
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public LogBase getLog() {
		return log;
	}

	public void setLog(LogBase log) {
		this.log = log;
	}

}
