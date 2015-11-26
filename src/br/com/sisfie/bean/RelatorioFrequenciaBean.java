package br.com.sisfie.bean;

import java.io.File;
import java.util.ArrayList;
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
import br.com.sisfie.dto.CredenciamentoDTO;
import br.com.sisfie.dto.EtiquetaDTO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Credenciamento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.service.CredenciamentoService;
import br.com.sisfie.service.CursoService;
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

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{turmaService}")
	protected TurmaService turmaService;

	@ManagedProperty(value = "#{credenciamentoService}")
	protected CredenciamentoService credenciamentoService;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	private Curso curso;
	private InscricaoCurso inscricaoCurso;
	private Integer idTurma;
	private String formato;
	private List<Turma> turmas;
	private List<Credenciamento> listaCredenciamento;
	private List<InscricaoCurso> listaInscricaoCurso;
	private boolean exibirBotaoGerarCredenciamento;

	public RelatorioFrequenciaBean() {
		curso = new Curso();
		inscricaoCurso = new InscricaoCurso();
		inscricaoCurso.setCandidato(new Candidato());
		turmas = new ArrayList<Turma>();
		listaCredenciamento = new ArrayList<Credenciamento>();
		listaInscricaoCurso = new ArrayList<InscricaoCurso>();
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

	public void gerarRelatorioEtiqueta() {
		try {
			if (!validarCurso()) {
				return;
			}

			listaInscricaoCurso = inscricaoCursoService.listarInscricoes(curso, inscricaoCurso, idTurma);

			if (listaInscricaoCurso != null && !listaInscricaoCurso.isEmpty()) {
				List<EtiquetaDTO> listaEtiquetaDTO = new ArrayList<EtiquetaDTO>();
				for (InscricaoCurso inscricaoCurso : listaInscricaoCurso) {
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

	public List<InscricaoCurso> getListaInscricaoCurso() {
		return listaInscricaoCurso;
	}

	public void setListaInscricaoCurso(List<InscricaoCurso> listaInscricaoCurso) {
		this.listaInscricaoCurso = listaInscricaoCurso;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}
}
