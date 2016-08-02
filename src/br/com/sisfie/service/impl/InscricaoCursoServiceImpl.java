package br.com.sisfie.service.impl;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.mail.MessagingException;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.arquitetura.util.ThreadEnviarEmail;
import br.com.sisfie.DAO.InscricaoCursoDAO;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.ProfessorEvento;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.InscricaoCursoService;
import br.com.sisfie.util.Constantes;

@Service(value = "inscricaoCursoService")
@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
public class InscricaoCursoServiceImpl implements InscricaoCursoService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "inscricaoCursoDAO")
	protected InscricaoCursoDAO inscricaoCursoDAO;

	@Autowired(required = true)
	@Qualifier(value = "mailSender")
	private JavaMailSender simpleMailSender;

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public InscricaoCursoDAO getInscricaoCursoDAO() {
		return inscricaoCursoDAO;
	}

	public void setInscricaoCursoDAO(InscricaoCursoDAO inscricaoCursoDAO) {
		this.inscricaoCursoDAO = inscricaoCursoDAO;
	}

	public JavaMailSender getSimpleMailSender() {
		return simpleMailSender;
	}

	public void setSimpleMailSender(JavaMailSender simpleMailSender) {
		this.simpleMailSender = simpleMailSender;
	}

	@Override
	public List<InscricaoCurso> recuperarInscricoes(Integer idCurso) {
		return inscricaoCursoDAO.recuperarInscricoes(idCurso);
	}

	@Override
	public Long countPesquisaInscricaoCandidato(InscricaoCurso model, Integer cancelada, Integer paga, Integer homologada) {
		return inscricaoCursoDAO.countPesquisaInscricaoCandidato(model, cancelada, paga, homologada);
	}

	@Override
	public List<InscricaoCurso> paginatePesquisaInscricaoCandidato(int first, int pageSize, InscricaoCurso model, Integer cancelada,
			Integer paga, Integer homologada) {
		return inscricaoCursoDAO.paginatePesquisaInscricaoCandidato(first, pageSize, model, cancelada, paga, homologada);
	}

	@Override
	public List<InscricaoCurso> consultarInscricoesParaHomologacao(Curso curso, Integer quantidadeVagas, boolean dentroRegiao)
			throws Exception {
		return inscricaoCursoDAO.consultarInscricoesParaHomologacao(curso, quantidadeVagas, dentroRegiao);
	}

	@Override
	public Long consultarInscricoes(Curso curso, boolean dentroRegiao) throws Exception {
		return inscricaoCursoDAO.consultarInscricoes(curso, dentroRegiao);
	}

	@Override
	public Long countPesquisaInscricaoCandidato(InscricaoCurso model, Integer idStatus, List<Curso> listaCursos, boolean semSelecaoOficina) {
		return inscricaoCursoDAO.countPesquisaInscricaoCandidato(model, idStatus, listaCursos, semSelecaoOficina);
	}

	@Override
	public List<InscricaoCurso> paginatePesquisaInscricaoCandidato(int first, int pageSize, InscricaoCurso model, Integer idStatus,
			List<Curso> listaCursos, boolean semSelecaoOficina) {
		return inscricaoCursoDAO.paginatePesquisaInscricaoCandidato(first, pageSize, model, idStatus, listaCursos, semSelecaoOficina);
	}

	@Override
	public Integer recuperarQuantidadeInscricoesPorOrgao(Integer idOpcaoRegiao, Integer idCurso, Integer quantidadeVagas) {
		return inscricaoCursoDAO.recuperarQuantidadeInscricoesPorOrgao(idOpcaoRegiao, idCurso, quantidadeVagas);
	}

	@Override
	public List<InscricaoCurso> recuperarInscricoesPorOrgao(Integer idOpcaoRegiao, Integer idCurso, Integer quantidadeVagas) {
		return inscricaoCursoDAO.recuperarInscricoesPorOrgao(idOpcaoRegiao, idCurso, quantidadeVagas);
	}

	@Override
	public void isentarInscricao(InscricaoCurso inscricaoCurso) throws Exception {
		dao.save(inscricaoCurso);

		StatusInscricao ultimoStatus = inscricaoCursoDAO.ultimoStatusInscricao(inscricaoCurso);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(ultimoStatus.getId()));
		dao.merge(inscricaoCurso);

		montarEmail(inscricaoCurso);
	}

	private void montarEmail(InscricaoCurso inscricaoCurso) {
		// Preenchendo o corpo do Email
		StringBuilder textoEmail = new StringBuilder();
		textoEmail.append("Prezado(a) <b>" + inscricaoCurso.getCandidato().getNome() + "</b>,");
		textoEmail.append("<br/>");
		textoEmail.append("<br/>");
		textoEmail.append("<p>A sua inscri&ccedil;&atilde;o no evento " + inscricaoCurso.getCurso().getTitulo());
		textoEmail.append(", no per&iacute;odo de " + inscricaoCurso.getCurso().getDataRealizacaoInicio() + " a "
				+ inscricaoCurso.getCurso().getDataRealizacaoFim());
		textoEmail.append(", no local " + inscricaoCurso.getCurso().getLocalizacao().getDescricao());
		textoEmail.append(" foi realizada com sucesso.</p>");
		textoEmail.append("<br/>");
		textoEmail.append("<br/>");
		textoEmail.append("<p>Mensagem Autom&aacute;tica - N&atilde;o responder</p>");

		String assunto = "Sistema SISFIE - CONFIRMAÇÃO DE INSCRIÇÃO ";

		// enviar Email
		Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, textoEmail.toString(), inscricaoCurso.getCandidato()
				.getEmailInstitucional(), Constantes.EMAIL_SISTEMA, true);
		thread.start();
	}

	@Override
	public void inscreverCandidatoForaPrazo(InscricaoCurso inscricaoCurso, StatusInscricao statusInscricao) throws Exception {

		dao.save(inscricaoCurso);
		dao.save(statusInscricao);

		inscricaoCurso.setUltimoStatus(new StatusInscricao(statusInscricao.getId()));

		// gerando o numero da inscricao
		SimpleDateFormat dfAno = new SimpleDateFormat("yyyy");
		String ano = dfAno.format(new Date());
		ano = ano.substring(2, 4);
		SimpleDateFormat dfMes = new SimpleDateFormat("MM");
		String mes = dfMes.format(new Date());

		String numeroInscricao = inscricaoCurso.getCurso().getCodigo().substring(6, 11);
		numeroInscricao = ano + mes + numeroInscricao + inscricaoCurso.getId();
		inscricaoCurso.setInscricao(numeroInscricao);
		dao.merge(inscricaoCurso);

		if (inscricaoCurso.getCurso().getFlgPossuiOficina()) {
			montarEmailComOficina(inscricaoCurso);
		} else {
			montarEmail(inscricaoCurso);
		}
	}

	private void montarEmailComOficina(InscricaoCurso inscricaoCurso) {
		// Preenchendo o corpo do Email
		StringBuilder textoEmail = new StringBuilder();
		textoEmail.append("Prezado(a) <b>" + inscricaoCurso.getCandidato().getNome() + "</b>,");
		textoEmail.append("<br/>");
		textoEmail.append("<br/>");
		textoEmail.append("<p>A sua pr&eacute;-inscri&ccedil;&atilde;o no evento " + inscricaoCurso.getCurso().getTitulo());
		textoEmail.append(", no per&iacute;odo de " + inscricaoCurso.getCurso().getDataRealizacaoInicio() + " a "
				+ inscricaoCurso.getCurso().getDataRealizacaoFim());
		textoEmail.append(", no local " + inscricaoCurso.getCurso().getLocalizacao().getDescricao());
		textoEmail.append(" foi realizada com sucesso.</p>");
		textoEmail
				.append("<b><p>Obs.: Verifique, na p&aacute;gina da ESAF, a publica&ccedil;&atilde;o do evento para informa&ccedil;&otilde;es dos procedimentos, ");
		textoEmail.append("condi&ccedil;&otilde;es e pr&eacute;-requisitos para efetivar a sua inscri&ccedil;&atilde;o. ");
		textoEmail
				.append("O n&atilde;o cumprimento do disposto no edital e/ou ementa do curso implicar&aacute; no cancelamento da inscri&ccedil;&atilde;o.</p></b>");
		textoEmail.append("<p>Atenciosamente.</p>");
		textoEmail.append("<p>Coordena&ccedil;&atilde;o de Eventos</p>");
		textoEmail.append("<p>Escola de Administra&ccedil;&atilde;o Fazend&aacute;ria-ESAF</p>");
		textoEmail.append("<p>Mensagem Autom&aacute;tica - N&atilde;o responder</p>");

		String assunto = "Sistema SISFIE - PRÉ-INSCRIÇÃO ";

		// enviar Email
		Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, textoEmail.toString(), inscricaoCurso.getCandidato()
				.getEmailInstitucional(), Constantes.EMAIL_SISTEMA, true);
		thread.start();
	}

	@Override
	public void confirmarCandidato(InscricaoCurso inscricaoCurso, StatusInscricao statusInscricao) throws Exception {
		dao.save(statusInscricao);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(statusInscricao.getId()));
		dao.merge(inscricaoCurso);
	}

	@Override
	public List<InscricaoCurso> recuperarInscricoesAguardandoComprovante(Integer idCurso) {
		return inscricaoCursoDAO.recuperarInscricoesAguardandoComprovante(idCurso);
	}

	@Override
	public void cancelarCandidato(Map<InscricaoCurso, StatusInscricao> mapaInscricaoStatus) throws Exception {
		if (mapaInscricaoStatus != null && !mapaInscricaoStatus.isEmpty()) {

			ApplicationContext context = new ClassPathXmlApplicationContext("applicationContext-service.xml");
			JavaMailSenderImpl mailSender = (JavaMailSenderImpl) context.getBean("mailSender");

			for (Entry<InscricaoCurso, StatusInscricao> registro : mapaInscricaoStatus.entrySet()) {
				dao.save(registro.getValue());
				registro.getKey().setUltimoStatus(new StatusInscricao(registro.getValue().getId()));
				dao.merge(registro.getKey());

				enviarEmailCancelamento(registro.getKey(), mailSender.getUsername());
			}
		}
	}

	private void enviarEmailCancelamento(InscricaoCurso inscricaoCurso, String userName) throws MessagingException {
		inscricaoCurso = (InscricaoCurso) dao.get(InscricaoCurso.class, inscricaoCurso.getId());
		// Preenchendo o corpo do Email
		StringBuilder corpoEmail = new StringBuilder();
		corpoEmail.append("Prezado(a) <b>" + inscricaoCurso.getCandidato().getNome() + "</b>,");
		corpoEmail.append("<br/>");
		corpoEmail.append("<br/>");
		corpoEmail.append("<p>A sua inscri&ccedil;&atilde;o no evento " + inscricaoCurso.getCurso().getTitulo());
		corpoEmail.append(", no per&iacute;odo de " + inscricaoCurso.getCurso().getDataRealizacaoInicio() + " a "
				+ inscricaoCurso.getCurso().getDataRealizacaoFim());
		corpoEmail.append(", no local " + inscricaoCurso.getCurso().getLocalizacao().getDescricao());
		corpoEmail.append(" foi cancelada por vencer o prazo para pagamento.</p>");
		corpoEmail.append("<br/>");
		corpoEmail.append("Para maiores informa&ccedil;&otilde;es entre em contato: ");
		corpoEmail.append("<br/>");
		corpoEmail.append("<b>Gestor do Curso: </b>" + inscricaoCurso.getCurso().getUsuario().getNome());
		corpoEmail.append("<br/>");
		corpoEmail.append("<b>E-mail:</b> " + inscricaoCurso.getCurso().getUsuario().getEmail());
		corpoEmail.append("<br/>");
		corpoEmail.append("<br/>");
		corpoEmail.append("<p>Mensagem Autom&aacute;tica - N&atilde;o responder</p>");

		String assunto = "Sistema SISFIE - CANCELAMENTO DE INSCRIÇÃO ";

		// enviar Email
		Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, corpoEmail.toString(), inscricaoCurso.getCandidato()
				.getEmailInstitucional(), userName, true);
		thread.start();
	}

	@Override
	public List<InscricaoCurso> recuperarParceirosInscritos(List<String> listaEmailParceiros, List<Integer> listaIdsCursos) {
		return inscricaoCursoDAO.recuperarParceirosInscritos(listaEmailParceiros, listaIdsCursos);
	}

	@Override
	public InscricaoGrade recuperarParceiroInscrito(EmailCursoPrivado emailCursoParceiro) {
		return inscricaoCursoDAO.recuperarParceiroInscrito(emailCursoParceiro);
	}

	@Override
	public List<InscricaoCurso> recuperarParceirosInscritos(Integer idCurso) {
		return inscricaoCursoDAO.recuperarParceirosInscritos(idCurso);
	}

	@Override
	public void atualizarUltimoStatusInscricao(List<InscricaoCurso> listaInscricaoCurso) throws Exception {
		for (InscricaoCurso inscricaoCurso : listaInscricaoCurso) {
			dao.merge(inscricaoCurso);
		}
	}

	@Override
	public Long recuperInscricoesSemUltimoStatus(Curso curso) {
		return inscricaoCursoDAO.recuperInscricoesSemUltimoStatus(curso);
	}

	@Override
	public InscricaoCurso recuperarInscricaoComColecoes(Integer idInscricao) {
		InscricaoCurso inscricaoCurso = (InscricaoCurso) dao.get(InscricaoCurso.class, idInscricao);
		Hibernate.initialize(inscricaoCurso.getStatusInscricoes());
		Hibernate.initialize(inscricaoCurso.getCandidato());
		Hibernate.initialize(inscricaoCurso.getCandidato().getOrgao());
		Hibernate.initialize(inscricaoCurso.getCurso());
		Hibernate.initialize(inscricaoCurso.getComprovantes());
		Hibernate.initialize(inscricaoCurso.getDocumentos());
		return inscricaoCurso;
	}

	@Override
	public InscricaoCurso recupararInscricao(String numInscricao, Integer idCurso, Integer idTurma, Integer idHorario) {
		return inscricaoCursoDAO.recupararInscricao(numInscricao, idCurso, idTurma, idHorario);
	}

	@Override
	public InscricaoGrade recupararInscricaoGrade(String numInscricao, Integer idCurso, Integer idTurma, Integer idHorario) {
		return inscricaoCursoDAO.recupararInscricaoGrade(numInscricao, idCurso, idTurma, idHorario);
	}

	@Override
	public List<InscricaoCurso> recuperarInscricao(Integer idCurso, Integer idTurma, Integer idTurno) {
		return inscricaoCursoDAO.recuperarInscricao(idCurso, idTurma, idTurno);
	}

	@Override
	public InscricaoCurso recupararInscricaoSemOficina(String inscricao, Integer idCurso, Integer idTurma, Integer idTurno) {
		return inscricaoCursoDAO.recupararInscricaoSemOficina(inscricao, idCurso, idTurma, idTurno);
	}

	@Override
	public List<InscricaoCurso> listarInscricoes(Curso curso, InscricaoCurso inscricaoCurso, Integer idTurma) {
		return inscricaoCursoDAO.listarInscricoes(curso, inscricaoCurso, idTurma);
	}

	@Override
	public InscricaoCurso recuperarInscricao(String numInscricao) {
		return inscricaoCursoDAO.recuperarInscricao(numInscricao);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void cancelarInstrutor(InscricaoCurso instrutor, Usuario usuario) throws Exception {
		StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(instrutor.getId()), usuario,
				new Status(Status.CANCELADO), new Date());
		
		dao.save(statusInscricao);
		instrutor.setUltimoStatus(new StatusInscricao(statusInscricao.getId()));
		dao.merge(instrutor);
	}

	@Override
	public List<InscricaoGrade> listarInscricaoGrade(InscricaoCurso inscricaoCurso) {
		return inscricaoCursoDAO.listarInscricaoGrade(inscricaoCurso);
	}

	@Override
	public InscricaoCurso recuperarDocente(InscricaoCurso inscricaoCurso) {
		return inscricaoCursoDAO.recuperarDocente(inscricaoCurso);
	}

	@Override
	public ProfessorEvento recuperarDocenteCursoComOficina(InscricaoCurso inscricaoCurso) {
		return inscricaoCursoDAO.recuperarDocenteCursoComOficina(inscricaoCurso);
	}
}
