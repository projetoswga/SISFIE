package br.com.sisfie.bean;

import java.io.File;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;
import javax.faces.model.SelectItem;

import org.primefaces.event.SelectEvent;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.DateUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.arquitetura.util.RelatorioUtil;
import br.com.arquitetura.util.StringUtil;
import br.com.sisfie.dto.CandidatosInscritosDTO;
import br.com.sisfie.dto.DetailCandidatosInscritosDTO;
import br.com.sisfie.dto.ExportarCandidatosInscritosDTO;
import br.com.sisfie.dto.RelatorioPesquisaDTO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.MunicipioCurso;
import br.com.sisfie.entidade.Orgao;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.service.CandidatoService;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.OrgaoService;
import br.com.sisfie.service.TurmaService;
import br.com.sisfie.service.impl.InscricaoCursoServiceImpl;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "relatorioCandidatoInscritoBean")
@ViewScoped
public class RelatorioCandidatoInscritoBean extends BaseBean<Candidato> {

	@ManagedProperty(value = "#{candidatoService}")
	protected CandidatoService candidatoService;

	@ManagedProperty(value = "#{OrgaoService}")
	protected OrgaoService orgaoService;

	@ManagedProperty(value = "#{turmaService}")
	protected TurmaService turmaService;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;
	
	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	private static final long serialVersionUID = -6193703505151419776L;

	public static final Integer CONFIRMADO = 1;
	public static final Integer PENDENTE = 2;
	public static final Integer LISTA_ESPERA = 3;

	private Date dataHj;
	private MunicipioCurso municipioCurso;
	private Curso curso;
	private Integer idTurma;
	private Orgao orgao;
	private Orgao orgaoSolicitante;
	private Date dtInicial;
	private Date dtFinal;
	private String formato;
	private List<SelectItem> turmas;
	private Integer idSituacaoInscricao;
	private List<SelectItem> situacaoInscricoes;
	private List<ExportarCandidatosInscritosDTO> listaInscritos;
	private Integer countInscricao;

	public RelatorioCandidatoInscritoBean() {
		dataHj = new Date();
		municipioCurso = new MunicipioCurso();
		orgao = new Orgao();
		turmas = new ArrayList<SelectItem>();
		turmas.add(new SelectItem("", "Seleciona o curso"));
		listaInscritos = new ArrayList<ExportarCandidatosInscritosDTO>();
	}

	@PostConstruct
	public void carregarTela() {
		try {
			formato = "pdf";
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

	public void gerarRelatorio() {
		try {

			RelatorioPesquisaDTO relatorioPesquisaDTO = new RelatorioPesquisaDTO(curso, orgaoSolicitante, orgao, dtInicial, dtFinal,
					new Turma(idTurma), idSituacaoInscricao);

			List<InscricaoCurso> listaInscricaoCurso = candidatoService.listarCandidatosInscritos(relatorioPesquisaDTO);
			if (listaInscricaoCurso == null || listaInscricaoCurso.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("", "Nenhum registro encontrado.");
				return;
			}

			List<InscricaoCurso> listaCandidatos = new ArrayList<InscricaoCurso>(listaInscricaoCurso);

			List<CandidatosInscritosDTO> listareRelatoriosDTOs = new ArrayList<CandidatosInscritosDTO>();
			CandidatosInscritosDTO dto = new CandidatosInscritosDTO();
			DetailCandidatosInscritosDTO detailCandidatosInscritosDTO = new DetailCandidatosInscritosDTO();

			// cursos ja adicionados
			Set<Integer> idsAdicionados = new HashSet<Integer>();

			// pega os cursos
			for (InscricaoCurso item : listaInscricaoCurso) {
				if (!idsAdicionados.contains(item.getCurso().getId())) {
					dto = new CandidatosInscritosDTO();

					dto.setCaminho(FacesContext.getCurrentInstance().getExternalContext().getRealPath("/jasper/") + File.separator);

					dto.setCodCurso(StringUtil.format("##.##.##.#####.##.##", item.getCurso().getCodigo()));
					dto.setLocal(item.getCurso().getLocalizacao().getDescricao());
					dto.setNomeCurso(item.getCurso().getTitulo());
					if (item.getCurso().getOrgao() != null && item.getCurso().getOrgao().getNomeSiglaFormat() != null) {
						dto.setNomeOrgao(item.getCurso().getOrgao().getNomeSiglaFormat());
					} else {
						dto.setNomeOrgao("");
					}
					dto.setPeriodo(DateUtil.getDataHora(item.getCurso().getDtRealizacaoInicio(), "dd/MM/yyyy") + " à "
							+ DateUtil.getDataHora(item.getCurso().getDtRealizacaoFim(), "dd/MM/yyyy"));
					// Se tiver filtro de turma usa o do Filtro.
					if (idTurma != null && idTurma != 0) {
						Turma turma = (Turma) universalManager.get(Turma.class, idTurma);
						dto.setTurma(turma.getDescricao());
					} else {
						dto.setTurma(formatTurmas(item));
					}

					// Implementação para instrutores
					// dto.setInstrutores(formatarInstrutores(item));
					idsAdicionados.add(item.getCurso().getId());

					// coloca todos os inscritos daquele curso
					Integer contador = 1;
					for (InscricaoCurso inscricaoCurso : listaCandidatos) {
						if (inscricaoCurso.getCurso().getId().equals(item.getCurso().getId())) {
							detailCandidatosInscritosDTO = new DetailCandidatosInscritosDTO();

							detailCandidatosInscritosDTO.setContador(contador.toString());
							contador++;
							detailCandidatosInscritosDTO.setCargo(candidatoService.recuperarCargoAtivo(inscricaoCurso.getCandidato()
									.getId()));
							if (inscricaoCurso.getCandidato().getCpf() != null && !inscricaoCurso.getCandidato().getCpf().isEmpty()) {
								detailCandidatosInscritosDTO.setCpf(StringUtil.format("###.###.###-##", inscricaoCurso.getCandidato()
										.getCpf()));
							} else {
								detailCandidatosInscritosDTO.setCpf("");
							}

							if (inscricaoCurso.getCandidato().getOrgao() != null
									&& inscricaoCurso.getCandidato().getOrgao().getSigla() != null) {
								detailCandidatosInscritosDTO.setOrgao(inscricaoCurso.getCandidato().getOrgao().getSigla());
							} else {
								detailCandidatosInscritosDTO.setOrgao("");
							}

							detailCandidatosInscritosDTO.setEmail(inscricaoCurso.getCandidato().getEmailInstitucional());
							if (inscricaoCurso.getCandidato().getEmailChefe() != null) {
								detailCandidatosInscritosDTO.setEmailChefe(inscricaoCurso.getCandidato().getEmailChefe());
							} else {
								detailCandidatosInscritosDTO.setEmailChefe("");
							}
							if (inscricaoCurso.getCandidato().getMatricula() != null) {
								detailCandidatosInscritosDTO.setMatricula(inscricaoCurso.getCandidato().getMatricula());
							} else {
								detailCandidatosInscritosDTO.setMatricula("");
							}
							detailCandidatosInscritosDTO.setNomeCandidato(inscricaoCurso.getCandidato().getNome());

							if (dto.getTurma() != null) {
								detailCandidatosInscritosDTO.setTurma(dto.getTurma());
							} else {
								detailCandidatosInscritosDTO.setTurma("");
							}

							dto.getListaDetailCandidatosInscritosDTOs().add(detailCandidatosInscritosDTO);

						}
					}

					listareRelatoriosDTOs.add(dto);

				}

			}

			String caminho = "/jasper/Inscritos.jasper";

			Map<String, Object> map = new HashMap<String, Object>();

			map.put("dataAtual", DateUtil.getDataHora(new Date(), "dd/MM/yyyy"));
			map.put("IMAGE",
					FacesContext.getCurrentInstance().getExternalContext()
							.getRealPath("/resources/design/imagem-default/logo_esaf_relatorio.png"));

			map.put("SUBREPORT_DIR", FacesContext.getCurrentInstance().getExternalContext().getRealPath("/jasper/") + File.separator);
			map.put("LISTA", listareRelatoriosDTOs);

			RelatorioUtil.gerarRelatorio(map, caminho, "Relacao_Inscritos", formato);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private String formatTurmas(InscricaoCurso inscricaoCurso) {

		// Adiciona os instrutores
		String turmas = "";
		int count = 0;
		if (inscricaoCurso.getCurso() != null){
			if (inscricaoCurso.getCurso().getFlgPossuiOficina()){
				List<InscricaoGrade> inscricaoGrades = inscricaoCursoService.listarInscricaoGrade(inscricaoCurso);
				for (InscricaoGrade inscricaoGrade : inscricaoGrades) {
					if (count == 0) {
						turmas = inscricaoGrade.getGradeOficina().getTurma().getDescricao();
						count++;
					} else {
						turmas = turmas + ", " + inscricaoGrade.getGradeOficina().getTurma().getDescricao();
					}
				}
			} else {
				if (inscricaoCurso.getCurso().getTurmas() != null) {
					// Ordena as turmas por ordem alfabetica
					List<Turma> listaOrdenada = new ArrayList<Turma>(inscricaoCurso.getCurso().getTurmas());
					Collections.sort(listaOrdenada, new Comparator<Turma>() {
						@Override
						public int compare(Turma o1, Turma o2) {
							return o1.getDescricao().trim().compareToIgnoreCase(o2.getDescricao().trim());
						}
					});
					
					for (Turma turma : listaOrdenada) {
						if (count == 0) {
							turmas = turma.getDescricao();
							count++;
						} else {
							turmas = turmas + ", " + turma.getDescricao();
						}
					}
				}
			}
		}

		return turmas;

	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		Curso a = new Curso();
		a.setTitulo(query);
		try {
			List<Curso> listaBanco = cursoService.recuperarCursos(a);
			if (listaBanco != null && !listaBanco.isEmpty()) {
				for (Curso curso : listaBanco) {
					if (curso.getUsuario().getId().equals(loginBean.getModel().getId())
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

	public void buscarTurma(SelectEvent event) {
		try {
			if (curso == null || curso.getId() == null || curso.getId() == 0) {
				turmas = new ArrayList<SelectItem>();
				turmas.add(new SelectItem("", "Curso sem turma cadastrada"));
				idTurma = null;
			} else {
				List<Turma> turmasAux = turmaService.listarTurmas(curso.getId());
				turmas = new ArrayList<SelectItem>();
				if (turmasAux != null && !turmasAux.isEmpty()) {
					turmas.add(new SelectItem("", "Selecione"));
					for (Turma turma : turmasAux) {
						turmas.add(new SelectItem(turma.getId(), turma.getDescricao()));
					}
				} else {
					turmas.add(new SelectItem("", "Curso sem turma cadastrada"));
				}
			}

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void buscarInscritos() {
		try {
			listaInscritos = new ArrayList<ExportarCandidatosInscritosDTO>();
			RelatorioPesquisaDTO relatorioPesquisaDTO = new RelatorioPesquisaDTO(curso, orgaoSolicitante, orgao, dtInicial, dtFinal,
					new Turma(idTurma), idSituacaoInscricao);
			List<InscricaoCurso> listaInscricaoCurso = candidatoService.listarCandidatosInscritos(relatorioPesquisaDTO);
			if (listaInscricaoCurso == null || listaInscricaoCurso.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("", "Nenhum registro encontrado.");
				return;
			}

			for (InscricaoCurso inscricaoCurso : listaInscricaoCurso) {
				ExportarCandidatosInscritosDTO dto = new ExportarCandidatosInscritosDTO();
				if (inscricaoCurso.getCandidato().getCpf() != null) {
					dto.setCPFDocEstrangeiro(StringUtil.format("###.###.###-##", inscricaoCurso.getCandidato().getCpf()));
				} else {
					dto.setCPFDocEstrangeiro(inscricaoCurso.getCandidato().getCpf());
				}
				dto.setEmailChefia(inscricaoCurso.getCandidato().getEmailChefe());
				dto.setEmailInstitucional(inscricaoCurso.getCandidato().getEmailInstitucional());
				dto.setInscricao(inscricaoCurso.getInscricao());
				dto.setMatricula(inscricaoCurso.getCandidato().getMatricula());
				dto.setMunicipio(inscricaoCurso.getCandidato().getMunicipioOrgao().getDescricao());
				dto.setNome(inscricaoCurso.getCandidato().getNome());
				dto.setNomeOrgao(inscricaoCurso.getCandidato().getOrgao().getNomeSiglaFormat());
				dto.setStatus(inscricaoCurso.getUltimoStatus().getStatus().getDescricao());
				dto.setTelComercial(inscricaoCurso.getCandidato().getTelComercial());
				if (inscricaoCurso.getTurma() != null){
					dto.setTurma(inscricaoCurso.getTurma().getDescricao());
				}
				dto.setCurso(inscricaoCurso.getCurso().getCursoData());
				dto.setUf(inscricaoCurso.getCandidato().getMunicipioOrgao().getUf().getSigla());
				listaInscritos.add(dto);
			}
			countInscricao = listaInscritos.size();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@Override
	public void verificarAcesso() {
	}

	@Override
	public Candidato createModel() {
		return null;
	}

	@Override
	public String getQualifiedName() {
		return "Candidatos inscritos";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Date getDataHj() {
		return dataHj;
	}

	public void setDataHj(Date dataHj) {
		this.dataHj = dataHj;
	}

	public CandidatoService getCandidatoService() {
		return candidatoService;
	}

	public void setCandidatoService(CandidatoService candidatoService) {
		this.candidatoService = candidatoService;
	}

	public MunicipioCurso getMunicipioCurso() {
		return municipioCurso;
	}

	public void setMunicipioCurso(MunicipioCurso municipioCurso) {
		this.municipioCurso = municipioCurso;
	}

	public Orgao getOrgao() {
		return orgao;
	}

	public void setOrgao(Orgao orgao) {
		this.orgao = orgao;
	}

	public Date getDtInicial() {
		return dtInicial;
	}

	public void setDtInicial(Date dtInicial) {
		this.dtInicial = dtInicial;
	}

	public Date getDtFinal() {
		return dtFinal;
	}

	public void setDtFinal(Date dtFinal) {
		this.dtFinal = dtFinal;
	}

	public OrgaoService getOrgaoService() {
		return orgaoService;
	}

	public void setOrgaoService(OrgaoService orgaoService) {
		this.orgaoService = orgaoService;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public String getFormato() {
		return formato;
	}

	public void setFormato(String formato) {
		this.formato = formato;
	}

	public TurmaService getTurmaService() {
		return turmaService;
	}

	public void setTurmaService(TurmaService turmaService) {
		this.turmaService = turmaService;
	}

	public Integer getIdTurma() {
		return idTurma;
	}

	public void setIdTurma(Integer idTurma) {
		this.idTurma = idTurma;
	}

	public List<SelectItem> getTurmas() {
		return turmas;
	}

	public void setTurmas(List<SelectItem> turmas) {
		this.turmas = turmas;
	}

	public Orgao getOrgaoSolicitante() {
		return orgaoSolicitante;
	}

	public void setOrgaoSolicitante(Orgao orgaoSolicitante) {
		this.orgaoSolicitante = orgaoSolicitante;
	}

	public Integer getIdSituacaoInscricao() {
		return idSituacaoInscricao;
	}

	public void setIdSituacaoInscricao(Integer idSituacaoInscricao) {
		this.idSituacaoInscricao = idSituacaoInscricao;
	}

	public List<SelectItem> getSituacaoInscricoes() {
		situacaoInscricoes = new ArrayList<SelectItem>();
		situacaoInscricoes.add(new SelectItem(0, "Selecione"));
		situacaoInscricoes.add(new SelectItem(1, "Confirmados"));
		situacaoInscricoes.add(new SelectItem(2, "Pendentes"));
		situacaoInscricoes.add(new SelectItem(3, "Lista de Espera"));
		return situacaoInscricoes;
	}

	public void setSituacaoInscricoes(List<SelectItem> situacaoInscricoes) {
		this.situacaoInscricoes = situacaoInscricoes;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public List<ExportarCandidatosInscritosDTO> getListaInscritos() {
		return listaInscritos;
	}

	public void setListaInscritos(List<ExportarCandidatosInscritosDTO> listaInscritos) {
		this.listaInscritos = listaInscritos;
	}

	public Integer getCountInscricao() {
		return countInscricao;
	}

	public void setCountInscricao(Integer countInscricao) {
		this.countInscricao = countInscricao;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}

}
