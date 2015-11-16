package br.com.sisfie.bean;

import java.util.Date;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.context.FacesContext;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.service.CursoService;

@ManagedBean(name = "confirmarInscricaoBean")
@ViewScoped
public class ConfirmarInscricaoBean extends BaseBean<InscricaoCurso> {

	private static final long serialVersionUID = 1L;

	// service
	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	private boolean mostrarErro;

	@PostConstruct
	public void carregarTela() {
		mostrarErro = false;
		try {
			String hashCandidato = FacesContext.getCurrentInstance().getExternalContext().getRequestParameterMap().get("hash");
			InscricaoCurso inscricaoCurso = cursoService.recuperarInscricaoPeloHash(hashCandidato);
			if (inscricaoCurso != null) {
				setModel(inscricaoCurso);
			} else {
				mostrarErro = true;
				return;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void confirmar() {
		try {

			StatusInscricao statusInscricao = new StatusInscricao(getModel(), loginBean.getModel(),
					new Status(Status.CONFIRMADO_PELO_CHEFE), new Date());

			universalManager.save(statusInscricao);
			getModel().setUltimoStatus(new StatusInscricao(statusInscricao.getId()));
			universalManager.save(getModel());

			FacesContext.getCurrentInstance().getExternalContext().redirect("informacao.jsf");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	public void naoConfirmar() {
		try {
			StatusInscricao statusInscricao = new StatusInscricao(getModel(), loginBean.getModel(), new Status(Status.CANCELADO),
					new Date());

			universalManager.save(statusInscricao);
			getModel().setUltimoStatus(new StatusInscricao(statusInscricao.getId()));
			universalManager.save(getModel());

			FacesContext.getCurrentInstance().getExternalContext().redirect("informacao.jsf");
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@Override
	public InscricaoCurso createModel() {
		return new InscricaoCurso();
	}

	@Override
	public String getQualifiedName() {
		return "Confirmação";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public boolean isMostrarErro() {
		return mostrarErro;
	}

	public void setMostrarErro(boolean mostrarErro) {
		this.mostrarErro = mostrarErro;
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

	@Override
	public void verificarAcesso() {

	}

}
