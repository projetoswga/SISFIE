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

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.GradePacote;
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.Pacote;
import br.com.sisfie.entidade.PacoteOficina;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.service.GradePacoteService;
import br.com.sisfie.service.HorarioService;
import br.com.sisfie.service.PacoteService;

@ManagedBean(name = "gradePacotesBean")
@ViewScoped
public class GradePacotesBean extends PaginableBean<GradePacote> {

	private static final long serialVersionUID = -2323958366549635156L;

	@ManagedProperty(value = "#{pacoteService}")
	protected PacoteService pacoteService;

	@ManagedProperty(value = "#{horarioService}")
	protected HorarioService horarioService;

	@ManagedProperty(value = "#{gradePacoteService}")
	protected GradePacoteService gradePacoteService;

	private Integer idPacote;
	private List<Pacote> pacotes;
	private List<PacoteOficina> pacoteOficinas;
	private List<Horario> horarios;
	private List<Turma> turmas;
	private List<GradePacote> gradePacotes;
	private Integer idTurma;
	private Integer idHorario;

	public GradePacotesBean() {
		pacotes = new ArrayList<Pacote>();
		pacoteOficinas = new ArrayList<PacoteOficina>();
		horarios = new ArrayList<Horario>();
		turmas = new ArrayList<Turma>();
		gradePacotes = new ArrayList<GradePacote>();
	}

	@SuppressWarnings("unchecked")
	@PostConstruct
	public void carregarTela() {
		verificarAcesso();
		if (pacotes.isEmpty()) {
			try {
				pacotes = universalManager.getAll(Pacote.class);
				Collections.sort(pacotes, new Comparator<Pacote>() {
					@Override
					public int compare(Pacote o1, Pacote o2) {
						return o1.getNomPacote().trim().compareTo(o2.getNomPacote());
					}
				});
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
	}

	public void carregarOficinas(AjaxBehaviorEvent evt) {
		if (idPacote == null || idPacote.equals(0)) {
			gradePacotes = new ArrayList<GradePacote>();
			return;
		}
		pacoteOficinas = pacoteService.recuperarPacoteOficinaPorPacote(idPacote);
		if (pacoteOficinas != null && !pacoteOficinas.isEmpty()) {
			// Pelo fato de todos os registros serem do mesmo curso.
			// É selecionado qualquer um para obter o id do curso e carregar a combo de horario.
			carregarCombos(pacoteOficinas.get(0).getPacote().getCurso().getId());
		} else {
			return;
		}

		gradePacotes = gradePacoteService.listarGradePacotes(idPacote);
		if (gradePacotes == null || gradePacotes.isEmpty()) {
			// Caso a grade estaja vazia
			if (pacoteOficinas != null && !pacoteOficinas.isEmpty()) {
				for (PacoteOficina pacoteOficina : pacoteOficinas) {
					GradePacote gradePacote = new GradePacote();
					gradePacote.setHorario(new Horario());
					gradePacote.setTurma(new Turma());
					gradePacote.setPacoteOficina(pacoteOficina);
					gradePacotes.add(gradePacote);
				}
			}
		} else {
			// Verficando os já persistidos
			for (GradePacote gradePacote : gradePacotes) {
				if (pacoteOficinas.contains(gradePacote.getPacoteOficina())) {
					pacoteOficinas.remove(gradePacote.getPacoteOficina());
					continue;
				}
			}
			// adicionando os não persistidos
			for (PacoteOficina pacoteOficina : pacoteOficinas) {
				GradePacote gradePacote = new GradePacote();
				gradePacote.setHorario(new Horario());
				gradePacote.setTurma(new Turma());
				gradePacote.setPacoteOficina(pacoteOficina);
				gradePacotes.add(gradePacote);
			}
		}
	}

	@SuppressWarnings("unchecked")
	public void carregarCombos(Integer idCurso) {
		if (idCurso != null && !idCurso.equals(0)) {
			try {
				horarios = horarioService.listarHorarios(idCurso);
				Collections.sort(horarios, new Comparator<Horario>() {
					@Override
					public int compare(Horario o1, Horario o2) {
						return o1.getDesHorario().trim().compareTo(o2.getDesHorario());
					}
				});
			
				Turma turma = new Turma();
				turma.setCurso(new Curso(idCurso));
				turmas = universalManager.listBy(turma);
				Collections.sort(turmas, new Comparator<Turma>() {
					@Override
					public int compare(Turma o1, Turma o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
	}

	public void editarExcluirOficinas() {
		if (idHorario != null && !idHorario.equals(0) && idTurma != null && !idTurma.equals(0)) {
			getModel().setHorario(new Horario(idHorario));
			getModel().setTurma(new Turma(idTurma));
			Integer countGradePacote = gradePacoteService.countGradePacote(getModel()).intValue();
			limparIdsCombos();
			if (countGradePacote > 0 && (getModel().getId() == null || getModel().getId().equals(0))) {
				FacesMessagesUtil.addErrorMessage("Conflito de registros!",
						"já existe uma oficina no pacote para o horário e turma selecionados!");
				return;
			}
			alterarOficinaGradePacote();
		} else {
			FacesMessagesUtil.addErrorMessage("Seleção Inválida!", "É necessário selecionar um horário e uma turma!");
		}
	}

	private void limparIdsCombos() {
		idHorario = null;
		idTurma = null;
	}

	private void alterarOficinaGradePacote() {
		try {
			gradePacoteService.alterarOficinaGradePacote(getModel());
			FacesMessagesUtil.addInfoMessage("Oficina!", "salva com sucesso na grade de pacotes!");
			setModel(createModel());
			carregarOficinas(null);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void removerOficinaGradePacote() {
		try {
			gradePacoteService.removerOficinaGradePacote(getModel());
			FacesMessagesUtil.addInfoMessage("Oficina!", "Removida com sucesso da grade de pacotes!");
			setModel(createModel());
			carregarOficinas(null);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {

	}

	@Override
	public GradePacote createModel() {
		return new GradePacote();
	}

	@Override
	public String getQualifiedName() {
		return "Grade de Pacotes";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}

	public Integer getIdPacote() {
		return idPacote;
	}

	public void setIdPacote(Integer idPacote) {
		this.idPacote = idPacote;
	}

	public List<Pacote> getPacotes() {
		return pacotes;
	}

	public void setPacotes(List<Pacote> pacotes) {
		this.pacotes = pacotes;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public PacoteService getPacoteService() {
		return pacoteService;
	}

	public void setPacoteService(PacoteService pacoteService) {
		this.pacoteService = pacoteService;
	}

	public List<PacoteOficina> getPacoteOficinas() {
		return pacoteOficinas;
	}

	public void setPacoteOficinas(List<PacoteOficina> pacoteOficinas) {
		this.pacoteOficinas = pacoteOficinas;
	}

	public List<Horario> getHorarios() {
		return horarios;
	}

	public void setHorarios(List<Horario> horarios) {
		this.horarios = horarios;
	}

	public List<Turma> getTurmas() {
		return turmas;
	}

	public void setTurmas(List<Turma> turmas) {
		this.turmas = turmas;
	}

	public List<GradePacote> getGradePacotes() {
		return gradePacotes;
	}

	public void setGradePacotes(List<GradePacote> gradePacotes) {
		this.gradePacotes = gradePacotes;
	}

	public HorarioService getHorarioService() {
		return horarioService;
	}

	public void setHorarioService(HorarioService horarioService) {
		this.horarioService = horarioService;
	}

	public GradePacoteService getGradePacoteService() {
		return gradePacoteService;
	}

	public void setGradePacoteService(GradePacoteService gradePacoteService) {
		this.gradePacoteService = gradePacoteService;
	}

	public Integer getIdTurma() {
		return idTurma;
	}

	public void setIdTurma(Integer idTurma) {
		this.idTurma = idTurma;
	}

	public Integer getIdHorario() {
		return idHorario;
	}

	public void setIdHorario(Integer idHorario) {
		this.idHorario = idHorario;
	}
}
