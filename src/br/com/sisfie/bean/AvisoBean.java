package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.util.Constantes;

@ManagedBean
@ViewScoped
public class AvisoBean extends BaseBean<InscricaoCurso> {

	private static final long serialVersionUID = -8294188998250807722L;

	private List<InscricaoCurso> candidatosCancelados;

	private Curso cursoPesqCandidatoCancelado;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	private boolean mostarTabela;
	
	public void carregarCandidatos() {
		try {

			candidatosCancelados = cursoService.carregarListaCandidatoCancelados(cursoPesqCandidatoCancelado);

			// Organiza por data
			Collections.sort(candidatosCancelados, new Comparator<InscricaoCurso>() {
				@Override
				public int compare(InscricaoCurso o1, InscricaoCurso o2) {
					return o2.getUltimoStatus().getDtAtualizacao().compareTo(o1.getUltimoStatus().getDtAtualizacao());
				}
			});

			mostarTabela = true;
			
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
			return;
		}
	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		Curso a = new Curso();
		a.setTitulo(query);

		try {
			Usuario user = (Usuario) getSessionMap().get(Constantes.USUARIO_SESSAO);
			a.setUsuario(new Usuario(user.getId()));
			sugestoes = cursoService.recuperarCursosSemOficina(a);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;

	}

	public void limparCampos() {
		candidatosCancelados = new ArrayList<InscricaoCurso>();
		cursoPesqCandidatoCancelado = new Curso();
		mostarTabela= false;
	}

	@Override
	public void verificarAcesso() {
	}

	@Override
	public InscricaoCurso createModel() {
		return null;
	}

	@Override
	public String getQualifiedName() {
		return null;
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public List<InscricaoCurso> getCandidatosCancelados() {
		return candidatosCancelados;
	}

	public void setCandidatosCancelados(List<InscricaoCurso> candidatosCancelados) {
		this.candidatosCancelados = candidatosCancelados;
	}

	public Curso getCursoPesqCandidatoCancelado() {
		return cursoPesqCandidatoCancelado;
	}

	public void setCursoPesqCandidatoCancelado(Curso cursoPesqCandidatoCancelado) {
		this.cursoPesqCandidatoCancelado = cursoPesqCandidatoCancelado;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public boolean isMostarTabela() {
		return mostarTabela;
	}

	public void setMostarTabela(boolean mostarTabela) {
		this.mostarTabela = mostarTabela;
	}

}
