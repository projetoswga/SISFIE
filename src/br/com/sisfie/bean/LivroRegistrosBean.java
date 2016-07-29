package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.arquitetura.util.RelatorioUtil;
import br.com.arquitetura.util.StringUtil;
import br.com.sisfie.dto.LivroRegistrosDTO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoCursoCertificado;
import br.com.sisfie.entidade.Turno;
import br.com.sisfie.service.CandidatoService;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.SecretariaService;

@ManagedBean(name = "livroRegistrosBean")
@ViewScoped
public class LivroRegistrosBean extends PaginableBean<InscricaoCursoCertificado> {

	private static final long serialVersionUID = -8294188998250807722L;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{candidatoService}")
	protected CandidatoService candidatoService;

	@ManagedProperty(value = "#{secretariaService}")
	protected SecretariaService secretariaService;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	private List<InscricaoCursoCertificado> listaInscricaoCursoCertificados;
	private List<LivroRegistrosDTO> listaLivroRegistroDTO;
	private Curso curso;
	private Candidato candidato;
	private boolean exibirConteudo;

	public LivroRegistrosBean() {
		listaInscricaoCursoCertificados = new ArrayList<>();
		listaLivroRegistroDTO = new ArrayList<>();
		curso = new Curso();
		candidato = new Candidato();
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

	public List<Candidato> completeCandidato(String query) {
		List<Candidato> sugestoes = new ArrayList<Candidato>();
		try {
			sugestoes = candidatoService.pesquisarCandidato(query);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return sugestoes;
	}

	public void visualizarConteudo() {
		exibirConteudo = false;
		if (curso != null && curso.getId() != null) {
			exibirConteudo = true;
		}
	}

	public void gerarRelatorio() {
		try {
			if (curso == null || curso.getId() == null) {
				FacesMessagesUtil.addErrorMessage("", "É necessário escolher um curso!");
				return;
			}

			listaInscricaoCursoCertificados = secretariaService.listarInscricaoCursoCertificados(curso, candidato);

			if (listaInscricaoCursoCertificados != null && !listaInscricaoCursoCertificados.isEmpty()) {

				listaLivroRegistroDTO = new ArrayList<>();
				for (InscricaoCursoCertificado inscricaoCursoCertificado : listaInscricaoCursoCertificados) {
					LivroRegistrosDTO livroRegistrosDTO = new LivroRegistrosDTO();
					livroRegistrosDTO.setAnoCorrente(String.valueOf(Calendar.getInstance().get(Calendar.YEAR)));
					if (curso.getFlgPossuiOficina()) {
						livroRegistrosDTO.setCargaHoraria(
								inscricaoCursoCertificado.getInscricaoCurso().getCurso().getCargaHoraria().toString());
					} else {
						livroRegistrosDTO
								.setCargaHoraria(getCargaHoraria(inscricaoCursoCertificado.getInscricaoCurso().getCurso()));
					}
					if (inscricaoCursoCertificado.getInscricaoCurso().getFlgInstrutor()) {
						livroRegistrosDTO
								.setConteudoProgramaticoDocente(inscricaoCursoCertificado.getConteudoProgramaticoDocente());
					} else {
						livroRegistrosDTO.setConteudoProgramaticoParticipante(
								inscricaoCursoCertificado.getConteudoProgramaticoParticipante());
					}
					livroRegistrosDTO.setDataAtualRegistro(inscricaoCursoCertificado.getInscricaoCurso().getDtCadastroFormat());
					livroRegistrosDTO.setDiretor("Campo ainda não acrescentado no módulo Secretaria");
					InscricaoCurso docente = inscricaoCursoService.recuperarDocente(
							inscricaoCursoCertificado.getInscricaoCurso().getCurso().getId(),
							inscricaoCursoCertificado.getInscricaoCurso().getTurma());
					if (docente != null) {
						livroRegistrosDTO.setDocente(docente.getCandidato().getNome());
					}
					livroRegistrosDTO.setLocalizacaoCurso(
							inscricaoCursoCertificado.getInscricaoCurso().getCurso().getLocalizacao().getDescricao());
					livroRegistrosDTO.setNomeCandidato(inscricaoCursoCertificado.getInscricaoCurso().getCandidato().getNome());
					livroRegistrosDTO.setNumeroProjeto(StringUtil.format("##.##.##.#####.##.##",
							inscricaoCursoCertificado.getInscricaoCurso().getCurso().getCodigo()));
					livroRegistrosDTO.setPeriodoRealizacao(
							inscricaoCursoCertificado.getInscricaoCurso().getCurso().getPeriodoRealizacaoCurso());
					livroRegistrosDTO.setRegistroAtual("Campo ainda não definido");
					livroRegistrosDTO.setRegistroInicial("Campo ainda não definido");
					livroRegistrosDTO.setTituloCurso(inscricaoCursoCertificado.getInscricaoCurso().getCurso().getTitulo());
					livroRegistrosDTO.setUsuario(inscricaoCursoCertificado.getInscricaoCurso().getCurso().getUsuario().getNome());
					listaLivroRegistroDTO.add(livroRegistrosDTO);
				}

				RelatorioUtil.gerarRelatorio(listaLivroRegistroDTO, new HashMap<String, Object>(), "/jasper/livroRegistros.jasper",
						"Livro_Registros", "pdf");
			} else {
				FacesMessagesUtil.addInfoMessage("Nenhum registro encontrado!");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private String getCargaHoraria(Curso curso) {
		Calendar inicioCurso = Calendar.getInstance();
		inicioCurso.setTime(curso.getDtRealizacaoInicio());

		Calendar fimCurso = Calendar.getInstance();
		fimCurso.setTime(curso.getDtRealizacaoFim());

		int qtdDiasCurso = fimCurso.get(Calendar.DAY_OF_YEAR) - inicioCurso.get(Calendar.DAY_OF_YEAR);
		int cargaHorariaCurso = qtdDiasCurso * 8;

		if (curso.getTurno() != null && curso.getTurno().getId() != null && !curso.getTurno().getId().equals(Turno.AMBOS)) {
			cargaHorariaCurso /= 2;
		}
		return String.valueOf(cargaHorariaCurso);
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	@PostConstruct
	public void verificarAcesso() {
	}

	@Override
	public InscricaoCursoCertificado createModel() {
		return new InscricaoCursoCertificado();
	}

	@Override
	public String getQualifiedName() {
		return "Livro de Registros";
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

	public SecretariaService getSecretariaService() {
		return secretariaService;
	}

	public void setSecretariaService(SecretariaService secretariaService) {
		this.secretariaService = secretariaService;
	}

	public List<InscricaoCursoCertificado> getListaInscricaoCursoCertificados() {
		return listaInscricaoCursoCertificados;
	}

	public void setListaInscricaoCursoCertificados(List<InscricaoCursoCertificado> listaInscricaoCursoCertificados) {
		this.listaInscricaoCursoCertificados = listaInscricaoCursoCertificados;
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

	public boolean isExibirConteudo() {
		return exibirConteudo;
	}

	public void setExibirConteudo(boolean exibirConteudo) {
		this.exibirConteudo = exibirConteudo;
	}

	public List<LivroRegistrosDTO> getListaLivroRegistroDTO() {
		return listaLivroRegistroDTO;
	}

	public void setListaLivroRegistroDTO(List<LivroRegistrosDTO> listaLivroRegistroDTO) {
		this.listaLivroRegistroDTO = listaLivroRegistroDTO;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}
}
