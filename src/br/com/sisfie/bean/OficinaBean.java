package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "oficinaBean")
@ViewScoped
public class OficinaBean extends PaginableBean<Oficina> {

	private static final long serialVersionUID = 2478859934470511191L;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	private List<Curso> cursos;
	private Integer idCurso;
	private Date hoje;

	public OficinaBean() {
		hoje = new Date();
		cursos = new ArrayList<Curso>();
	}

	@PostConstruct
	public void carregarTela() {
		if (cursos.isEmpty()) {
			try {
				Usuario user = (Usuario) getSessionMap().get(Constantes.USUARIO_SESSAO);
				cursos = cursoService.recuperarCursosComOficina(user);
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
		getModel().setCurso((Curso) universalManager.get(Curso.class, idCurso));
		return super.save();
	}

	@Override
	public String load() {
		idCurso = getModel().getCurso().getId();
		return super.load();
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {
	}

	@Override
	public Oficina createModel() {
		return new Oficina();
	}

	@Override
	public String getQualifiedName() {
		return "Oficina";
	}

	@Override
	public boolean isFeminino() {
		return true;
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

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Date getHoje() {
		return hoje;
	}

	public void setHoje(Date hoje) {
		this.hoje = hoje;
	}

	public Integer getIdCurso() {
		return idCurso;
	}

	public void setIdCurso(Integer idCurso) {
		this.idCurso = idCurso;
	}

}
