package br.com.sisfie.bean;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.Reader;
import java.io.Writer;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;

import org.hibernate.Hibernate;
import org.primefaces.context.RequestContext;
import org.primefaces.event.FileUploadEvent;
import org.primefaces.model.DefaultStreamedContent;
import org.primefaces.model.StreamedContent;
import org.primefaces.model.UploadedFile;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.DateUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.dataModel.InscricaoCursoDataModel;
import br.com.sisfie.dto.InscricaoGradeDTO;
import br.com.sisfie.dto.OficinaInscritosDTO;
import br.com.sisfie.entidade.CampoPreenchimento;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.CandidatoComplemento;
import br.com.sisfie.entidade.CandidatoPreenchimento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.Homologacao;
import br.com.sisfie.entidade.HomologacaoCurso;
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.InscricaoComprovante;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoDocumento;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.InscricaoInfoComplementar;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Orgao;
import br.com.sisfie.entidade.Situacao;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusCurso;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.service.CandidatoService;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.DistribuirService;
import br.com.sisfie.service.FrequenciaService;
import br.com.sisfie.service.GradeOficinaService;
import br.com.sisfie.service.HorarioService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.OrgaoService;
import br.com.sisfie.util.CnpjUtil;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.ImagemUtil;

import com.googlecode.jcsv.reader.CSVReader;
import com.googlecode.jcsv.reader.internal.CSVReaderBuilder;
import com.googlecode.jcsv.writer.CSVWriter;
import com.googlecode.jcsv.writer.internal.CSVWriterBuilder;

@ManagedBean(name = "gerenciarCursoBean")
@ViewScoped
public class GerenciarCursoBean extends BaseBean<Curso> {

	private static final long serialVersionUID = -507533115478637909L;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{distribuirService}")
	protected DistribuirService distribuirService;

	@ManagedProperty(value = "#{horarioService}")
	protected HorarioService horarioService;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	@ManagedProperty(value = "#{OrgaoService}")
	protected OrgaoService orgaoService;

	@ManagedProperty(value = "#{candidatoService}")
	protected CandidatoService candidatoService;

	@ManagedProperty(value = "#{frequenciaService}")
	protected FrequenciaService frequenciaService;

	@ManagedProperty(value = "#{gradeOficinaService}")
	protected GradeOficinaService gradeOficinaService;

	private Curso curso;

	private InscricaoCurso inscricaoCurso;
	private String textoInvalidarComprovante;
	private String textoCancelar;

	private CandidatoComplemento candidatoComplemento;

	private List<InscricaoCurso> listaCandidatoPendentes = new ArrayList<InscricaoCurso>();
	private List<InscricaoCurso> listaEspera = new ArrayList<InscricaoCurso>();
	private List<InscricaoCurso> listaInstrutores = new ArrayList<>();
	private InscricaoCursoDataModel listaCandidatosConfirmados;
	private InscricaoCurso[] inscricoesCursoConfirmados;
	private List<Turma> turmas;
	private Integer idTurma;
	private Integer capacidadeMaximaInscritos;
	private Integer vagasParceiro;

	private boolean mostrarBotaoSalvarInfoComplementar;
	private boolean mostarFinalizarInscricao;
	private boolean desabilitarCurso;
	private boolean cursoFinalizado;
	private Integer vagasPreencidas;
	private Integer vagasAbertas;
	private boolean mostrarInformacaoPagamento;
	private InscricaoInfoComplementar inscricaoInfoComplementar;
	private InscricaoComprovante comprovanteExcluir;
	private InscricaoDocumento documentoExcluir;
	private Integer totalPendentes;
	private Integer totalConfirmados;
	private Integer totalEspera;
	private Date dtInscricaoFim;
	private boolean mostrarPanelVisualizacao;
	private List<InscricaoGradeDTO> listaInscricaoGradeDTOs;
	private List<GradeOficina> listaGradeOficinas;
	private boolean mostrarPanelVisualizacaoInscricoesOficinas;
	private List<OficinaInscritosDTO> listaOficinaInscritosDTOs;
	private Integer quantidadeVagas;
	private Integer totalInscricoes;
	private boolean dentroRegiao;
	private boolean mostrarPanelAceitacoes;
	private List<SelectItem> listaSituacaoCandidatos;
	private Integer idSituacaoCandidatoSelecionado;
	private Integer idOpcaoRegiao;
	private boolean mostrarTextoInscricao;
	private Candidato candidato;
	private List<Candidato> listaCandidatos;
	private InscricaoGradeDTO inscricaoGradeDTO;
	private StreamedContent arquivoEvento;
	private StreamedContent arquivoTurmas;
	private StreamedContent arquivoParticipantes;
	private boolean mostrarDadosBancario;
	private boolean mostrarNivelEnsino;
	private boolean mostrarExperienciaProfissional;
	public static final Integer TODOS = 1;
	public static final Integer CANDIDATOS_CONFIRMADOS = 2;
	public static final Integer CANDIDATOS_PENDENTES = 3;
	public static final Integer CANDIDATOS_ESPERA = 4;
	public static final Integer DENTRO_REGIAO = 1;
	public static final Integer FORA_REGIAO = 2;
	public static final Integer AMBOS = 3;

	public GerenciarCursoBean() {
		inscricaoGradeDTO = new InscricaoGradeDTO();
		candidatoComplemento = new CandidatoComplemento();
		mostrarDadosBancario = false;
		mostrarExperienciaProfissional = false;
		mostrarNivelEnsino = false;
		inscricaoCurso = new InscricaoCurso();
		inscricaoCurso.setComprovantes(new ArrayList<InscricaoComprovante>());
	}

	@Override
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_CURSO_GERENCIAR");
	}

	@PostConstruct
	public void carregarTela() {
		verificarAcesso();

		Integer idCurso = (Integer) getSessionMap().remove("idCursoGerenciar");
		if (idCurso != null) {
			curso = (Curso) universalManager.get(Curso.class, idCurso);
			carregarLista();
			desabilitarCurso = true;
		}
	}

	public void verificarInscricoesPorOrgao() {
		if (!idOpcaoRegiao.equals(DENTRO_REGIAO) && !idOpcaoRegiao.equals(FORA_REGIAO) && !idOpcaoRegiao.equals(AMBOS)) {
			FacesMessagesUtil.addErrorMessage("", "É necessário escolher pelo menos uma opção no campo Região!");
			return;
		}
		totalInscricoes = inscricaoCursoService.recuperarQuantidadeInscricoesPorOrgao(idOpcaoRegiao, curso.getId(), quantidadeVagas);
		if (totalInscricoes == null || totalInscricoes == 0) {
			FacesMessagesUtil.addInfoMessage("", "Nenhum registro encontrado.");
		}
		mostrarTextoInscricao = Boolean.TRUE;
	}

	public void aceitarInscricoes() {
		try {
			curso = (Curso) universalManager.get(Curso.class, curso.getId());
			List<InscricaoCurso> inscricoes = inscricaoCursoService.recuperarInscricoesPorOrgao(idOpcaoRegiao, curso.getId(),
					quantidadeVagas);
			if (inscricoes != null && !inscricoes.isEmpty()) {
				for (InscricaoCurso inscricaoCurso : inscricoes) {
					inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));

					boolean cursoPago = false;
					if (curso.getHomologacaoCursos() != null && !curso.getHomologacaoCursos().isEmpty()) {
						for (HomologacaoCurso homologacaoCurso : curso.getHomologacaoCursos()) {
							if (homologacaoCurso.getHomologacao().getId().equals(Homologacao.CONFIRMACAO_NOTA_EMPENHO)
									|| homologacaoCurso.getHomologacao().getId().equals(Homologacao.CONFIRMACAO_PAGAMENTO)
									|| homologacaoCurso.getHomologacao().getId().equals(Homologacao.CONFIRMACAO_VIA_GRU)) {
								cursoPago = true;
								break;
							}
						}
					}

					if (cursoPago) {
						StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()),
								loginBean.getModel(), new Status(Status.AGUARDANDO_COMPROVANTE), new Date());
						inscricaoCurso.getStatusInscricoes().add(statusInscricao);
						cursoService.autorizarPagamento((InscricaoCurso) inscricaoCurso.clone());
					} else {
						StatusInscricao statusInscricao = new StatusInscricao(inscricaoCurso, loginBean.getModel(), new Status(
								Status.AGUARDANDO_HOMOLOGACAO), new Date());
						inscricaoCurso.getStatusInscricoes().add(statusInscricao);
						cursoService.aceitarInscricao((InscricaoCurso) inscricaoCurso.clone());
					}
				}

				FacesMessagesUtil.addInfoMessage("Inscrições", "Aceitas " + ConstantesARQ.COM_SUCESSO);
				carregarLista();

			} else {
				FacesMessagesUtil.addErrorMessage("Inscrições", "Não há inscrições à serem Aceitas!");
				quantidadeVagas = 0;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void desfazerAceitacoes() {
		try {
			if (totalInscricoes < quantidadeVagas) {
				FacesMessagesUtil.addErrorMessage("", "Quantidade de vagas por região maior que total de inscritos!");
				return;
			}
			List<InscricaoCurso> inscricoes = inscricaoCursoService
					.consultarInscricoesParaHomologacao(curso, quantidadeVagas, dentroRegiao);
			if (inscricoes != null && !inscricoes.isEmpty()) {
				for (InscricaoCurso inscricaoCurso : inscricoes) {
					StatusInscricao ultimoStatusInscricao = getUltimoStatus(inscricaoCurso);
					if (ultimoStatusInscricao != null && ultimoStatusInscricao.getStatus().getId().equals(Status.AGUARDANDO_COMPROVANTE)) {
						StatusInscricao penultimoStatusInscricao = getPenultimoStatus(inscricaoCurso);
						penultimoStatusInscricao = (StatusInscricao) universalManager.get(StatusInscricao.class,
								penultimoStatusInscricao.getId());

						StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()),
								loginBean.getModel(), new Status(penultimoStatusInscricao.getStatus().getId()), new Date());
						universalManager.save(statusInscricao);
						inscricaoCurso.setUltimoStatus(new StatusInscricao(statusInscricao.getId()));
						universalManager.save(inscricaoCurso);
					}
				}
				FacesMessagesUtil.addInfoMessage("Inscrições", "Aceitação desfeitas " + ConstantesARQ.COM_SUCESSO);
				carregarLista();
			} else {
				FacesMessagesUtil.addErrorMessage("Inscrições", "Não há inscrições para desfazer as aceitações!");
				quantidadeVagas = 0;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private StatusInscricao getPenultimoStatus(InscricaoCurso inscricaoCurso) {
		List<StatusInscricao> listaStatusInscricoes = new ArrayList<StatusInscricao>();
		listaStatusInscricoes.addAll(inscricaoCurso.getStatusInscricoes());
		Collections.sort(listaStatusInscricoes, new Comparator<StatusInscricao>() {
			@Override
			public int compare(StatusInscricao o1, StatusInscricao o2) {
				return o1.getId().compareTo(o2.getId());
			}
		});
		return listaStatusInscricoes.get(listaStatusInscricoes.size() - 2);
	}

	private StatusInscricao getUltimoStatus(InscricaoCurso inscricaoCurso) {
		if (inscricaoCurso.getStatusInscricoes() != null && !inscricaoCurso.getStatusInscricoes().isEmpty()) {
			List<StatusInscricao> listaStatusInscricoes = new ArrayList<StatusInscricao>();
			listaStatusInscricoes.addAll(inscricaoCurso.getStatusInscricoes());
			Collections.sort(listaStatusInscricoes, new Comparator<StatusInscricao>() {
				@Override
				public int compare(StatusInscricao o1, StatusInscricao o2) {
					return o1.getId().compareTo(o2.getId());
				}
			});
			return listaStatusInscricoes.get(listaStatusInscricoes.size() - 1);
		} else {
			return null;
		}
	}

	public void limparAceitacoes() {
		quantidadeVagas = 0;
		totalInscricoes = 0;
		idOpcaoRegiao = 0;
		mostrarPanelAceitacoes = Boolean.FALSE;
		mostrarTextoInscricao = Boolean.FALSE;
	}

	public void visualizarAceitacoesPorOrgao() {
		ocultarPaineis();
		mostrarPanelAceitacoes = Boolean.TRUE;
	}

	public void visualizarInscricaoGrade() {
		try {
			List<Integer> idsCandidatosConfirmados = new ArrayList<Integer>();
			for (InscricaoCurso inscricaoCurso : listaCandidatosConfirmados) {
				idsCandidatosConfirmados.add(inscricaoCurso.getId());
			}

			// Mapeando para obter os inscritos
			List<InscricaoGrade> listaInscricaoGrades = gradeOficinaService.listarInscricaoGrades(curso.getId(), idsCandidatosConfirmados);
			Map<InscricaoGradeDTO, List<InscricaoCurso>> mapInscricaoGrade = new HashMap<InscricaoGradeDTO, List<InscricaoCurso>>();
			for (InscricaoGrade inscricaoGrade : listaInscricaoGrades) {
				InscricaoGradeDTO inscricaoGradeDTO = new InscricaoGradeDTO();
				inscricaoGradeDTO.setHorario(inscricaoGrade.getGradeOficina().getHorario());
				inscricaoGradeDTO.setTurma(inscricaoGrade.getGradeOficina().getTurma());
				inscricaoGradeDTO.setSala(inscricaoGrade.getGradeOficina().getSala());
				inscricaoGradeDTO.setOficina(inscricaoGrade.getGradeOficina().getOficina());
				inscricaoGradeDTO.setProfessorEvento(inscricaoGrade.getGradeOficina().getProfessorEvento());

				if (mapInscricaoGrade.containsKey(inscricaoGradeDTO)) {
					mapInscricaoGrade.get(inscricaoGradeDTO).add(inscricaoGrade.getInscricaoCurso());
				} else {
					inscricaoGradeDTO.getListaInscricaoCursos().add(inscricaoGrade.getInscricaoCurso());
					mapInscricaoGrade.put(inscricaoGradeDTO, inscricaoGradeDTO.getListaInscricaoCursos());
				}
			}

			// Mapeando por horário
			Map<Horario, List<InscricaoGradeDTO>> mapHorarioGrade = new HashMap<Horario, List<InscricaoGradeDTO>>();
			for (Entry<InscricaoGradeDTO, List<InscricaoCurso>> entry : mapInscricaoGrade.entrySet()) {
				Horario horario = ((InscricaoGradeDTO) entry.getKey()).getHorario();
				if (mapHorarioGrade.containsKey(horario)) {
					mapHorarioGrade.get(horario).add(entry.getKey());
				} else {
					List<InscricaoGradeDTO> listaInscricaoGraPorHorario = ((InscricaoGradeDTO) entry.getKey())
							.getListaInscricaoGradePorHorario();
					listaInscricaoGraPorHorario.add(entry.getKey());
					mapHorarioGrade.put(horario, listaInscricaoGraPorHorario);
				}
			}

			// Populando a lista para apresentação na tela
			listaInscricaoGradeDTOs = new ArrayList<InscricaoGradeDTO>();
			for (Entry<Horario, List<InscricaoGradeDTO>> entry : mapHorarioGrade.entrySet()) {
				InscricaoGradeDTO inscricaoGradeDTO = new InscricaoGradeDTO();
				inscricaoGradeDTO.setHorario(entry.getKey());
				inscricaoGradeDTO.setListaInscricaoGradePorHorario(entry.getValue());
				listaInscricaoGradeDTOs.add(inscricaoGradeDTO);
			}

			Collections.sort(listaInscricaoGradeDTOs, new Comparator<InscricaoGradeDTO>() {
				@Override
				public int compare(InscricaoGradeDTO o1, InscricaoGradeDTO o2) {
					return o1.getHorario().getDatHoraInicio().compareTo(o2.getHorario().getDatHoraInicio());
				}
			});
			ocultarPaineis();
			mostrarPanelVisualizacao = Boolean.TRUE;
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			;
		}
	}

	public void visualizarInscricoesOficinas() {
		List<Oficina> oficinas = cursoService.recuperarOficinas(curso);
		listaOficinaInscritosDTOs = new ArrayList<OficinaInscritosDTO>();

		List<Integer> idsInscritosCancelados = new ArrayList<Integer>();
		verificarInscritosCancelados(idsInscritosCancelados);

		List<Integer> idsInscritos = new ArrayList<Integer>();
		verificarStatusInscricao(idsInscritos);

		for (Oficina oficina : oficinas) {
			OficinaInscritosDTO oficinaInscritosDTO = new OficinaInscritosDTO();
			oficinaInscritosDTO.setOficina(oficina);
			oficinaInscritosDTO.setQtdInscritos(0);
			if (!idSituacaoCandidatoSelecionado.equals(TODOS)) {
				if (!idsInscritos.isEmpty()) {
					oficinaInscritosDTO.setQtdInscritos(cursoService.retornarQuantidadeInscritos(curso, oficina, idsInscritos,
							idsInscritosCancelados));
				}
			} else {
				oficinaInscritosDTO.setQtdInscritos(cursoService.retornarQuantidadeInscritos(curso, oficina, idsInscritos,
						idsInscritosCancelados));
			}
			listaOficinaInscritosDTOs.add(oficinaInscritosDTO);
		}
		ocultarPaineis();
		mostrarPanelVisualizacaoInscricoesOficinas = Boolean.TRUE;
		if (listaOficinaInscritosDTOs.isEmpty()) {
			FacesMessagesUtil.addInfoMessage("", "Não há informação a ser exibida!");
		}
	}

	private void verificarInscritosCancelados(List<Integer> idsInscritosCancelados) {
		try {
			for (InscricaoCurso inscrito : cursoService.carregarListaCandidatoCancelados(curso)) {
				idsInscritosCancelados.add(inscrito.getId());
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void verificarStatusInscricao(List<Integer> idsInscritos) {

		if (idSituacaoCandidatoSelecionado != null && idSituacaoCandidatoSelecionado != 0 && !idSituacaoCandidatoSelecionado.equals(TODOS)) {

			if (idSituacaoCandidatoSelecionado.equals(CANDIDATOS_CONFIRMADOS)) {
				for (InscricaoCurso inscrito : listaCandidatosConfirmados) {
					idsInscritos.add(inscrito.getId());
				}
			} else if (idSituacaoCandidatoSelecionado.equals(CANDIDATOS_PENDENTES)) {
				for (InscricaoCurso inscrito : listaCandidatoPendentes) {
					idsInscritos.add(inscrito.getId());
				}
			} else if (idSituacaoCandidatoSelecionado.equals(CANDIDATOS_ESPERA)) {
				for (InscricaoCurso inscrito : listaEspera) {
					idsInscritos.add(inscrito.getId());
				}
			}
		}
	}

	@SuppressWarnings("unchecked")
	public String montarGrade() {
		getSessionMap().put("idCursoGerenciar", curso.getId());
		return redirect("gerenciarCursoComOficina.jsf");
	}

	@SuppressWarnings("unchecked")
	public void prorrogarInscricao() {
		try {
			if (dtInscricaoFim == null) {
				FacesMessagesUtil.addErrorMessage("Erro", "É necessário escolher uma data para prorrogar Inscrição!");
				return;
			}
			curso = (Curso) universalManager.get(Curso.class, curso.getId());
			Hibernate.initialize(curso.getStatusCursos());
			Curso cursoClone = (Curso) curso.clone();
			cursoClone.setDtTerminoInscricao(dtInscricaoFim);

			StatusCurso statusCurso = new StatusCurso();
			statusCurso.setCurso(new Curso(cursoClone.getId()));
			statusCurso.setDtAtualizacao(new Date());
			statusCurso.setStatus(new Status(Status.EM_ANDAMENTO));
			statusCurso.setUsuario(loginBean.getModel());
			cursoClone.getStatusCursos().add(statusCurso);

			cursoClone.getStatusCursos().add(statusCurso);
			cursoClone.setFlgFinalizado(false);

			universalManager.save(cursoClone);

			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Inscrições prorrogadas com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			FacesMessagesUtil.addInfoMessage("Inscrição", "Erro ao tentar prorrogar Inscrição!");
		} finally {
			dtInscricaoFim = null;
		}
	}

	@SuppressWarnings("unchecked")
	public void abrirPopupDistribuir() {
		try {
			// verifica se o curso tem mais de uma turma disponivel.
			if (curso.getTurmas() != null && !curso.getTurmas().isEmpty()) {
				if (inscricoesCursoConfirmados != null && inscricoesCursoConfirmados.length != 0) {
					// carrega as turmas
					Turma turma = new Turma();
					turma.setCurso(new Curso(curso.getId()));
					turma.setFlgAtivo(true);
					turmas = universalManager.listBy(turma);

					idTurma = null;
					// abre o popup
					RequestContext requestContext = RequestContext.getCurrentInstance();
					requestContext.execute("distribuicaoPop.show();");
				} else {
					FacesMessagesUtil.addErrorMessage("Candidato Confirmado",
							" É necessário selecionar pelo menos um Candidato Confirmado.");
					return;
				}
			} else {
				FacesMessagesUtil.addErrorMessage("Turma", " Não é possível distribuir,pois o curso não possui mais de duas turmas.");
				return;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	public void baixarComprovante(Integer id, String tipo) {
		try {
			String url = Constantes.URL_COMPROVANTE + "loadImagemBD?idImagemDownload=" + id + "&tipo=" + tipo;
			FacesContext.getCurrentInstance().getExternalContext().redirect(url);
		} catch (IOException e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void anexarComprovante(FileUploadEvent event) {
		try {

			String fileName = ImagemUtil.criarNomeArquivo(event.getFile().getFileName(), loginBean.getModel());
			fileName = ImagemUtil.verificarTamanhoNomeArquivo(fileName);

			InscricaoComprovante comprovante = new InscricaoComprovante();
			comprovante.setDtCadastro(new Date());
			comprovante.setImgComprovante(event.getFile().getContents());
			comprovante.setNome(fileName);
			comprovante.setTipo(event.getFile().getContentType());
			comprovante.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));

			String os = System.getProperty("os.name");
			/* Descobre se linux ou windows */
			if (os.contains("win") || os.trim().toLowerCase().contains("windows") || os.trim().toLowerCase().contains("win")) {
				comprovante.setUrlImagem(Constantes.PATH_IMG_WINDOWS + fileName);
			} else {
				comprovante.setUrlImagem(Constantes.PATH_IMG_LINUX + fileName);
			}
			
			// Força a criação do arquivo no file system
			FileOutputStream fos = new FileOutputStream(new File(comprovante.getUrlImagem()));
			fos.write(event.getFile().getContents());
			fos.close();

			// comprovantes.add(comprovante);
			if (inscricaoCurso.getComprovantes() == null) {
				inscricaoCurso.setComprovantes(new ArrayList<InscricaoComprovante>());
			}

			inscricaoCurso.getComprovantes().add(comprovante);

			FacesMessagesUtil.addInfoMessage(" ", "Arquivo " + event.getFile().getFileName() + " adicionado com sucesso!");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void anexarDocumento(FileUploadEvent event) {
		try {

			String fileName = ImagemUtil.criarNomeArquivo(event.getFile().getFileName(), loginBean.getModel());
			fileName = ImagemUtil.verificarTamanhoNomeArquivo(fileName);

			InscricaoDocumento documento = new InscricaoDocumento();
			documento.setDtCadastro(new Date());
			documento.setImgDocumento(event.getFile().getContents());
			documento.setNomArquivo(fileName);
			documento.setNomTipo(event.getFile().getContentType());
			documento.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));

			String os = System.getProperty("os.name");
			/* Descobre se linux ou windows */
			if (os.contains("win") || os.trim().toLowerCase().contains("windows") || os.trim().toLowerCase().contains("win")) {
				documento.setUrlImagem(Constantes.PATH_IMG_WINDOWS + fileName);
			} else {
				documento.setUrlImagem(Constantes.PATH_IMG_LINUX + fileName);
			}
			
			// Força a criação do arquivo no file system
			FileOutputStream fos = new FileOutputStream(new File(documento.getUrlImagem()));
			fos.write(event.getFile().getContents());
			fos.close();

			if (inscricaoCurso.getDocumentos() == null) {
				inscricaoCurso.setDocumentos(new ArrayList<InscricaoDocumento>());
			}

			inscricaoCurso.getDocumentos().add(documento);

			FacesMessagesUtil.addInfoMessage(" ", "Arquivo " + event.getFile().getFileName() + " adicionado com sucesso!");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@SuppressWarnings("unchecked")
	public void salvarAnexos() {
		try {
			if (!verificarComprovanteDocumentoNovos()) {
				FacesMessagesUtil.addErrorMessage("", " Não há novo(s) Comprovante(s) e/ou Documento(s) a serem salvos.");
				return;
			}
			StatusInscricao statusInscricao = new StatusInscricao(inscricaoCurso, loginBean.getModel(), new Status(
					Status.AGUARDANDO_VALIDACAO_COMPROVANTE), new Date());

			inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
			inscricaoCurso.getStatusInscricoes().add(statusInscricao);

			cursoService.salvarAnexos(inscricaoCurso);

			inscricaoCurso = new InscricaoCurso();

			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Salvo com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);

			redirect("gerenciarCurso.jsf");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private boolean verificarComprovanteDocumentoNovos() {
		if (inscricaoCurso.getComprovantes() != null && !inscricaoCurso.getComprovantes().isEmpty()) {
			for (InscricaoComprovante inscricaoComprovante : inscricaoCurso.getComprovantes()) {
				if (inscricaoComprovante.getId() == null) {
					return true;
				}
			}
		}
		if (inscricaoCurso.getDocumentos() != null && !inscricaoCurso.getDocumentos().isEmpty()) {
			for (InscricaoDocumento inscricaoDocumento : inscricaoCurso.getDocumentos()) {
				if (inscricaoDocumento.getId() == null) {
					return true;
				}
			}
		}
		return false;
	}

	public void deleteComprovante() {
		try {
			inscricaoCurso.getComprovantes().remove(comprovanteExcluir);
			FacesMessagesUtil.addInfoMessage("Comprovante ", " excluído com sucesso!");

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void deleteDocumento() {
		try {
			inscricaoCurso.getDocumentos().remove(documentoExcluir);
			FacesMessagesUtil.addInfoMessage("Documento ", " excluído com sucesso!");

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void distribuirManual() {
		try {
			if (idTurma == null || idTurma == 0) {
				FacesMessagesUtil.addErrorMessage("Turma", Constantes.CAMPO_OBRIGATORIO);
				return;
			}

			// Verificar como salva e exibir a turma na lista de confirmados.
			cursoService.salvarInscricaoCursoTurma(inscricoesCursoConfirmados, idTurma);

			// recarrega a lista
			listaCandidatosConfirmados = new InscricaoCursoDataModel(cursoService.carregarListaCandidatoConfirmados(curso));

			inscricoesCursoConfirmados = null;

			FacesMessagesUtil.addInfoMessage("Turma Distribuída", Constantes.COM_SUCESSO);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void distribuirAuto() {
		try {

			FacesMessagesUtil.addInfoMessage("Turma Distribuída", Constantes.COM_SUCESSO);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void mostrarMsg() {
		Boolean carregarTelaGerenciar = (Boolean) getSessionMap().remove("carregarTelaGerenciar");
		if (carregarTelaGerenciar != null && carregarTelaGerenciar) {
			Integer idCurso = (Integer) getSessionMap().remove("idCurso");
			curso = (Curso) universalManager.get(Curso.class, idCurso);
			carregarLista();
			String msg = (String) getSessionMap().remove("msg");
			FacesMessagesUtil.addInfoMessage(msg, "");

			Boolean visualizar = (Boolean) getSessionMap().remove("desabilitarCurso");
			if (visualizar != null && visualizar) {
				desabilitarCurso = true;
			}

		}
	}

	public void carregarLista() {
		try {
			listaOficinaInscritosDTOs = new ArrayList<OficinaInscritosDTO>();
			inscricaoCurso = new InscricaoCurso();
			inscricaoInfoComplementar = new InscricaoInfoComplementar();

			listaCandidatoPendentes = cursoService.carregarListaCandidatoParticipante(curso);
			listaEspera = cursoService.carregarListaEspera(curso);
			if (!curso.getFlgPossuiOficina()){
				listaInstrutores = cursoService.carregarListaInstrutores(curso);
			}
			listaCandidatosConfirmados = new InscricaoCursoDataModel(cursoService.carregarListaCandidatoConfirmados(curso));

			vagasPreencidas = 0;
			if (listaCandidatoPendentes != null) {
				totalPendentes = listaCandidatoPendentes.size();
				vagasPreencidas += totalPendentes;
			}
			if (listaEspera != null) {
				totalEspera = listaEspera.size();
			}
			if (listaCandidatosConfirmados != null) {
				totalConfirmados = listaCandidatosConfirmados.getRowCount();
				vagasPreencidas += totalConfirmados;
			}

			// preenche os campos vagas abertas e vagas preenchidas.
			if (curso.getVagas() != null) {
				vagasAbertas = curso.getVagas() - vagasPreencidas;
				if (vagasAbertas < 0) {
					vagasAbertas = 0;
				}
			} else {
				vagasAbertas = 0;
			}

			// verifica se vai mostrar o finalizar curso
			// se flag falso quer dizer que gestor define a finalizacao do curso
			StatusCurso statusCurso = cursoService.ultimoStatusCurso(curso);
			if (statusCurso != null) {
				if ((curso.getFlgDataAtivo() == null || !curso.getFlgDataAtivo())
						&& !statusCurso.getStatus().getId().equals(Status.FINALIZADA_INSCRICAO)) {
					mostarFinalizarInscricao = true;
				} else {
					mostarFinalizarInscricao = false;
				}
			}

			/**
			 * Verificar a capacidade do evento quando for anexo C pela capacidade das salas adicionadas na grade de oficinas. A capacidade
			 * do evendo se dará pela soma total da capacidade das salas em cada horário e a soma que tiver a capacidade menor será a
			 * capacidade total prevista, uma vez que todos devem escolher oficinas em todos os horários.
			 */
			if (curso.getFlgPossuiOficina()){
				capacidadeMaximaInscritos = gradeOficinaService.recuperarCapacidadeMaximaInscritos(curso.getId());
				if (capacidadeMaximaInscritos != null && curso.getNumPercentualVagasParceiro() != null){
					vagasParceiro = (int) Math.floor(capacidadeMaximaInscritos * curso.getNumPercentualVagasParceiro() / 100);
					vagasAbertas = capacidadeMaximaInscritos - vagasPreencidas;
				} else {
					capacidadeMaximaInscritos = 0;
					vagasAbertas = 0;
				}
			}

			ocultarPaineis();
			limparAceitacoes();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@SuppressWarnings("unchecked")
	public List<Candidato> completeCandidato(String query) {
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

	@SuppressWarnings("unchecked")
	public void inscreverCandidatoForaPrazo() {
		try {
			if (candidato == null || candidato.getNome() == null || candidato.getNome().equals("")) {
				FacesMessagesUtil.addErrorMessage("Erro", "É necessário escolher um candidato para realizar a inscrição!");
				return;
			}

			InscricaoCurso inscricaoCurso = new InscricaoCurso();

			/**
			 * Verificando a existencia de alguma inscrição do candidato no curso selecionado para não haver duplicicade. Somente poderá
			 * reinscrever caso o candidato tenha sido cancelado.
			 */
			InscricaoCurso inscricaoCursoVerificiacao = new InscricaoCurso();
			inscricaoCursoVerificiacao.setCandidato(new Candidato(candidato.getId()));
			inscricaoCursoVerificiacao.setCurso(new Curso(curso.getId()));
			List<InscricaoCurso> listaInscricoesExistentes = universalManager.listBy(inscricaoCursoVerificiacao);
			if (listaInscricoesExistentes != null && !listaInscricoesExistentes.isEmpty()) {
				inscricaoCursoVerificiacao = listaInscricoesExistentes.get(0);
				if (!getUltimoStatus(inscricaoCursoVerificiacao).getStatus().getId().equals(Status.CANCELADO)) {
					FacesMessagesUtil.addErrorMessage("Erro", "Já existe uma inscrição neste curso para o candidato selecionado!");
					return;
				}
				inscricaoCurso = (InscricaoCurso) inscricaoCursoVerificiacao.clone();
			}

			inscricaoCurso.setCandidato(candidato);
			inscricaoCurso.setCurso(curso);
			inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
			inscricaoCurso.setDtCadastro(new Date());

			StatusInscricao statusInscricao = new StatusInscricao(inscricaoCurso, loginBean.getModel(), new Status(Status.HOMOLOGADO),
					new Date());

			inscricaoCursoService.inscreverCandidatoForaPrazo(inscricaoCurso, statusInscricao);
			carregarLista();
			FacesMessagesUtil.addInfoMessage("", "Inscrição realizada com sucesso!");
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Erro", "Erro ao tentar realizar inscricão!");
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void ocultarPaineis() {
		mostrarPanelVisualizacao = Boolean.FALSE;
		mostrarPanelVisualizacaoInscricoesOficinas = Boolean.FALSE;
		mostrarPanelAceitacoes = Boolean.FALSE;
	}

	public void selecionar() {
		try {

			inscricaoInfoComplementar = new InscricaoInfoComplementar();

			inscricaoCurso = inscricaoCursoService.recuperarInscricaoComColecoes(inscricaoCurso.getId());

			// verifica se mostra info do pagamento
			mostrarInformacaoPagamento = false;
			for (HomologacaoCurso hc : inscricaoCurso.getCurso().getHomologacaoCursos()) {
				if (hc.getHomologacao().getId().equals(Homologacao.CONFIRMACAO_NOTA_EMPENHO)
						|| hc.getHomologacao().getId().equals(Homologacao.CONFIRMACAO_VIA_GRU)) {
					mostrarInformacaoPagamento = true;
					if (inscricaoCurso.getInscricaoInfoComplemento() != null && !inscricaoCurso.getInscricaoInfoComplemento().isEmpty()) {
						inscricaoInfoComplementar = inscricaoCurso.getInscricaoInfoComplemento().iterator().next();
						mostrarBotaoSalvarInfoComplementar = false;
					} else {
						mostrarBotaoSalvarInfoComplementar = true;
					}
					break;
				}
			}

			curso = inscricaoCurso.getCurso();

			// Carregando o complemento do candidato
			candidatoComplemento = candidatoService.recuperarCandidatoComplemento(inscricaoCurso.getCandidato().getId());

			mostrarDadosBancario = false;
			mostrarExperienciaProfissional = false;
			mostrarNivelEnsino = false;
			for (CandidatoPreenchimento cp : curso.getCandidatoPreenchimentos()) {
				if (cp.getCampoPreenchimento().getId().equals(CampoPreenchimento.DADOS_BANCARIO)) {
					mostrarDadosBancario = true;
					continue;
				}
				if (cp.getCampoPreenchimento().getId().equals(CampoPreenchimento.EXPERIENCIA_PROFISSIONAL)) {
					mostrarExperienciaProfissional = true;
					continue;
				}
				if (cp.getCampoPreenchimento().getId().equals(CampoPreenchimento.NIVEL_ENSINO)) {
					mostrarNivelEnsino = true;
					continue;
				}
			}

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@SuppressWarnings("unchecked")
	public String homologar() {
		try {

			StatusInscricao statusInscricao = new StatusInscricao(inscricaoCurso, loginBean.getModel(), new Status(Status.HOMOLOGADO),
					new Date());

			inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
			inscricaoCurso.getStatusInscricoes().add(statusInscricao);
			// Coloca o ano que a inscricao foi homologada.
			// Isso é feito para gerar o numero da inscricao.
			Integer anoAtual = Integer.valueOf(DateUtil.getDataHora(new Date(), "yyyy"));
			inscricaoCurso.setAnoHomologacao(anoAtual);

			cursoService.homologarCurso(inscricaoCurso);
			inscricaoCurso = new InscricaoCurso();

			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Homologado com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}

		return redirect("gerenciarCurso.jsf");

	}

	public void salvarIncricaoInfoComplementar() {
		try {
			if (inscricaoInfoComplementar.getOrgao() == null || inscricaoInfoComplementar.getOrgao().getId() == null
					|| inscricaoInfoComplementar.getOrgao().getId() == 0) {
				FacesMessagesUtil.addErrorMessage("Órgão ", Constantes.CAMPO_OBRIGATORIO);
				return;
			}
			if (inscricaoInfoComplementar.getNumeroEmpenho() == null || inscricaoInfoComplementar.getNumeroEmpenho().isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Número Empenho ", Constantes.CAMPO_OBRIGATORIO);
				return;
			}
			if (inscricaoInfoComplementar.getEnderecoOrgaoComplemento() == null
					|| inscricaoInfoComplementar.getEnderecoOrgaoComplemento().isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Endereço Órgão ", Constantes.CAMPO_OBRIGATORIO);
				return;
			}
			if (inscricaoInfoComplementar.getCnpj() == null || inscricaoInfoComplementar.getCnpj().isEmpty()) {
				FacesMessagesUtil.addErrorMessage("CNPJ ", Constantes.CAMPO_OBRIGATORIO);
				return;
			}
			String cnpj = inscricaoInfoComplementar.getCnpj().trim().replaceAll("[/()-.]", "");
			// Validar cnpj
			if (!CnpjUtil.isValidCNPJ(cnpj)) {
				FacesMessagesUtil.addErrorMessage("CNPJ ", "Inválido");
				return;
			}
			// retirar mascaras
			inscricaoInfoComplementar.setCnpj(cnpj);
			// retira mascara
			if (inscricaoInfoComplementar.getContato() != null && !inscricaoInfoComplementar.getContato().trim().equals("")) {
				inscricaoInfoComplementar.setContato(inscricaoInfoComplementar.getContato().trim().replaceAll("[()-]", ""));
			}
			if (inscricaoInfoComplementar.getTelefoneFinanceiro() != null
					&& !inscricaoInfoComplementar.getTelefoneFinanceiro().trim().equals("")) {
				inscricaoInfoComplementar.setTelefoneFinanceiro(inscricaoInfoComplementar.getTelefoneFinanceiro().trim()
						.replaceAll("[()-]", ""));
			}
			inscricaoInfoComplementar.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));
			cursoService.salvarInscricaoInfoComplementar(inscricaoInfoComplementar);
			mostrarBotaoSalvarInfoComplementar = false;
			FacesMessagesUtil.addInfoMessage("Informações do Órgão Pagante", "Salvas" + Constantes.COM_SUCESSO);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
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

	@SuppressWarnings("unchecked")
	public String confirmarCandidato() {
		try {
			StatusInscricao statusInscricao = new StatusInscricao(inscricaoCurso, loginBean.getModel(), new Status(
					Status.PRESENCA_CONFIRMADA), new Date());

			inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));

			inscricaoCursoService.confirmarCandidato(inscricaoCurso, statusInscricao);

			inscricaoCurso = new InscricaoCurso();

			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Candidato confirmado com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		return redirect("gerenciarCurso.jsf");
	}

	@SuppressWarnings("unchecked")
	public String autorizarPagamento() {
		try {

			StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()), loginBean.getModel(),
					new Status(Status.AGUARDANDO_COMPROVANTE), new Date());

			inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
			inscricaoCurso.getStatusInscricoes().add(statusInscricao);

			cursoService.autorizarPagamento(inscricaoCurso);
			inscricaoCurso = new InscricaoCurso();

			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Pré-Inscrição aceita com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}

		return redirect("gerenciarCurso.jsf");

	}

	// @SuppressWarnings("unchecked")
	// public String anexarComprovante() {
	// try {
	//
	// if (comprovantes == null || comprovantes.isEmpty()) {
	// FacesMessagesUtil.addErrorMessage("", "É necessário adicionar um ou mais comprovantes.");
	// return "";
	// }
	// inscricaoCurso.setComprovantes(new ArrayList<InscricaoComprovante>(comprovantes));
	// StatusInscricao statusInscricao = new StatusInscricao();
	// statusInscricao.setDtAtualizacao(new Date());
	// statusInscricao.setInscricaoCurso(inscricaoCurso);
	// statusInscricao.setStatus(new Status(Status.AGUARDANDO_VALIDACAO_COMPROVANTE));
	// statusInscricao.setUsuario(loginBean.getModel());
	//
	// inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
	// inscricaoCurso.getStatusInscricoes().add(statusInscricao);
	//
	// cursoService.anexarComprovante(inscricaoCurso);
	// inscricaoCurso = new InscricaoCurso();
	//
	// getSessionMap().put("carregarTelaGerenciar", true);
	// getSessionMap().put("idCurso", curso.getId());
	// getSessionMap().put("msg", "Salvo com sucesso!");
	// getSessionMap().put("desabilitarCurso", desabilitarCurso);
	// } catch (Exception e) {
	// ExcecaoUtil.tratarExcecao(e);
	// return ERROR;
	// }
	// return redirect("gerenciarCurso.jsf");
	// }

	// @SuppressWarnings("unchecked")
	// public String anexarDocumento() {
	// try {
	//
	// if (documentos == null || documentos.isEmpty()) {
	// FacesMessagesUtil.addErrorMessage("", "É necessário adicionar um ou mais documentos.");
	// return "";
	// }
	// StatusInscricao statusInscricao = new StatusInscricao();
	// statusInscricao.setDtAtualizacao(new Date());
	// statusInscricao.setInscricaoCurso(inscricaoCurso);
	// statusInscricao.setStatus(new Status(Status.AGUARDANDO_VALIDACAO_COMPROVANTE));
	// statusInscricao.setUsuario(loginBean.getModel());
	//
	// inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
	// inscricaoCurso.getStatusInscricoes().add(statusInscricao);
	//
	// cursoService.anexarDocumento(inscricaoCurso);
	// inscricaoCurso = new InscricaoCurso();
	//
	// getSessionMap().put("carregarTelaGerenciar", true);
	// getSessionMap().put("idCurso", curso.getId());
	// getSessionMap().put("msg", "Salvo com sucesso!");
	// getSessionMap().put("desabilitarCurso", desabilitarCurso);
	// } catch (Exception e) {
	// ExcecaoUtil.tratarExcecao(e);
	// return ERROR;
	// }
	// return redirect("gerenciarCurso.jsf");
	// }

	@SuppressWarnings("unchecked")
	public String finalizarCurso() {
		try {
			curso = (Curso) universalManager.get(Curso.class, curso.getId());
			Hibernate.initialize(curso.getStatusCursos());
			Curso cursoUpdate = (Curso) curso.clone();

			StatusCurso statusCurso = new StatusCurso();
			statusCurso.setCurso(new Curso(cursoUpdate.getId()));
			statusCurso.setDtAtualizacao(new Date());
			statusCurso.setStatus(new Status(Status.FINALIZADO_CURSO));
			statusCurso.setUsuario(loginBean.getModel());
			cursoUpdate.getStatusCursos().add(statusCurso);

			cursoUpdate.getStatusCursos().add(statusCurso);
			cursoUpdate.setFlgFinalizado(true);

			universalManager.save(cursoUpdate);

			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Curso Finalizado com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}

		return redirect("gerenciarCurso.jsf");

	}

	@SuppressWarnings("unchecked")
	public String finalizarInscricao() {
		try {
			curso = (Curso) universalManager.get(Curso.class, curso.getId());
			Hibernate.initialize(curso.getStatusCursos());
			Curso cursoUpdate = (Curso) curso.clone();

			StatusCurso statusCurso = new StatusCurso();
			statusCurso.setCurso(new Curso(cursoUpdate.getId()));
			statusCurso.setDtAtualizacao(new Date());
			statusCurso.setStatus(new Status(Status.FINALIZADA_INSCRICAO));
			statusCurso.setUsuario(loginBean.getModel());
			cursoUpdate.getStatusCursos().add(statusCurso);

			universalManager.save(cursoUpdate);

			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Inscrições Finalizadas com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		return redirect("gerenciarCurso.jsf");

	}

	@SuppressWarnings("unchecked")
	public String elegerCandidato() {
		try {
			// verifica se precisa de confirmação do chefe
			boolean homologacaoConfirmacaoChefe = false;
			boolean semHomologacao = false;

			Curso cursoAux = (Curso) universalManager.get(Curso.class, curso.getId());

			if (cursoAux.getHomologacaoCursos() == null || cursoAux.getHomologacaoCursos().isEmpty()) {
				semHomologacao = true;
			} else {
				for (HomologacaoCurso hm : cursoAux.getHomologacaoCursos()) {
					Homologacao h = hm.getHomologacao();
					if (h.getId().equals(Homologacao.CONFIRMACAO_CHEFE)) {
						homologacaoConfirmacaoChefe = true;
					}
				}
			}

			StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()), loginBean.getModel(), null,
					new Date());
			if (homologacaoConfirmacaoChefe) {
				statusInscricao.setStatus(new Status(Status.PRE_INSCRITO));
			} else if (semHomologacao) {
				statusInscricao.setStatus(new Status(Status.AGUARDANDO_HOMOLOGACAO));
			} else {
				statusInscricao.setStatus(new Status(Status.AGUARDANDO_ACEITE_INSCRICAO));
			}

			inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
			inscricaoCurso.getStatusInscricoes().add(statusInscricao);

			cursoService.elegerCandidato(inscricaoCurso, statusInscricao.getStatus());

			inscricaoCurso = null;

			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Candidato Elegido com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		return redirect("gerenciarCurso.jsf");

	}

	@SuppressWarnings("unchecked")
	public String cancelarInscricao() {
		try {
			if (textoCancelar == null || textoCancelar.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Corpo Email", Constantes.CAMPO_OBRIGATORIO);
				return ERROR;
			}

			StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()), loginBean.getModel(),
					new Status(Status.CANCELADO), new Date());

			inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
			inscricaoCurso.getStatusInscricoes().add(statusInscricao);

			cursoService.cancelarInscricao(inscricaoCurso, textoCancelar, statusInscricao);
			inscricaoCurso = new InscricaoCurso();
			textoInvalidarComprovante = null;
			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Inscrição Cancelada com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}

		return redirect("gerenciarCurso.jsf");

	}

	@SuppressWarnings("unchecked")
	public String invalidarComprovante() {
		try {
			if (textoInvalidarComprovante == null || textoInvalidarComprovante.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Corpo Email", Constantes.CAMPO_OBRIGATORIO);
				return ERROR;
			}
			StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()), loginBean.getModel(),
					new Status(Status.INVALIDAR_COMPROVANTE), new Date());

			inscricaoCurso.setSituacao(new Situacao(Situacao.INSCRITO));
			inscricaoCurso.getStatusInscricoes().add(statusInscricao);

			cursoService.invalidarComprovante(inscricaoCurso, textoInvalidarComprovante);
			inscricaoCurso = new InscricaoCurso();
			textoInvalidarComprovante = null;
			getSessionMap().put("carregarTelaGerenciar", true);
			getSessionMap().put("idCurso", curso.getId());
			getSessionMap().put("msg", "Comprovante Invalidado com sucesso!");
			getSessionMap().put("desabilitarCurso", desabilitarCurso);

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}

		return redirect("gerenciarCurso.jsf");

	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		Curso a = new Curso();
		a.setTitulo(query);
		try {
			List<Curso> listaBanco = cursoService.recuperarCursos(a);
			if (listaBanco != null && !listaBanco.isEmpty()) {
				for (Curso curso : listaBanco) {
					if ((curso.getUsuario().getId().equals(loginBean.getModel().getId()) && acessoBean
							.verificarAcesso("ROLE_CURSO_GERENCIAR"))
							|| acessoBean.verificarAcesso("ROLE_PESQ_ACESSO_GERAL")
							|| loginBean.getModel().getPerfil().getDescricao().equals(Constantes.PERFIL_SISFIE)) {
						sugestoes.add(curso);
					}
				}
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return sugestoes;
	}

	@Override
	public Curso createModel() {
		return new Curso();
	}

	@Override
	public String getQualifiedName() {
		return "Curso";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public List<InscricaoCurso> getListaEspera() {
		return listaEspera;
	}

	public void setListaEspera(List<InscricaoCurso> listaEspera) {
		this.listaEspera = listaEspera;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public String getTextoInvalidarComprovante() {
		return textoInvalidarComprovante;
	}

	public void setTextoInvalidarComprovante(String textoInvalidarComprovante) {
		this.textoInvalidarComprovante = textoInvalidarComprovante;
	}

	public String getTextoCancelar() {
		return textoCancelar;
	}

	public void setTextoCancelar(String textoCancelar) {
		this.textoCancelar = textoCancelar;
	}

	public boolean isMostarFinalizarInscricao() {
		return mostarFinalizarInscricao;
	}

	public void setMostarFinalizarInscricao(boolean mostarFinalizarInscricao) {
		this.mostarFinalizarInscricao = mostarFinalizarInscricao;
	}

	public boolean isDesabilitarCurso() {
		return desabilitarCurso;
	}

	public void setDesabilitarCurso(boolean desabilitarCurso) {
		this.desabilitarCurso = desabilitarCurso;
	}

	public boolean isCursoFinalizado() {
		if (curso != null) {
			if (curso.getFlgFinalizado() != null && curso.getFlgFinalizado()) {
				cursoFinalizado = true;
			} else {
				cursoFinalizado = false;
			}
		}
		return cursoFinalizado;
	}

	public void setCursoFinalizado(boolean cursoFinalizado) {
		this.cursoFinalizado = cursoFinalizado;
	}

	public Integer getVagasPreencidas() {
		return vagasPreencidas;
	}

	public void setVagasPreencidas(Integer vagasPreencidas) {
		this.vagasPreencidas = vagasPreencidas;
	}

	public Integer getVagasAbertas() {
		return vagasAbertas;
	}

	public void setVagasAbertas(Integer vagasAbertas) {
		this.vagasAbertas = vagasAbertas;
	}

	public boolean isMostrarInformacaoPagamento() {
		return mostrarInformacaoPagamento;
	}

	public void setMostrarInformacaoPagamento(boolean mostrarInformacaoPagamento) {
		this.mostrarInformacaoPagamento = mostrarInformacaoPagamento;
	}

	public InscricaoInfoComplementar getInscricaoInfoComplementar() {
		return inscricaoInfoComplementar;
	}

	public void setInscricaoInfoComplementar(InscricaoInfoComplementar inscricaoInfoComplementar) {
		this.inscricaoInfoComplementar = inscricaoInfoComplementar;
	}

	public List<InscricaoCurso> getListaCandidatoPendentes() {
		return listaCandidatoPendentes;
	}

	public void setListaCandidatoPendentes(List<InscricaoCurso> listaCandidatoPendentes) {
		this.listaCandidatoPendentes = listaCandidatoPendentes;
	}

	public void setListaCandidatosConfirmados(InscricaoCursoDataModel listaCandidatosConfirmados) {
		this.listaCandidatosConfirmados = listaCandidatosConfirmados;
	}

	public InscricaoCursoDataModel getListaCandidatosConfirmados() {
		return listaCandidatosConfirmados;
	}

	public InscricaoCurso[] getInscricoesCursoConfirmados() {
		return inscricoesCursoConfirmados;
	}

	public void setInscricoesCursoConfirmados(InscricaoCurso[] inscricoesCursoConfirmados) {
		this.inscricoesCursoConfirmados = inscricoesCursoConfirmados;
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

	public InscricaoComprovante getComprovanteExcluir() {
		return comprovanteExcluir;
	}

	public void setComprovanteExcluir(InscricaoComprovante comprovanteExcluir) {
		this.comprovanteExcluir = comprovanteExcluir;
	}

	public Integer getTotalPendentes() {
		return totalPendentes;
	}

	public void setTotalPendentes(Integer totalPendentes) {
		this.totalPendentes = totalPendentes;
	}

	public Integer getTotalConfirmados() {
		return totalConfirmados;
	}

	public void setTotalConfirmados(Integer totalConfirmados) {
		this.totalConfirmados = totalConfirmados;
	}

	public Integer getTotalEspera() {
		return totalEspera;
	}

	public void setTotalEspera(Integer totalEspera) {
		this.totalEspera = totalEspera;
	}

	public Date getDtInscricaoFim() {
		return dtInscricaoFim;
	}

	public void setDtInscricaoFim(Date dtInscricaoFim) {
		this.dtInscricaoFim = dtInscricaoFim;
	}

	public DistribuirService getDistribuirService() {
		return distribuirService;
	}

	public void setDistribuirService(DistribuirService distribuirService) {
		this.distribuirService = distribuirService;
	}

	public boolean isMostrarPanelVisualizacao() {
		return mostrarPanelVisualizacao;
	}

	public void setMostrarPanelVisualizacao(boolean mostrarPanelVisualizacao) {
		this.mostrarPanelVisualizacao = mostrarPanelVisualizacao;
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

	public List<GradeOficina> getListaGradeOficinas() {
		return listaGradeOficinas;
	}

	public void setListaGradeOficinas(List<GradeOficina> listaGradeOficinas) {
		this.listaGradeOficinas = listaGradeOficinas;
	}

	public OrgaoService getOrgaoService() {
		return orgaoService;
	}

	public void setOrgaoService(OrgaoService orgaoService) {
		this.orgaoService = orgaoService;
	}

	public boolean isMostrarBotaoSalvarInfoComplementar() {
		return mostrarBotaoSalvarInfoComplementar;
	}

	public void setMostrarBotaoSalvarInfoComplementar(boolean mostrarBotaoSalvarInfoComplementar) {
		this.mostrarBotaoSalvarInfoComplementar = mostrarBotaoSalvarInfoComplementar;
	}

	public boolean isMostrarPanelVisualizacaoInscricoesOficinas() {
		return mostrarPanelVisualizacaoInscricoesOficinas;
	}

	public void setMostrarPanelVisualizacaoInscricoesOficinas(boolean mostrarPanelVisualizacaoInscricoesOficinas) {
		this.mostrarPanelVisualizacaoInscricoesOficinas = mostrarPanelVisualizacaoInscricoesOficinas;
	}

	public List<OficinaInscritosDTO> getListaOficinaInscritosDTOs() {
		return listaOficinaInscritosDTOs;
	}

	public void setListaOficinaInscritosDTOs(List<OficinaInscritosDTO> listaOficinaInscritosDTOs) {
		this.listaOficinaInscritosDTOs = listaOficinaInscritosDTOs;
	}

	public Integer getQuantidadeVagas() {
		return quantidadeVagas;
	}

	public void setQuantidadeVagas(Integer quantidadeVagas) {
		this.quantidadeVagas = quantidadeVagas;
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

	public List<SelectItem> getListaSituacaoCandidatos() {
		listaSituacaoCandidatos = new ArrayList<SelectItem>();
		listaSituacaoCandidatos.add(new SelectItem(TODOS, "Todos"));
		listaSituacaoCandidatos.add(new SelectItem(CANDIDATOS_CONFIRMADOS, "Confirmados"));
		listaSituacaoCandidatos.add(new SelectItem(CANDIDATOS_PENDENTES, "Pendentes"));
		listaSituacaoCandidatos.add(new SelectItem(CANDIDATOS_ESPERA, "Lista de Espera"));
		return listaSituacaoCandidatos;
	}

	public void setListaSituacaoCandidatos(List<SelectItem> listaSituacaoCandidatos) {
		this.listaSituacaoCandidatos = listaSituacaoCandidatos;
	}

	public Integer getIdSituacaoCandidatoSelecionado() {
		return idSituacaoCandidatoSelecionado;
	}

	public void setIdSituacaoCandidatoSelecionado(Integer idSituacaoCandidatoSelecionado) {
		this.idSituacaoCandidatoSelecionado = idSituacaoCandidatoSelecionado;
	}

	public Integer getIdOpcaoRegiao() {
		return idOpcaoRegiao;
	}

	public void setIdOpcaoRegiao(Integer idOpcaoRegiao) {
		this.idOpcaoRegiao = idOpcaoRegiao;
	}

	public boolean isMostrarPanelAceitacoes() {
		return mostrarPanelAceitacoes;
	}

	public void setMostrarPanelAceitacoes(boolean mostrarPanelAceitacoes) {
		this.mostrarPanelAceitacoes = mostrarPanelAceitacoes;
	}

	public boolean isMostrarTextoInscricao() {
		return mostrarTextoInscricao;
	}

	public void setMostrarTextoInscricao(boolean mostrarTextoInscricao) {
		this.mostrarTextoInscricao = mostrarTextoInscricao;
	}

	public List<Candidato> getListaCandidatos() {
		return listaCandidatos;
	}

	public void setListaCandidatos(List<Candidato> listaCandidatos) {
		this.listaCandidatos = listaCandidatos;
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

	@SuppressWarnings({ "unchecked", "rawtypes" })
	private InputStream gerarArquivoCSV(List<Object> listaDados) {
		try {
			InputStream stream;
			CSVWriter csvw;
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			Writer w = new OutputStreamWriter(baos, "ISO-8859-1");
			csvw = CSVWriterBuilder.newDefaultWriter(w);
			for (Object item : listaDados) {
				Object[] dados = (Object[]) item;
				String[] stringArray = Arrays.copyOf(dados, dados.length, String[].class);
				csvw.write(stringArray);
			}
			csvw.flush();
			csvw.close();
			stream = new ByteArrayInputStream(baos.toByteArray());
			return stream;
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	public StreamedContent getArquivoEvento() {
		List<Object> listaDados = gradeOficinaService.gerarArquivoEventoFrequencia(curso.getId());
		InputStream stream = gerarArquivoCSV(listaDados);
		arquivoEvento = new DefaultStreamedContent(stream, "application/octet-stream", curso.getTitulo() + " - (Evento).csv");
		return arquivoEvento;
	}

	public void setArquivoEvento(StreamedContent arquivoEvento) {
		this.arquivoEvento = arquivoEvento;
	}

	public StreamedContent getArquivoTurmas() {
		List<Object> listaDados = gradeOficinaService.gerarArquivoTurmasFrequencia(curso.getId());
		InputStream stream = gerarArquivoCSV(listaDados);
		arquivoTurmas = new DefaultStreamedContent(stream, "application/octet-stream", curso.getTitulo() + " - (Turmas).csv");
		return arquivoTurmas;
	}

	public void setArquivoTurmas(StreamedContent arquivoTurmas) {
		this.arquivoTurmas = arquivoTurmas;
	}

	public StreamedContent getArquivoParticipantes() {
		List<Object> listaDados = gradeOficinaService.gerarArquivoParticipantesFrequencia(curso.getId());
		InputStream stream = gerarArquivoCSV(listaDados);
		arquivoParticipantes = new DefaultStreamedContent(stream, "application/octet-stream", curso.getTitulo() + " - (Participantes).csv");
		return arquivoParticipantes;
	}

	public void setArquivoParticipantes(StreamedContent arquivoParticipantes) {
		this.arquivoParticipantes = arquivoParticipantes;
	}

	@SuppressWarnings("unchecked")
	public void importarFrequencia(FileUploadEvent event) {
		try {
			UploadedFile arquivoFrequencia = event.getFile();
			if (arquivoFrequencia == null) {
				FacesMessagesUtil.addErrorMessage("Erro na Importação de Frequência", "Nenhum arquivo selecionado");
				return;
			}
			Reader reader = new InputStreamReader(arquivoFrequencia.getInputstream(), "ISO-8859-1");
			CSVReader<String[]> csvParser = CSVReaderBuilder.newDefaultReader(reader);
			List<String[]> data = csvParser.readAll();

			if (data.get(0).length != 4) {
				FacesMessagesUtil.addErrorMessage("Erro na Importação de Frequência",
						"Arquivo selecionado não corresponde a um arquivo de frequência válido!");
				return;
			}

			List<Frequencia> listaFrequencias = new ArrayList<Frequencia>();
			boolean verificado = false;
			for (String[] colums : data) {
				Frequencia frequencia = new Frequencia();
				frequencia.setGradeOficina(new GradeOficina(Integer.parseInt(colums[0].trim())));
				
				InscricaoCurso inscricaoCurso = new InscricaoCurso();
				inscricaoCurso.setInscricao(colums[1].trim());
				List<InscricaoCurso> listaConsulta = universalManager.listBy(inscricaoCurso);
				
				frequencia.setInscricaoCurso(new InscricaoCurso(listaConsulta.get(0).getId()));
				frequencia.setHorarioEntrada(new Timestamp(Long.parseLong(colums[2].trim())));
				frequencia.setHorarioSaida(new Timestamp(Long.parseLong(colums[3].trim())));

				/**
				 * Verifica se o arquivo já foi inserido na base. Basta verificar por apenas um registro e feito a verificação uma vez não
				 * há necessidade de verificar novamente.
				 */
				if (!verificado) {
					List<Frequencia> listaVerificacaoImportacao = universalManager.listBy(frequencia);
					if (listaVerificacaoImportacao != null && !listaVerificacaoImportacao.isEmpty()) {
						FacesMessagesUtil.addErrorMessage("", "Arquivo " + arquivoFrequencia.getFileName()
								+ " já importado na base de dados.");
						return;
					}
					verificado = true;
				}

				listaFrequencias.add(frequencia);
			}

			frequenciaService.salvarListaFrequencia(listaFrequencias);
			FacesMessagesUtil.addInfoMessage("Importação de Frequência", "Importação do arquivo de Frequência realizado com sucesso!");
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Erro na importação de Frequência",
					"Provavelmente o arquivo não corresponde a um arquivo de Frequência!");
		}
	}

	public FrequenciaService getFrequenciaService() {
		return frequenciaService;
	}

	public void setFrequenciaService(FrequenciaService frequenciaService) {
		this.frequenciaService = frequenciaService;
	}

	public CandidatoComplemento getCandidatoComplemento() {
		return candidatoComplemento;
	}

	public void setCandidatoComplemento(CandidatoComplemento candidatoComplemento) {
		this.candidatoComplemento = candidatoComplemento;
	}

	public boolean isMostrarDadosBancario() {
		return mostrarDadosBancario;
	}

	public void setMostrarDadosBancario(boolean mostrarDadosBancario) {
		this.mostrarDadosBancario = mostrarDadosBancario;
	}

	public boolean isMostrarNivelEnsino() {
		return mostrarNivelEnsino;
	}

	public void setMostrarNivelEnsino(boolean mostrarNivelEnsino) {
		this.mostrarNivelEnsino = mostrarNivelEnsino;
	}

	public boolean isMostrarExperienciaProfissional() {
		return mostrarExperienciaProfissional;
	}

	public void setMostrarExperienciaProfissional(boolean mostrarExperienciaProfissional) {
		this.mostrarExperienciaProfissional = mostrarExperienciaProfissional;
	}

	public InscricaoDocumento getDocumentoExcluir() {
		return documentoExcluir;
	}

	public void setDocumentoExcluir(InscricaoDocumento documentoExcluir) {
		this.documentoExcluir = documentoExcluir;
	}

	public GradeOficinaService getGradeOficinaService() {
		return gradeOficinaService;
	}

	public void setGradeOficinaService(GradeOficinaService gradeOficinaService) {
		this.gradeOficinaService = gradeOficinaService;
	}

	public List<InscricaoGradeDTO> getListaInscricaoGradeDTOs() {
		return listaInscricaoGradeDTOs;
	}

	public void setListaInscricaoGradeDTOs(List<InscricaoGradeDTO> listaInscricaoGradeDTOs) {
		this.listaInscricaoGradeDTOs = listaInscricaoGradeDTOs;
	}

	public InscricaoGradeDTO getInscricaoGradeDTO() {
		return inscricaoGradeDTO;
	}

	public void setInscricaoGradeDTO(InscricaoGradeDTO inscricaoGradeDTO) {
		this.inscricaoGradeDTO = inscricaoGradeDTO;
	}

	public Integer getCapacidadeMaximaInscritos() {
		return capacidadeMaximaInscritos;
	}

	public void setCapacidadeMaximaInscritos(Integer capacidadeMaximaInscritos) {
		this.capacidadeMaximaInscritos = capacidadeMaximaInscritos;
	}

	public Integer getVagasParceiro() {
		return vagasParceiro;
	}

	public void setVagasParceiro(Integer vagasParceiro) {
		this.vagasParceiro = vagasParceiro;
	}

	public List<InscricaoCurso> getListaInstrutores() {
		return listaInstrutores;
	}

	public void setListaInstrutores(List<InscricaoCurso> listaInstrutores) {
		this.listaInstrutores = listaInstrutores;
	}
}
