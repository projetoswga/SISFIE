package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "turmaBean")
@ViewScoped
public class TurmaBean extends PaginableBean<Turma> {

	private static final long serialVersionUID = -8294188998250807722L;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	private Integer idCurso;
	private List<Curso> cursos;

	public TurmaBean() {
		cursos = new ArrayList<Curso>();
	}

	@PostConstruct
	public void carregarTela() {
		verificarAcesso();
		if (cursos.isEmpty()) {
			try {
				Usuario user = (Usuario) getSessionMap().get(Constantes.USUARIO_SESSAO);
				List<Curso> listaBanco = cursoService.recuperarCursosAtivos();
				if (listaBanco != null && !listaBanco.isEmpty()) {
					for (Curso curso : listaBanco) {
						if ((curso.getUsuario().getId().equals(user.getId()) && acessoBean.verificarAcesso("ROLE_TURMA"))
								|| acessoBean.verificarAcesso("ROLE_PESQ_ACESSO_GERAL")) {
							cursos.add(curso);
						}
					}
				}
				//cursos = cursoService.recuperarCursosAtivos(user);
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
	}

	@Override
	public String save() {
		try {
			getModel().setCurso((Curso) universalManager.get(Curso.class, idCurso));
			super.save();
			limparCampos();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return "";
	}

	private void limparCampos() {
		setModel(createModel());
		idCurso = null;
	}

	@Override
	public String load() {
		idCurso = getModel().getCurso().getId();
		return super.load();
	}

	@Override
	public void verificarAcesso() {
		// acessoBean.bloquearTela("ROLE_TURMA");
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public Turma createModel() {
		return new Turma();
	}

	@Override
	public String getQualifiedName() {
		return "Turma";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}

	public Integer getIdCurso() {
		return idCurso;
	}

	public void setIdCurso(Integer idCurso) {
		this.idCurso = idCurso;
	}

	public List<Curso> getCursos() {
		return cursos;
	}

	public void setCursos(List<Curso> cursos) {
		this.cursos = cursos;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}
}