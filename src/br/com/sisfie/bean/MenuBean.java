package br.com.sisfie.bean;

import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import org.primefaces.component.menuitem.MenuItem;
import org.primefaces.component.submenu.Submenu;
import org.primefaces.model.DefaultMenuModel;
import org.primefaces.model.MenuModel;

import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "menuBean")
@ViewScoped
public class MenuBean {

	private MenuModel menu;

	@ManagedProperty(value = "#{acessoBean}")
	private AcessoBean acessoBean;

	public MenuBean() {
	}

	@PostConstruct
	public void carregarMenu() {
		menu = new DefaultMenuModel();

		/**
		 * CURSO
		 */
		Submenu Curso = new Submenu();
		Curso.setLabel("Curso");

		MenuItem item = new MenuItem();
		if (acessoBean.verificarAcesso("ROLE_CURSO_CADASTRO")) {
			item.setId("CadastrarCurso");
			item.setValue("Cadastrar");
			item.setUrl("/pages/cadastrarCurso.jsf");
			Curso.getChildren().add(item);

		}
		if (acessoBean.verificarAcesso("ROLE_CURSO_PESQUISAR")) {
			item = new MenuItem();
			item.setId("PesquisarCursoId");
			item.setValue("Pesquisar");
			item.setUrl("/pages/pesquisarCurso.jsf");
			Curso.getChildren().add(item);
		}

		if (acessoBean.verificarAcesso("ROLE_CURSO_GERENCIAR")) {
			item = new MenuItem();
			item.setId("GerenciarCurso");
			item.setValue("Gerenciar");
			item.setUrl("/pages/gerenciarCurso.jsf");
			Curso.getChildren().add(item);
		}

		item = new MenuItem();
		item.setId("MontarGrades");
		item.setValue("Montar Grades");
		item.setUrl("/pages/gerenciarCursoComOficina.jsf");
		Curso.getChildren().add(item);

		if (acessoBean.verificarAcesso("ROLE_COMUNICADO_MALA_DIRETA")) {
			item = new MenuItem();
			item.setId("Comunicado");
			item.setValue("Comunicado - Mala Direta");
			item.setUrl("/pages/comunicado.jsf");
			Curso.getChildren().add(item);
		}

		menu.addSubmenu(Curso);

		/**
		 * CANDIDATO
		 */
		Submenu candidato = new Submenu();
		candidato.setLabel("Candidato");

		item = new MenuItem();
		item.setValue("Pesquisar Candidato");
		item.setUrl("/pages/pesquisarCandidato.jsf");
		candidato.getChildren().add(item);

		item = new MenuItem();
		item.setValue("Excluir Candidato");
		item.setUrl("/pages/excluirCandidato.jsf");
		candidato.getChildren().add(item);

		item = new MenuItem();
		item.setValue("Pesquisar Inscrição");
		item.setUrl("/pages/pesquisarInscricaoCandidato.jsf");
		candidato.getChildren().add(item);

		item = new MenuItem();
		item.setValue("Pesquisar Parceiros");
		item.setUrl("/pages/pesquisarParceiros.jsf");
		candidato.getChildren().add(item);

		menu.addSubmenu(candidato);

		/**
		 * APOIO
		 */
		Submenu Apoio = new Submenu();
		Apoio.setLabel("Apoio");

		if (acessoBean.verificarAcesso("ROLE_AREA")) {
			item = new MenuItem();
			item.setValue("Área de Interesse");
			item.setUrl("/pages/area.jsf");
			Apoio.getChildren().add(item);
		}
		item = new MenuItem();
		item.setValue("Área de Conhecimento");
		item.setUrl("/pages/areaConhecimento.jsf");
		Apoio.getChildren().add(item);
		if (acessoBean.verificarAcesso("ROLE_ATUACAO")) {
			item = new MenuItem();
			item.setValue("Atuação");
			item.setUrl("/pages/atuacao.jsf");
			Apoio.getChildren().add(item);
		}

		if (acessoBean.verificarAcesso("ROLE_CARGO")) {
			item = new MenuItem();
			item.setValue("Cargo");
			item.setUrl("/pages/cargo.jsf");
			Apoio.getChildren().add(item);

		}

		if (acessoBean.verificarAcesso("ROLE_LOCALIZACAO")) {
			item = new MenuItem();
			item.setValue("Localização");
			item.setUrl("/pages/localizacao.jsf");
			Apoio.getChildren().add(item);
		}
		if (acessoBean.verificarAcesso("ROLE_ORGAO")) {
			item = new MenuItem();
			item.setValue("Õrgão");
			item.setUrl("/pages/orgao.jsf");
			Apoio.getChildren().add(item);
		}
		if (acessoBean.verificarAcesso("ROLE_TURMA")) {
			item = new MenuItem();
			item.setValue("Turma");
			item.setUrl("/pages/turma.jsf");
			Apoio.getChildren().add(item);
		}

		menu.addSubmenu(Apoio);

		/**
		 * RELATÓRIOS
		 */
		Submenu relatorios = new Submenu();
		relatorios.setLabel("Relatórios");

		item = new MenuItem();
		item.setValue("Candidatos inscritos");
		item.setUrl("/pages/gerarRelatorioCandicadosInscritos.jsf");
		relatorios.getChildren().add(item);

		item = new MenuItem();
		item.setValue("Exportar Inscritos");
		item.setUrl("/pages/exportarCandidatosInscritos.jsf");
		relatorios.getChildren().add(item);

		menu.addSubmenu(relatorios);

		/**
		 * FREQUÊNCIA
		 */
		Submenu frequencia = new Submenu();
		frequencia.setLabel("Frequência");

		item = new MenuItem();
		item.setValue("Registrar");
		item.setUrl("/pages/registrarFrequencia.jsf");
		frequencia.getChildren().add(item);

		item = new MenuItem();
		item.setValue("Credenciamento");
		item.setUrl("/pages/credenciamento.jsf");
		frequencia.getChildren().add(item);

		/**
		 * RELATÓRIOS FREQUÊNCIA
		 */
		Submenu relatoriosFrequencia = new Submenu();
		relatoriosFrequencia.setLabel("Relatórios");

		item = new MenuItem();
		item.setValue("Credenciamento");
		item.setUrl("/pages/relatorioCredenciamento.jsf");
		relatoriosFrequencia.getChildren().add(item);
		
		item = new MenuItem();
		item.setValue("Etiquetas");
		item.setUrl("/pages/relatorioEtiqueta.jsf");
		relatoriosFrequencia.getChildren().add(item);

		frequencia.getChildren().add(relatoriosFrequencia);
		
		menu.addSubmenu(frequencia);

		/**
		 * ACESSO
		 */
		Submenu acesso = new Submenu();
		acesso.setLabel("Acesso");

		if (acessoBean.verificarAcesso("ROLE_PERFIL")) {
			item = new MenuItem();
			item.setValue("Perfil");
			item.setUrl("/pages/perfil.jsf");
			acesso.getChildren().add(item);
		}

		if (acessoBean.verificarAcesso("ROLE_USUARIO")) {

			item = new MenuItem();
			item.setValue("Usuário");
			item.setUrl("/pages/usuario.jsf");
			acesso.getChildren().add(item);

			item = new MenuItem();
			item.setValue("Setor Responsável ESAF");
			item.setUrl("/pages/setorResponsavel.jsf");
			acesso.getChildren().add(item);
		}
		if (acessoBean.verificarAcesso("ROLE_PERFIL_FUNCIONALIDADE")) {
			item = new MenuItem();
			item = new MenuItem();
			item.setValue("Perfil Funcionalidade");
			item.setUrl("/pages/perfilFuncionalidade.jsf");
			acesso.getChildren().add(item);
		}

		menu.addSubmenu(acesso);

		/**
		 * BD
		 */
		try {
			Usuario user = (Usuario) getSessionMap().get(Constantes.USUARIO_SESSAO);
			if (user.getPerfil().getDescricao().equals(Constantes.PERFIL_SISFIE)) {

				Submenu BD = new Submenu();
				BD.setLabel("BD");

				item = new MenuItem();
				item.setValue("Sequence");
				item.setUrl("/pages/sequence.jsf");
				BD.getChildren().add(item);

				item = new MenuItem();
				item.setValue("Atualizar Último Status");
				item.setUrl("/pages/atualizarUltimoStatusInscricao.jsf");
				BD.getChildren().add(item);

				menu.addSubmenu(BD);
			}
		} catch (Exception e) {
			// nao trata a exceÃ§Ã£o do menu BD Menu interno do sisfie.
		}
	}

	@SuppressWarnings("rawtypes")
	protected Map getSessionMap() {
		if (FacesContext.getCurrentInstance() != null
				&& FacesContext.getCurrentInstance().getExternalContext().getSessionMap() != null) {
			return FacesContext.getCurrentInstance().getExternalContext().getSessionMap();
		} else {
			return null;
		}
	}

	public MenuModel getMenu() {
		return menu;
	}

	public void setMenu(MenuModel menu) {
		this.menu = menu;
	}

	public AcessoBean getAcessoBean() {
		return acessoBean;
	}

	public void setAcessoBean(AcessoBean acessoBean) {
		this.acessoBean = acessoBean;
	}
}
