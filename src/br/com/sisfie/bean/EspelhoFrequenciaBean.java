package br.com.sisfie.bean;

import java.util.Map;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.service.FrequenciaService;

/**
 * @author Wesley Marra
 *
 */
@ManagedBean(name = "espelhoFrequenciaBean")
@ViewScoped
public class EspelhoFrequenciaBean extends PaginableBean<Frequencia> {

	private static final long serialVersionUID = 1L;

	@ManagedProperty(value = "#{frequenciaService}")
	protected FrequenciaService frequenciaService;

	private Frequencia frequencia;
	private InscricaoCurso inscricaoCurso;

	public EspelhoFrequenciaBean() {
		inscricaoCurso = new InscricaoCurso();
		frequencia = new Frequencia();
	}

	public void pesquisar() {
		try {
			if (!validarCampos()) {
				return;
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private boolean validarCampos() throws Exception {
		if (inscricaoCurso == null || inscricaoCurso.getInscricao() == null || !inscricaoCurso.getInscricao().isEmpty()) {
			FacesMessagesUtil.addErrorMessage("", "Nenhuma inscrição informada.");
			return Boolean.FALSE;
		}
		return Boolean.TRUE;
	}
	
	public void copiarExtrato() {
		// TODO: Implementar.....
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
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

	public FrequenciaService getFrequenciaService() {
		return frequenciaService;
	}

	public void setFrequenciaService(FrequenciaService frequenciaService) {
		this.frequenciaService = frequenciaService;
	}

	public Frequencia getFrequencia() {
		return frequencia;
	}

	public void setFrequencia(Frequencia frequencia) {
		this.frequencia = frequencia;
	}
}
