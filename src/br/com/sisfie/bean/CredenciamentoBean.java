package br.com.sisfie.bean;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Credenciamento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCurso;

@ManagedBean(name = "credenciamentoBean")
@ViewScoped
public class CredenciamentoBean extends PaginableBean<Credenciamento> {

	private static final long serialVersionUID = -8294188998250807722L;

	private Curso curso;
	private InscricaoCurso inscricaoCurso;

	public CredenciamentoBean() {
		curso = new Curso();
		inscricaoCurso = new InscricaoCurso();
	}

	@SuppressWarnings("unchecked")
	public void pesquisar() {
		try {
			inscricaoCurso.setInscricao(getModel().getNumInscricao());
			List<InscricaoCurso> listaConsulta = universalManager.listBy(inscricaoCurso);
			if (listaConsulta != null && !listaConsulta.isEmpty()) {
				inscricaoCurso = listaConsulta.get(0);
			} else {
				FacesMessagesUtil.addErrorMessage("Credenciamento", "Inscrição não encontrada!");
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
		inscricaoCurso = new InscricaoCurso();
		return "";
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

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}
}
