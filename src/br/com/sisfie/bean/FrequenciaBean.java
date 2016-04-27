package br.com.sisfie.bean;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import org.primefaces.event.FileUploadEvent;

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
import br.com.sisfie.entidade.Turno;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.FrequenciaService;
import br.com.sisfie.service.GradeOficinaService;
import br.com.sisfie.service.HorarioService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.TurmaService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.ImagemUtil;

/**
 * @author Wesley Marra
 *
 */
@ManagedBean(name = "frequenciaBean")
@ViewScoped
public class FrequenciaBean extends PaginableBean<Frequencia> {

	private static final long serialVersionUID = 1L;

	private static final String APROVADO = "A";
	private static final String REPROVADO = "R";

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

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
	private Turno turno;
	private Horario horario;
	private Frequencia frequencia;
	private InscricaoGrade inscricaoGrade;
	private InscricaoCurso inscricaoCurso;
	private List<Turma> listaTurma;
	private List<Horario> listaHorario;
	private List<Turno> listaTurno;
	private List<Frequencia> listaFrequencia;
	private List<Frequencia> frequencias;
	private List<InscricaoCurso> listaInscricoesAprovadas;
	private List<InscricaoCurso> listaInscricoesReprovadas;
	private List<Curso> listaArquivosFrequencia;
	private Integer quantidadeInscritos;
	private boolean exibirTurma;
	private boolean exibirHorario;
	private boolean exibirTurno;
	private boolean exibirInscricao;
	private boolean exibirBotaoFinalizar;
	private boolean exibirConteudo;

	public FrequenciaBean() {
		curso = new Curso();
		turma = new Turma();
		turno = new Turno();
		horario = new Horario();
		inscricaoGrade = new InscricaoGrade();
		inscricaoCurso = new InscricaoCurso();
		listaTurma = new ArrayList<Turma>();
		listaHorario = new ArrayList<Horario>();
		listaTurno = new ArrayList<Turno>();
		listaFrequencia = new ArrayList<Frequencia>();
		listaInscricoesAprovadas = new ArrayList<>();
		listaInscricoesReprovadas = new ArrayList<>();
		listaArquivosFrequencia = new ArrayList<>();
		frequencia = new Frequencia();
		frequencias = new ArrayList<>();
		getModel().setInscricaoCurso(new InscricaoCurso());
	}

	public void importarListaFrequencia(FileUploadEvent event) {
		try {
			String fileName = ImagemUtil.criarNomeArquivo(event.getFile().getFileName(), loginBean.getModel());
			fileName = ImagemUtil.verificarTamanhoNomeArquivo(fileName);
			curso.setNomeArquivoFrequencia(fileName);

			String os = System.getProperty("os.name");
			/* Descobre se linux ou windows */
			if (os.contains("win") || os.trim().toLowerCase().contains("windows") || os.trim().toLowerCase().contains("win")) {
				curso.setUrlArquivoFrequencia(Constantes.PATH_IMG_WINDOWS + fileName);
			} else {
				curso.setUrlArquivoFrequencia(Constantes.PATH_IMG_LINUX + fileName);
			}

			// Força a criação do arquivo no file system
			FileOutputStream fos = new FileOutputStream(new File(curso.getUrlArquivoFrequencia()));
			fos.write(event.getFile().getContents());
			fos.close();

			universalManager.save(curso);
			listaArquivosFrequencia = new ArrayList<>();
			listaArquivosFrequencia.add(curso);
			FacesMessagesUtil.addInfoMessage("", "Arquivo salvo com sucesso!");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void baixarArquivoFrequencia(Integer id, String tipo) {
		try {
			String url = Constantes.URL_COMPROVANTE + "loadImagemBD?idImagemDownload=" + id + "&tipo=" + tipo;
			FacesContext.getCurrentInstance().getExternalContext().redirect(url);
		} catch (IOException e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void deleteArquivoFrequencia(Curso cursoSelecionado) {
		try {
			listaArquivosFrequencia.remove(cursoSelecionado);
			this.curso.setNomeArquivoFrequencia("");
			this.curso.setUrlArquivoFrequencia("");
			universalManager.save(this.curso);
			FacesMessagesUtil.addInfoMessage("Arquivo de Frequência ", " excluído com sucesso!");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void reprovarInscricao(InscricaoCurso inscricaoCurso) {
		try {
			listaInscricoesAprovadas.remove(inscricaoCurso);
			listaInscricoesReprovadas.add(inscricaoCurso);
			inscricaoCurso.setStatus(REPROVADO);
			universalManager.save(inscricaoCurso);
			FacesMessagesUtil.addInfoMessage("", "Inscrição reprovada.");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void aprovarInscricao(InscricaoCurso inscricaoCurso) {
		try {
			listaInscricoesReprovadas.remove(inscricaoCurso);
			listaInscricoesAprovadas.add(inscricaoCurso);
			inscricaoCurso.setStatus(APROVADO);
			universalManager.save(inscricaoCurso);
			FacesMessagesUtil.addInfoMessage("", "Inscrição aprovada.");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void visualizarFrequencia(InscricaoCurso inscricaoCurso) {
		frequencias = new ArrayList<>(inscricaoCurso.getFrequencias());
		Collections.sort(frequencias, new Comparator<Frequencia>() {
			@Override
			public int compare(Frequencia o1, Frequencia o2) {
				return o1.getHorarioEntrada().compareTo(o2.getHorarioEntrada());
			}
		});
	}

	public void carregarListas() {
		exibirConteudo = true;
		listaInscricoesAprovadas = new ArrayList<>();
		listaInscricoesReprovadas = new ArrayList<>();
		listaArquivosFrequencia = new ArrayList<>();

		if (curso.getNomeArquivoFrequencia() != null && !curso.getNomeArquivoFrequencia().isEmpty()) {
			listaArquivosFrequencia.add(curso);
		}

		int cargaHorariaCurso = 0;

		if (curso.getFlgPossuiOficina()) {
			cargaHorariaCurso = curso.getCargaHoraria();
		} else {
			Calendar inicioCurso = Calendar.getInstance();
			inicioCurso.setTime(curso.getDtRealizacaoInicio());

			Calendar fimCurso = Calendar.getInstance();
			fimCurso.setTime(curso.getDtRealizacaoFim());

			int qtdDiasCurso = fimCurso.get(Calendar.DAY_OF_YEAR) - inicioCurso.get(Calendar.DAY_OF_YEAR);
			cargaHorariaCurso = qtdDiasCurso * 8;

			if (curso.getTurno() != null && curso.getTurno().getId() != null && !curso.getTurno().getId().equals(Turno.AMBOS)) {
				cargaHorariaCurso /= 2;
			}
		}

		if (curso.getPorcentagem() == null) {
			FacesMessagesUtil.addErrorMessage("",
					"É necessário informar um percentual de frequência para aprovação na edição do curso.");
			return;
		}

		Integer porcentagemAprovacao = cargaHorariaCurso * curso.getPorcentagem() / 100;

		List<InscricaoCurso> listaCandidatoConfirmados = cursoService.carregarListaCandidatoConfirmados(curso);
		for (InscricaoCurso inscricaoCurso : listaCandidatoConfirmados) {

			long diferencaEmMinutos = 0;
			for (Frequencia frequencia : inscricaoCurso.getFrequencias()) {
				diferencaEmMinutos += ((frequencia.getHorarioSaida().getTime() - frequencia.getHorarioEntrada().getTime())
						/ (60 * 1000)) + 1;
			}

			long horas = diferencaEmMinutos / 60;
			long minutosRestantes = diferencaEmMinutos % 60;
			inscricaoCurso.setTotalFrequencia(String.format("%d:%02d", horas, minutosRestantes));
			
			// Caso tenha alguma aprovação ou reprovação 
			if (inscricaoCurso.getStatus() != null) {
				inscricaoCurso.setTotalFrequencia(String.format("%s (%s)", inscricaoCurso.getTotalFrequencia(), "Alterado pelo gestor"));
				if (inscricaoCurso.getStatus().equals(APROVADO)) {
					listaInscricoesAprovadas.add(inscricaoCurso);
				} else if (inscricaoCurso.getStatus().equals(REPROVADO)) {
					listaInscricoesReprovadas.add(inscricaoCurso);
				}
				continue;
			}

			if (horas >= porcentagemAprovacao) {
				listaInscricoesAprovadas.add(inscricaoCurso);
			} else {
				listaInscricoesReprovadas.add(inscricaoCurso);
			}
		}
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

	@SuppressWarnings("unchecked")
	public void verificarExistenciaTurmasHorarios() {
		limparHorariosTurnos();
		exibirTurma = Boolean.FALSE;
		exibirHorario = Boolean.FALSE;
		exibirTurno = Boolean.FALSE;
		exibirBotaoFinalizar = Boolean.FALSE;
		exibirInscricao = Boolean.TRUE;

		if (curso != null && curso.getId() != null) {
			if (curso.getTurmas() != null && !curso.getTurmas().isEmpty()) {
				listaTurma = turmaService.listarTurmas(curso.getId());
				exibirTurma = Boolean.TRUE;
				exibirInscricao = Boolean.FALSE;
				if (curso.getFlgPossuiOficina()) {
					listaHorario = horarioService.listarHorarios(curso.getId());
					exibirHorario = Boolean.TRUE;
				} else {
					listaTurno = universalManager.getAll(Turno.class);
					exibirTurno = Boolean.TRUE;
				}
				quantidadeInscritos = cursoService.retornarQuantidadeInscritos(curso);
			} else {
				exibirBotaoFinalizar = Boolean.TRUE;
			}
		}
	}

	private void limparHorariosTurnos() {
		horario = new Horario();
		turno = new Turno();
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
			carregarListaFrequencia(inscricaoGrade.getGradeOficina(), inscricaoCurso);
			limparCampos();
			FacesMessagesUtil.addInfoMessage("", "Registro realizado com sucesso.");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void carregarListaFrequencia(GradeOficina gradeOficina, InscricaoCurso inscricaoCurso) throws Exception {
		if (curso.getFlgPossuiOficina()) {
			listaFrequencia = frequenciaService.listarFrequencias(gradeOficina.getId());
		} else {
			listaFrequencia = frequenciaService.listarFrequenciasSemOficina(inscricaoCurso);
		}
	}

	private void limparCampos() {
		inscricaoCurso = new InscricaoCurso();
		inscricaoGrade = new InscricaoGrade();
		getModel().setInscricaoCurso(new InscricaoCurso());
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
			frequenciaNova.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));
			if (curso.getFlgPossuiOficina()) {
				frequenciaNova.setGradeOficina(new GradeOficina(inscricaoGrade.getGradeOficina().getId()));
			}
			frequenciaService.salvar(frequenciaNova);
		}
	}

	public void finalizarFrequencia() {
		try {
			List<Frequencia> listaFrequenciaEmAberto = new ArrayList<Frequencia>();
			GradeOficina gradeOficina = new GradeOficina();
			InscricaoCurso inscricaoCurso = new InscricaoCurso();

			if (curso.getFlgPossuiOficina()) {
				gradeOficina = gradeOficinaService.recupararGradeOficina(curso.getId(), turma.getId(), horario.getId());
				if (gradeOficina != null && gradeOficina.getId() != null) {
					listaFrequenciaEmAberto = frequenciaService.pesquisarFrequenciasAbertas(gradeOficina.getId());
				}
			} else {
				inscricaoCurso = inscricaoCursoService.recuperarInscricao(curso.getId(), turma.getId(), turno.getId());
				listaFrequenciaEmAberto = frequenciaService.pesquisarFrequenciasAbertasSemOficina(inscricaoCurso.getId());
			}

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
			carregarListaFrequencia(gradeOficina, inscricaoCurso);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void pesquisar() {
		try {
			if (!validarCampos()) {
				return;
			}
			if (inscricaoCurso.getCurso().getFlgPossuiOficina() && !validarCredenciamento()) {
				return;
			}
			carregarListaFrequencia(inscricaoGrade.getGradeOficina(), inscricaoCurso);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@SuppressWarnings("unchecked")
	private boolean validarCredenciamento() throws Exception {
		Credenciamento credenciamento = new Credenciamento();
		credenciamento.setNumInscricao(getModel().getInscricaoCurso().getInscricao());
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
					if (turno == null || turno.getId() == null || turno.getId() == 0) {
						FacesMessagesUtil.addErrorMessage("", "Nenhuma Turno selecionada.");
						return Boolean.FALSE;
					}
				}
			}
		}

		if (getModel() != null && getModel().getInscricaoCurso() != null && getModel().getInscricaoCurso().getInscricao() != null
				&& !getModel().getInscricaoCurso().getInscricao().isEmpty()) {
			if (curso.getFlgPossuiOficina()) {
				inscricaoCurso = inscricaoCursoService.recupararInscricao(getModel().getInscricaoCurso().getInscricao(),
						curso.getId(), turma.getId(), horario.getId());
				inscricaoGrade = inscricaoCursoService.recupararInscricaoGrade(getModel().getInscricaoCurso().getInscricao(),
						curso.getId(), turma.getId(), horario.getId());
			} else {
				if (curso.getTurmas() != null && !curso.getTurmas().isEmpty()) {
					inscricaoCurso = inscricaoCursoService.recupararInscricaoSemOficina(
							getModel().getInscricaoCurso().getInscricao(), curso.getId(), turma.getId(), turno.getId());
				} else {
					inscricaoCurso = inscricaoCursoService.recupararInscricaoSemOficina(
							getModel().getInscricaoCurso().getInscricao(), curso.getId(), null, null);
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

	public List<Turno> getListaTurno() {
		return listaTurno;
	}

	public void setListaTurno(List<Turno> listaTurno) {
		this.listaTurno = listaTurno;
	}

	public boolean isExibirTurno() {
		return exibirTurno;
	}

	public void setExibirTurno(boolean exibirTurno) {
		this.exibirTurno = exibirTurno;
	}

	public Turno getTurno() {
		return turno;
	}

	public void setTurno(Turno turno) {
		this.turno = turno;
	}

	public List<InscricaoCurso> getListaInscricoesAprovadas() {
		return listaInscricoesAprovadas;
	}

	public void setListaInscricoesAprovadas(List<InscricaoCurso> listaInscricoesAprovadas) {
		this.listaInscricoesAprovadas = listaInscricoesAprovadas;
	}

	public List<InscricaoCurso> getListaInscricoesReprovadas() {
		return listaInscricoesReprovadas;
	}

	public void setListaInscricoesReprovadas(List<InscricaoCurso> listaInscricoesReprovadas) {
		this.listaInscricoesReprovadas = listaInscricoesReprovadas;
	}

	public List<Frequencia> getFrequencias() {
		return frequencias;
	}

	public void setFrequencias(List<Frequencia> frequencias) {
		this.frequencias = frequencias;
	}

	public boolean isExibirConteudo() {
		return exibirConteudo;
	}

	public void setExibirConteudo(boolean exibirConteudo) {
		this.exibirConteudo = exibirConteudo;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public List<Curso> getListaArquivosFrequencia() {
		return listaArquivosFrequencia;
	}

	public void setListaArquivosFrequencia(List<Curso> listaArquivosFrequencia) {
		this.listaArquivosFrequencia = listaArquivosFrequencia;
	}
}
