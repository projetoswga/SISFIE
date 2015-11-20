package br.com.sisfie.bean;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Credenciamento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.FrequenciaService;
import br.com.sisfie.service.GradeOficinaService;
import br.com.sisfie.service.HorarioService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.TurmaService;

/**
 * @author Wesley Marra
 *
 */
@ManagedBean(name = "registrarFrequenciaBean")
@ViewScoped
public class RegistrarFrequenciaBean extends PaginableBean<Frequencia> {

	private static final long serialVersionUID = 1L;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{turmaService}")
	protected TurmaService turmaService;

	@ManagedProperty(value = "#{horarioService}")
	protected HorarioService horarioService;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	@ManagedProperty(value = "#{frequenciaService}")
	protected FrequenciaService frequenciaService;
	
	@ManagedProperty(value = "#{gradeOficinaService}")
	protected GradeOficinaService gradeOficinaService;

	private Curso curso;
	private Turma turma;
	private Horario horario;
	private Frequencia frequencia;
	private InscricaoGrade inscricaoGrade;
	private InscricaoCurso inscricaoCurso;
	private List<Turma> listaTurma;
	private List<Horario> listaHorario;
	private List<Frequencia> listaFrequencia;
	private Integer quantidadeInscritos;
	private boolean exibirTurma;
	private boolean exibirHorario;
	private boolean exibirInscricao;
	private boolean exibirBotaoFinalizar;

	public RegistrarFrequenciaBean() {
		curso = new Curso();
		turma = new Turma();
		horario = new Horario();
		inscricaoGrade = new InscricaoGrade();
		inscricaoCurso = new InscricaoCurso();
		listaTurma = new ArrayList<Turma>();
		listaHorario = new ArrayList<Horario>();
		listaFrequencia = new ArrayList<Frequencia>();
		frequencia = new Frequencia();
	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		Curso curso = new Curso();
		curso.setTitulo(query);
		try {
			sugestoes = cursoService.recuperarCursos(curso);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return sugestoes;
	}

	public void verificarExistenciaTurmasHorarios() {
		exibirTurma = Boolean.FALSE;
		exibirHorario = Boolean.FALSE;
		exibirInscricao = Boolean.TRUE;

		if (curso != null && curso.getId() != null && curso.getTurmas() != null && !curso.getTurmas().isEmpty()) {
			listaTurma = turmaService.listarTurmas(curso.getId());
			exibirTurma = Boolean.TRUE;
			exibirInscricao = Boolean.FALSE;
			if (curso.getFlgPossuiOficina()) {
				listaHorario = horarioService.listarHorarios(curso.getId());
				exibirHorario = Boolean.TRUE;
			}
			quantidadeInscritos = cursoService.retornarQuantidadeInscritos(curso);
		}
	}

	public void renderizarCampoInscricaoVisualizarBotaoFinalizar() {
		exibirInscricao = Boolean.TRUE;
		visualizaBotaoFinalizar();
	}

	private void visualizaBotaoFinalizar() {
		exibirBotaoFinalizar = Boolean.FALSE;
		if (curso != null && curso.getId() != null) {
			/**
			 * Caso o curso seja composto por oficina, para visualizar o botão finalizar é necessário que o usuario tenha selecionado uma
			 * turma e um horário.
			 */
			if (curso.getFlgPossuiOficina()) {
				if (turma != null && turma.getId() != null) {
					if (horario != null && horario.getId() != null) {
						exibirBotaoFinalizar = Boolean.TRUE;
					}
				}
			} else {
				/**
				 * Se o curso não for composto por oficina mas tenha turmas, para visualizar o botão finalizar é necessário que o usuario
				 * tenha selecionado uma turma.
				 */
				if (curso.getTurmas() != null && !curso.getTurmas().isEmpty()) {
					if (turma != null && turma.getId() != null) {
						exibirBotaoFinalizar = Boolean.TRUE;
					}
					/**
					 * Senão basta ter selecionado um curso.
					 */
				} else {
					exibirBotaoFinalizar = Boolean.TRUE;
				}
			}
		}
	}

	public void registrar() {
		try {
			frequencia = frequenciaService.recuperarUltimaFrequencia(inscricaoCurso.getInscricao());
			verificandoComoSeraRegistradoFrequencia();
			listaFrequencia = frequenciaService.listarFrequencias(inscricaoGrade.getGradeOficina().getId());
			limparCampos();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void limparCampos() {
		inscricaoCurso = new InscricaoCurso();
		inscricaoGrade = new InscricaoGrade();
		getModel().setNumIncricao(null);
	}

	private void verificandoComoSeraRegistradoFrequencia() throws Exception {
		if (frequencia != null && frequencia.getId() != null) {
			// Quando não registrou a saída, somente altera o registro.
			if (frequencia.getHorarioSaida() == null) {
				frequencia.setHorarioSaida(new Timestamp(new Date().getTime()));
				frequenciaService.salvar((Frequencia) frequencia.clone());
			} else {
				// Se já foi registrado a saída é necessário criar um novo registro.
				Frequencia frequenciaClone = (Frequencia) frequencia.clone();
				frequenciaClone.setId(null);
				frequenciaClone.setHorarioEntrada(new Timestamp(new Date().getTime()));
				frequenciaClone.setHorarioSaida(null);
				frequenciaService.salvar(frequenciaClone);
			}
		} else {
			// Caso não exita nenhum registro ainda.
			Frequencia frequenciaNova = new Frequencia();
			frequenciaNova.setHorarioEntrada(new Timestamp(new Date().getTime()));
			frequenciaNova.setHorarioSaida(null);
			frequenciaNova.setNumIncricao(inscricaoCurso.getInscricao());
			frequenciaNova.setGradeOficina(new GradeOficina(inscricaoGrade.getGradeOficina().getId()));
			frequenciaService.salvar(frequenciaNova);
		}
	}

	public void finalizarFrequencia() {
		try {
			if (curso.getFlgPossuiOficina()) {
				
				GradeOficina gradeOficina = gradeOficinaService.recupararGradeOficina(curso.getId(), turma.getId(),
						horario.getId());
				if (gradeOficina != null && gradeOficina.getId() != null) {
					
					List<Frequencia> listaFrequenciaEmAberto = frequenciaService
							.pesquisarFrequenciasAbertas(gradeOficina.getId());

					if (listaFrequenciaEmAberto != null && !listaFrequenciaEmAberto.isEmpty()) {
						for (Frequencia frequencia : listaFrequenciaEmAberto) {
							Frequencia frequenciaClone = (Frequencia) frequencia.clone();
							frequenciaClone.setHorarioSaida(new Timestamp(new Date().getTime()));
							frequenciaService.salvar(frequenciaClone);
						}
						FacesMessagesUtil.addInfoMessage("", "Frequência da turma finalizada com sucesso.");
					} else {
						FacesMessagesUtil.addErrorMessage("", "Não há inscrições para serem finalizadas.");
					}
				}
			} else {
				// TODO: Implementar quando não for curso composto por oficina. Porém terá que rever a modelagem
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void pesquisar() {
		try {
			if (!validarCampos()) {
				return;
			}
			if (!validarCredenciamento()) {
				return;
			}
			listaFrequencia = frequenciaService.listarFrequencias(inscricaoGrade.getGradeOficina().getId());
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@SuppressWarnings("unchecked")
	private boolean validarCredenciamento() throws Exception {
		Credenciamento credenciamento = new Credenciamento();
		credenciamento.setNumInscricao(getModel().getNumIncricao());
		List<Credenciamento> listaConsulta = universalManager.listBy(credenciamento);
		if (listaConsulta == null || listaConsulta.isEmpty()) {
			FacesMessagesUtil.addErrorMessage("", "Credenciamento não realizado para essa inscrição.");
			return Boolean.FALSE;
		}
		return Boolean.TRUE;
	}

	private boolean validarCampos() throws Exception {
		inscricaoCurso = new InscricaoCurso();

		if (curso == null || curso.getId() == null) {
			FacesMessagesUtil.addErrorMessage("", "Nenhum curso selecionado.");
			return Boolean.FALSE;
		} else {
			if (curso.getFlgPossuiOficina()) {
				if (turma == null || turma.getId() == null || turma.getId() == 0) {
					FacesMessagesUtil.addErrorMessage("", "Nenhuma Turma selecionada.");
					return Boolean.FALSE;
				}
				if (horario == null || horario.getId() == null || horario.getId() == 0) {
					FacesMessagesUtil.addErrorMessage("", "Nenhum Horário selecionado.");
					return Boolean.FALSE;
				}
			} else {
				if (curso.getTurmas() != null && !curso.getTurmas().isEmpty()) {
					if (turma == null || turma.getId() == null || turma.getId() == 0) {
						FacesMessagesUtil.addErrorMessage("", "Nenhuma Turma selecionada.");
						return Boolean.FALSE;
					}
				}
			}
		}

		if (getModel() != null && getModel().getNumIncricao() != null && !getModel().getNumIncricao().isEmpty()) {
			if (curso.getFlgPossuiOficina()) {
				inscricaoCurso = inscricaoCursoService.recupararInscricao(getModel().getNumIncricao(), curso.getId(),
						turma.getId(), horario.getId());
				inscricaoGrade = inscricaoCursoService.recupararInscricaoGrade(getModel().getNumIncricao(), curso.getId(),
						turma.getId(), horario.getId());
			} else {
				if (curso.getTurmas() != null && !curso.getTurmas().isEmpty()) {
					inscricaoCurso = inscricaoCursoService.recupararInscricao(getModel().getNumIncricao(), curso.getId(),
							turma.getId(), null);
				} else {
					inscricaoCurso = inscricaoCursoService.recupararInscricao(getModel().getNumIncricao(), curso.getId(), null,
							null);
				}
			}
			if (inscricaoCurso == null || inscricaoCurso.getId() == null || inscricaoCurso.getId() == 0) {
				FacesMessagesUtil.addErrorMessage("", "Inscrição não encontrada conforme dados informados.");
				return Boolean.FALSE;
			}
		} else {
			FacesMessagesUtil.addErrorMessage("", "Nenhuma Inscrição informada.");
			return Boolean.FALSE;
		}

		return Boolean.TRUE;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public Turma getTurma() {
		return turma;
	}

	public void setTurma(Turma turma) {
		this.turma = turma;
	}

	public Horario getHorario() {
		return horario;
	}

	public void setHorario(Horario horario) {
		this.horario = horario;
	}

	public InscricaoGrade getInscricaoGrade() {
		return inscricaoGrade;
	}

	public void setInscricaoGrade(InscricaoGrade inscricaoGrade) {
		this.inscricaoGrade = inscricaoGrade;
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public List<Turma> getListaTurma() {
		return listaTurma;
	}

	public void setListaTurma(List<Turma> listaTurma) {
		this.listaTurma = listaTurma;
	}

	public List<Horario> getListaHorario() {
		return listaHorario;
	}

	public void setListaHorario(List<Horario> listaHorario) {
		this.listaHorario = listaHorario;
	}

	public boolean isExibirTurma() {
		return exibirTurma;
	}

	public void setExibirTurma(boolean exibirTurma) {
		this.exibirTurma = exibirTurma;
	}

	public boolean isExibirHorario() {
		return exibirHorario;
	}

	public void setExibirHorario(boolean exibirHorario) {
		this.exibirHorario = exibirHorario;
	}

	public boolean isExibirInscricao() {
		return exibirInscricao;
	}

	public void setExibirInscricao(boolean exibirInscricao) {
		this.exibirInscricao = exibirInscricao;
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {
	}

	@Override
	public Frequencia createModel() {
		return new Frequencia();
	}

	@Override
	public String getQualifiedName() {
		return "Frequência";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public TurmaService getTurmaService() {
		return turmaService;
	}

	public void setTurmaService(TurmaService turmaService) {
		this.turmaService = turmaService;
	}

	public Integer getQuantidadeInscritos() {
		return quantidadeInscritos;
	}

	public void setQuantidadeInscritos(Integer quantidadeInscritos) {
		this.quantidadeInscritos = quantidadeInscritos;
	}

	public HorarioService getHorarioService() {
		return horarioService;
	}

	public void setHorarioService(HorarioService horarioService) {
		this.horarioService = horarioService;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}

	public List<Frequencia> getListaFrequencia() {
		return listaFrequencia;
	}

	public void setListaFrequencia(List<Frequencia> listaFrequencia) {
		this.listaFrequencia = listaFrequencia;
	}

	public FrequenciaService getFrequenciaService() {
		return frequenciaService;
	}

	public void setFrequenciaService(FrequenciaService frequenciaService) {
		this.frequenciaService = frequenciaService;
	}

	public Frequencia getFrequencia() {
		return frequencia;
	}

	public void setFrequencia(Frequencia frequencia) {
		this.frequencia = frequencia;
	}

	public boolean isExibirBotaoFinalizar() {
		return exibirBotaoFinalizar;
	}

	public void setExibirBotaoFinalizar(boolean exibirBotaoFinalizar) {
		this.exibirBotaoFinalizar = exibirBotaoFinalizar;
	}

	public GradeOficinaService getGradeOficinaService() {
		return gradeOficinaService;
	}

	public void setGradeOficinaService(GradeOficinaService gradeOficinaService) {
		this.gradeOficinaService = gradeOficinaService;
	}
}
