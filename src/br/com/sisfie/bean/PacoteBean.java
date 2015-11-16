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

import org.springframework.dao.DataIntegrityViolationException;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Pacote;
import br.com.sisfie.entidade.PacoteOficina;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.OficinaService;
import br.com.sisfie.service.PacoteService;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "pacoteBean")
@ViewScoped
public class PacoteBean extends PaginableBean<Pacote> {

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{oficinaService}")
	protected OficinaService oficinaService;

	@ManagedProperty(value = "#{pacoteService}")
	protected PacoteService pacoteService;

	private static final long serialVersionUID = -8311779582651536943L;
	private List<Curso> cursos;
	private Integer idCurso;
	private List<Oficina> oficinas;
	private List<PacoteOficina> pacoteOficinas;
	private List<Oficina> listaOficinasSelecionadas;
	private Oficina oficinaExclusao;
	private List<PacoteOficina> listaPacoteOficinasExclusao;
	private Oficina oficinaSelecionada;

	public PacoteBean() {
		cursos = new ArrayList<Curso>();
		oficinas = new ArrayList<Oficina>();
		listaOficinasSelecionadas = new ArrayList<Oficina>();
		pacoteOficinas = new ArrayList<PacoteOficina>();
		oficinaExclusao = new Oficina();
		listaPacoteOficinasExclusao = new ArrayList<PacoteOficina>();
		oficinaSelecionada = new Oficina();
	}

	@PostConstruct
	public void carregarTela() {
		verificarAcesso();
		if (cursos.isEmpty()) {
			try {
				Usuario user = (Usuario) getSessionMap().get(Constantes.USUARIO_SESSAO);
				cursos = cursoService.recuperarCursosComOficina(user);
				Collections.sort(cursos, new Comparator<Curso>() {
					@Override
					public int compare(Curso o1, Curso o2) {
						return o1.getTitulo().trim().compareTo(o2.getTitulo());
					}
				});
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
	}

	@Override
	public String save() {
		try {
			if (listaOficinasSelecionadas == null || listaOficinasSelecionadas.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Oficinas não selecionadas", "Selecione pelo menos uma oficina!");
				return "";
			}

			// Removendo da listaOficinasSelecionas as oficinas já persistidas
			List<PacoteOficina> pacotesOficinas = pacoteService.recuperarPacoteOficina(idCurso);
			for (PacoteOficina pacoteOficina : pacotesOficinas) {
				if (listaOficinasSelecionadas.contains(pacoteOficina.getOficina())) {
					listaOficinasSelecionadas.remove(pacoteOficina.getOficina());
				}
			}

			getModel().setCurso(new Curso(idCurso));
			for (Oficina oficina : listaOficinasSelecionadas) {
				PacoteOficina pacoteOficina = new PacoteOficina();
				pacoteOficina.setPacote(getModel());
				pacoteOficina.setOficina(oficina);
				pacoteOficinas.add(pacoteOficina);
			}
			pacoteService.save(pacoteOficinas, listaPacoteOficinasExclusao, getModel());
			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), this.getSaveMessage() + " " + ConstantesARQ.COM_SUCESSO);
			/*
			 * Caso o usuario tente remover alguma oficina com o pacote em uso na grade de pacotes ou pela seleção de pacotes. Somente no
			 * caso de edição.
			 */
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage("Violação de integridade na base de dados!",
					"Não foi possível remover uma ou mais oficina(s) do pacote devido o mesmo já está sendo utilizado!");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		} finally {
			limparCampos();
		}
		return "";
	}

	private void limparCampos() {
		setModel(createModel());
		idCurso = 0;
		pacoteOficinas = new ArrayList<PacoteOficina>();
		listaOficinasSelecionadas = new ArrayList<Oficina>();
		oficinas = new ArrayList<Oficina>();
		listaPacoteOficinasExclusao = new ArrayList<PacoteOficina>();
	}

	public void adicionarOficina() {
		Integer totalCargaHoraria = 0;
		for (Oficina oficina : listaOficinasSelecionadas) {
			totalCargaHoraria += oficina.getNumCargaHoraria();
		}
		if (oficinaSelecionada != null && oficinaSelecionada.getId() != null && !oficinaSelecionada.getId().equals(0)) {
			Integer totalComNovoRegistro = totalCargaHoraria + oficinaSelecionada.getNumCargaHoraria();
			if (totalComNovoRegistro > 36) {
				if ((36 - totalCargaHoraria) <= 0) {
					FacesMessagesUtil.addInfoMessage("Total de carga horária excedida.", "Não é possível adicinar mais oficinas.");
				} else {
					FacesMessagesUtil.addInfoMessage("Total de carga horária excedida.", "Selecione Oficina com no máximo "
							+ (36 - totalCargaHoraria) + ":00h.");
				}
				return;
			} else {
				listaOficinasSelecionadas.add(oficinaSelecionada);
			}
		} else {
			FacesMessagesUtil.addErrorMessage("Erro!", "Nenhuma oficina selecionada!");
			return;
		}
		// Removendo da lista de exclusão a oficina quando o usuário seleciona a mesma oficina sem antes persistir
		List<PacoteOficina> listaPacoteOficinaAux = new ArrayList<PacoteOficina>();
		listaPacoteOficinaAux.addAll(listaPacoteOficinasExclusao);
		for (PacoteOficina pacoteOficina : listaPacoteOficinaAux) {
			if (pacoteOficina.getOficina().getId().equals(oficinaSelecionada.getId())) {
				listaPacoteOficinasExclusao.remove(pacoteOficina);
			}
		}
		oficinaSelecionada = new Oficina();
	}

	public List<Oficina> completeOficina(String query) {
		List<Oficina> sugestoes = new ArrayList<Oficina>();
		try {
			sugestoes = oficinaService.pesquisarOficina(query, idCurso);
			if (sugestoes != null && !sugestoes.isEmpty()) {
				if (listaOficinasSelecionadas != null && !listaOficinasSelecionadas.isEmpty()) {
					sugestoes.removeAll(listaOficinasSelecionadas);
				}
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;
	}

	public void excluirOficina() {
		if (oficinaExclusao != null && oficinaExclusao.getId() != null) {
			PacoteOficina pacoteOficina = new PacoteOficina();
			try {
				pacoteOficina = pacoteService.recuperarPacoteOficina(oficinaExclusao.getId(), idCurso);
				if (pacoteOficina != null) {
					listaPacoteOficinasExclusao.add(pacoteOficina);
				}
				listaOficinasSelecionadas.remove(oficinaExclusao);
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
	}

	@Override
	public String load() {
		idCurso = getModel().getCurso().getId();
		try {
			listaOficinasSelecionadas = oficinaService.recuperarOficina(idCurso, getModel().getId());
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return super.load();
	}

	@Override
	public String delete() {
		try {
			List<PacoteOficina> listaPacoteOficinas = pacoteService.recuperarPacoteOficina(getModel());
			pacoteService.delete(listaPacoteOficinas, getModel());
			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), this.getRemoveMessage() + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(),
					"Não é possível remover o pacote, ele está sendo usado pela grade de pacote ou pela seleção de pacotes");
		} catch (Exception e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_EXCLUIR);
		}
		return "";
	}

	public void carregarOficinas(AjaxBehaviorEvent evt) {
		listaOficinasSelecionadas = new ArrayList<Oficina>();
		setModel(createModel());
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {

	}

	@Override
	public Pacote createModel() {
		return new Pacote();
	}

	@Override
	public String getQualifiedName() {
		return "Pacote";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public List<Curso> getCursos() {
		return cursos;
	}

	public void setCursos(List<Curso> cursos) {
		this.cursos = cursos;
	}

	public Integer getIdCurso() {
		return idCurso;
	}

	public void setIdCurso(Integer idCurso) {
		this.idCurso = idCurso;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public OficinaService getOficinaService() {
		return oficinaService;
	}

	public void setOficinaService(OficinaService oficinaService) {
		this.oficinaService = oficinaService;
	}

	public List<Oficina> getOficinas() {
		return oficinas;
	}

	public void setOficinas(List<Oficina> oficinas) {
		this.oficinas = oficinas;
	}

	public List<PacoteOficina> getPacoteOficinas() {
		return pacoteOficinas;
	}

	public void setPacoteOficinas(List<PacoteOficina> pacoteOficinas) {
		this.pacoteOficinas = pacoteOficinas;
	}

	public PacoteService getPacoteService() {
		return pacoteService;
	}

	public void setPacoteService(PacoteService pacoteService) {
		this.pacoteService = pacoteService;
	}

	public List<Oficina> getListaOficinasSelecionadas() {
		return listaOficinasSelecionadas;
	}

	public void setListaOficinasSelecionadas(List<Oficina> listaOficinasSelecionadas) {
		this.listaOficinasSelecionadas = listaOficinasSelecionadas;
	}

	public Oficina getOficinaExclusao() {
		return oficinaExclusao;
	}

	public void setOficinaExclusao(Oficina oficinaExclusao) {
		this.oficinaExclusao = oficinaExclusao;
	}

	public List<PacoteOficina> getListaPacoteOficinasExclusao() {
		return listaPacoteOficinasExclusao;
	}

	public void setListaPacoteOficinasExclusao(List<PacoteOficina> listaPacoteOficinasExclusao) {
		this.listaPacoteOficinasExclusao = listaPacoteOficinasExclusao;
	}

	public Oficina getOficinaSelecionada() {
		return oficinaSelecionada;
	}

	public void setOficinaSelecionada(Oficina oficinaSelecionada) {
		this.oficinaSelecionada = oficinaSelecionada;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}
}
