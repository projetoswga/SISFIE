package br.com.sisfie.bean;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.model.SelectItem;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.service.UniversalManager;
import br.com.arquitetura.util.ComboUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Perfil;
import br.com.sisfie.entidade.SetorResponsavelEsaf;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.UsuarioService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.CriptoUtil;

@ManagedBean(name = "usuarioBean")
@ViewScoped
public class UsuarioBean extends PaginableBean<Usuario> {

	private static final long serialVersionUID = -2117169483826989342L;

	private Integer idPerfilSelecionado;
	private Integer idSetorResponsavel;

	private List<SelectItem> perfis;
	private List<SelectItem> setores;

	@ManagedProperty(value = "#{usuarioService}")
	public UsuarioService usuarioService;

	@Override
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_USUARIO");
	}

	@SuppressWarnings("unchecked")
	@PostConstruct
	public void carregarListas() {
		verificarAcesso();
		perfis = ComboUtil.getItens(universalManager.getAll(Perfil.class));
		SelectItem itemRemover = null;
		for (SelectItem item : perfis) {
			if (item.getLabel().equalsIgnoreCase(Constantes.PERFIL_SISFIE)) {
				itemRemover = item;
			}
		}
		setores = ComboUtil.getItens(universalManager.getAll(SetorResponsavelEsaf.class));
		
		if (itemRemover != null) {
			perfis.remove(itemRemover);
		}

		Collections.sort(perfis, new Comparator<SelectItem>() {
			@Override
			public int compare(SelectItem o1, SelectItem o2) {
				return o1.getLabel().compareTo(o2.getLabel());
			}
		});
		
		Collections.sort(setores, new Comparator<SelectItem>() {
			@Override
			public int compare(SelectItem o1, SelectItem o2) {
				return o1.getLabel().compareTo(o2.getLabel());
			}
		});
	}

	@SuppressWarnings("unchecked")
	@Override
	public String save() {
		try {
			// so colocar a senha se for novo registro
			if (getModel().getId() == null) {
				getModel().setSenha(CriptoUtil.getCriptografia(Constantes.SENHA_DEFAULT));
			}
			getModel().setPerfil(new Perfil(idPerfilSelecionado));
			getModel().setSetorResponsavelEsaf(new SetorResponsavelEsaf(idSetorResponsavel));

			// Validar Login unique
			Usuario user = new Usuario();
			user.setLogin(getModel().getLogin().trim());
			List<Usuario> lista = universalManager.listBy(user, false);
			if (lista != null && !lista.isEmpty() && !lista.get(0).getId().equals(getModel().getId())) {
				FacesMessagesUtil.addErrorMessage("Login ", " Já cadastrado");
				return "";
			}

			// Validar Email unique
			user = new Usuario();
			user.setEmail(getModel().getEmail().trim());
			lista = universalManager.listBy(user, false);
			if (lista != null && !lista.isEmpty() && !lista.get(0).getId().equals(getModel().getId())) {
				FacesMessagesUtil.addErrorMessage("Email ", " Já cadastrado");
				return "";
			}
			super.save();
			idPerfilSelecionado = null;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return SUCCESS;
	}

	public String restaurarSenha() {
		try {
			usuarioService.restaurarSenha((Usuario) getModel().clone());
			FacesMessagesUtil.addInfoMessage("Senha  Restaurada", " SENHA ATUAL: " + Constantes.SENHA_DEFAULT);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return SUCCESS;
	}

	@Override
	public String load() {

		super.load();
		idPerfilSelecionado = getModel().getPerfil().getId();
		return SUCCESS;
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public Usuario createModel() {
		return new Usuario();
	}

	@Override
	public String getQualifiedName() {
		return "Usuário";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public Integer getIdPerfilSelecionado() {
		return idPerfilSelecionado;
	}

	public void setIdPerfilSelecionado(Integer idPerfilSelecionado) {
		this.idPerfilSelecionado = idPerfilSelecionado;
	}

	public List<SelectItem> getPerfis() {
		return perfis;
	}

	public void setPerfis(List<SelectItem> perfis) {
		this.perfis = perfis;
	}

	public UsuarioService getUsuarioService() {
		return usuarioService;
	}

	public void setUsuarioService(UsuarioService usuarioService) {
		this.usuarioService = usuarioService;
	}

	public Integer getIdSetorResponsavel() {
		return idSetorResponsavel;
	}

	public void setIdSetorResponsavel(Integer idSetorResponsavel) {
		this.idSetorResponsavel = idSetorResponsavel;
	}

	public List<SelectItem> getSetores() {
		return setores;
	}

	public void setSetores(List<SelectItem> setores) {
		this.setores = setores;
	}
	
	

}
