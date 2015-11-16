package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.model.SelectItem;

import org.hibernate.Hibernate;
import org.primefaces.context.RequestContext;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.dataModel.EmailCursoDataModel;
import br.com.sisfie.dataModel.InscricaoCursoDataModel;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "comunicadoBean")
@ViewScoped
public class ComunicadoBean extends PaginableBean<Candidato> {

	private static final long serialVersionUID = 1L;

	private Curso curso;

	private InscricaoCursoDataModel listaCandidato;

	private EmailCursoDataModel listaEmails;

	private InscricaoCurso[] inscricoes;

	private EmailCursoPrivado[] emails;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	private String assunto;
	private String corpoEmail;
	private String msgAviso;
	private Integer idStatus;
	private Integer vagasPreencidas;
	private Integer vagasAbertas;
	private boolean cursoPrivado = false;

	private List<SelectItem> listaStatus = new ArrayList<SelectItem>();

	public ComunicadoBean() {
	}

	@PostConstruct
	public void postConstruct() {
		verificarAcesso();
	}

	@Override
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_COMUNICADO_MALA_DIRETA");
	}

	public void mensagemAviso() {
		try {

			if (assunto == null || assunto.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Assunto", Constantes.CAMPO_OBRIGATORIO);
				return;
			}
			if (corpoEmail == null || corpoEmail.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Email", Constantes.CAMPO_OBRIGATORIO);
				return;
			}
			if (cursoPrivado) {
				if (emails == null || emails.length == 0) {
					FacesMessagesUtil.addErrorMessage("", "É necessário selecionar pelo menos um candidato!");
					return;
				}

				StringBuilder msg = new StringBuilder();
				msg.append("<b>Confirma o envio de " + emails.length + " E-mail(s) para:</b> <br/><br/>");
				for (EmailCursoPrivado email : emails) {
					msg.append(email.getEmail() + "<br/>");
				}
				msg.append("<br/>");
				msgAviso = msg.toString();
			} else {
				if (inscricoes == null || inscricoes.length == 0) {
					FacesMessagesUtil.addErrorMessage("", "É necessário selecionar pelo menos um candidato!");
					return;
				}

				StringBuilder msg = new StringBuilder();
				msg.append("<b>Confirma o envio de " + inscricoes.length + " E-mail(s) para:</b> <br/><br/>");
				for (InscricaoCurso inscricaoCurso : inscricoes) {
					msg.append(inscricaoCurso.getCandidato().getEmailInstitucional() + "<br/>");
				}
				msg.append("<br/>");
				msgAviso = msg.toString();
			}

			RequestContext context = RequestContext.getCurrentInstance();
			context.execute("enviarEmail.show();");

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	public void enviarEmail() {
		try {

			if (assunto == null || assunto.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Assunto", Constantes.CAMPO_OBRIGATORIO);
				return;
			}
			if (corpoEmail == null || corpoEmail.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("Email", Constantes.CAMPO_OBRIGATORIO);
				return;
			}

			if (cursoPrivado) {
				enviarEmailPrivado();
			} else {
				enviarEmailPublico();
			}

			idStatus = null;
			listaStatus = new ArrayList<SelectItem>();
			assunto = null;
			corpoEmail = null;
			curso = null;
			inscricoes = null;
			FacesMessagesUtil.addInfoMessage("Os E-mails estão sendo enviados, ",
					" assim que for concluído você receberá um e-mail, no seguinte endereço "
							+ loginBean.getModel().getEmail());

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	public void enviarEmailPublico() throws Exception {
		if (inscricoes == null || inscricoes.length == 0) {
			FacesMessagesUtil.addErrorMessage("", "É necessário selecionar pelo menos um candidato!");
			return;
		}
		for (InscricaoCurso obj : inscricoes) {
			obj = (InscricaoCurso) universalManager.get(InscricaoCurso.class, obj.getId());
			Hibernate.initialize(obj.getCandidato());
			Hibernate.initialize(obj.getCandidato());
		}

		cursoService.enviarEmails(inscricoes, assunto, corpoEmail, loginBean.getModel().getEmail());

	}

	public void enviarEmailPrivado() throws Exception {
		if (emails == null || emails.length == 0) {
			FacesMessagesUtil.addErrorMessage("", "É necessário selecionar pelo menos um candidato!");
			return;
		}
		cursoService.enviarEmails(emails, assunto, corpoEmail, loginBean.getModel().getEmail(), true);
	}

	public List<Curso> completeCurso(String query) {
		List<Curso> sugestoes = new ArrayList<Curso>();
		try {
			Curso a = new Curso();
			a.setTitulo(query);

			a.setUsuario(new Usuario(loginBean.getModel().getId()));

			sugestoes = universalManager.listBy(a);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;

	}

	public void carregarLista() {
		try {
			// curso privado

			if (idStatus != null && idStatus != 0) {
				if (cursoPrivado) {
					curso = (Curso) universalManager.get(Curso.class, curso.getId());
					List<EmailCursoPrivado> emails = new ArrayList<EmailCursoPrivado>(curso.getEmailsCursoPrivado());
					listaEmails = new EmailCursoDataModel(emails);
				} else {
					List<InscricaoCurso> lista = cursoService.carregarListaCandidato(curso, idStatus);
					listaCandidato = new InscricaoCursoDataModel(lista);
				}

				// preenche os campos vagas abertas e vagas preenchidas.
				vagasPreencidas = cursoService.retornarQuantidadeInscritos(curso);
				if (curso.getVagas() != null) {
					vagasAbertas = curso.getVagas() - vagasPreencidas;
					if (vagasAbertas < 0) {
						vagasAbertas = 0;
					}
				} else {
					vagasAbertas = 0;
				}

			} else {
				assunto = null;
				corpoEmail = null;
				msgAviso = null;
				inscricoes = null;
			}

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void carregarStatus() {
		try {

			if (curso == null || curso.getId() == null) {
				limparCampos();
			} else {
				limparCampos();

				cursoPrivado = curso.getPrivado();
				// Verifica se é curso privado
				if (cursoPrivado) {
					idStatus = 999;
					listaStatus.add(new SelectItem(999, "Curso Privado"));
					carregarLista();
				} else {
					List<Integer> idsStatus = new ArrayList<Integer>();
					idsStatus.add(Status.AGUARDANDO_VAGA);
					idsStatus.add(Status.AGUARDANDO_VAGA_PRIORIDADE);
					idsStatus.add(Status.PRE_INSCRITO);
					idsStatus.add(Status.AGUARDANDO_COMPROVANTE);
					idsStatus.add(Status.CONFIRMADO_PELO_CHEFE);
					idsStatus.add(Status.INVALIDAR_COMPROVANTE);
					idsStatus.add(Status.HOMOLOGADO);
					idsStatus.add(Status.CANCELADO);
					idsStatus.add(Status.PRESENCA_CONFIRMADA);
					idsStatus.add(Status.AGUARDANDO_ACEITE_INSCRICAO);
					List<Status> status = cursoService.carregarStatus(idsStatus);

					listaStatus.add(new SelectItem("", "Selecione"));
					for (Status st : status) {
						listaStatus.add(new SelectItem(st.getId(), st.getDescricao()));
					}

				}

			}

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void limparCampos() {
		listaStatus = new ArrayList<SelectItem>();
		assunto = null;
		corpoEmail = null;
		msgAviso = null;
		inscricoes = null;
	}

	@Override
	public Candidato createModel() {
		return new Candidato();
	}

	@Override
	public String getQualifiedName() {
		return "Comunicado";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
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

	public InscricaoCursoDataModel getListaCandidato() {
		return listaCandidato;
	}

	public void setListaCandidato(InscricaoCursoDataModel listaCandidato) {
		this.listaCandidato = listaCandidato;
	}

	public InscricaoCurso[] getInscricoes() {
		return inscricoes;
	}

	public void setInscricoes(InscricaoCurso[] inscricoes) {
		this.inscricoes = inscricoes;
	}

	public String getAssunto() {
		return assunto;
	}

	public void setAssunto(String assunto) {
		this.assunto = assunto;
	}

	public String getCorpoEmail() {
		return corpoEmail;
	}

	public void setCorpoEmail(String corpoEmail) {
		this.corpoEmail = corpoEmail;
	}

	public String getMsgAviso() {
		return msgAviso;
	}

	public void setMsgAviso(String msgAviso) {
		this.msgAviso = msgAviso;
	}

	public Integer getIdStatus() {
		return idStatus;
	}

	public void setIdStatus(Integer idStatus) {
		this.idStatus = idStatus;
	}

	public Integer getVagasPreencidas() {
		return vagasPreencidas;
	}

	public void setVagasPreencidas(Integer vagasPreencidas) {
		this.vagasPreencidas = vagasPreencidas;
	}

	public Integer getVagasAbertas() {
		return vagasAbertas;
	}

	public void setVagasAbertas(Integer vagasAbertas) {
		this.vagasAbertas = vagasAbertas;
	}

	public List<SelectItem> getListaStatus() {
		return listaStatus;
	}

	public void setListaStatus(List<SelectItem> listaStatus) {
		this.listaStatus = listaStatus;
	}

	public boolean isCursoPrivado() {
		return cursoPrivado;
	}

	public void setCursoPrivado(boolean cursoPrivado) {
		this.cursoPrivado = cursoPrivado;
	}

	public EmailCursoDataModel getListaEmails() {
		return listaEmails;
	}

	public void setListaEmails(EmailCursoDataModel listaEmails) {
		this.listaEmails = listaEmails;
	}

	public EmailCursoPrivado[] getEmails() {
		return emails;
	}

	public void setEmails(EmailCursoPrivado[] emails) {
		this.emails = emails;
	}

}
