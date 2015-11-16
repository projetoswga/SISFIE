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
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Sala;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.service.GradeOficinaService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.OficinaService;
import br.com.sisfie.service.SalaService;

@ManagedBean(name = "gradeOficinasBean")
@ViewScoped
public class GradeOficinasBean extends PaginableBean<GradeOficina> {

	private static final long serialVersionUID = -4304175175904043587L;

	@ManagedProperty(value = "#{oficinaService}")
	protected OficinaService oficinaService;

	@ManagedProperty(value = "#{salaService}")
	protected SalaService salaService;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	@ManagedProperty(value = "#{gradeOficinaService}")
	protected GradeOficinaService gradeOficinaService;

	private Integer idOficina;
	private List<Oficina> oficinas;
	private Integer idSala;
	private List<Sala> salas;
	private Integer idProfessor;
	private List<Candidato> professores;
	private Integer idTurma;
	private List<Turma> turmas;
	private boolean mostrarCampos;

	public GradeOficinasBean() {
		oficinas = new ArrayList<Oficina>();
		salas = new ArrayList<Sala>();
		professores = new ArrayList<Candidato>();
		turmas = new ArrayList<Turma>();
	}

	@SuppressWarnings("unchecked")
	@PostConstruct
	public void carregarTela() {
		verificarAcesso();
		if (oficinas.isEmpty()) {
			try {
				oficinas = universalManager.getAll(Oficina.class);
				Collections.sort(oficinas, new Comparator<Oficina>() {
					@Override
					public int compare(Oficina o1, Oficina o2) {
						return o1.getNomOficina().trim().compareTo(o2.getNomOficina());
					}
				});
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
	}

	public void recuperarInscricaoCursos(AjaxBehaviorEvent evt) {
		try {
			idProfessor = null;
			idSala = null;
			idTurma = null;
			Oficina oficina = (Oficina) universalManager.get(Oficina.class, idOficina);
			InscricaoCurso inscricaoCurso = new InscricaoCurso();
			inscricaoCurso.setCurso(oficina.getCurso());
			List<InscricaoCurso> inscricaoCursos = inscricaoCursoService.recuperarInscricoes(oficina.getCurso().getId());
			if (inscricaoCursos == null || inscricaoCursos.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Erro!", "Não exitem candidatos no curso para o qual a Oficina pertence.");
				professores = new ArrayList<Candidato>();
				turmas = new ArrayList<Turma>();
				salas = new ArrayList<Sala>();
				mostrarCampos = Boolean.FALSE;
				return;
			}
			carregarProfessores(inscricaoCursos);
			carregarTurmas(inscricaoCursos);
			carregarSalas(inscricaoCursos);
			mostrarCampos = Boolean.TRUE;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void recuperarInscricaoCursosEdicao() {
		try {
			idOficina = getModel().getOficina().getId();
			idProfessor = getModel().getProfessorEvento().getCandidato().getId();
			idSala = getModel().getSala().getId();
			idTurma = getModel().getTurma().getId();
			Oficina oficina = (Oficina) universalManager.get(Oficina.class, idOficina);
			InscricaoCurso inscricaoCurso = new InscricaoCurso();
			inscricaoCurso.setCurso(oficina.getCurso());
			List<InscricaoCurso> inscricaoCursos = inscricaoCursoService.recuperarInscricoes(oficina.getCurso().getId());
			carregarProfessores(inscricaoCursos);
			carregarTurmas(inscricaoCursos);
			carregarSalas(inscricaoCursos);
			mostrarCampos = Boolean.TRUE;
			super.load();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void carregarProfessores(List<InscricaoCurso> inscricaoCursos) {
		try {
			professores = new ArrayList<Candidato>();
			for (InscricaoCurso inscricaoCurso : inscricaoCursos) {
				professores.add(inscricaoCurso.getCandidato());
			}

			Collections.sort(professores, new Comparator<Candidato>() {
				@Override
				public int compare(Candidato o1, Candidato o2) {
					return o1.getNome().trim().compareTo(o2.getNome());
				}
			});
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void carregarTurmas(List<InscricaoCurso> inscricaoCursos) {
		try {
			turmas = new ArrayList<Turma>();
			for (InscricaoCurso inscricaoCurso : inscricaoCursos) {
				turmas.add(inscricaoCurso.getTurma());
			}

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

	private void carregarSalas(List<InscricaoCurso> inscricaoCursos) {
		try {
			List<Integer> listaIdCursos = new ArrayList<Integer>();
			for (InscricaoCurso inscricaoCurso : inscricaoCursos) {
				listaIdCursos.add(inscricaoCurso.getCurso().getId());
			}
			salas = salaService.recuperarSalas(listaIdCursos);

			Collections.sort(salas, new Comparator<Sala>() {
				@Override
				public int compare(Sala o1, Sala o2) {
					return o1.getNomSala().trim().compareTo(o2.getNomSala());
				}
			});
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@Override
	public String save() {
		try {
			getModel().setOficina(new Oficina(idOficina));
			getModel().getProfessorEvento().setCandidato(new Candidato(idProfessor));
			getModel().setSala(new Sala(idSala));
			getModel().setTurma((Turma) universalManager.get(Turma.class, idTurma));
			Integer count = gradeOficinaService.verificarRestricoes(getModel()).intValue();
			if (count <= 0) {
				super.save();
				limparCampos();
			} else {
				FacesMessagesUtil.addErrorMessage("Conflito entre horários!",
						"Existem conflitos entre horários de acordo com as opções selecionadas.");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return "";
	}

	// private boolean verificarRestricoes() throws Exception {
	// Turma turma = (Turma) universalManager.get(Turma.class, idTurma);
	// List<GradeOficina> listaGradeOficinas = gradeOficinaService.recuperarOficinas(getModel());
	// for (GradeOficina gradeOficina : listaGradeOficinas) {
	// /**
	// * Verificando se exitem conflitos entre os horários das oficinas referente ao professor, a sala e a turma
	// */
	// if (gradeOficina.getTurma().getHorario().getId().equals(turma.getHorario().getId())) {
	// if (gradeOficina.getCandidato().getId().equals(idProfessor)) {
	// FacesMessagesUtil.addErrorMessage("Conflito entre horários!",
	// "Existe outra oficina no mesmo horário ministrada pelo Professor selecionado.");
	// return Boolean.FALSE;
	// }
	// if (gradeOficina.getSala().getId().equals(idSala)) {
	// FacesMessagesUtil.addErrorMessage("Conflito entre horários!",
	// "Existe outra oficina no mesmo horário para a Sala selecionada.");
	// return Boolean.FALSE;
	// }
	// if (gradeOficina.getTurma().getId().equals(idTurma)) {
	// FacesMessagesUtil.addErrorMessage("Conflito entre horários!",
	// "Existe outra oficina no mesmo horário para a Turma selecionada.");
	// return Boolean.FALSE;
	// }
	// }
	// }
	// return Boolean.TRUE;
	// }

	private void limparCampos() {
		setModel(createModel());
		idOficina = null;
		idProfessor = null;
		idSala = null;
		idTurma = null;
		mostrarCampos = Boolean.FALSE;
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {

	}

	@Override
	public GradeOficina createModel() {
		return new GradeOficina();
	}

	@Override
	public String getQualifiedName() {
		return "Grade de Oficina";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}

	public Integer getIdOficina() {
		return idOficina;
	}

	public void setIdOficina(Integer idOficina) {
		this.idOficina = idOficina;
	}

	public List<Oficina> getOficinas() {
		return oficinas;
	}

	public void setOficinas(List<Oficina> oficinas) {
		this.oficinas = oficinas;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getIdSala() {
		return idSala;
	}

	public void setIdSala(Integer idSala) {
		this.idSala = idSala;
	}

	public List<Sala> getSalas() {
		return salas;
	}

	public void setSalas(List<Sala> salas) {
		this.salas = salas;
	}

	public Integer getIdProfessor() {
		return idProfessor;
	}

	public void setIdProfessor(Integer idProfessor) {
		this.idProfessor = idProfessor;
	}

	public List<Candidato> getProfessores() {
		return professores;
	}

	public void setProfessores(List<Candidato> professores) {
		this.professores = professores;
	}

	public Integer getIdTurma() {
		return idTurma;
	}

	public void setIdTurma(Integer idTurma) {
		this.idTurma = idTurma;
	}

	public List<Turma> getTurmas() {
		return turmas;
	}

	public void setTurmas(List<Turma> turmas) {
		this.turmas = turmas;
	}

	public OficinaService getOficinaService() {
		return oficinaService;
	}

	public void setOficinaService(OficinaService oficinaService) {
		this.oficinaService = oficinaService;
	}

	public SalaService getSalaService() {
		return salaService;
	}

	public void setSalaService(SalaService salaService) {
		this.salaService = salaService;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}

	public GradeOficinaService getGradeOficinaService() {
		return gradeOficinaService;
	}

	public void setGradeOficinaService(GradeOficinaService gradeOficinaService) {
		this.gradeOficinaService = gradeOficinaService;
	}

	public boolean isMostrarCampos() {
		return mostrarCampos;
	}

	public void setMostrarCampos(boolean mostrarCampos) {
		this.mostrarCampos = mostrarCampos;
	}
}
