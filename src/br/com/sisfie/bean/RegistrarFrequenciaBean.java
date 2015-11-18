package br.com.sisfie.bean;

import java.util.ArrayList;
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
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.HorarioService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.service.TurmaService;

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

	private Curso curso;
	private Turma turma;
	private Horario horario;
	private InscricaoGrade inscricaoGrade;
	private InscricaoCurso inscricaoCurso;
	private List<Turma> listaTurma;
	private List<Horario> listaHorario;
	private Integer quantidadeInscritos;
	private boolean exibirTurma;
	private boolean exibirHorario;
	private boolean exibirInscricao;

	public RegistrarFrequenciaBean() {
		curso = new Curso();
		turma = new Turma();
		horario = new Horario();
		inscricaoGrade = new InscricaoGrade();
		inscricaoCurso = new InscricaoCurso();
		listaTurma = new ArrayList<Turma>();
		listaHorario = new ArrayList<Horario>();
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

	public void renderizarCampoInscricao() {
		exibirInscricao = Boolean.TRUE;
	}
	
	public void registrar() {
		// TODO: Implementar.......
	}
	
	public void finalizarFrequencia() {
		// TODO: Implementar.......
	}

	public void pesquisar() {
		try {
			if (!validarCampos()) {
				return;
			}
			if (!validarCredenciamento()) {
				return;
			}
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
			if (curso.getFlgPossuiOficina()){
				inscricaoCurso = inscricaoCursoService.recupararInscricao(getModel().getNumIncricao(), curso.getId(), turma.getId(), horario.getId());
				inscricaoGrade = inscricaoCursoService.recupararInscricaoGrade(getModel().getNumIncricao(), curso.getId(), turma.getId(), horario.getId());
			} else {
				if (curso.getTurmas() != null && !curso.getTurmas().isEmpty()){
					inscricaoCurso = inscricaoCursoService.recupararInscricao(getModel().getNumIncricao(), curso.getId(), turma.getId(), null);
				} else {
					inscricaoCurso = inscricaoCursoService.recupararInscricao(getModel().getNumIncricao(), curso.getId(), null, null);
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
}
