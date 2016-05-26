package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Credenciamento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.service.GradeOficinaService;
import br.com.sisfie.service.InscricaoCursoService;

@ManagedBean(name = "credenciamentoBean")
@ViewScoped
public class CredenciamentoBean extends PaginableBean<Credenciamento> {

	private static final long serialVersionUID = -8294188998250807722L;
	
	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;
	
	@ManagedProperty(value = "#{gradeOficinaService}")
	protected GradeOficinaService gradeOficinaService;

	private boolean exibirTurma;
	private InscricaoCurso inscricaoCurso;
	private List<InscricaoGrade> listaInscricaoGrade;

	public CredenciamentoBean() {
		inicializarDados();
	}

	public void pesquisar() {
		try {
			if (getModel().getNumInscricao() != null && !getModel().getNumInscricao().isEmpty()){
				
				inscricaoCurso = inscricaoCursoService.recuperarInscricao(getModel().getNumInscricao());
				
				if (inscricaoCurso == null) {
					FacesMessagesUtil.addErrorMessage("Credenciamento", "Inscrição não encontrada!");
					return;
				}

				exibirTurma = Boolean.TRUE;
				if (inscricaoCurso.getCurso().getFlgPossuiOficina()) {
					List<Integer> ids = new ArrayList<>();
					ids.add(inscricaoCurso.getId());
					listaInscricaoGrade = gradeOficinaService.listarInscricaoGrades(inscricaoCurso.getCurso().getId(), ids);
					if (listaInscricaoGrade != null && !listaInscricaoGrade.isEmpty()){
						exibirTurma = Boolean.TRUE;
					} else {
						exibirTurma = Boolean.FALSE;
					}
				} 
			} else {
				FacesMessagesUtil.addErrorMessage("Credenciamento", "É necessário informar um número de inscrição!");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public String save() {
		if (inscricaoCurso != null && inscricaoCurso.getId() != null) {
			try {
				Credenciamento credenciamentoConsulta = new Credenciamento();
				credenciamentoConsulta.setCurso(new Curso(inscricaoCurso.getCurso().getId()));
				credenciamentoConsulta.setNumInscricao(inscricaoCurso.getInscricao());
				List<Credenciamento> listaConsulta = universalManager.listBy(credenciamentoConsulta);
				if (listaConsulta != null && !listaConsulta.isEmpty()) {
					FacesMessagesUtil.addErrorMessage("", "Já existe um credenciamento realizado para essa inscrição!");
				} else {
					getModel().setCurso(new Curso(inscricaoCurso.getCurso().getId()));
					getModel().setDataCadastro(new Date());
					getModel().setHorarioEntrada(new Date());
					getModel().setNumInscricao(inscricaoCurso.getInscricao());
					super.save();
				}
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
		inicializarDados();
		return "";
	}

	private void inicializarDados() {
		inscricaoCurso = new InscricaoCurso();
		listaInscricaoGrade = new ArrayList<>();
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
	public Credenciamento createModel() {
		return new Credenciamento();
	}

	@Override
	public String getQualifiedName() {
		return "Credenciamento";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
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

	public List<InscricaoGrade> getListaInscricaoGrade() {
		return listaInscricaoGrade;
	}

	public void setListaInscricaoGrade(List<InscricaoGrade> listaInscricaoGrade) {
		this.listaInscricaoGrade = listaInscricaoGrade;
	}

	public boolean isExibirTurma() {
		return exibirTurma;
	}

	public void setExibirTurma(boolean exibirTurma) {
		this.exibirTurma = exibirTurma;
	}
}
