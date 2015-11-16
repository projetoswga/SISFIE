package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Orgao;
import br.com.sisfie.service.OrgaoService;

@ManagedBean(name = "orgaoBean")
@ViewScoped
public class OrgaoBean extends PaginableBean<Orgao> {

	private static final long serialVersionUID = -1376112744204876463L;

	private Orgao orgaoSelecionado;

	@ManagedProperty(value = "#{OrgaoService}")
	protected OrgaoService orgaoService;

	public OrgaoBean() {
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_ORGAO");
	}

	@PostConstruct
	public void carregarListas() {
		verificarAcesso();
	}

	@Override
	public String save() {
		try {
			// Validar unique da sigla
			List<Orgao> lista = orgaoService.pesquisarOrgaoSigla(getModel().getSigla());
			if (lista != null && !lista.isEmpty() && !lista.get(0).getId().equals(getModel().getId())) {
				FacesMessagesUtil.addErrorMessage("Sigla ", " Já cadastrado");
				return "";
			}
			
			if (orgaoSelecionado == null || orgaoSelecionado.getId() == null) {
				getModel().setOrgao(null);
			} else {
				getModel().setOrgao(new Orgao(orgaoSelecionado.getId()));
			}

			if (getModel().getTelefone() != null && !getModel().getTelefone().trim().equals("")) {
				getModel().setTelefone(getModel().getTelefone().trim().replaceAll("[()-]", ""));
			}
			if (getModel().getSigla().length() < 7) {
				String nomeFormat = getModel().getSigla() + " - " + getModel().getNome();
				getModel().setNomeSiglaFormat(nomeFormat);
			} else {
				getModel().setNomeSiglaFormat(getModel().getNome());
			}
			super.save();
			orgaoSelecionado = null;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return SUCCESS;
	}

	public List<Orgao> completeOrgao(String query) {
		List<Orgao> sugestoes = new ArrayList<Orgao>();
		try {
			sugestoes = orgaoService.pesquisarOrgao(query);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;
	}
	
	public void inabilitarOrgao(){
		getModel().setFlgAtivo(false);
		super.save();
	}
	
	public void reabilitarOrgao(){
		getModel().setFlgAtivo(true);
		super.save();
	}

	@Override
	public String load() {
		try {
			super.load();
			if (getModel().getOrgao() != null && getModel().getOrgao().getId() != null) {
				orgaoSelecionado = getModel().getOrgao();
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return SUCCESS;
	}

	@Override
	public Orgao createModel() {
		return new Orgao();
	}

	@Override
	public String getQualifiedName() {
		return "Órgão";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public Orgao getOrgaoSelecionado() {
		return orgaoSelecionado;
	}

	public void setOrgaoSelecionado(Orgao orgaoSelecionado) {
		this.orgaoSelecionado = orgaoSelecionado;
	}

	public OrgaoService getOrgaoService() {
		return orgaoService;
	}

	public void setOrgaoService(OrgaoService orgaoService) {
		this.orgaoService = orgaoService;
	}
}
