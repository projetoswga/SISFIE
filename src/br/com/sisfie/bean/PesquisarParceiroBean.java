package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.model.SelectItem;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.dto.ParceirosDTO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.FacesUtil;

@ManagedBean(name = "pesquisarParceiroBean")
@ViewScoped
public class PesquisarParceiroBean extends BaseBean<EmailCursoPrivado> {

	private static final long serialVersionUID = 3968001846710188062L;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	private ParceirosDTO dto;
	private List<ParceirosDTO> listaParceiros;
	private List<SelectItem> tipoParceiros;

	public PesquisarParceiroBean() {
		dto = new ParceirosDTO();
		listaParceiros = new ArrayList<ParceirosDTO>();
	}

	public void pesquisar() {
		try {
			listaParceiros = new ArrayList<ParceirosDTO>();
			if (dto.getInscrito().equals(ParceirosDTO.INSCRITO)) {
				getParceirosInscritos();
			} else if (dto.getInscrito().equals(ParceirosDTO.NAO_INSCRITO)) {
				getParceirosNaoInscritos();
			} else if (dto.getInscrito().equals(ParceirosDTO.TODOS)){
				getParceirosInscritos();
				getParceirosNaoInscritos();
			}
			getTipoParceiros();
			if (listaParceiros.isEmpty()){
				FacesMessagesUtil.addInfoMessage("", "Nenhum parceiro encontrado.");
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void getParceirosNaoInscritos() throws Exception {
		List<InscricaoCurso> listaParceirosInscritos = inscricaoCursoService.recuperarParceirosInscritos(dto.getCurso().getId());
		if (listaParceirosInscritos != null && !listaParceirosInscritos.isEmpty()) {
			
			List<String> listaEmailParceirosInscritos = new ArrayList<String>();
			for (InscricaoCurso inscricaoCurso : listaParceirosInscritos) {
				listaEmailParceirosInscritos.add(inscricaoCurso.getCandidato().getEmailInstitucional());
			}
			
			List<EmailCursoPrivado> listaParceirosNaoInscritos = cursoService.recuperarParceirosNaoInscritos(dto.getCurso().getId(), listaEmailParceirosInscritos);
			if (listaParceirosNaoInscritos != null && !listaParceirosNaoInscritos.isEmpty()) {
				for (EmailCursoPrivado parceiroNaoInscrito : listaParceirosNaoInscritos) {
					listaParceiros.add(popularParceiro(parceiroNaoInscrito));
				}
			}
		}
	}

	private void getParceirosInscritos() {
		List<InscricaoCurso> listaParceirosInscritos = inscricaoCursoService.recuperarParceirosInscritos(dto.getCurso().getId());
		if (listaParceirosInscritos != null && !listaParceirosInscritos.isEmpty()) {
			for (InscricaoCurso inscricaoCurso : listaParceirosInscritos) {
				listaParceiros.add(popularParceiro(inscricaoCurso));
			}
		}
	}

	@SuppressWarnings("unchecked")
	private ParceirosDTO popularParceiro(EmailCursoPrivado emailCursoParceiro) throws Exception {
		ParceirosDTO parceirosDTO = new ParceirosDTO();
		Candidato candidato = new Candidato();
		candidato.setEmailInstitucional(emailCursoParceiro.getEmail());
		List<Candidato> candidatos = universalManager.listBy(candidato);
		if (candidatos != null && !candidatos.isEmpty()) {
			parceirosDTO.setCandidato(candidatos.get(0));
		}
		parceirosDTO.setInscrito(ParceirosDTO.NAO_INSCRITO);
		parceirosDTO.setEmail(emailCursoParceiro.getEmail());
		parceirosDTO.setCurso(emailCursoParceiro.getCurso());
		return parceirosDTO;
	}

	private ParceirosDTO popularParceiro(InscricaoCurso inscricaoCurso) {
		ParceirosDTO parceirosDTO = new ParceirosDTO();
		parceirosDTO.setCandidato(inscricaoCurso.getCandidato());
		parceirosDTO.setCurso(inscricaoCurso.getCurso());
		parceirosDTO.setEmail(inscricaoCurso.getCandidato().getEmailInstitucional());
		parceirosDTO.setInscrito(ParceirosDTO.INSCRITO);
		return parceirosDTO;
	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		Curso a = new Curso();
		a.setTitulo(query);
		try {
			List<Curso> listaBanco = cursoService.recuperarCursos(a);
			if (listaBanco != null && !listaBanco.isEmpty()) {
				for (Curso curso : listaBanco) {
					if ((curso.getUsuario().getId().equals(loginBean.getModel().getId()) && acessoBean
							.verificarAcesso("ROLE_CURSO_GERENCIAR"))
							|| acessoBean.verificarAcesso("ROLE_PESQ_ACESSO_GERAL")
							|| loginBean.getModel().getPerfil().getDescricao().equals(Constantes.PERFIL_SISFIE)) {
						sugestoes.add(curso);
					}
				}
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return sugestoes;
	}

	public ParceirosDTO getDto() {
		return dto;
	}

	public void setDto(ParceirosDTO dto) {
		this.dto = dto;
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

	@Override
	public EmailCursoPrivado createModel() {
		return new EmailCursoPrivado();
	}

	@Override
	public String getQualifiedName() {
		return "Parceiros";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public List<ParceirosDTO> getListaParceiros() {
		return listaParceiros;
	}

	public void setListaParceiros(List<ParceirosDTO> listaParceiros) {
		this.listaParceiros = listaParceiros;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}

	public List<SelectItem> getTipoParceiros() {
		tipoParceiros = new ArrayList<SelectItem>();
		tipoParceiros.add(new SelectItem(ParceirosDTO.TODOS.toString(), "Selecione"));
		tipoParceiros.add(new SelectItem(ParceirosDTO.INSCRITO.toString(), "Sim"));
		tipoParceiros.add(new SelectItem(ParceirosDTO.NAO_INSCRITO.toString(), "Não"));
		return tipoParceiros;
	}

	public void setTipoParceiros(List<SelectItem> tipoParceiros) {
		this.tipoParceiros = tipoParceiros;
	}
}
