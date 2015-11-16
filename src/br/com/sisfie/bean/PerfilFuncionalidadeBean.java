package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.event.AjaxBehaviorEvent;
import javax.faces.model.SelectItem;

import org.primefaces.model.DefaultTreeNode;
import org.primefaces.model.TreeNode;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ComboUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Funcionalidade;
import br.com.sisfie.entidade.Perfil;
import br.com.sisfie.entidade.PerfilFuncionalidade;
import br.com.sisfie.service.AcessoService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.CustomTreeNode;

@ManagedBean(name = "perfilFuncionalidadeBean")
@ViewScoped
public class PerfilFuncionalidadeBean extends PaginableBean<PerfilFuncionalidade> {

	private static final long serialVersionUID = 2666747395316165039L;

	private List<SelectItem> perfis;

	private Integer idPerfilSelecionado;

	private Integer idPerfilHerdado;

	private TreeNode rootColum1;
	private TreeNode rootColum2;
	private TreeNode rootColum3;

	private List<TreeNode> selecionados;
	private TreeNode[] selecionadoColum1;
	private TreeNode[] selecionadoColum2;
	private TreeNode[] selecionadoColum3;

	private boolean selecionarTodos;

	@ManagedProperty(value = "#{acessoServiceImpl}")
	private AcessoService acessoService;

	@Override
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_PERFIL_FUNCIONALIDADE");
		
	}

	public void carregarTela() {
		Boolean save = (Boolean) getSessionMap().remove("savePerfilFuncionalidade");
		if (save != null && save) {
			FacesMessagesUtil.addInfoMessage(" ", this.getSaveMessage() + " " + ConstantesARQ.COM_SUCESSO + "<br/>"
					+ "O efeito das alterações do perfil só serão visualizados após o usuário efetuar logoff caso esteja logado");
		}
		carregarListas();
	}

	@PostConstruct
	public void carregarListas() {
		perfis = ComboUtil.getItens(universalManager.getAll(Perfil.class));
		SelectItem itemRemover = null;
		for (SelectItem item : perfis) {
			if (item.getLabel().equalsIgnoreCase(Constantes.PERFIL_SISFIE)) {
				itemRemover = item;
			}
		}
		if (itemRemover != null) {
			perfis.remove(itemRemover);
		}
		Collections.sort(perfis, new Comparator<SelectItem>() {
			@Override
			public int compare(SelectItem o1, SelectItem o2) {
				return o1.getLabel().compareTo(o2.getLabel());
			}
		});
	}

	public void selecionarTodos() {
		if (rootColum1 != null && rootColum1.getChildren() != null) {
			// Node1 dos pais
			for (TreeNode node1 : rootColum1.getChildren()) {
				node1.setSelected(selecionarTodos);
				for (TreeNode node1Filho : node1.getChildren()) {
					node1Filho.setSelected(selecionarTodos);
				}
			}

		}
		if (rootColum2 != null && rootColum2.getChildren() != null) {
			// Node1 dos pais
			for (TreeNode node1 : rootColum2.getChildren()) {
				node1.setSelected(selecionarTodos);
				for (TreeNode node1Filho : node1.getChildren()) {
					node1Filho.setSelected(selecionarTodos);
				}
			}

		}
		if (rootColum3 != null && rootColum3.getChildren() != null) {
			// Node1 dos pais
			for (TreeNode node1 : rootColum3.getChildren()) {
				node1.setSelected(selecionarTodos);
				for (TreeNode node1Filho : node1.getChildren()) {
					node1Filho.setSelected(selecionarTodos);
				}
			}

		}
	}

	/**
	 * Para usar varias colunas irei dividir os node em 3 roots
	 */
	public void carregarNode(Integer idPerfil) {
		try {

			rootColum1 = new DefaultTreeNode("RootColum1", null);
			rootColum2 = new DefaultTreeNode("RootColum2", null);
			rootColum3 = new DefaultTreeNode("RootColum3", null);

			int cont = 1;

			List<Funcionalidade> pais = acessoService.carregarPais();
			Collections.sort(pais, new Comparator<Funcionalidade>() {
				@Override
				public int compare(Funcionalidade o1, Funcionalidade o2) {
					return o1.getNome().trim().compareToIgnoreCase(o2.getNome().trim());
				}
			});
			for (Funcionalidade func : pais) {
				List<Funcionalidade> listaFilho = acessoService.carregarFilhos(func.getId());
				Collections.sort(listaFilho, new Comparator<Funcionalidade>() {
					@Override
					public int compare(Funcionalidade o1, Funcionalidade o2) {
						return o1.getNome().trim().compareToIgnoreCase(o2.getNome().trim());
					}
				});
				func.setFilhos(listaFilho);
				TreeNode nodePai = null;
				if (cont == 1) {
					nodePai = new CustomTreeNode(func.getNome(), rootColum1, func.getId());
					cont++;
				} else if (cont == 2) {
					nodePai = new CustomTreeNode(func.getNome(), rootColum2, func.getId());
					cont++;
				} else if (cont == 3) {
					nodePai = new CustomTreeNode(func.getNome(), rootColum3, func.getId());
					cont = 1;
				}
				// Copia as funcionalidade
				if (idPerfilSelecionado != null && func != null && acessoService.existeFuncionalidade(idPerfil, func)) {
					nodePai.setSelected(true);
				}
				nodePai.setExpanded(true);
				func.setNode(nodePai);

				TreeNode nodefilho = null;
				for (Funcionalidade filho : func.getFilhos()) {
					nodefilho = new CustomTreeNode(filho.getNome(), func.getNode(), filho.getId());

					// Copia as funcionalidade
					if (idPerfilSelecionado != null && filho != null && acessoService.existeFuncionalidade(idPerfil, filho)) {
						nodefilho.setSelected(true);
					}
					filho.setNode(nodefilho);
				}
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void selecionarPerfilPai(AjaxBehaviorEvent evt) {
		try {
			if (idPerfilHerdado != null && !idPerfilHerdado.equals(0)) {
				carregarNode(idPerfilHerdado);
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void selecionarPerfil(AjaxBehaviorEvent evt) {
		try {
			limparSelecionados();
			idPerfilHerdado = null;
			if (idPerfilSelecionado != null && !idPerfilSelecionado.equals(0)) {
				carregarNode(idPerfilSelecionado);
			}

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void limparSelecionados() {
		selecionadoColum1 = null;
		selecionadoColum2 = null;
		selecionadoColum3 = null;
		selecionados = new ArrayList<TreeNode>();
	}

	@Override
	public String save() {
		try {
			List<PerfilFuncionalidade> listaSalvarAux = new ArrayList<PerfilFuncionalidade>();

			Perfil perfil = (Perfil) universalManager.get(Perfil.class, idPerfilSelecionado);

			for (TreeNode node : getSelecionados()) {
				PerfilFuncionalidade pf = new PerfilFuncionalidade();
				CustomTreeNode custom = (CustomTreeNode) node;
				pf.setPerfil(perfil);
				pf.setFuncionalidade((Funcionalidade) universalManager.get(Funcionalidade.class, custom.getIdObject()));

				// salva o pai como true
				if (pf.getFuncionalidade().getPai() != null && pf.getFuncionalidade().getPai().getId() != null) {
					PerfilFuncionalidade pai = new PerfilFuncionalidade();
					pai.setPerfil(perfil);
					pai.setFuncionalidade((Funcionalidade) universalManager.get(Funcionalidade.class, pf.getFuncionalidade().getPai()
							.getId()));

					// verifica se já nao existe na lista
					boolean controle = false;
					for (PerfilFuncionalidade pfComp : listaSalvarAux) {
						if (pfComp.getFuncionalidade().getId().equals(pai.getFuncionalidade().getId())) {
							controle = true;
							break;
						}
					}
					if (!controle) {
						listaSalvarAux.add(pai);
					}
				}

				listaSalvarAux.add(pf);
			}

			PerfilFuncionalidade pf = new PerfilFuncionalidade();
			pf.setPerfil(new Perfil(idPerfilSelecionado));

			List<PerfilFuncionalidade> todosBD = universalManager.listBy(pf);

			List<PerfilFuncionalidade> listaExcluir = preparaListaExcluir(todosBD, listaSalvarAux);
			List<PerfilFuncionalidade> listaSalvar = preparaListaSalvar(listaSalvarAux);

			acessoService.salvarPerfilFuncionalidade(listaSalvar, listaExcluir);
			getSessionMap().put("savePerfilFuncionalidade", true);

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return redirect("perfilFuncionalidade.jsf");
	}

	/**
	 * Metodo retira os registros que não precisam ser excluido. <br/>
	 * ListaExcluir= TodosBD - registroSalvar<br/>
	 * Recupera todos os registros do banco daquele perfil e retira os registros
	 * que seão salvo.
	 * 
	 * @param todos
	 * @param salvar
	 * @return
	 */
	private List<PerfilFuncionalidade> preparaListaExcluir(List<PerfilFuncionalidade> todos, List<PerfilFuncionalidade> salvar) {
		List<PerfilFuncionalidade> result = new ArrayList<PerfilFuncionalidade>();

		boolean controle = false;
		for (PerfilFuncionalidade td : todos) {
			for (PerfilFuncionalidade save : salvar) {
				if (td.getFuncionalidade().getId().equals(save.getFuncionalidade().getId())
						&& td.getPerfil().getId().equals(save.getPerfil().getId())) {

					controle = true;
					break;
				}
			}
			if (!controle) {
				result.add(td);
			}
			controle = false;

		}
		return result;
	}

	/**
	 * Metodo retira os registros que estão salvos. <br/>
	 * Faz um Count e verifica se está no banco, senão tiver adiciona na lista
	 * que será salvo.
	 * 
	 * @param salvar
	 * @return
	 */
	private List<PerfilFuncionalidade> preparaListaSalvar(List<PerfilFuncionalidade> salvar) {
		List<PerfilFuncionalidade> result = new ArrayList<PerfilFuncionalidade>();

		for (PerfilFuncionalidade list : salvar) {
			PerfilFuncionalidade pf = new PerfilFuncionalidade();
			pf.setFuncionalidade(new Funcionalidade(list.getFuncionalidade().getId()));
			pf.setPerfil(new Perfil(list.getPerfil().getId()));
			if (acessoService.countPerfilFuncionalidade(pf) == 0) {
				result.add(list);
			}
		}
		return result;
	}

	@Override
	public PerfilFuncionalidade createModel() {
		return new PerfilFuncionalidade();
	}

	@Override
	public String getQualifiedName() {
		return "";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public void setPerfis(List<SelectItem> perfis) {
		this.perfis = perfis;
	}

	public Integer getIdPerfilSelecionado() {
		return idPerfilSelecionado;
	}

	public void setIdPerfilSelecionado(Integer idPerfilSelecionado) {
		this.idPerfilSelecionado = idPerfilSelecionado;
	}

	public Integer getIdPerfilHerdado() {
		return idPerfilHerdado;
	}

	public void setIdPerfilHerdado(Integer idPerfilHerdado) {
		this.idPerfilHerdado = idPerfilHerdado;
	}

	public TreeNode getRootColum1() {
		return rootColum1;
	}

	public void setRootColum1(TreeNode rootColum1) {
		this.rootColum1 = rootColum1;
	}

	public TreeNode getRootColum2() {
		return rootColum2;
	}

	public void setRootColum2(TreeNode rootColum2) {
		this.rootColum2 = rootColum2;
	}

	public TreeNode getRootColum3() {
		return rootColum3;
	}

	public void setRootColum3(TreeNode rootColum3) {
		this.rootColum3 = rootColum3;
	}

	public TreeNode[] getSelecionadoColum1() {
		return selecionadoColum1;
	}

	public void setSelecionadoColum1(TreeNode[] selecionadoColum1) {
		this.selecionadoColum1 = selecionadoColum1;
	}

	public TreeNode[] getSelecionadoColum2() {
		return selecionadoColum2;
	}

	public void setSelecionadoColum2(TreeNode[] selecionadoColum2) {
		this.selecionadoColum2 = selecionadoColum2;
	}

	public TreeNode[] getSelecionadoColum3() {
		return selecionadoColum3;
	}

	public void setSelecionadoColum3(TreeNode[] selecionadoColum3) {
		this.selecionadoColum3 = selecionadoColum3;
	}

	public void setSelecionados(List<TreeNode> selecionados) {
		this.selecionados = selecionados;
	}

	public List<TreeNode> getSelecionados() {
		selecionados = new ArrayList<TreeNode>();
		if (selecionadoColum1 != null && selecionadoColum1.length > 0) {
			for (TreeNode node : selecionadoColum1) {
				CustomTreeNode custom = (CustomTreeNode) node;
				// Não está funcionando o Contains.
				// Irei implementar na mão
				boolean existe = false;
				for (TreeNode node2 : selecionados) {
					CustomTreeNode customList = (CustomTreeNode) node2;
					Integer idList = (Integer) customList.getIdObject();
					Integer idNode = (Integer) custom.getIdObject();
					if (idList.equals(idNode)) {
						existe = true;
						break;
					}
				}
				if (!existe) {
					selecionados.add(node);
				}
			}
		}
		if (selecionadoColum2 != null && selecionadoColum2.length > 0) {
			for (TreeNode node : selecionadoColum2) {
				CustomTreeNode custom = (CustomTreeNode) node;
				// Não está funcionando o Contains.
				// Irei implementar na mão
				boolean existe = false;
				for (TreeNode node2 : selecionados) {
					CustomTreeNode customList = (CustomTreeNode) node2;
					Integer idList = (Integer) customList.getIdObject();
					Integer idNode = (Integer) custom.getIdObject();
					if (idList.equals(idNode)) {
						existe = true;
						break;
					}
				}
				if (!existe) {
					selecionados.add(node);
				}
			}
		}
		if (selecionadoColum3 != null && selecionadoColum3.length > 0) {
			for (TreeNode node : selecionadoColum3) {
				CustomTreeNode custom = (CustomTreeNode) node;
				// Não está funcionando o Contains.
				// Irei implementar na mão
				boolean existe = false;
				for (TreeNode node2 : selecionados) {
					CustomTreeNode customList = (CustomTreeNode) node2;
					Integer idList = (Integer) customList.getIdObject();
					Integer idNode = (Integer) custom.getIdObject();
					if (idList.equals(idNode)) {
						existe = true;
						break;
					}
				}
				if (!existe) {
					selecionados.add(node);
				}
			}
		}
		return selecionados;
	}

	public boolean isSelecionarTodos() {
		return selecionarTodos;
	}

	public void setSelecionarTodos(boolean selecionarTodos) {
		this.selecionarTodos = selecionarTodos;
	}

	public AcessoService getAcessoService() {
		return acessoService;
	}

	public void setAcessoService(AcessoService acessoService) {
		this.acessoService = acessoService;
	}

	public List<SelectItem> getPerfis() {
		return perfis;
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

}
