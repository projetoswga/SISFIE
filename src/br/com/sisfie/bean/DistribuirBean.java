package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.excecao.DistribuicaoException;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.DistribuirService;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "distribuirBean")
@ViewScoped
public class DistribuirBean extends BaseBean<Curso> {

	private static final long serialVersionUID = -507533115478637909L;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{distribuirService}")
	protected DistribuirService distribuirService;

	private List<Curso> cursos;

	private Integer idCurso;

	@PostConstruct
	public void carregarTela() {
		verificarAcesso();
	}

	public void distribuir() {
		try {
			distribuirService.distrbuirInscritos(new Curso(idCurso));
			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), this.getSaveMessage() + " " + ConstantesARQ.COM_SUCESSO);
			idCurso = null;
		} catch (Exception e) {
			if (e instanceof DistribuicaoException) {
				FacesMessagesUtil.addErrorMessage("Erro ao distribuir. ", e.getMessage());
			} else {
				ExcecaoUtil.tratarExcecao(e);
				FacesMessagesUtil.addErrorMessage("Erro ao distribuir. ", e.getMessage());
			}
		}
	}

	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_DISTRIBUIR");
	}

	public String getQualifiedName() {
		return "Distrbuir Inscritos";
	}

	public List<Curso> getCursos() {
		if (cursos == null || cursos.isEmpty()) {
			try {
				cursos = new ArrayList<Curso>();
				Usuario user = (Usuario) getSessionMap().get(Constantes.USUARIO_SESSAO);
				cursos = cursoService.recuperarCursosComOficinaNaoDistribuidos(user);
				Collections.sort(cursos, new Comparator<Curso>() {
					@Override
					public int compare(Curso o1, Curso o2) {
						return o1.getTitulo().trim().compareTo(o2.getTitulo());
					}
				});
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
		return cursos;
	}

	public void setCursos(List<Curso> cursos) {
		this.cursos = cursos;
	}

	public Integer getIdCurso() {
		return idCurso;
	}

	public void setIdCurso(Integer idCurso) {
		this.idCurso = idCurso;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	@Override
	public Curso createModel() {
		return null;
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public DistribuirService getDistribuirService() {
		return distribuirService;
	}

	public void setDistribuirService(DistribuirService distribuirService) {
		this.distribuirService = distribuirService;
	}

}
