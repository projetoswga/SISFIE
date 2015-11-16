package br.com.sisfie.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.InscricaoCursoService;

/**
 * Classe criada somente para poder atualizar o último status inscrição dos candidados dos cursos em produção na esaf que foram executados
 * antes da alteração na base de dados. Isso de fez necessário por não termos acesso a base de produção do SERPRO.
 * 
 * @author Wesley Marra
 * 
 */
@ManagedBean(name = "atualizarUltimoStatusInscricaoBean")
@ViewScoped
public class AtualizarUltimoStatusInscricaoBean implements Serializable {

	private static final long serialVersionUID = 7107370172441731371L;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	private Curso curso;
	private List<InscricaoCurso> listaInscricaoCurso;
	private List<Curso> listaCurso;
	
	public AtualizarUltimoStatusInscricaoBean() {
		curso = new Curso();
		listaInscricaoCurso = new ArrayList<InscricaoCurso>();
		listaCurso = new ArrayList<Curso>();
	}

	public void pesquisar() {
		try {
			List<Curso> listaCursoBanco = cursoService.recuperarCursosComInscricoes(curso);
			if (listaCursoBanco != null && !listaCursoBanco.isEmpty()) {
				Long countInscricoesSemUltimoStatus;
				for (Curso curso : listaCursoBanco) {
					countInscricoesSemUltimoStatus = inscricaoCursoService.recuperInscricoesSemUltimoStatus(curso);
					if (countInscricoesSemUltimoStatus != null && countInscricoesSemUltimoStatus != 0) {
						listaCurso.add(curso);
					}
				}
				if (listaCurso == null || listaCurso.isEmpty()){
					FacesMessagesUtil.addInfoMessage("", "Não há curso(s) para ser(em) atualizado(s).");
				}
			} else {
				FacesMessagesUtil.addInfoMessage("", "Não há curso(s) para ser(em) atualizado(s).");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public List<Curso> completeCurso(String query) {
		List<Curso> listaBanco = new ArrayList<Curso>();
		Curso curso = new Curso();
		curso.setTitulo(query);
		try {
			listaBanco = cursoService.recuperarCursos(curso);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return listaBanco;
	}

	public void atualizar(Curso cursoSelecionado) {
		try {
			if (cursoSelecionado != null && cursoSelecionado.getId() != null) {
				listaInscricaoCurso = inscricaoCursoService.recuperarInscricoes(cursoSelecionado.getId());
				if (listaInscricaoCurso != null && !listaInscricaoCurso.isEmpty()) {
					for (InscricaoCurso inscricaoCurso : listaInscricaoCurso) {
						StatusInscricao ultimoStatus = cursoService.getUltimoStatusInscricao(inscricaoCurso);
						inscricaoCurso.setUltimoStatus(new StatusInscricao(ultimoStatus.getId()));
					}
					inscricaoCursoService.atualizarUltimoStatusInscricao(listaInscricaoCurso);
					FacesMessagesUtil.addInfoMessage("", "Operação realizada com sucesso.");
				} else {
					FacesMessagesUtil.addInfoMessage("", "Nenhuma inscrição encontrada para o curso selecionado.");
				}
				limparDados();
			} else {
				FacesMessagesUtil.addErrorMessage("Erro!", "É necessário selecionar um curso para realizar a atualização.");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void limparDados() {
		curso = new Curso();
		listaInscricaoCurso = new ArrayList<InscricaoCurso>();
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public List<InscricaoCurso> getListaInscricaoCurso() {
		return listaInscricaoCurso;
	}

	public void setListaInscricaoCurso(List<InscricaoCurso> listaInscricaoCurso) {
		this.listaInscricaoCurso = listaInscricaoCurso;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}

	public List<Curso> getListaCurso() {
		return listaCurso;
	}

	public void setListaCurso(List<Curso> listaCurso) {
		this.listaCurso = listaCurso;
	}
}
