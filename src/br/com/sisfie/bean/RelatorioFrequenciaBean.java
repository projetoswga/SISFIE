package br.com.sisfie.bean;

import java.io.File;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import org.primefaces.event.SelectEvent;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.arquitetura.util.RelatorioUtil;
import br.com.sisfie.dto.AlunoDTO;
import br.com.sisfie.dto.CrachaDTO;
import br.com.sisfie.dto.CredenciamentoDTO;
import br.com.sisfie.dto.EtiquetaDTO;
import br.com.sisfie.dto.MapaFrequencia;
import br.com.sisfie.dto.OficinaDTO;
import br.com.sisfie.dto.crossTab.CrossTab;
import br.com.sisfie.dto.crossTab.Header;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Credenciamento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.service.CredenciamentoService;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.FrequenciaService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.TurmaService;

/**
 * @author Wesley Marra
 *
 */
@ManagedBean(name = "relatorioFrequenciaBean")
@ViewScoped
public class RelatorioFrequenciaBean extends PaginableBean<Frequencia> {

	private static final long serialVersionUID = -1076197214282604639L;
	private static final Integer MINIMO_HORAS_FREQUENCIA_TURNO = 3;
	private static final String FORMATO_EXCEL = "xls";

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{turmaService}")
	protected TurmaService turmaService;

	@ManagedProperty(value = "#{credenciamentoService}")
	protected CredenciamentoService credenciamentoService;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	@ManagedProperty(value = "#{frequenciaService}")
	protected FrequenciaService frequenciaService;

	private Curso curso;
	private InscricaoCurso inscricaoCurso;
	private Integer idTurma;
	private String formato;
	private List<Turma> turmas;
	private List<Credenciamento> listaCredenciamento;
	private List<InscricaoCurso> listaEtiquetas;
	private List<InscricaoCurso> listaCrachas;
	private List<InscricaoCurso> listaMapaFrequencia;
	private boolean exibirBotaoGerarCredenciamento;
	private boolean exibirMinutos;

	public RelatorioFrequenciaBean() {
		curso = new Curso();
		inscricaoCurso = new InscricaoCurso();
		inscricaoCurso.setCandidato(new Candidato());
		turmas = new ArrayList<Turma>();
		listaCredenciamento = new ArrayList<Credenciamento>();
		listaEtiquetas = new ArrayList<InscricaoCurso>();
		listaCrachas = new ArrayList<InscricaoCurso>();
		listaMapaFrequencia = new ArrayList<InscricaoCurso>();
	}

	@PostConstruct
	public void carregarTela() {
		try {
			formato = "pdf";
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
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

	public void buscarTurma(SelectEvent event) {
		try {
			exibirBotaoGerarCredenciamento = Boolean.FALSE;
			if (curso.getTurmas() != null && !curso.getTurmas().isEmpty()) {
				turmas = turmaService.listarTurmas(curso.getId());
				if (turmas != null && !turmas.isEmpty()) {
					exibirBotaoGerarCredenciamento = Boolean.TRUE;
				}
			} else {
				exibirBotaoGerarCredenciamento = Boolean.TRUE;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void gerarRelatorioMapaFrequencia() {
		try {
			if (!validarCurso()) {
				return;
			}

			listaMapaFrequencia = inscricaoCursoService.listarInscricoes(curso, inscricaoCurso, idTurma);

			List<AlunoDTO> listaFrequencia = new ArrayList<AlunoDTO>();

			if (listaMapaFrequencia != null && !listaMapaFrequencia.isEmpty()) {

				for (InscricaoCurso inscricaoCurso : listaMapaFrequencia) {

					AlunoDTO alunoDTO = new AlunoDTO(inscricaoCurso.getInscricao(),
							inscricaoCurso.getCandidato().getNome().toUpperCase(),
							inscricaoCurso.getCandidato().getOrgao().getNomeSiglaFormat());

					// Esta será incrementada em um dia até atingir a data final do evento
					Calendar datFrequencia = new GregorianCalendar();
					datFrequencia.setTimeInMillis(curso.getDtRealizacaoInicio().getTime());

					// Data inicio do evento
					Calendar datInicioEvento = new GregorianCalendar();
					datInicioEvento.setTimeInMillis(curso.getDtRealizacaoInicio().getTime());

					// Data fim do evento
					Calendar datFimEvento = new GregorianCalendar();
					datFimEvento.setTimeInMillis(curso.getDtRealizacaoFim().getTime());

					// Data corrente do evento
					Calendar datCorrente = Calendar.getInstance();

					DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
					do {
						FREQUENCIA manha = FREQUENCIA.A_COMPARECE;
						FREQUENCIA tarde = FREQUENCIA.A_COMPARECE;

						Calendar datHorFreqMANHA_INI = new GregorianCalendar(datFrequencia.get(Calendar.YEAR),
								datFrequencia.get(Calendar.MONTH), datFrequencia.get(Calendar.DAY_OF_MONTH), 8, 30);
						Calendar datHorFreqMANHA_FIM = new GregorianCalendar(datFrequencia.get(Calendar.YEAR),
								datFrequencia.get(Calendar.MONTH), datFrequencia.get(Calendar.DAY_OF_MONTH), 12, 30);
						Calendar datHorFreqTARDE_INI = new GregorianCalendar(datFrequencia.get(Calendar.YEAR),
								datFrequencia.get(Calendar.MONTH), datFrequencia.get(Calendar.DAY_OF_MONTH), 14, 00);
						Calendar datHorFreqTARDE_FIM = new GregorianCalendar(datFrequencia.get(Calendar.YEAR),
								datFrequencia.get(Calendar.MONTH), datFrequencia.get(Calendar.DAY_OF_MONTH), 18, 00);

						Integer minutosFrequenciaManha = 0;
						Integer minutosFrequenciaTarde = 0;

						if (datHorFreqMANHA_INI.before(datCorrente)) {

							List<Frequencia> frequencias = frequenciaService
									.pesquisarFrequenciasData(inscricaoCurso.getInscricao(), datFrequencia);

							if (null == frequencias || frequencias.isEmpty()) {
								manha = FREQUENCIA.AUSENTE;
								tarde = FREQUENCIA.AUSENTE;
							} else {

								for (Frequencia fre : frequencias) {
									if (fre.getHorarioEntrada().before(datHorFreqMANHA_FIM.getTime())) { // até 12 e 30
										/* Manhã */
										int diffInMin = (int) ((fre.getHorarioSaida().getTime()
												- fre.getHorarioEntrada().getTime()) / (1000 * 60));
										minutosFrequenciaManha += diffInMin;
									} else {
										/* Tarde */
										int diffInMin = (int) ((fre.getHorarioSaida().getTime()
												- fre.getHorarioEntrada().getTime()) / (1000 * 60));
										minutosFrequenciaTarde += diffInMin;
									}
								}

								if (minutosFrequenciaManha >= MINIMO_HORAS_FREQUENCIA_TURNO * 60)
									manha = FREQUENCIA.PRESENTE;
								else if (datHorFreqMANHA_INI.before(datCorrente) && datHorFreqMANHA_FIM.after(datCorrente)
										&& minutosFrequenciaManha > 0)
									// Está na sala mais a frequencia do turno ainda não fechou
									manha = FREQUENCIA.PRESENCA_PARCIAL;
								else
									manha = FREQUENCIA.AUSENTE;

								// Total de frequencia deu mais de 180 minutos
								if (minutosFrequenciaTarde >= MINIMO_HORAS_FREQUENCIA_TURNO * 60)
									tarde = FREQUENCIA.PRESENTE;
								else if (datHorFreqTARDE_INI.before(datCorrente) && datHorFreqTARDE_FIM.after(datCorrente)
										&& minutosFrequenciaTarde > 0)
									// Está na sala mais a frequencia do turno ainda não fechou
									tarde = FREQUENCIA.PRESENCA_PARCIAL;
								else
									tarde = FREQUENCIA.AUSENTE;
							}

							// No primeiro dia a frequência da manhã é por meio do credenciamento, se for credenciado tem frequencia
							if (datFrequencia.get(Calendar.DAY_OF_MONTH) == datInicioEvento.get(Calendar.DAY_OF_MONTH))
								if (credenciamentoService.recuperarCredenciamento(inscricaoCurso.getInscricao()) != null) {
									// Crendenciado, então tem frequencia na manhã do dia do evento
									minutosFrequenciaManha = 240;
									manha = FREQUENCIA.PRESENTE;
								}
						}

						if (exibirMinutos) {
							// EXIBIR os minutos ao invés de F, P ou PP
							alunoDTO.getMapaFrequencia().add(new MapaFrequencia(df.format(datFrequencia.getTime()) + " MANHÃ",
									minutosFrequenciaManha.toString()));
							alunoDTO.getMapaFrequencia().add(new MapaFrequencia(df.format(datFrequencia.getTime()) + " TARDE",
									minutosFrequenciaTarde.toString()));
						} else {
							alunoDTO.getMapaFrequencia()
									.add(new MapaFrequencia(df.format(datFrequencia.getTime()) + " MANHÃ", manha.getStatus()));
							alunoDTO.getMapaFrequencia()
									.add(new MapaFrequencia(df.format(datFrequencia.getTime()) + " TARDE", tarde.getStatus()));
						}

						// Próxima dia do Evento
						datFrequencia.add(Calendar.DAY_OF_MONTH, 1);
					} while (datFrequencia.before(datFimEvento) || datFrequencia.compareTo(datFimEvento) == 0);

					listaFrequencia.add(alunoDTO);
				}

				String caminho = "/jasper/mapaGeral.jasper";
				String nomeRelatorio = "MapaFrequencia";

				calcularTotalFaltas(listaFrequencia);

				Map<String, Object> map = new HashMap<String, Object>();
				map.put("image", FacesContext.getCurrentInstance().getExternalContext()
						.getRealPath("/resources/design/imagem-default/logo_esaf_relatorio.png"));
				map.put("tituloDescricaoSemana", curso.getCursoData());
				map.put("tituloDataLocal", curso.getLocalizacao().getDescricao());

				RelatorioUtil.gerarRelatorio(montarCrossTab(listaFrequencia), map, caminho, nomeRelatorio, FORMATO_EXCEL);

			} else {
				FacesMessagesUtil.addErrorMessage("", "Não há candidatos para gerar o mapa de frequência.");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private List<CrossTab> montarCrossTab(List<AlunoDTO> lista) {
		List<CrossTab> listaRetorno = new ArrayList<CrossTab>();
		Integer cont = 1;
		for (AlunoDTO list : lista) {
			Integer posicao = 1;
			// Atributos do aluno
			listaRetorno.add(new CrossTab(new Header("Nome", posicao++), cont, list.getNomeCompleto()));
			listaRetorno.add(new CrossTab(new Header("Inscrição", posicao++), cont, list.getInscricao()));
			listaRetorno.add(new CrossTab(new Header("Órgão", posicao++), cont, list.getOrgao()));
			for (MapaFrequencia frequencia : list.getMapaFrequencia()) {
				// atributos da frequencia
				listaRetorno.add(new CrossTab(new Header(frequencia.getData(), posicao++), cont, frequencia.getPresenca()));
			}
			listaRetorno.add(new CrossTab(new Header("Total Faltas", posicao++), cont, list.getTotalFaltas()));
			cont++;
		}
		return listaRetorno;
	}

	private void calcularTotalFaltas(List<AlunoDTO> listaFrequencia) {
		for (AlunoDTO alunoDTO : listaFrequencia) {
			Integer totalFaltas = 0;
			for (MapaFrequencia frequencia : alunoDTO.getMapaFrequencia()) {
				if (frequencia.getPresenca() == null || frequencia.getPresenca().isEmpty()) {
					continue;
				}
				if (frequencia.getPresenca().equalsIgnoreCase("F") || "0".equals(frequencia.getPresenca())) {
					totalFaltas++;
				}
				alunoDTO.setTotalFaltas(totalFaltas.toString());
			}
		}
	}

	@SuppressWarnings("unchecked")
	public void gerarRelatorioCrachas() {
		try {
			if (!validarCurso()) {
				return;
			}

			listaCrachas = inscricaoCursoService.listarInscricoes(curso, inscricaoCurso, idTurma);

			DateFormat hf = new SimpleDateFormat("HH:mm");

			if (listaCrachas != null && !listaCrachas.isEmpty()) {
				Horario h;
				int q = 0;
				CrachaDTO crachaDTO;
				List<CrachaDTO> listaCrachaDTO = new ArrayList<CrachaDTO>();

				for (InscricaoCurso inscricaoCurso : listaCrachas) {
					listaCrachaDTO
							.add(crachaDTO = new CrachaDTO(inscricaoCurso.getInscricao(), inscricaoCurso.getCandidato().getNome(),
									inscricaoCurso.getCandidato().getOrgao().getNomeSiglaFormat(),
									inscricaoCurso.getCandidato().getNome().split(" ")[0], null));

					InscricaoGrade inscricaoGradeConsulta = new InscricaoGrade();
					inscricaoGradeConsulta.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));
					List<InscricaoGrade> listaInscricaoGrade = universalManager.listBy(inscricaoGradeConsulta);

					if (listaInscricaoGrade != null && !listaInscricaoGrade.isEmpty()) {

						Collections.sort(listaInscricaoGrade, new Comparator<InscricaoGrade>() {
							@Override
							public int compare(InscricaoGrade o1, InscricaoGrade o2) {
								return o1.getGradeOficina().getHorario().getDesHorario().trim()
										.compareTo(o2.getGradeOficina().getHorario().getDesHorario());
							}
						});

						List<OficinaDTO> listaOficinasDTO = new ArrayList<OficinaDTO>();
						q = 1;

						for (InscricaoGrade inscricaoGrade : listaInscricaoGrade) {
							if (++q > 10)
								break;

							h = inscricaoGrade.getGradeOficina().getHorario();
							listaOficinasDTO.add(new OficinaDTO(
									"Horário \"" + h.getDesHorario() + "\" das " + hf.format(h.getDatHoraInicio().getTime())
											+ " às " + hf.format(h.getDatHoraFim().getTime()),
									inscricaoGrade.getGradeOficina().getTurma().getDescricao(),
									inscricaoGrade.getGradeOficina().getSala().getNomSala()));
						}
						crachaDTO.setOficinas(listaOficinasDTO);
					}
				}

				String caminho = "/jasper/cracha.jasper";
				String nomeRelatorio = "Crachas";

				Map<String, Object> map = new HashMap<String, Object>();
				map.put("SUBREPORT",
						FacesContext.getCurrentInstance().getExternalContext().getRealPath("/jasper/") + File.separator);

				Collections.sort(listaCrachaDTO, new Comparator<CrachaDTO>() {
					@Override
					public int compare(CrachaDTO o1, CrachaDTO o2) {
						return o1.getNomeCompleto().trim().compareTo(o2.getNomeCompleto());
					}
				});

				RelatorioUtil.gerarRelatorio(listaCrachaDTO, map, caminho, nomeRelatorio, formato);
			} else {
				FacesMessagesUtil.addErrorMessage("", "Não há candidatos para gerar os Crachás.");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void gerarRelatorioEtiqueta() {
		try {
			if (!validarCurso()) {
				return;
			}

			listaEtiquetas = inscricaoCursoService.listarInscricoes(curso, inscricaoCurso, idTurma);

			if (listaEtiquetas != null && !listaEtiquetas.isEmpty()) {
				List<EtiquetaDTO> listaEtiquetaDTO = new ArrayList<EtiquetaDTO>();
				for (InscricaoCurso inscricaoCurso : listaEtiquetas) {
					listaEtiquetaDTO.add(new EtiquetaDTO(inscricaoCurso.getCandidato().getNome(), inscricaoCurso.getInscricao()));
				}

				String caminho = "/jasper/etiqueta.jasper";
				String nomeRelatorio = "Etiqueta";

				RelatorioUtil.gerarRelatorio(listaEtiquetaDTO, caminho, nomeRelatorio, formato);
			} else {
				FacesMessagesUtil.addErrorMessage("", "Não há candidatos para gerar etiquetas.");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void gerarRelatorioCredenciamento() {
		try {
			if (!validarCurso()) {
				return;
			}

			listaCredenciamento = credenciamentoService.listarCredenciamento(curso.getId(), idTurma);

			if (listaCredenciamento != null && !listaCredenciamento.isEmpty()) {
				List<CredenciamentoDTO> listaCredenciamentoDTO = new ArrayList<CredenciamentoDTO>();
				for (Credenciamento credenciamento : listaCredenciamento) {
					InscricaoCurso inscricaoCurso = new InscricaoCurso();
					inscricaoCurso.setInscricao(credenciamento.getNumInscricao());
					inscricaoCurso = (InscricaoCurso) universalManager.listBy(inscricaoCurso).get(0);

					listaCredenciamentoDTO.add(new CredenciamentoDTO(credenciamento.getId().toString(),
							inscricaoCurso.getInscricao(), inscricaoCurso.getCandidato().getNome(),
							inscricaoCurso.getCandidato().getOrgao().getNomeSiglaFormat()));
				}

				String caminho = "/jasper/credenciamento.jasper";
				String nomeRelatorio = "Credenciamento";

				Map<String, Object> map = new HashMap<String, Object>();
				map.put("image", FacesContext.getCurrentInstance().getExternalContext()
						.getRealPath("/resources/design/imagem-default/logo_esaf_relatorio.png"));
				map.put("SUBREPORT",
						FacesContext.getCurrentInstance().getExternalContext().getRealPath("/jasper/") + File.separator);
				map.put("tituloDescricaoSemana", curso.getTitulo());
				map.put("tituloDataLocal", curso.getCursoData());
				map.put("lista", listaCredenciamentoDTO);

				RelatorioUtil.gerarRelatorio(map, caminho, nomeRelatorio, formato);
			} else {
				FacesMessagesUtil.addErrorMessage("", "Não há Credenciamento para serem exibidos.");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private boolean validarCurso() {
		if (curso == null || curso.getId() == null || curso.getId() == 0) {
			FacesMessagesUtil.addErrorMessage("", "Nenhum curso selecionado.");
			return Boolean.FALSE;
		}
		return Boolean.TRUE;
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
		return "Relatório";
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

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
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

	public TurmaService getTurmaService() {
		return turmaService;
	}

	public void setTurmaService(TurmaService turmaService) {
		this.turmaService = turmaService;
	}

	public boolean isExibirBotaoGerarCredenciamento() {
		return exibirBotaoGerarCredenciamento;
	}

	public void setExibirBotaoGerarCredenciamento(boolean exibirBotaoGerarCredenciamento) {
		this.exibirBotaoGerarCredenciamento = exibirBotaoGerarCredenciamento;
	}

	public String getFormato() {
		return formato;
	}

	public void setFormato(String formato) {
		this.formato = formato;
	}

	public List<Credenciamento> getListaCredenciamento() {
		return listaCredenciamento;
	}

	public void setListaCredenciamento(List<Credenciamento> listaCredenciamento) {
		this.listaCredenciamento = listaCredenciamento;
	}

	public CredenciamentoService getCredenciamentoService() {
		return credenciamentoService;
	}

	public void setCredenciamentoService(CredenciamentoService credenciamentoService) {
		this.credenciamentoService = credenciamentoService;
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public List<InscricaoCurso> getListaEtiquetas() {
		return listaEtiquetas;
	}

	public void setListaEtiquetas(List<InscricaoCurso> listaEtiquetas) {
		this.listaEtiquetas = listaEtiquetas;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}

	public List<InscricaoCurso> getListaCrachas() {
		return listaCrachas;
	}

	public void setListaCrachas(List<InscricaoCurso> listaCrachas) {
		this.listaCrachas = listaCrachas;
	}

	public List<InscricaoCurso> getListaMapaFrequencia() {
		return listaMapaFrequencia;
	}

	public void setListaMapaFrequencia(List<InscricaoCurso> listaMapaFrequencia) {
		this.listaMapaFrequencia = listaMapaFrequencia;
	}

	public boolean isExibirMinutos() {
		return exibirMinutos;
	}

	public void setExibirMinutos(boolean exibirMinutos) {
		this.exibirMinutos = exibirMinutos;
	}

	public FrequenciaService getFrequenciaService() {
		return frequenciaService;
	}

	public void setFrequenciaService(FrequenciaService frequenciaService) {
		this.frequenciaService = frequenciaService;
	}
}

enum FREQUENCIA {
	PRESENTE("P"), AUSENTE("F"), A_COMPARECE(""), PRESENCA_PARCIAL("PP");

	private String status;

	private FREQUENCIA(String status) {
		this.status = status;
	}

	public String getStatus() {
		return this.status;
	}
}
