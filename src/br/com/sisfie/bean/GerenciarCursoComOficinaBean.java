package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.event.AjaxBehaviorEvent;

import org.hibernate.Hibernate;
import org.primefaces.context.RequestContext;
import org.springframework.dao.DataIntegrityViolationException;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.DateUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.GradePacote;
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Pacote;
import br.com.sisfie.entidade.PacoteOficina;
import br.com.sisfie.entidade.ProfessorEvento;
import br.com.sisfie.entidade.Sala;
import br.com.sisfie.entidade.SelecaoPacote;
import br.com.sisfie.entidade.Situacao;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.service.CandidatoService;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.GradeOficinaService;
import br.com.sisfie.service.GradePacoteService;
import br.com.sisfie.service.HorarioService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.OficinaService;
import br.com.sisfie.service.PacoteService;
import br.com.sisfie.service.ProfessorEventoService;
import br.com.sisfie.service.SalaService;
import br.com.sisfie.service.SelecaoPacoteService;
import br.com.sisfie.service.TurmaService;

@ManagedBean(name = "gerenciarCursoComOficinaBean")
@ViewScoped
public class GerenciarCursoComOficinaBean extends BaseBean<Curso> {

	private static final long serialVersionUID = 7704780196603144018L;

	@ManagedProperty(value = "#{professorEventoService}")
	protected ProfessorEventoService professorEventoService;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{horarioService}")
	protected HorarioService horarioService;

	@ManagedProperty(value = "#{turmaService}")
	protected TurmaService turmaService;

	@ManagedProperty(value = "#{salaService}")
	protected SalaService salaService;

	@ManagedProperty(value = "#{oficinaService}")
	protected OficinaService oficinaService;

	@ManagedProperty(value = "#{pacoteService}")
	protected PacoteService pacoteService;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	@ManagedProperty(value = "#{gradePacoteService}")
	protected GradePacoteService gradePacoteService;

	@ManagedProperty(value = "#{gradeOficinaService}")
	protected GradeOficinaService gradeOficinaService;

	@ManagedProperty(value = "#{candidatoService}")
	protected CandidatoService candidatoService;

	@ManagedProperty(value = "#{selecaoPacoteService}")
	protected SelecaoPacoteService selecaoPacoteService;

	private Curso curso;
	private Curso cursoClone;
	private Horario horario;
	private List<Horario> listaHorarios;
	private Date hoje = new Date();
	private Date dataFimMinima = new Date();
	private Turma turma;
	private List<Turma> listaTurmas;
	private List<Horario> horariosTurmas;
	private Integer idHorarioTurma;
	private Sala sala;
	private List<Sala> listaSalas;
	private Oficina oficina;
	private List<Oficina> listaOficinas;
	private List<Oficina> listaOficinasSelecionadas;
	private Pacote pacote;
	private List<PacoteOficina> pacoteOficinas;
	private List<PacoteOficina> listaPacoteOficinasExclusao;
	private Oficina oficinaSelecionada;
	private Oficina oficinaPacoteExclusao;
	private List<Pacote> listaPacotes;
	private Integer quantidadeVagas;
	private Integer totalInscricoes;
	private boolean dentroRegiao;
	private Integer activeIndex;
	private Integer idPacote;
	private List<Pacote> pacotes;
	private List<GradePacote> gradePacotes;
	private List<PacoteOficina> gradePacoteOficinas;
	private List<Horario> gradePacoteHorarios;
	private List<Turma> gradePacoteTurmas;
	private Integer idTurma;
	private GradePacote gradePacote;
	private Integer idHorario;
	private Integer idOficina;
	private List<Oficina> oficinas;
	private Integer idSala;
	private List<Sala> salas;
	private Integer idProfessor;
	private List<Candidato> candidatosProfessores;
	private List<ProfessorEvento> professores;
	private Integer idGradeOficinaTurma;
	private List<Turma> gradeOficinaTurmas;
	private boolean mostrarCampos;
	private GradeOficina gradeOficina;
	private List<GradeOficina> gradeOficinas;
	private ProfessorEvento professor;
	private Candidato candidato;
	private Integer idProfessorPacoteOficina;
	private boolean mostrarDialogAdicionarOficinasPacote;
	private boolean mostrarTotalCargaHoraria;
	private Integer totalComNovoRegistro;

	private static final Integer HORARIO = 0;
	private static final Integer TURMA = 1;
	private static final Integer SALA = 2;
	private static final Integer PROFESSOR = 3;
	private static final Integer OFICINA = 4;
	private static final Integer PACOTE = 5;

	public GerenciarCursoComOficinaBean() {
		curso = new Curso();
		horario = new Horario();
		listaHorarios = new ArrayList<Horario>();
		turma = new Turma();
		listaTurmas = new ArrayList<Turma>();
		horariosTurmas = new ArrayList<Horario>();
		sala = new Sala();
		listaSalas = new ArrayList<Sala>();
		oficina = new Oficina();
		listaOficinas = new ArrayList<Oficina>();
		listaOficinasSelecionadas = new ArrayList<Oficina>();
		pacote = new Pacote();
		pacoteOficinas = new ArrayList<PacoteOficina>();
		listaPacoteOficinasExclusao = new ArrayList<PacoteOficina>();
		oficinaSelecionada = new Oficina();
		oficinaPacoteExclusao = new Oficina();
		pacotes = new ArrayList<Pacote>();
		gradePacotes = new ArrayList<GradePacote>();
		gradePacoteOficinas = new ArrayList<PacoteOficina>();
		gradePacoteTurmas = new ArrayList<Turma>();
		gradePacote = new GradePacote();
		oficinas = new ArrayList<Oficina>();
		salas = new ArrayList<Sala>();
		professores = new ArrayList<ProfessorEvento>();
		gradeOficinaTurmas = new ArrayList<Turma>();
		gradeOficina = new GradeOficina();
		gradeOficinas = new ArrayList<GradeOficina>();
		professor = new ProfessorEvento();
		candidatosProfessores = new ArrayList<Candidato>();
		candidato = new Candidato();
		cursoClone = new Curso();
	}

	@PostConstruct
	public void carregarTela() {
		verificarAcesso();
		Integer idCurso = (Integer) getSessionMap().remove("idCursoGerenciar");
		if (idCurso != null) {
			curso = (Curso) universalManager.get(Curso.class, idCurso);
			carregarListas();
		}
	}

	public void clonarApoio() {
		try {
			if (cursoClone == null || cursoClone.getId() == null) {
				FacesMessagesUtil.addErrorMessage("Clonar Apoio", "Para clonar o apoio, é necessário escolher um curso.");
				return;
			}
			cursoService.clonarApoio(curso, cursoClone);
			carregarListas();
			FacesMessagesUtil.addInfoMessage(" ", "Apoio clonado com sucesso!");
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Clonar Apoio", "Erro ao tentar clocar apoio.");
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void recuperarInscricaoCursos(AjaxBehaviorEvent evt) {
		try {
			// idProfessor = null;
			// idSala = null;
			// idTurma = null;
			professores = new ArrayList<ProfessorEvento>();
			gradeOficinaTurmas = new ArrayList<Turma>();
			salas = new ArrayList<Sala>();
			curso = (Curso) universalManager.get(Curso.class, curso.getId());
			carregarTurmas();
			carregarSalas();
			carregarListaCandidatoProfessor();
			carregarProfessores();
			mostrarCampos = Boolean.TRUE;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void recuperarInscricaoCursosEdicao() {
		try {
			idOficina = gradeOficina.getOficina().getId();
			idProfessor = gradeOficina.getProfessorEvento().getCandidato().getId();
			idSala = gradeOficina.getSala().getId();
			idGradeOficinaTurma = gradeOficina.getTurma().getId();
			curso = (Curso) universalManager.get(Curso.class, curso.getId());
			idHorarioTurma = gradeOficina.getHorario().getId();
			carregarTurmas();
			carregarSalas();
			mostrarCampos = Boolean.TRUE;
			gradeOficina = (GradeOficina) universalManager.get(GradeOficina.class, gradeOficina.getId());
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void carregarProfessores() {
		try {
			professores = professorEventoService.listarProfessores(curso.getId());

			Collections.sort(professores, new Comparator<ProfessorEvento>() {
				@Override
				public int compare(ProfessorEvento o1, ProfessorEvento o2) {
					return o1.getCandidato().getNome().trim().compareTo(o2.getCandidato().getNome());
				}
			});
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void carregarTurmas() {
		try {
			gradeOficinaTurmas = new ArrayList<Turma>();
			gradeOficinaTurmas.addAll(curso.getTurmas());

			Collections.sort(gradeOficinaTurmas, new Comparator<Turma>() {
				@Override
				public int compare(Turma o1, Turma o2) {
					return o1.getDescricao().trim().compareTo(o2.getDescricao());
				}
			});
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void carregarSalas() {
		try {
			salas = new ArrayList<Sala>();
			salas.addAll(curso.getSalas());

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

	public String salvarGradeOficina() {
		try {
			gradeOficina.setOficina(new Oficina(idOficina));
			gradeOficina.setProfessorEvento(professorEventoService.recuperarProfessorEvento(idProfessor, curso.getId()));
			gradeOficina.setSala(new Sala(idSala));
			gradeOficina.setTurma(new Turma(idGradeOficinaTurma));
			gradeOficina.setHorario(new Horario(idHorarioTurma));
			Integer count = gradeOficinaService.verificarRestricoes(gradeOficina).intValue();
			if (count <= 0) {
				gradeOficinaService.salvarGradeOficina(gradeOficina);
				limparGradeOficina();
				carregarGradeOficinas();
				FacesMessagesUtil.addInfoMessage("Grade de Oficinas!", "Grade de Oficinas Salva com sucesso.");
			} else {
				FacesMessagesUtil.addErrorMessage("Conflito entre horários!",
						"Existem conflitos entre horários de acordo com as opções selecionadas.");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return "";
	}

	public void excluirGradeOficina() {
		try {
			gradeOficinaService.excluirGradeOficina(gradeOficina);
			carregarGradeOficinas();
			FacesMessagesUtil.addInfoMessage("Grade de Oficinas!", "Grade de Oficinas removida com sucesso.");
		} catch (DataIntegrityViolationException e){
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage("Violação de integridade na base de dados!",
					"Não foi possível remover a Grade de Oficina devido o mesmo já está sendo utilizado!");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void limparGradeOficina() {
		gradeOficina = new GradeOficina();
		idHorarioTurma = null;
		idOficina = null;
		idProfessor = null;
		idSala = null;
		idGradeOficinaTurma = null;
		mostrarCampos = Boolean.FALSE;
	}

	public void editarExcluirOficinas() {
		if (idHorario != null && !idHorario.equals(0) && idTurma != null && !idTurma.equals(0)) {
			gradePacote.setHorario(new Horario(idHorario));
			gradePacote.setTurma(new Turma(idTurma));
			Integer countGradePacote = gradePacoteService.countGradePacote(gradePacote).intValue();
			limparIdsCombos();
			if (countGradePacote > 0 && (gradePacote.getId() == null || gradePacote.getId().equals(0))) {
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
			gradePacoteService.alterarOficinaGradePacote(gradePacote);
			FacesMessagesUtil.addInfoMessage("Oficina!", "salva com sucesso na grade de pacotes!");
			gradePacote = new GradePacote();
			carregarOficinas(null);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void removerOficinaGradePacote() {
		try {
			gradePacoteService.removerOficinaGradePacote(gradePacote);
			FacesMessagesUtil.addInfoMessage("Oficina!", "Removida com sucesso da grade de pacotes!");
			gradePacote = new GradePacote();
			carregarOficinas(null);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void carregarOficinas(AjaxBehaviorEvent evt) {
		if (idPacote == null || idPacote.equals(0)) {
			gradePacotes = new ArrayList<GradePacote>();
			return;
		}
		gradePacoteOficinas = pacoteService.recuperarPacoteOficinaPorPacote(idPacote);
		if (gradePacoteOficinas != null && !gradePacoteOficinas.isEmpty()) {
			carregarCombos();
		} else {
			return;
		}

		gradePacotes = gradePacoteService.listarGradePacotes(idPacote);
		if (gradePacotes == null || gradePacotes.isEmpty()) {
			// Caso a grade estaja vazia
			if (gradePacoteOficinas != null && !gradePacoteOficinas.isEmpty()) {
				for (PacoteOficina pacoteOficina : gradePacoteOficinas) {
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
				if (gradePacoteOficinas.contains(gradePacote.getPacoteOficina())) {
					gradePacoteOficinas.remove(gradePacote.getPacoteOficina());
					continue;
				}
			}
			// adicionando os não persistidos
			for (PacoteOficina pacoteOficina : gradePacoteOficinas) {
				GradePacote gradePacote = new GradePacote();
				gradePacote.setHorario(new Horario());
				gradePacote.setTurma(new Turma());
				gradePacote.setPacoteOficina(pacoteOficina);
				gradePacotes.add(gradePacote);
			}
		}
	}

	@SuppressWarnings("unchecked")
	public void carregarCombos() {
		try {
			gradePacoteHorarios = horarioService.listarHorarios(curso.getId());
			Collections.sort(gradePacoteHorarios, new Comparator<Horario>() {
				@Override
				public int compare(Horario o1, Horario o2) {
					return o1.getDesHorario().trim().compareTo(o2.getDesHorario());
				}
			});

			Turma turma = new Turma();
			turma.setCurso(new Curso(curso.getId()));
			gradePacoteTurmas = universalManager.listBy(turma);
			Collections.sort(gradePacoteTurmas, new Comparator<Turma>() {
				@Override
				public int compare(Turma o1, Turma o2) {
					return o1.getDescricao().trim().compareTo(o2.getDescricao());
				}
			});
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		Curso c = new Curso();
		c.setTitulo(query);

		try {
			List<Curso> listaBanco = cursoService.recuperarCursosComOficina(c);

			if (listaBanco != null && !listaBanco.isEmpty()) {
				for (Curso curso : listaBanco) {
					if ((curso.getUsuario().getId().equals(loginBean.getModel().getId()) && acessoBean
							.verificarAcesso("ROLE_CURSO_GERENCIAR")) || acessoBean.verificarAcesso("ROLE_PESQ_ACESSO_GERAL")) {
						sugestoes.add(curso);
					}
				}
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return sugestoes;
	}

	public void carregarListas() {
		try {
			carregarGradeOficinas();
			carregarPacotesGradePacotes();
			carregarOficinasGradeOficina();
			carregarListaTurmas();
			carregarListaSalas();
			carregarListaOficinas();
			carregarListaPacotes();
			carregarListaHorarios();
			carregarProfessores();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@SuppressWarnings("unchecked")
	private void carregarListaCandidatoProfessor() {
		try {
			candidatosProfessores = universalManager.getAll(Candidato.class);

			Collections.sort(candidatosProfessores, new Comparator<Candidato>() {
				@Override
				public int compare(Candidato o1, Candidato o2) {
					return o1.getNome().trim().compareTo(o2.getNome());
				}
			});
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void carregarGradeOficinas() {
		try {
			gradeOficinas = gradeOficinaService.listarGradeOficinas(curso.getId());
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	private void carregarOficinasGradeOficina() {
		try {
			oficinas = oficinaService.recuperarOficinasDisponiveis(curso.getId());
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

	private void carregarPacotesGradePacotes() {
		try {
			pacotes = pacoteService.recuperarPacotes(curso.getId());
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

	private void carregarListaPacotes() {
		try {
			listaPacotes = pacoteService.recuperarPacotes(curso.getId());
			/**
			 * Caso não tenha sido cadastrado horários, é omitido a aba Turmas e subtraído 1 do index da aba corrente.
			 */
			if (listaHorarios == null || listaHorarios.isEmpty()) {
				activeIndex = PACOTE - 1;
			} else {
				activeIndex = PACOTE;
			}
			mostrarTotalCargaHoraria = false;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	private void carregarListaOficinas() {
		try {
			listaOficinas = oficinaService.recuperarOficinasDisponiveis(curso.getId());
			// Atualizando a lista de oficinas para seleção na grade de oficinas
			oficinas = new ArrayList<Oficina>();
			oficinas.addAll(listaOficinas);
			/**
			 * Caso não tenha sido cadastrado horários, é omitido a aba Turmas e subtraído 1 do index da aba corrente.
			 */
			if (listaHorarios == null || listaHorarios.isEmpty()) {
				activeIndex = OFICINA - 1;
			} else {
				activeIndex = OFICINA;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	private void carregarListaSalas() {
		try {
			List<Integer> idsCurso = new ArrayList<Integer>();
			idsCurso.add(curso.getId());
			listaSalas = salaService.recuperarSalas(idsCurso);
			/**
			 * Caso não tenha sido cadastrado horários, é omitido a aba Turmas e subtraído 1 do index da aba corrente.
			 */
			if (listaHorarios == null || listaHorarios.isEmpty()) {
				activeIndex = SALA - 1;
			} else {
				activeIndex = SALA;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void carregarListaTurmas() {
		try {
			listaTurmas = turmaService.listarTurmas(curso.getId());
			activeIndex = TURMA;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	private void carregarListaHorarios() {
		try {
			listaHorarios = horarioService.listarHorarios(curso.getId());
			horariosTurmas = new ArrayList<Horario>();
			horariosTurmas.addAll(listaHorarios);
			activeIndex = HORARIO;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void sugerirDataHoras(AjaxBehaviorEvent evt) {
		if (horario.getDatHoraInicio() != null) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(horario.getDatHoraInicio());
			calendar.add(Calendar.HOUR_OF_DAY, 4);
			horario.setDatHoraFim(calendar.getTime());
			dataFimMinima = calendar.getTime();
		}
	}

	@SuppressWarnings("unchecked")
	public void salvarHorario() {
		try {
			if (horario.getDesHorario() == null || horario.getDesHorario().isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "É necessário informar a descrição do Horário!");
				return;
			}
			if (horario.getDatHoraInicio() == null) {
				FacesMessagesUtil.addErrorMessage(" ", "É necessário informar a Data/hora início!");
				return;
			}
			if (horario.getDatHoraFim() == null) {
				FacesMessagesUtil.addErrorMessage(" ", "É necessário informar a Data/hora fim!");
				return;
			}
			Horario horarioVerificacao = new Horario();
			horarioVerificacao.setDesHorario(horario.getDesHorario());
			horarioVerificacao.setCurso(new Curso(curso.getId()));
			List<Horario> listaHorarioVerificacao = universalManager.listBy(horarioVerificacao);
			// Removendo o registro no caso de edição
			if (horario.getId() != null) {
				listaHorarioVerificacao.remove(horario);
			}
			if (!listaHorarioVerificacao.isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "Horário já cadastrado com a descrição informada!");
			} else {
				horario.setCurso(this.curso);
				horarioService.salvarHorario(horario);
				limparHorario();
				carregarListaHorarios();
				FacesMessagesUtil.addInfoMessage("Horário ", ConstantesARQ.SALVO + " " + ConstantesARQ.COM_SUCESSO);
			}
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Horário", ConstantesARQ.ERRO_SALVAR);
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void loadHorario() {
		try {
			horario = (Horario) universalManager.get(Horario.class, horario.getId());
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void excluirHorario() {
		try {
			horarioService.excluirHorario(horario);
			limparHorario();
			carregarListaHorarios();
			FacesMessagesUtil.addInfoMessage("Horário ", ConstantesARQ.REMOVIDO + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage("Violação de integridade na base de dados!",
					"Não foi possível remover o horário devido o mesmo já está sendo utilizado!");
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Horário", ConstantesARQ.ERRO_EXCLUIR);
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void limparHorario() {
		horario = new Horario();
	}

	@SuppressWarnings("unchecked")
	public void salvarTurma() {
		try {
			if (turma.getDescricao() == null || turma.getDescricao().isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "É necessário informar a descrição da turma!");
				return;
			}
			Turma turmaVerificacao = new Turma();
			turmaVerificacao.setDescricao(turma.getDescricao());
			turmaVerificacao.setCurso(new Curso(curso.getId()));
			List<Turma> listaTurmaVerificacao = universalManager.listBy(turmaVerificacao);
			// Removendo o registro no caso de edição
			if (turma.getId() != null) {
				listaTurmaVerificacao.remove(turma);
			}
			if (!listaTurmaVerificacao.isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "Turma já cadastrada com a descrição informada!");
			} else {
				turma.setCurso(curso);
				turmaService.salvarTurma(turma);
				limparTurma();
				carregarListaTurmas();
				FacesMessagesUtil.addInfoMessage("Turma ", ConstantesARQ.SALVA + " " + ConstantesARQ.COM_SUCESSO);
			}
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Turma", ConstantesARQ.ERRO_SALVAR);
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void loadTurma() {
		try {
			turma = (Turma) universalManager.get(Turma.class, turma.getId());
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void excluirTurma() {
		try {
			turmaService.excluirTurma(turma);
			limparTurma();
			carregarListaTurmas();
			FacesMessagesUtil.addInfoMessage("Turma ", ConstantesARQ.REMOVIDA + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage("Violação de integridade na base de dados!",
					"Não foi possível remover a turma devido a mesma já está sendo utilizada!");
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Turma", ConstantesARQ.ERRO_EXCLUIR);
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void limparTurma() {
		turma = new Turma();
		idHorarioTurma = null;
	}

	@SuppressWarnings("unchecked")
	public void salvarSala() {
		try {
			if (sala.getNomSala() == null || sala.getNomSala().isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "É necessário informar a sala!");
				return;
			}
			if (sala.getNumCapacidade() == null || sala.getNumCapacidade() == 0) {
				FacesMessagesUtil.addErrorMessage(" ", "A capacidade da sala não pode ser vazia nem 0(zero)!");
				return;
			}
			if (sala.getDesLocalizacao() == null || sala.getDesLocalizacao().isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "É necessário informar a localização da sala!");
				return;
			}
			Sala salaVerificacao = new Sala();
			salaVerificacao.setNomSala(sala.getNomSala());
			salaVerificacao.setCurso(new Curso(curso.getId()));
			List<Sala> listaSalaVerificacao = universalManager.listBy(salaVerificacao);
			// Removendo o registro no caso de edição
			if (sala.getId() != null) {
				listaSalaVerificacao.remove(sala);
			}
			if (!listaSalaVerificacao.isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "Sala já cadastrada!");
			} else {
				sala.setCurso(this.curso);
				salaService.salvarSala(sala);
				carregarListaSalas();
				limparSala();
				FacesMessagesUtil.addInfoMessage("Sala ", ConstantesARQ.SALVA + " " + ConstantesARQ.COM_SUCESSO);
			}
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Sala", ConstantesARQ.ERRO_SALVAR);
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void salvarProfessor() {
		try {
			professor.setCurso(this.curso);
			if (candidato == null || candidato.getId() == null) {
				FacesMessagesUtil.addErrorMessage("Professor", "É necessário selecionar algum professor para salvar.");
				return;
			}
			professor.setCandidato(candidato);
			professorEventoService.salvarProfessor(professor);
			carregarProfessores();
			limparProfessor();
			FacesMessagesUtil.addInfoMessage("Professor ", ConstantesARQ.SALVO + " " + ConstantesARQ.COM_SUCESSO);
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Professor", ConstantesARQ.ERRO_SALVAR);
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void loadSala() {
		try {
			sala = (Sala) universalManager.get(Sala.class, sala.getId());
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void excluirSala() {
		try {
			salaService.excluirSala(sala);
			limparSala();
			carregarListaSalas();
			FacesMessagesUtil.addInfoMessage("Sala ", ConstantesARQ.REMOVIDA + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage("Violação de integridade na base de dados!",
					"Não foi possível remover a Sala devido a mesma já está sendo utilizada!");
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Sala", ConstantesARQ.ERRO_EXCLUIR);
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void excluirProfessor() {
		try {
			professorEventoService.excluirProfessor(professor);
			FacesMessagesUtil.addInfoMessage("Professor ", ConstantesARQ.REMOVIDO + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage("Violação de integridade na base de dados!",
					"Não foi possível remover o professor devido o mesmo já está sendo utilizado!");
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Professor", ConstantesARQ.ERRO_EXCLUIR);
			ExcecaoUtil.tratarExcecao(e);
		} finally {
			limparProfessor();
			carregarProfessores();
			if (listaHorarios == null || listaHorarios.isEmpty()) {
				activeIndex = PROFESSOR - 1;
			} else {
				activeIndex = PROFESSOR;
			}
		}
	}

	public void limparSala() {
		sala = new Sala();
	}

	public void limparProfessor() {
		professor = new ProfessorEvento();
		candidato = new Candidato();
	}

	@SuppressWarnings("unchecked")
	public void salvarOficina() {
		try {
			if (oficina.getNomOficina() == null || oficina.getNomOficina().isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "É necessário informar o nome da oficina!");
				carregarListaOficinas();
				return;
			}
			if (oficina.getNumCargaHoraria() == null) {
				FacesMessagesUtil.addErrorMessage(" ", "É necessário informar a carga horária!");
				carregarListaOficinas();
				return;
			}
			if (oficina.getCodOficina() == null || oficina.getCodOficina().isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "É necessário informar o código da oficina!");
				carregarListaOficinas();
				return;
			}
			Oficina oficinaVerificacao = new Oficina();
			oficinaVerificacao.setNomOficina(oficina.getNomOficina());
			oficinaVerificacao.setCurso(new Curso(curso.getId()));
			List<Oficina> listaOficinaVerificacao = universalManager.listBy(oficinaVerificacao);
			// Removendo o registro no caso de edição
			if (oficina.getId() != null) {
				listaOficinaVerificacao.remove(oficina);
			}
			if (!listaOficinaVerificacao.isEmpty()) {
				FacesMessagesUtil.addErrorMessage(" ", "Oficina já cadastrada!");
				carregarListaOficinas();
			} else {
				oficina.setCurso(this.curso);
				oficinaService.salvarOficina(oficina);
				carregarListaOficinas();
				limparOficina();
				FacesMessagesUtil.addInfoMessage("Oficina ", ConstantesARQ.SALVA + " " + ConstantesARQ.COM_SUCESSO);
			}
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Oficina", ConstantesARQ.ERRO_SALVAR);
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void loadOficina() {
		try {
			oficina = (Oficina) universalManager.get(Oficina.class, oficina.getId());
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void excluirOficina() {
		try {
			oficinaService.excluirOficina(oficina);
			FacesMessagesUtil.addInfoMessage("Oficina ", ConstantesARQ.REMOVIDA + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage("Violação de integridade na base de dados!",
					"Não foi possível remover a oficina devido a mesma já está sendo utilizada!");
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Oficina", ConstantesARQ.ERRO_EXCLUIR);
			ExcecaoUtil.tratarExcecao(e);
		} finally {
			limparOficina();
			carregarListaOficinas();
			if (listaHorarios == null || listaHorarios.isEmpty()) {
				activeIndex = OFICINA - 1;
			} else {
				activeIndex = OFICINA;
			}
		}
	}

	public void limparOficina() {
		oficina = new Oficina();
	}

	public void salvarPacote() {
		try {
			if (listaOficinasSelecionadas == null || listaOficinasSelecionadas.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Oficinas não selecionadas", "Selecione pelo menos uma oficina!");
				return;
			}

			totalComNovoRegistro = 0;
			for (Oficina oficina : listaOficinasSelecionadas) {
				totalComNovoRegistro += oficina.getNumCargaHoraria();
			}
			if (totalComNovoRegistro < 36 || totalComNovoRegistro > 48) {
				FacesMessagesUtil.addErrorMessage("Total da carga horária inválida!",
						"O total da carga horária das oficinas deve atingir entre 36 e 48 horas.");
				return;
			}

			pacote.setCurso(this.curso);
			for (Oficina oficina : listaOficinasSelecionadas) {
				PacoteOficina pacoteOficina = null;
				if (pacote.getId() != null) {
					pacoteOficina = pacoteService.recuperarPacoteOficina(pacote, oficina);
				}
				if (pacoteOficina == null) {
					pacoteOficina = new PacoteOficina();
				}
				pacoteOficina.setPacote(pacote);
				pacoteOficina.setOficina(oficina);
				pacoteOficinas.add(pacoteOficina);
			}
			pacoteService.save(pacoteOficinas, listaPacoteOficinasExclusao, pacote);
			FacesMessagesUtil.addInfoMessage("Pacote ", ConstantesARQ.SALVO + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage("Violação de integridade na base de dados!",
					"Não foi possível remover uma ou mais oficina(s) do pacote devido o mesmo já está sendo utilizado!");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		} finally {
			if (totalComNovoRegistro >= 36 && totalComNovoRegistro <= 48) {
				limparPacote();
			}
			carregarListaPacotes();
			carregarPacotesGradePacotes();
		}
	}

	public void limparPacote() {
		pacote = new Pacote();
		pacoteOficinas = new ArrayList<PacoteOficina>();
		listaOficinasSelecionadas = new ArrayList<Oficina>();
		listaPacoteOficinasExclusao = new ArrayList<PacoteOficina>();
		oficinaSelecionada = new Oficina();
		candidato = new Candidato();
		mostrarTotalCargaHoraria = false;
	}

	public void verificarNomePacote() {
		try {
			if (pacote == null || pacote.getNomPacote() == null || pacote.getNomPacote().isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Erro!", "Nome do pacote é obrigatório!");
				return;
			} else {
				List<SelecaoPacote> listaPacotes = selecaoPacoteService.listarSelecaoPacote(pacote.getId());
				if (listaPacotes != null && !listaPacotes.isEmpty()) {
					FacesMessagesUtil.addErrorMessage("Erro!", "Pacote já utilizado em seleções por candidatos!");
					return;
				}
				Pacote pacoteVerificacao = new Pacote();
				pacoteVerificacao.setNomPacote(pacote.getNomPacote());
				pacoteVerificacao.setCurso(new Curso(curso.getId()));
				if (pacote.getId() == null && !universalManager.listBy(pacoteVerificacao).isEmpty()) {
					FacesMessagesUtil.addInfoMessage(" ", "Pacote já cadastrado com o nome informado!");
				} else {
					mostrarDialogAdicionarOficinasPacote = true;
					RequestContext context = RequestContext.getCurrentInstance();
					context.execute("adicionarOficinas.show();");
					context.update("idPanelOficinaProfessor");
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void adicionarOficinaPacote() {

		// Validando campos
		if (pacote == null || pacote.getNomPacote() == null || pacote.getNomPacote().isEmpty()) {
			FacesMessagesUtil.addErrorMessage("Erro!", "Nome do pacote é obrigatório!");
			return;
		}
		if (oficinaSelecionada == null || oficinaSelecionada.getId() == null || oficinaSelecionada.getId().equals(0)) {
			FacesMessagesUtil.addErrorMessage("Erro!", "Nenhuma oficina selecionada!");
			return;
		}

		Integer totalCargaHoraria = 0;
		totalComNovoRegistro = 0;
		for (Oficina oficina : listaOficinasSelecionadas) {
			totalCargaHoraria += oficina.getNumCargaHoraria();
		}
		RequestContext context = RequestContext.getCurrentInstance();
		if (oficinaSelecionada != null && oficinaSelecionada.getId() != null && !oficinaSelecionada.getId().equals(0)) {
			totalComNovoRegistro = totalCargaHoraria + oficinaSelecionada.getNumCargaHoraria();
			if (totalComNovoRegistro > 48) {
				if ((48 - totalCargaHoraria) <= 0) {
					FacesMessagesUtil.addErrorMessage("Total de carga horária excedida.", "Não é possível adicinar mais oficinas.");
				} else {
					FacesMessagesUtil.addErrorMessage("Total de carga horária excedida.", "Selecione Oficina com no máximo "
							+ (48 - totalCargaHoraria) + ":00h.");
				}
				totalComNovoRegistro -= oficinaSelecionada.getNumCargaHoraria();
				context.execute("adicionarOficinas.hide();");
				context.update("idPanelOficinaProfessor");
				mostrarDialogAdicionarOficinasPacote = false;
				oficinaSelecionada = new Oficina();
				return;
			} else {
				listaOficinasSelecionadas.add(oficinaSelecionada);
			}
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
		mostrarDialogAdicionarOficinasPacote = false;
		context.execute("adicionarOficinas.hide();");
		context.update("idPanelOficinaProfessor");
		mostrarTotalCargaHoraria = true;
	}

	public List<Oficina> completeOficina(String query) {
		List<Oficina> sugestoes = new ArrayList<Oficina>();
		try {
			sugestoes = oficinaService.pesquisarOficina(query, curso.getId());
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

	@SuppressWarnings("unchecked")
	public List<Candidato> completeProfessor(String query) {
		List<Candidato> sugestoes = new ArrayList<Candidato>();
		try {
			if (query == null || query.isEmpty()) {
				sugestoes = universalManager.getAll(Candidato.class);
			} else {
				sugestoes = candidatoService.pesquisarCandidato(query);
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;
	}

	public List<Candidato> completeProfessorEvento(String query) {
		List<Candidato> sugestoes = new ArrayList<Candidato>();
		List<Candidato> professorEventos = professorEventoService.listarTodosProfessores();
		try {
			if (query == null || query.isEmpty()) {
				sugestoes.addAll(professorEventos);
			} else {
				// Listando os ids dos candidato que são professores
				StringBuilder idCandidatos = new StringBuilder();
				if (professorEventos != null && !professorEventos.isEmpty()) {
					for (Candidato professor : professorEventos) {
						idCandidatos.append(professor.getId() + ",");
					}
				}

				// Somente recupera os candidatos que forem professores e de acordo com o parametro digitado
				if (idCandidatos != null && !idCandidatos.equals("")) {
					sugestoes = candidatoService.pesquisarCandidato(query, idCandidatos.substring(0, idCandidatos.length() - 1));
				}
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;
	}

	@SuppressWarnings("unchecked")
	public void excluirOficinaPacote() {
		if (oficinaPacoteExclusao != null && oficinaPacoteExclusao.getId() != null) {
			PacoteOficina pacoteOficina = new PacoteOficina();
			try {
				if (pacote != null && pacote.getId() != null && !pacote.getId().equals(0)) {
					pacoteOficina.setPacote(new Pacote(pacote.getId()));
					pacoteOficina.setOficina(new Oficina(oficinaPacoteExclusao.getId()));
					List<PacoteOficina> lista = universalManager.listBy(pacoteOficina);
					if (lista != null && !lista.isEmpty()) {
						pacoteOficina = lista.get(0);
					}
				}
				if (pacoteOficina != null && pacoteOficina.getId() != null) {
					listaPacoteOficinasExclusao.add(pacoteOficina);
				}
				listaOficinasSelecionadas.remove(oficinaPacoteExclusao);
				mostrarTotalizarCargaHoraria();
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
	}

	public void loadPacote() {
		try {
			pacote = (Pacote) universalManager.get(Pacote.class, pacote.getId());
			listaOficinasSelecionadas = oficinaService.recuperarOficina(curso.getId(), pacote.getId());
			mostrarTotalizarCargaHoraria();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void mostrarTotalizarCargaHoraria() {
		totalComNovoRegistro = 0;
		for (Oficina oficina : listaOficinasSelecionadas) {
			totalComNovoRegistro += oficina.getNumCargaHoraria();
		}
		if (totalComNovoRegistro > 0) {
			mostrarTotalCargaHoraria = true;
		} else {
			mostrarTotalCargaHoraria = false;
		}
	}

	public void excluirPacote() {
		try {
			List<PacoteOficina> listaPacoteOficinas = pacoteService.recuperarPacoteOficina(pacote);
			pacoteService.delete(listaPacoteOficinas, pacote);
			carregarListaPacotes();
			carregarPacotesGradePacotes();
			limparPacote();
			FacesMessagesUtil.addInfoMessage("Pacote ", ConstantesARQ.REMOVIDO + " " + ConstantesARQ.COM_SUCESSO);
		} catch (DataIntegrityViolationException e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(),
					"Não é possível remover o pacote, ele está sendo usado pela grade de pacote ou pela seleção de pacotes");
		} catch (Exception e) {
			e.printStackTrace();
			FacesMessagesUtil.addErrorMessage("Pacote", ConstantesARQ.ERRO_EXCLUIR);
		}
	}

	public void consultarInscricoesDentroRegiao() {
		try {
			dentroRegiao = Boolean.TRUE;
			curso = (Curso) universalManager.get(Curso.class, curso.getId());
			Hibernate.initialize(curso.getMunicipioCursos());
			Hibernate.initialize(curso.getUfCursos());
			if ((curso.getMunicipioCursos() == null || curso.getMunicipioCursos().isEmpty())
					&& (curso.getUfCursos() == null || curso.getUfCursos().isEmpty())) {
				FacesMessagesUtil.addInfoMessage("Curso", "Curso não habilitado por região!");
				return;
			}
			totalInscricoes = inscricaoCursoService.consultarInscricoes(curso, dentroRegiao).intValue();
			if (totalInscricoes != null && totalInscricoes > 0) {
				FacesMessagesUtil.addInfoMessage("Região do Curso", "Foram encotrado(s): " + totalInscricoes
						+ " inscrição(ões) com o órgão dentro da região do curso!");
			} else {
				FacesMessagesUtil.addInfoMessage("Região do Curso", "Não há Inscrições dentro da região do curso!");
				quantidadeVagas = null;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void consultarInscricoesForaRegiao() {
		try {
			dentroRegiao = Boolean.FALSE;
			curso = (Curso) universalManager.get(Curso.class, curso.getId());
			if ((curso.getMunicipioCursos() == null || curso.getMunicipioCursos().isEmpty())
					&& (curso.getUfCursos() == null || curso.getUfCursos().isEmpty())) {
				FacesMessagesUtil.addInfoMessage("Curso", "Curso não habilitado por região!");
				return;
			}
			Hibernate.initialize(curso.getMunicipioCursos());
			Hibernate.initialize(curso.getUfCursos());
			totalInscricoes = inscricaoCursoService.consultarInscricoes(curso, dentroRegiao).intValue();
			if (totalInscricoes != null && totalInscricoes > 0) {
				FacesMessagesUtil.addInfoMessage("Região do Curso", "Foram encotrado(s): " + totalInscricoes
						+ " inscrição(ões) com o órgão fora da região do curso!");
			} else {
				FacesMessagesUtil.addInfoMessage("Região do Curso", "Não há Inscrições fora da região do curso!");
				quantidadeVagas = null;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void homologarInscricoes() {
		try {
			if (totalInscricoes < quantidadeVagas) {
				FacesMessagesUtil.addErrorMessage("Homologação", "Quantidade de vagas por região maior que total de inscritos!");
				return;
			}
			curso = (Curso) universalManager.get(Curso.class, curso.getId());
			Hibernate.initialize(curso.getMunicipioCursos());
			Hibernate.initialize(curso.getUfCursos());
			List<InscricaoCurso> inscricoes = inscricaoCursoService
					.consultarInscricoesParaHomologacao(curso, quantidadeVagas, dentroRegiao);
			if (inscricoes != null && !inscricoes.isEmpty()) {
				for (InscricaoCurso inscricaoCurso : inscricoes) {

					StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()), loginBean.getModel(),
							new Status(Status.HOMOLOGADO), new Date());

					inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
					inscricaoCurso.getStatusInscricoes().add(statusInscricao);
					// Coloca o ano que a inscricao foi homologada.
					// Isso é feito para gerar o numero da inscricao.
					Integer anoAtual = Integer.valueOf(DateUtil.getDataHora(new Date(), "yyyy"));
					inscricaoCurso.setAnoHomologacao(anoAtual);

					cursoService.homologarCurso((InscricaoCurso) inscricaoCurso.clone());
					limparHomologacoes();
				}
				FacesMessagesUtil.addInfoMessage("Inscrições", "Homologadas " + ConstantesARQ.COM_SUCESSO);
			} else {
				FacesMessagesUtil.addErrorMessage("Inscrições", "Não há inscrições à serem homologadas!");
				quantidadeVagas = null;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void desfazerHomologacoes() {
		try {
			if (totalInscricoes < quantidadeVagas) {
				FacesMessagesUtil.addErrorMessage("Homologação", "Quantidade de vagas por região maior que total de inscritos!");
				return;
			}
			List<InscricaoCurso> inscricoes = inscricaoCursoService
					.consultarInscricoesParaHomologacao(curso, quantidadeVagas, dentroRegiao);
			if (inscricoes != null && !inscricoes.isEmpty()) {
				for (InscricaoCurso inscricaoCurso : inscricoes) {
					StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()), loginBean.getModel(),
							new Status(Status.AGUARDANDO_HOMOLOGACAO), new Date());
					universalManager.save(statusInscricao);
					inscricaoCurso.setUltimoStatus(new StatusInscricao(statusInscricao.getId()));
					universalManager.save(inscricaoCurso);
					limparHomologacoes();
				}
				FacesMessagesUtil.addInfoMessage("Inscrições", "Homologações desfeitas " + ConstantesARQ.COM_SUCESSO);
			} else {
				FacesMessagesUtil.addErrorMessage("Inscrições", "Não há inscrições para desfazer as homologações!");
				quantidadeVagas = null;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void limparHomologacoes() {
		quantidadeVagas = null;
	}

	@Override
	public void verificarAcesso() {

	}

	@Override
	public Curso createModel() {
		return new Curso();
	}

	@Override
	public String getQualifiedName() {
		return null;
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public HorarioService getHorarioService() {
		return horarioService;
	}

	public void setHorarioService(HorarioService horarioService) {
		this.horarioService = horarioService;
	}

	public List<Horario> getListaHorarios() {
		return listaHorarios;
	}

	public void setListaHorarios(List<Horario> listaHorarios) {
		this.listaHorarios = listaHorarios;
	}

	public Horario getHorario() {
		return horario;
	}

	public void setHorario(Horario horario) {
		this.horario = horario;
	}

	public Date getHoje() {
		return hoje;
	}

	public void setHoje(Date hoje) {
		this.hoje = hoje;
	}

	public Date getDataFimMinima() {
		return dataFimMinima;
	}

	public void setDataFimMinima(Date dataFimMinima) {
		this.dataFimMinima = dataFimMinima;
	}

	public Turma getTurma() {
		return turma;
	}

	public void setTurma(Turma turma) {
		this.turma = turma;
	}

	public List<Turma> getListaTurmas() {
		return listaTurmas;
	}

	public void setListaTurmas(List<Turma> listaTurmas) {
		this.listaTurmas = listaTurmas;
	}

	public List<Horario> getHorariosTurmas() {
		return horariosTurmas;
	}

	public void setHorariosTurmas(List<Horario> horariosTurmas) {
		this.horariosTurmas = horariosTurmas;
	}

	public Integer getIdHorarioTurma() {
		return idHorarioTurma;
	}

	public void setIdHorarioTurma(Integer idHorarioTurma) {
		this.idHorarioTurma = idHorarioTurma;
	}

	public TurmaService getTurmaService() {
		return turmaService;
	}

	public void setTurmaService(TurmaService turmaService) {
		this.turmaService = turmaService;
	}

	public Sala getSala() {
		return sala;
	}

	public void setSala(Sala sala) {
		this.sala = sala;
	}

	public List<Sala> getListaSalas() {
		return listaSalas;
	}

	public void setListaSalas(List<Sala> listaSalas) {
		this.listaSalas = listaSalas;
	}

	public SalaService getSalaService() {
		return salaService;
	}

	public void setSalaService(SalaService salaService) {
		this.salaService = salaService;
	}

	public Oficina getOficina() {
		return oficina;
	}

	public void setOficina(Oficina oficina) {
		this.oficina = oficina;
	}

	public List<Oficina> getListaOficinas() {
		return listaOficinas;
	}

	public void setListaOficinas(List<Oficina> listaOficinas) {
		this.listaOficinas = listaOficinas;
	}

	public OficinaService getOficinaService() {
		return oficinaService;
	}

	public void setOficinaService(OficinaService oficinaService) {
		this.oficinaService = oficinaService;
	}

	public List<Oficina> getListaOficinasSelecionadas() {
		return listaOficinasSelecionadas;
	}

	public void setListaOficinasSelecionadas(List<Oficina> listaOficinasSelecionadas) {
		this.listaOficinasSelecionadas = listaOficinasSelecionadas;
	}

	public PacoteService getPacoteService() {
		return pacoteService;
	}

	public void setPacoteService(PacoteService pacoteService) {
		this.pacoteService = pacoteService;
	}

	public Pacote getPacote() {
		return pacote;
	}

	public void setPacote(Pacote pacote) {
		this.pacote = pacote;
	}

	public List<PacoteOficina> getPacoteOficinas() {
		return pacoteOficinas;
	}

	public void setPacoteOficinas(List<PacoteOficina> pacoteOficinas) {
		this.pacoteOficinas = pacoteOficinas;
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

	public Oficina getOficinaPacoteExclusao() {
		return oficinaPacoteExclusao;
	}

	public void setOficinaPacoteExclusao(Oficina oficinaPacoteExclusao) {
		this.oficinaPacoteExclusao = oficinaPacoteExclusao;
	}

	public List<Pacote> getListaPacotes() {
		return listaPacotes;
	}

	public void setListaPacotes(List<Pacote> listaPacotes) {
		this.listaPacotes = listaPacotes;
	}

	public Integer getQuantidadeVagas() {
		return quantidadeVagas;
	}

	public void setQuantidadeVagas(Integer quantidadeVagas) {
		this.quantidadeVagas = quantidadeVagas;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}

	public Integer getTotalInscricoes() {
		return totalInscricoes;
	}

	public void setTotalInscricoes(Integer totalInscricoes) {
		this.totalInscricoes = totalInscricoes;
	}

	public boolean isDentroRegiao() {
		return dentroRegiao;
	}

	public void setDentroRegiao(boolean dentroRegiao) {
		this.dentroRegiao = dentroRegiao;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public Integer getActiveIndex() {
		return activeIndex;
	}

	public void setActiveIndex(Integer activeIndex) {
		this.activeIndex = activeIndex;
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

	public List<GradePacote> getGradePacotes() {
		return gradePacotes;
	}

	public void setGradePacotes(List<GradePacote> gradePacotes) {
		this.gradePacotes = gradePacotes;
	}

	public GradePacoteService getGradePacoteService() {
		return gradePacoteService;
	}

	public void setGradePacoteService(GradePacoteService gradePacoteService) {
		this.gradePacoteService = gradePacoteService;
	}

	public List<PacoteOficina> getGradePacoteOficinas() {
		return gradePacoteOficinas;
	}

	public void setGradePacoteOficinas(List<PacoteOficina> gradePacoteOficinas) {
		this.gradePacoteOficinas = gradePacoteOficinas;
	}

	public List<Horario> getGradePacoteHorarios() {
		return gradePacoteHorarios;
	}

	public void setGradePacoteHorarios(List<Horario> gradePacoteHorarios) {
		this.gradePacoteHorarios = gradePacoteHorarios;
	}

	public List<Turma> getGradePacoteTurmas() {
		return gradePacoteTurmas;
	}

	public void setGradePacoteTurmas(List<Turma> gradePacoteTurmas) {
		this.gradePacoteTurmas = gradePacoteTurmas;
	}

	public Integer getIdTurma() {
		return idTurma;
	}

	public void setIdTurma(Integer idTurma) {
		this.idTurma = idTurma;
	}

	public GradePacote getGradePacote() {
		return gradePacote;
	}

	public void setGradePacote(GradePacote gradePacote) {
		this.gradePacote = gradePacote;
	}

	public Integer getIdHorario() {
		return idHorario;
	}

	public void setIdHorario(Integer idHorario) {
		this.idHorario = idHorario;
	}

	public Integer getIdOficina() {
		return idOficina;
	}

	public void setIdOficina(Integer idOficina) {
		this.idOficina = idOficina;
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

	public Integer getIdGradeOficinaTurma() {
		return idGradeOficinaTurma;
	}

	public void setIdGradeOficinaTurma(Integer idGradeOficinaTurma) {
		this.idGradeOficinaTurma = idGradeOficinaTurma;
	}

	public List<Turma> getGradeOficinaTurmas() {
		return gradeOficinaTurmas;
	}

	public void setGradeOficinaTurmas(List<Turma> gradeOficinaTurmas) {
		this.gradeOficinaTurmas = gradeOficinaTurmas;
	}

	public boolean isMostrarCampos() {
		return mostrarCampos;
	}

	public void setMostrarCampos(boolean mostrarCampos) {
		this.mostrarCampos = mostrarCampos;
	}

	public List<Oficina> getOficinas() {
		return oficinas;
	}

	public void setOficinas(List<Oficina> oficinas) {
		this.oficinas = oficinas;
	}

	public GradeOficina getGradeOficina() {
		return gradeOficina;
	}

	public void setGradeOficina(GradeOficina gradeOficina) {
		this.gradeOficina = gradeOficina;
	}

	public GradeOficinaService getGradeOficinaService() {
		return gradeOficinaService;
	}

	public void setGradeOficinaService(GradeOficinaService gradeOficinaService) {
		this.gradeOficinaService = gradeOficinaService;
	}

	public List<GradeOficina> getGradeOficinas() {
		return gradeOficinas;
	}

	public void setGradeOficinas(List<GradeOficina> gradeOficinas) {
		this.gradeOficinas = gradeOficinas;
	}

	public List<ProfessorEvento> getProfessores() {
		return professores;
	}

	public void setProfessores(List<ProfessorEvento> professores) {
		this.professores = professores;
	}

	public ProfessorEventoService getProfessorEventoService() {
		return professorEventoService;
	}

	public void setProfessorEventoService(ProfessorEventoService professorEventoService) {
		this.professorEventoService = professorEventoService;
	}

	public ProfessorEvento getProfessor() {
		return professor;
	}

	public void setProfessor(ProfessorEvento professor) {
		this.professor = professor;
	}

	public List<Candidato> getCandidatosProfessores() {
		return candidatosProfessores;
	}

	public void setCandidatosProfessores(List<Candidato> candidatosProfessores) {
		this.candidatosProfessores = candidatosProfessores;
	}

	public CandidatoService getCandidatoService() {
		return candidatoService;
	}

	public void setCandidatoService(CandidatoService candidatoService) {
		this.candidatoService = candidatoService;
	}

	public Candidato getCandidato() {
		return candidato;
	}

	public void setCandidato(Candidato candidato) {
		this.candidato = candidato;
	}

	public Integer getIdProfessorPacoteOficina() {
		return idProfessorPacoteOficina;
	}

	public void setIdProfessorPacoteOficina(Integer idProfessorPacoteOficina) {
		this.idProfessorPacoteOficina = idProfessorPacoteOficina;
	}

	public boolean isMostrarDialogAdicionarOficinasPacote() {
		return mostrarDialogAdicionarOficinasPacote;
	}

	public void setMostrarDialogAdicionarOficinasPacote(boolean mostrarDialogAdicionarOficinasPacote) {
		this.mostrarDialogAdicionarOficinasPacote = mostrarDialogAdicionarOficinasPacote;
	}

	public Curso getCursoClone() {
		return cursoClone;
	}

	public void setCursoClone(Curso cursoClone) {
		this.cursoClone = cursoClone;
	}

	public boolean isMostrarTotalCargaHoraria() {
		return mostrarTotalCargaHoraria;
	}

	public void setMostrarTotalCargaHoraria(boolean mostrarTotalCargaHoraria) {
		this.mostrarTotalCargaHoraria = mostrarTotalCargaHoraria;
	}

	public Integer getTotalComNovoRegistro() {
		return totalComNovoRegistro;
	}

	public void setTotalComNovoRegistro(Integer totalComNovoRegistro) {
		this.totalComNovoRegistro = totalComNovoRegistro;
	}

	public SelecaoPacoteService getSelecaoPacoteService() {
		return selecaoPacoteService;
	}

	public void setSelecaoPacoteService(SelecaoPacoteService selecaoPacoteService) {
		this.selecaoPacoteService = selecaoPacoteService;
	}
}
