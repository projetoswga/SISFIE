package br.com.sisfie.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;

import org.hibernate.Hibernate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.arquitetura.util.ThreadEnviarEmail;
import br.com.sisfie.DAO.CandidatoDAO;
import br.com.sisfie.DAO.CursoDAO;
import br.com.sisfie.DAO.InscricaoCursoDAO;
import br.com.sisfie.dto.CursoDTO;
import br.com.sisfie.dto.ParceirosDTO;
import br.com.sisfie.entidade.AreaConhecimentoCurso;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.CandidatoPreenchimento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.EsferaCurso;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.GradePacote;
import br.com.sisfie.entidade.HomologacaoCurso;
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.InscricaoComprovante;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoDocumento;
import br.com.sisfie.entidade.InscricaoInfoComplementar;
import br.com.sisfie.entidade.Localizacao;
import br.com.sisfie.entidade.Municipio;
import br.com.sisfie.entidade.MunicipioCurso;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Pacote;
import br.com.sisfie.entidade.PacoteOficina;
import br.com.sisfie.entidade.ProfessorEvento;
import br.com.sisfie.entidade.Sala;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusCurso;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.entidade.Uf;
import br.com.sisfie.entidade.UfCurso;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.thread.ThreadEmail;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.CriptoUtil;

@Service(value = "CursoService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class CursoServiceImpl implements CursoService {

	@Autowired(required = true)
	@Qualifier(value = "mailSender")
	private JavaMailSender simpleMailSender;

	@Autowired(required = true)
	@Qualifier(value = "CursoDAO")
	protected CursoDAO cursoDAO;

	@Autowired(required = true)
	@Qualifier(value = "candidatoDAO")
	protected CandidatoDAO candidatoDAO;

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "mailSender")
	protected JavaMailSender mailSender;
	
	@Autowired(required = true)
	@Qualifier(value = "inscricaoCursoDAO")
	protected InscricaoCursoDAO inscricaoCursoDAO;

	@Override
	public List<Uf> completeUF(Uf a) {
		return cursoDAO.completeUF(a);
	}

	public CursoDAO getCursoDAO() {
		return cursoDAO;
	}

	public void setCursoDAO(CursoDAO cursoDAO) {
		this.cursoDAO = cursoDAO;
	}

	@Override
	public List<Uf> completeMunicipio(Municipio municipio, List<UfCurso> ufCursos) {
		return cursoDAO.completeMunicipio(municipio, ufCursos);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public Long countCurso(CursoDTO dto) {
		return cursoDAO.countCurso(dto);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public List<Curso> paginateCurso(int first, int pageSize, CursoDTO dto) {
		return cursoDAO.paginateCurso(first, pageSize, dto);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void save(Curso model, boolean enviarEmailParceiros) throws Exception {
		// Clona as listas para serem salvar
		List<HomologacaoCurso> homologacaoCursosSalvar = new ArrayList<HomologacaoCurso>();
		List<EsferaCurso> esferaCursosSalvar = new ArrayList<EsferaCurso>();
		List<CandidatoPreenchimento> candidatoPreenchimentosSalvar = new ArrayList<CandidatoPreenchimento>();
		List<EmailCursoPrivado> cursoEmailSalvar = new ArrayList<EmailCursoPrivado>();

		for (HomologacaoCurso lista : model.getHomologacaoCursos()) {
			homologacaoCursosSalvar.add((HomologacaoCurso) lista.clone());
		}
		for (EsferaCurso lista : model.getEsferaCurso()) {
			esferaCursosSalvar.add((EsferaCurso) lista.clone());
		}
		for (CandidatoPreenchimento lista : model.getCandidatoPreenchimentos()) {
			candidatoPreenchimentosSalvar.add((CandidatoPreenchimento) lista.clone());
		}
		for (EmailCursoPrivado lista : model.getEmailsCursoPrivado()) {
			cursoEmailSalvar.add((EmailCursoPrivado) lista.clone());
		}

		dao.save(model);

		model = (Curso) dao.get(Curso.class, model.getId());

		// senão tiver habilitado por regiao deve excluir todos as uf e
		// municipio
		if (!model.getFlgRegiaoAtivo()) {
			UfCurso ufCurso = new UfCurso();
			ufCurso.setCurso(new Curso(model.getId()));
			List<UfCurso> ufCursos = dao.listBy(ufCurso);
			for (UfCurso obj : ufCursos) {
				dao.remove(UfCurso.class, obj.getId());
			}

			MunicipioCurso municipioCurso = new MunicipioCurso();
			municipioCurso.setCurso(new Curso(model.getId()));
			List<MunicipioCurso> municipioCursos = dao.listBy(municipioCurso);
			for (MunicipioCurso obj : municipioCursos) {
				dao.remove(MunicipioCurso.class, obj.getId());
			}

		} else {
			// salva uF e municipio
			for (UfCurso ufCurso : model.getUfCursos()) {
				ufCurso.setCurso(new Curso(model.getId()));
				dao.save(ufCurso);
			}
			for (MunicipioCurso municipioCurso : model.getMunicipioCursos()) {
				municipioCurso.setCurso(new Curso(model.getId()));
				dao.save(municipioCurso);
			}

			// Exclui UF e municipio
			for (MunicipioCurso mc : model.getExclusaoMunicipioCursos()) {
				dao.remove(MunicipioCurso.class, mc.getId());
			}
			for (UfCurso uc : model.getExclusaoUfCursos()) {
				dao.remove(UfCurso.class, uc.getId());
			}
		}

		// se for curso publico não composto por oficina e sem percentual de vagas para parceiros apaga todos os relacionamentos
		if (model.getPublico() && model.getId() != null) {

			if (!model.getFlgPossuiOficina()
					&& (model.getNumPercentualVagasParceiro() == null || model.getNumPercentualVagasParceiro() == 0)) {
				
				EmailCursoPrivado email = new EmailCursoPrivado();
				email.setCurso(new Curso(model.getId()));
				List<EmailCursoPrivado> emailsExcluir = dao.listBy(email);
				for (EmailCursoPrivado list : emailsExcluir) {
					if (list.getId() != null) {
						dao.remove(EmailCursoPrivado.class, list.getId());
					}
				}
				
			}

		}

		// Excluir todos os check do BD para depois salvar de nv
		HomologacaoCurso homologacaoCurso = new HomologacaoCurso();
		homologacaoCurso.setCurso(new Curso(model.getId()));
		List<HomologacaoCurso> homologacaoCursosBD = dao.listBy(homologacaoCurso);
		for (HomologacaoCurso hc : homologacaoCursosBD) {
			if (hc.getId() != null) {
				dao.remove(HomologacaoCurso.class, hc.getId());
			}
		}

		EsferaCurso esferaCurso = new EsferaCurso();
		esferaCurso.setCurso(new Curso(model.getId()));
		List<EsferaCurso> esferaCursosBD = dao.listBy(esferaCurso);
		for (EsferaCurso obj : esferaCursosBD) {
			if (obj.getId() != null) {
				dao.remove(EsferaCurso.class, obj.getId());
			}
		}

		CandidatoPreenchimento cp = new CandidatoPreenchimento();
		cp.setCurso(new Curso(model.getId()));
		List<CandidatoPreenchimento> candidatoPreenchimentosBD = dao.listBy(cp);
		for (CandidatoPreenchimento obj : candidatoPreenchimentosBD) {
			if (obj.getId() != null) {
				dao.remove(CandidatoPreenchimento.class, obj.getId());
			}
		}

		if (model.isClonar()) {
			// Quando o curso é composto por oficinas, clona-se tbm os apoios do curso
			if (model.getFlgPossuiOficina()) {
				if (model.getHorarios() != null && !model.getHorarios().isEmpty()) {
					for (Horario horario : model.getHorarios()) {
						Horario horarioClone = (Horario) horario.clone();
						horarioClone.setCurso(new Curso(model.getId()));
						horarioClone.setGradeOficinas(new HashSet<GradeOficina>(0));
						horarioClone.setGradePacotes(new HashSet<GradePacote>(0));
						horarioClone.setId(null);
						dao.save(horarioClone);
					}
				}
				// Carregando novamente as turmas pois estava dando a exceção collection is not associated with any session
				if (model.getTurmas() != null && !model.getTurmas().isEmpty()) {
					for (Turma turma : model.getTurmas()) {
						Turma turmaClone = (Turma) turma.clone();
						turmaClone.setCurso(new Curso(model.getId()));
						turmaClone.setGradeOficinas(new HashSet<GradeOficina>(0));
						turmaClone.setGradePacotes(new HashSet<GradePacote>(0));
						turmaClone.setInscricaoCursos(new HashSet<InscricaoCurso>(0));
						turmaClone.setId(null);
						dao.save(turmaClone);
					}
				}
				if (model.getSalas() != null && !model.getSalas().isEmpty()) {
					for (Sala sala : model.getSalas()) {
						Sala salaClone = (Sala) sala.clone();
						salaClone.setCurso(new Curso(model.getId()));
						salaClone.setGradeOficinas(new HashSet<GradeOficina>(0));
						salaClone.setId(null);
						dao.save(salaClone);
					}
				}
				if (model.getProfessorEventos() != null && !model.getProfessorEventos().isEmpty()) {
					for (ProfessorEvento professorEvento : model.getProfessorEventos()) {
						ProfessorEvento professorEventoClone = (ProfessorEvento) professorEvento.clone();
						professorEventoClone.setCurso(new Curso(model.getId()));
						professorEventoClone.setId(null);
						dao.save(professorEventoClone);
					}
				}
				if (model.getOficinas() != null && !model.getOficinas().isEmpty()) {
					for (Oficina oficina : model.getOficinas()) {
						Oficina oficinaClone = (Oficina) oficina.clone();
						oficinaClone.setCurso(new Curso(model.getId()));
						oficinaClone.setGradeOficinas(new HashSet<GradeOficina>(0));
						oficinaClone.setPacoteOficinas(new HashSet<PacoteOficina>(0));
						oficinaClone.setId(null);
						dao.save(oficinaClone);
					}
				}
				if (model.getPacotes() != null && !model.getPacotes().isEmpty()) {
					for (Pacote pacote : model.getPacotes()) {
						// Carregando objeto para inicializar as collections
						pacote = (Pacote) dao.get(Pacote.class, pacote.getId());
						List<PacoteOficina> listaPacoteOficina = new ArrayList<PacoteOficina>();
						listaPacoteOficina.addAll(pacote.getPacoteOficinas());

						// Clonando o pacote
						Pacote pacoteClone = (Pacote) pacote.clone();
						pacoteClone.setCurso(new Curso(model.getId()));
						pacoteClone.setPacoteOficinas(new HashSet<PacoteOficina>());
						pacoteClone.setId(null);
						dao.save(pacoteClone);

						// Clonando as oficinas contidas no pacote
						for (PacoteOficina pacoteOficina : listaPacoteOficina) {
							pacoteOficina = (PacoteOficina) pacoteOficina.clone();
							pacoteOficina.getPacote().setId(pacoteClone.getId());
							pacoteOficina.setId(null);
							dao.save(pacoteOficina);
						}
					}
				}
			}
		}

		// Salvar os checkbox que foram selecionados
		for (HomologacaoCurso hc : homologacaoCursosSalvar) {
			hc.setCurso(model);
			dao.save(hc);
		}
		for (EsferaCurso obj : esferaCursosSalvar) {
			obj.setCurso(model);
			dao.save(obj);
		}
		for (CandidatoPreenchimento obj : candidatoPreenchimentosSalvar) {
			obj.setCurso(model);
			dao.save(obj);
		}

		for (EmailCursoPrivado obj : cursoEmailSalvar) {
			boolean isEdicao = obj.getId() != null && obj.getId() > 0 ? true : false;
			obj.setCurso(model);
			dao.save(obj);

			// Verifica se é para mandar email para os parceiros. Caso seja, envia email somente para os registros novos
			if (enviarEmailParceiros) {
				if (!isEdicao){
					// Recuperando o path da imagem
					String caminhoImagem = Constantes.ENDERECO_SERVIDOR_COM_PATH
							+ "/javax.faces.resource/esaf-logo-email.png.jsf?ln=design/imagem-default";
					
					String linkServidor = recuperarLink();
					
					// Preenchendo o corpo do Email
					StringBuilder textoEmail = new StringBuilder();
					textoEmail.append("Prezado(a),");
					textoEmail.append("<br/>");
					textoEmail.append("<br/>");
					textoEmail.append("Seu e-mail foi adicionado para realiza&ccedil;&atilde;o de um curso na ESAF, para fazer sua inscri&ccedil;&atilde;o:");
					textoEmail.append("<br/>");
					textoEmail.append("<b>Se j&aacute; tem cadastro na ESAF</b>, por gentileza entre no seu cadastro e escolha o curso na aba 'Inscri&ccedil;&otilde;es Abertas'.");
					textoEmail.append("<br/>");
					textoEmail.append("<b>Se ainda n&atilde;o &eacute; cadastrado</b>, fa&ccedil;a seu cadastro no link " + linkServidor);
					textoEmail.append("<br/>");
					textoEmail.append("Ao concluir o cadastro, o sistema enviar&aacute; a senha para seu e-mail. Retorne ao sistema e fa&ccedil;a o login utilizando o seu e-mail completo e a senha enviada.");
					textoEmail.append("<br/>");
					textoEmail.append("<br/>");
					textoEmail.append("<table cellspacing='0' cellpadding='0' width='750' border='1'>");
					textoEmail.append("<tr><td>");
					textoEmail.append("<table cellspacing='0' cellpadding='0' width='100%' >");
					textoEmail.append("<br/>");
					textoEmail.append("<tr>");
					textoEmail.append("<td width='35%'><img src='" + caminhoImagem + "'></td>");
					textoEmail.append("<td width='65%'><b>DESCRI&Ccedil;&Atilde;O DO CURSO</b></td>");
					textoEmail.append("</tr>");
					textoEmail.append("<br/>");
					textoEmail.append("</table>");
					textoEmail.append("</td></tr>");
					textoEmail.append("<tr><td>");
					textoEmail.append("<table cellspacing='0' cellpadding='0' width='100%'>");
					textoEmail.append("<br/>");
					textoEmail.append("<tr><td><b>Curso:</b> " + obj.getCurso().getCursoData() + " </td></tr>");
					obj.setCurso((Curso) dao.get(Curso.class, obj.getCurso().getId()));
					obj.getCurso().setLocalizacao((Localizacao) dao.get(Localizacao.class, obj.getCurso().getLocalizacao().getId()));
					textoEmail.append("<tr><td><b>Local:</b> " + obj.getCurso().getLocalizacao().getDescricao() + " </td></tr>");
					textoEmail.append("<tr><td><b>Data:</b> " + obj.getCurso().getDataRealizacaoInicio() + " </td></tr>");
					textoEmail.append("<br/>");
					textoEmail.append("</table>");
					textoEmail.append("</td></tr>");
					textoEmail.append("</table>");
					textoEmail.append("<br/>");
					textoEmail
					.append("<p><b>OBS.: Em caso de d&uacute;vida, procurar o coordenador do curso para obter maiores informa&ccedil;&otilde;es. <b></p>");
					textoEmail.append("<p>Coordenador: " + obj.getCurso().getUsuario().getNome());
					textoEmail.append("<br/>");
					textoEmail.append("Email Contato: " + obj.getCurso().getUsuario().getEmail() + "</p>");
					textoEmail.append("<p>Mensagem Autom&aacute;tica - N&atilde;o responder</p>");
					
					String assunto = "Sistema SISFIE - DESCRIÇÃO DE CURSO ";
					
					// enviando email
					Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, textoEmail.toString(), obj.getEmail(),
							Constantes.EMAIL_SISTEMA, true);
					thread.start();
				}
			}
		}

		if (model.getAreaConhecimentoCursos() != null && !model.getAreaConhecimentoCursos().isEmpty()) {
			for (AreaConhecimentoCurso areaConhecimentoCurso : model.getAreaConhecimentoCursos()) {
				areaConhecimentoCurso.setCurso(model);
				dao.save(areaConhecimentoCurso);
			}
		}
		if (model.getExclusaoAreaConhecimentoCursos() != null && !model.getExclusaoAreaConhecimentoCursos().isEmpty()) {
			for (AreaConhecimentoCurso areaConhecimentoCurso : model.getExclusaoAreaConhecimentoCursos()) {
				dao.remove(AreaConhecimentoCurso.class, areaConhecimentoCurso.getId());
			}
		}
		if (model.getExclusaoCursoEmail() != null && !model.getExclusaoCursoEmail().isEmpty()) {
			for (EmailCursoPrivado cursoEmail : model.getExclusaoCursoEmail()) {
				dao.remove(EmailCursoPrivado.class, cursoEmail.getId());
			}
		}

		/**
		 * Caso tenha inscritos, significa que o curso está sendo editado, logo tem que informar aos incritos que o curso teve alteração. Só
		 * não receberão os emails os candidatos que tiveram suas inscrições canceladas. Os emails serão enviados caso data de realização e
		 * a localização tenha sido alterados.
		 */
		if (model.getInscricoes() != null
				&& !model.getInscricoes().isEmpty()
				&& (model.getDtRealizacaoInicio().getTime() != model.getDataRealizacaoInicioOld().getTime()
						|| model.getDtRealizacaoFim().getTime() != model.getDataRealizacaoFimOld().getTime() || !model.getLocalizacao()
						.getId().equals(model.getIdLocalOld())) && !model.isClonar()) {

			for (InscricaoCurso inscricaoCurso : model.getInscricoes()) {
				inscricaoCurso.getCurso().setLocalizacao(
						(Localizacao) dao.get(Localizacao.class, inscricaoCurso.getCurso().getLocalizacao().getId()));
				StatusInscricao statusInscricao = getUltimoStatusInscricao(inscricaoCurso);
				if (!statusInscricao.getStatus().getId().equals(Status.CANCELADO)) {
					// Preenchendo o corpo do Email
					StringBuilder textoEmail = new StringBuilder();
					textoEmail.append("Prezado(a), " + inscricaoCurso.getCandidato().getNome());
					textoEmail.append("<br/>");
					textoEmail.append("<br/>");
					textoEmail.append("O curso " + inscricaoCurso.getCurso().getTitulo() + " teve altera&ccedil;&otilde;es. ");
					textoEmail.append("A data de realiza&ccedil;&atilde;o ser&aacute; de: "
							+ inscricaoCurso.getCurso().getDataRealizacaoInicio() + " a "
							+ inscricaoCurso.getCurso().getDataRealizacaoFim() + " e local: " + model.getLocalizacao().getDescricao());
					textoEmail.append("<br/>");
					textoEmail.append("<br/>");
					textoEmail
							.append("<p><b>OBS.: Em caso de d&uacute;vida, procurar o coordenador do curso para obter maiores informa&ccedil;&otilde;es. <b></p>");
					textoEmail.append("<p>Gestor: " + inscricaoCurso.getCurso().getUsuario().getNome());
					textoEmail.append("<br/>");
					textoEmail.append("Email Contato: " + inscricaoCurso.getCurso().getUsuario().getEmail() + "</p>");
					textoEmail.append("<p>Mensagem Autom&aacute;tica - N&atilde;o responder</p>");

					String assunto = "Sistema SISFIE - ALTERAÇÃO NO CURSO ";

					// enviar Email
					Thread thread = new ThreadEnviarEmail(mailSender, assunto, textoEmail.toString(), inscricaoCurso.getCandidato()
							.getEmailInstitucional(), Constantes.EMAIL_SISTEMA, true);
					thread.start();
				}
			}
		}
	}

	private String recuperarLink() {
		if (Constantes.ATIVA_IMG_LINK){
			return "<a href=" + Constantes.PATH_LINK_IMG + ">SISFIE</a>";
		} else {
			return "<a href=" + Constantes.ENDERECO_SERVIDOR_COM_PATH + "_INSCRICAO>SISFIE</a>";
		}
	}

	@Override
	public List<InscricaoCurso> carregarListaCandidato(Curso curso, Integer idStatus) {
		return cursoDAO.carregarListaCandidato(curso, idStatus);
	}

	@Override
	public List<InscricaoCurso> carregarListaEspera(Curso curso) {
		return cursoDAO.carregarListaEspera(curso);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void homologarCurso(InscricaoCurso inscricaoCurso) throws Exception {
		dao.save(inscricaoCurso);
		
		StatusInscricao ultimoStatus = getUltimoStatusInscricao(inscricaoCurso);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(ultimoStatus.getId()));
		dao.merge(inscricaoCurso);

		// verifica se tem comprovantes anexados
		for (InscricaoComprovante comprovante : inscricaoCurso.getComprovantes()) {
			if (comprovante.getId() == null) {
				dao.save(comprovante);
			}
		}

		// Recuperando o path da imagem
		String caminhoImagem = "http://" + Constantes.ENDERECO_SERVIDOR_COM_PATH
				+ "/javax.faces.resource/esaf-logo-email.png.jsf?ln=design/imagem-default";

		// Identificando o tipo de documento
		String documento = "";
		if (inscricaoCurso.getCandidato().getNacionalidadeBrasil()) {
			documento = inscricaoCurso.getCandidato().getCpf();
		} else {
			documento = inscricaoCurso.getCandidato().getDocEstrangeiro();
		}

		// Preenchendo o corpo do Email
		StringBuilder textoEmail = new StringBuilder();
		textoEmail.append("Prezado(a) <b>" + inscricaoCurso.getCandidato().getNome() + "</b>,");
		textoEmail.append("<br/>");
		textoEmail.append("<br/>");
		textoEmail
				.append("Recebemos as informa&ccedil;&otilde;es e a documenta&ccedil;&atilde;o necess&aacute;ria. A sua inscri&ccedil;&atilde;o encontra-se confirmada e devidamente homologada.");
		textoEmail.append("<br/>");
		textoEmail.append("<br/>");
		textoEmail.append("<table cellspacing='0' cellpadding='0' width='750' border='1'>");
		textoEmail.append("<tr><td>");
		textoEmail.append("<table cellspacing='0' cellpadding='0' width='100%' >");
		textoEmail.append("<br/>");
		textoEmail.append("<tr>");
		textoEmail.append("<td width='35%'><img src='" + caminhoImagem + "'></td>");
		textoEmail.append("<td width='65%'><b>COMPROVANTE DE INSCRI&Ccedil;&Atilde;O</b></td>");
		textoEmail.append("</tr>");
		textoEmail.append("<br/>");
		textoEmail.append("</table>");
		textoEmail.append("</td></tr>");
		textoEmail.append("<tr><td>");
		textoEmail.append("<table cellspacing='0' cellpadding='0' width='100%'>");
		textoEmail.append("<br/>");
		textoEmail.append("<tr><td><b>Curso:</b> " + inscricaoCurso.getCurso().getTitulo() + " </td></tr>");
		if (inscricaoCurso.getTurma() != null) {
			textoEmail.append("<tr><td><b>Turma:</b> " + inscricaoCurso.getTurma().getDescricao() + " </td></tr>");
		} else {
			textoEmail.append("<tr><td><b>Turma:</b> N&atilde;o informado!</td></tr>");
		}
		inscricaoCurso.setCurso((Curso) dao.get(Curso.class, inscricaoCurso.getCurso().getId()));
		inscricaoCurso.getCurso().setLocalizacao(
				(Localizacao) dao.get(Localizacao.class, inscricaoCurso.getCurso().getLocalizacao().getId()));
		textoEmail.append("<tr><td><b>Local:</b> " + inscricaoCurso.getCurso().getLocalizacao().getDescricao() + " </td></tr>");
		textoEmail.append("<tr><td><b>Data:</b> " + inscricaoCurso.getCurso().getDataRealizacaoInicio() + " </td></tr>");
		textoEmail.append("<br/>");
		textoEmail.append("</table>");
		textoEmail.append("</td></tr>");
		textoEmail.append("<tr><td>");
		textoEmail.append("<table cellspacing='0' cellpadding='0' width='100%'>");
		textoEmail.append("<br/>");
		textoEmail.append("<tr>");
		textoEmail.append("<td width='50%'><b>Nome:</b> " + inscricaoCurso.getCandidato().getNome() + " </td>");
		textoEmail.append("<td width='50%'><b>Nome para Crach&aacute;:</b> " + inscricaoCurso.getCandidato().getNome() + " </td>");
		textoEmail.append("</tr>");
		textoEmail.append("<tr><td><b>N&uacute;mero de inscri&ccedil;&atilde;o:</b> " + inscricaoCurso.getInscricao() + " </td></tr>");
		textoEmail.append("<tr><td><b>Doc. de Identifica&ccedil;&atilde;o:</b> " + documento + " </td></tr>");
		inscricaoCurso.setCandidato(candidatoDAO.recuperarCandidato(inscricaoCurso.getCandidato().getId()));
		textoEmail.append("<tr><td colspan='2'><b>&Oacute;rg&atilde;o/Entidade:</b> "
				+ inscricaoCurso.getCandidato().getOrgao().getNomeSiglaFormat() + " </td></tr>");
		textoEmail.append("<br/>");
		textoEmail.append("</table>");
		textoEmail.append("</td></tr>");
		textoEmail.append("</table>");
		textoEmail.append("<br/>");
		textoEmail.append("<p><b>OBS.: &Eacute; preciso confirmar presen&ccedil;a na aba inscri&ccedil;&otilde;es realizadas. <b></p>");
		textoEmail.append("<p>Mensagem Autom&aacute;tica - N&atilde;o responder</p>");

		String assunto = "Sistema SISFIE - COMPROVANTE  DE INSCRIÇÃO ";

		// enviando email
		Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, textoEmail.toString(), inscricaoCurso.getCandidato()
				.getEmailInstitucional(), Constantes.EMAIL_SISTEMA, true);
		thread.start();
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void invalidarComprovante(InscricaoCurso inscricaoCurso, String textoInvalidarComprovante) throws Exception {

		String assunto = "Sistema SISFIE - COMPROVANTE DE PAGAMENTO INVÁLIDO";
		StringBuilder corpo = new StringBuilder();
		corpo.append("<p>Prezado(a) <b>" + inscricaoCurso.getCandidato().getNome() + "</b>,</p>");
		corpo.append("<p>" + textoInvalidarComprovante + "</p>");
		corpo.append("Atenciosamente, ");
		corpo.append("<br/>");
		corpo.append("<b>ESAF - Escola de Administra&ccedil;&atilde;o Fazend&aacute;ria</b>");
		corpo.append("<br/>");
		corpo.append("<br/>");
		corpo.append("Mensagem Autom&aacute;tica - N&atilde;o Responder.");

		dao.save(inscricaoCurso);
		
		StatusInscricao ultimoStatus = getUltimoStatusInscricao(inscricaoCurso);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(ultimoStatus.getId()));
		dao.merge(inscricaoCurso);

		// enviar Email
		Thread thread = new ThreadEnviarEmail(mailSender, assunto, corpo.toString(), inscricaoCurso.getCandidato().getEmailInstitucional(),
				Constantes.EMAIL_SISTEMA, true);
		thread.start();

	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void cancelarInscricao(InscricaoCurso inscricaoCurso, String textoInvalidarComprovante, StatusInscricao statusInscricao) throws Exception {
		String assunto = "CANDIDATO CANCELADO NO CURSO DE " + inscricaoCurso.getCurso().getTitulo().toUpperCase();
		StringBuilder corpo = new StringBuilder();
		corpo.append(textoInvalidarComprovante);
		corpo.append(" <br/> ");
		corpo.append("Mensagem Autom&aacute;tica - N&atilde;o Responder.");

		dao.save(statusInscricao);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(statusInscricao.getId()));
		dao.merge(inscricaoCurso);
		
		// enviar Email
		Thread thread = new ThreadEnviarEmail(mailSender, assunto, corpo.toString(), inscricaoCurso.getCandidato().getEmailInstitucional(),
				Constantes.EMAIL_SISTEMA, true);
		thread.start();

	}

	@Override
	public StatusCurso ultimoStatusCurso(Curso curso) {
		return cursoDAO.ultimoStatusCurso(curso);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void deleteCurso(Curso cursoSelect) throws Exception {
		Curso curso = (Curso) dao.get(Curso.class, cursoSelect.getId());

		for (HomologacaoCurso homologacaoCurso : curso.getHomologacaoCursos()) {
			dao.remove(HomologacaoCurso.class, homologacaoCurso.getId());
		}
		for (EsferaCurso obj : curso.getEsferaCurso()) {
			dao.remove(EsferaCurso.class, obj.getId());
		}
		for (CandidatoPreenchimento obj : curso.getCandidatoPreenchimentos()) {
			dao.remove(CandidatoPreenchimento.class, obj.getId());
		}
		for (UfCurso obj : curso.getUfCursos()) {
			dao.remove(UfCurso.class, obj.getId());
		}
		for (MunicipioCurso obj : curso.getMunicipioCursos()) {
			dao.remove(MunicipioCurso.class, obj.getId());
		}
		for (StatusCurso obj : curso.getStatusCursos()) {
			dao.remove(StatusCurso.class, obj.getId());
		}
		for (InscricaoCurso obj : curso.getInscricoes()) {
			dao.remove(InscricaoCurso.class, obj.getId());
		}

		dao.remove(Curso.class, curso.getId());
	}

	@Override
	public void enviarEmails(InscricaoCurso[] inscricoes, String assunto, String corpoEmail, String emailResponsavel) throws Exception {
		Thread thread = new ThreadEmail(simpleMailSender, inscricoes, assunto, corpoEmail, emailResponsavel);
		thread.start();
	}

	@Override
	public void enviarEmails(EmailCursoPrivado[] emailCursoPrivado, String assunto, String corpoEmail, String emailResponsavel,
			boolean cursoPrivado) throws Exception {
		Thread thread = new ThreadEmail(simpleMailSender, emailCursoPrivado, assunto, corpoEmail, emailResponsavel, cursoPrivado);
		thread.start();
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public boolean existeInscricoes(Curso curso) throws Exception {
		return cursoDAO.existeInscricoes(curso);

	}

	@Override
	public List<Municipio> pesquisarMunicipio(String nome) {
		return cursoDAO.pesquisarMunicipio(nome);
	}

	@Override
	public List<Status> carregarStatus(List<Integer> idsStatus) {
		return cursoDAO.carregarStatus(idsStatus);
	}

	@Override
	public List<InscricaoCurso> carregarListaCandidatoParticipante(Curso curso) {
		return cursoDAO.carregarListaCandidatoParticipante(curso);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void elegerCandidato(InscricaoCurso inscricaoCurso, Status status) throws Exception {
		dao.save(inscricaoCurso);
		
		StatusInscricao ultimoStatus = getUltimoStatusInscricao(inscricaoCurso);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(ultimoStatus.getId()));
		dao.merge(inscricaoCurso);

		Candidato candidato = (Candidato) dao.get(Candidato.class, inscricaoCurso.getCandidato().getId());
		Curso curso = (Curso) dao.get(Curso.class, inscricaoCurso.getCurso().getId());

		if (status.getId().equals(Status.PRE_INSCRITO)) {
			// Envia email para o chefe.
			String hashCandidato = inscricaoCurso.getCandidato().getId().toString() + "_" + inscricaoCurso.getId().toString();
			hashCandidato = CriptoUtil.getCriptografia(hashCandidato);
			String link = Constantes.ENDERECO_SERVIDOR_COM_PATH + "/pages/externo/confirmarInscricao.jsf?hash=" + hashCandidato;

			// Preenchendo o corpo do Email
			StringBuilder textoEmail = new StringBuilder();
			textoEmail.append("<p>Prezado(a),</p>");
			textoEmail.append("<p>A pr&eacute;-inscri&ccedil;&atilde;o do servidor(a) <b>" + candidato.getNome() + "</b>");
			textoEmail.append(" no evento " + curso.getTitulo());
			textoEmail.append(", no per&iacute;odo de " + curso.getDataRealizacaoInicio() + " a ");
			textoEmail.append(curso.getDataRealizacaoFim());
			textoEmail.append(", no logal " + curso.getLocalizacao().getDescricao());
			textoEmail.append(" foi realizada com sucesso.</p>");
			textoEmail.append("<p>Para dar continuidade ao processo de inscri&ccedil;&atilde;o, ");
			textoEmail.append("solicitamos a gentileza de clicar no link <a href=\"" + link + "\">Autoriza&ccedil;&atilde;o</a> ");
			textoEmail.append("para autorizar a participa&ccedil;&atilde;o do candidato no evento.<br/>");
			textoEmail.append("<p>Caso n&atilde;o seja poss&iacute;vel acessar o link diretamente, ");
			textoEmail.append("por favor copie o endere&ccedil;o abaixo e cole na URL!<br/>");
			textoEmail.append(link + "</p>");
			textoEmail.append("<p>O comprovante de inscri&ccedil;&atilde;o ser&aacute; enviado para o email do candidato, ");
			textoEmail.append("assim que for homologado pelo coordenador do curso.</p>");
			textoEmail.append("<br/>");
			textoEmail.append("Mensagem Autom&aacute;tica - N&atilde;o responder");

			String assunto = "Sistema SISFIE - CONFIRMAÇÃO DE PRE-INSCRIÇÃO DE CANDIDATO";

			// enviando email
			Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, textoEmail.toString(), candidato.getEmailChefe(),
					Constantes.EMAIL_SISTEMA, true);
			thread.start();
		} else if (status.getId().equals(Status.AGUARDANDO_COMPROVANTE)) {

			// prepara conteudo do email
			StringBuilder textoEmail = new StringBuilder("Confirma&ccedil;&atilde;o de participa&ccedil;&atilde;o do candidato no curso "
					+ curso.getTitulo());
			textoEmail.append("<br/>");
			textoEmail.append("<br/>");
			textoEmail.append("<b>Por favor acessar o sistema para anexar o comprovante de pagamento</b>");
			textoEmail.append("<br/>");
			textoEmail.append("Para maiores informa&ccedil;&otilde;es entre em contato: ");
			textoEmail.append("<br/>");
			textoEmail.append("Gestor do Curso: " + curso.getUsuario().getNome());
			textoEmail.append("<br/>");
			textoEmail.append("E-mail: " + curso.getUsuario().getLogin());
			textoEmail.append("<br/>");
			textoEmail.append("<br/>");
			textoEmail.append("Mensagem Autom&aacute;tica - N&atilde;o Responder.");

			String assunto = "Sistema SISFIE - Confirmação para participação do Candidato " + candidato.getNome() + " no curso "
					+ curso.getTitulo();

			Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, textoEmail.toString(), candidato.getEmailInstitucional(),
					Constantes.EMAIL_SISTEMA, true);
			thread.start();
		}

	}

	@Override
	public Integer retornarQuantidadeInscritos(Curso curso) {
		return cursoDAO.retornarQuantidadeInscritos(curso);
	}

	@Override
	public InscricaoCurso recuperarInscricaoPeloHash(String hashCandidato) throws Exception {
		return cursoDAO.recuperarInscricaoPeloHash(hashCandidato);
	}

	@Override
	public List<Curso> recuperarCursosComOficina(Usuario user) {
		return cursoDAO.recuperarCursosComOficina(user);
	}

	@Override
	public List<Curso> recuperarCursosAtivos(Usuario user) {
		return cursoDAO.recuperarCursosAtivos(user);
	}

	@Override
	public List<Curso> recuperarCursosComOficinaNaoDistribuidos(Usuario user) {
		return cursoDAO.recuperarCursosComOficinaNaoDistribuidos(user);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void desfazerHomologacao(InscricaoCurso inscricaoCurso, StatusInscricao statusInscricao) throws Exception {
		dao.save(statusInscricao);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(statusInscricao.getId()));
		dao.merge(inscricaoCurso);
	}

	@Override
	public List<Curso> recuperarCursosSemOficina(Curso a) throws Exception {
		return cursoDAO.recuperarCursosSemOficina(a);
	}

	@Override
	public List<Curso> recuperarCursos(Curso a) throws Exception {
		return cursoDAO.recuperarCursos(a);
	}

	@Override
	public List<InscricaoCurso> carregarListaCandidatoConfirmados(Curso curso) {
		return cursoDAO.carregarListaCandidatoConfirmados(curso);
	}

	@Override
	public List<Curso> recuperarCursosComOficina(Curso curso) throws Exception {
		return cursoDAO.recuperarCursosComOficina(curso);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarInscricaoCursoTurma(InscricaoCurso[] inscricoesCursoConfirmados, Integer idTurma) throws Exception {
		for (InscricaoCurso inscricaoCurso : inscricoesCursoConfirmados) {
			inscricaoCurso = (InscricaoCurso) dao.get(InscricaoCurso.class, inscricaoCurso.getId());
			inscricaoCurso.setTurma(new Turma(idTurma));
			dao.merge(inscricaoCurso);
		}

	}

	@Override
	public List<InscricaoCurso> carregarListaCandidatoCancelados(Curso cursoPesqCandidatoCancelado) throws Exception {
		return cursoDAO.carregarListaCandidatoCancelados(cursoPesqCandidatoCancelado);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void autorizarPagamento(InscricaoCurso inscricaoCurso) throws Exception {

		dao.save(inscricaoCurso);
		
		StatusInscricao ultimoStatus = getUltimoStatusInscricao(inscricaoCurso);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(ultimoStatus.getId()));
		dao.merge(inscricaoCurso);

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
				.append("<p>Aguardamos o pagamento da taxa de inscri&ccedil;&atilde;o para dar continuidade ao processo de inscri&ccedil;&atilde;o.</p>");
		textoEmail.append("<p>Informa&ccedil;&otilde;es para emiss&atilde;o da Nota de Empenho:");
		textoEmail.append("<br/>");
		textoEmail.append("I. CNPJ: 02.317.176.0001/05");
		textoEmail.append("<br/>");
		textoEmail.append("II. UG: 170009");
		textoEmail.append("<br/>");
		textoEmail.append("III. Gest&atilde;o: 0001");
		textoEmail.append("<br/>");
		textoEmail.append("IV. Natureza da Despesa: 339139");
		textoEmail.append("<br/>");
		textoEmail
				.append("Estas informa&ccedil;&otilde;es devem ser repassadas para o Setor de Recursos Humanos e/ou Setor financeiro de seu &oacute;rg&atilde;o.</p>");
		textoEmail.append("Para anexar o comprovante de pagamento:");
		textoEmail.append("<br/>");
		textoEmail
				.append("- Por Nota de Empenho - solicite uma c&oacute;pia ao Recursos Humanos e/ou Financeiro do seu &oacute;rg&atilde;o/entidade;");
		textoEmail.append("<br/>");
		textoEmail.append("- Pessoa f&iacute;sica - Gere e imprima a GRU - Guia de Recolhimento da Uni&atilde;o, no link : ");
		textoEmail
				.append("http://www.stn.fazenda.gov.br selecionando o Banner GUIA DE RECOLHIMENTO DA UNI&Atilde;O localizado &agrave; direita da tela, ou acesse: ");
		textoEmail.append("http://www.stn.fazenda.gov.br/siafi/index_GRU.asp.");
		textoEmail.append("<br/>");
		textoEmail
				.append("<p>Ap&oacute;s o pagamento da GRU ou de posse da Nota de Empenho, retorne ao SISFIE, sistema de inscri&ccedil;&atilde;o da ESAF para anex&aacute;-la.</p>");
		textoEmail.append("<p>O comprovante de inscri&ccedil;&atilde;o ser&aacute; enviado por e-mail. ");
		textoEmail
				.append("Caso n&atilde;o receba, entre em contato com a coordena&ccedil;&atilde;o do curso por e-mail ou pelos telefones citados na divulga&ccedil;&atilde;o do curso em quest&atilde;o.</p>");
		textoEmail.append("<br/>");
		textoEmail.append("Mensagem Autom&aacute;tica - N&atilde;o responder");

		String assunto = "Sistema SISFIE - CONFIRMAÇÃO DA PRE-INSCRIÇÃO";

		// enviando email
		Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, textoEmail.toString(), inscricaoCurso.getCandidato()
				.getEmailInstitucional(), Constantes.EMAIL_SISTEMA, true);
		thread.start();
	}

	@Override
	public List<Curso> recuperarCursosAtivos() {
		return cursoDAO.recuperarCursosAtivos();
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarAnexos(InscricaoCurso inscricaoCurso) throws Exception {

		// Salvando os comprovantes
		for (InscricaoComprovante comprovante : inscricaoCurso.getComprovantes()) {
			if (comprovante.getId() == null) {
				// Salva arquivo em diretorio
				File file = new File(comprovante.getUrlImagem());
				OutputStream out = new FileOutputStream(file);
				byte[] contents = comprovante.getImgComprovante();
				out.write(contents);
				out.flush();
				out.close();

				// limpa o blob para não salvar em banco.
				comprovante.setImgComprovante(null);

				// salva o comprovante
				dao.save(comprovante);
			}
		}

		// Salvando os documentos
		for (InscricaoDocumento documento : inscricaoCurso.getDocumentos()) {
			if (documento.getId() == null) {
				// Salva arquivo em diretorio
				File file = new File(documento.getUrlImagem());
				OutputStream out = new FileOutputStream(file);
				byte[] contents = documento.getImgDocumento();
				out.write(contents);
				out.flush();
				out.close();

				// limpa o blob para não salvar em banco.
				documento.setImgDocumento(null);

				// salva o comprovante
				dao.save(documento);
			}
		}
		dao.save(inscricaoCurso);
		
		StatusInscricao ultimoStatus = inscricaoCursoDAO.ultimoStatusInscricao(inscricaoCurso);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(ultimoStatus.getId()));
		dao.merge(inscricaoCurso);
	}

	@Override
	public boolean verificarDistribuicaoCurso(Curso curso) {
		return cursoDAO.verificarDistribuicaoCurso(curso);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarInscricaoInfoComplementar(InscricaoInfoComplementar inscricaoInfoComplementar) throws Exception {
		dao.save(inscricaoInfoComplementar);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void desfazerCancelamento(InscricaoCurso model, StatusInscricao statusInscricao) throws Exception {
		dao.save(statusInscricao);
		model.setUltimoStatus(new StatusInscricao(statusInscricao.getId()));
		dao.merge(model);
	}

	@Override
	public List<Oficina> recuperarOficinas(Curso curso) {
		return cursoDAO.recuperarOficinas(curso);
	}

	@Override
	public Integer retornarQuantidadeInscritos(Curso curso, Oficina oficina, List<Integer> idsInscritos,
			List<Integer> idsInscritosCancelados) {
		return cursoDAO.retornarQuantidadeInscritos(curso, oficina, idsInscritos, idsInscritosCancelados);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void clonarApoio(Curso curso, Curso cursoClone) throws Exception {
		/**
		 * Removendo registros anteriores caso existam
		 */
		curso = (Curso) dao.get(Curso.class, curso.getId());
		Hibernate.initialize(curso.getHorarios());
		if (curso.getHorarios() != null && !curso.getHorarios().isEmpty()) {
			for (Horario horario : curso.getHorarios()) {
				dao.remove(Horario.class, horario.getId());
			}
		}
		Hibernate.initialize(curso.getTurmas());
		if (curso.getTurmas() != null && !curso.getTurmas().isEmpty()) {
			for (Turma turma : curso.getTurmas()) {
				dao.remove(Turma.class, turma.getId());
			}
		}
		Hibernate.initialize(curso.getSalas());
		if (curso.getSalas() != null && !curso.getSalas().isEmpty()) {
			for (Sala sala : curso.getSalas()) {
				dao.remove(Sala.class, sala.getId());
			}
		}
		Hibernate.initialize(curso.getProfessorEventos());
		if (curso.getProfessorEventos() != null && !curso.getProfessorEventos().isEmpty()) {
			for (ProfessorEvento professorEvento : curso.getProfessorEventos()) {
				dao.remove(ProfessorEvento.class, professorEvento.getId());
			}
		}
		Hibernate.initialize(curso.getOficinas());
		if (curso.getOficinas() != null && !curso.getOficinas().isEmpty()) {
			for (Oficina oficina : curso.getOficinas()) {
				dao.remove(Oficina.class, oficina.getId());
			}
		}
		Hibernate.initialize(curso.getPacotes());
		if (curso.getPacotes() != null && !curso.getPacotes().isEmpty()) {
			for (Pacote pacote : curso.getPacotes()) {
				dao.remove(Pacote.class, pacote.getId());
			}
		}
		/**
		 * Clonando o curso
		 */
		cursoClone = (Curso) dao.get(Curso.class, cursoClone.getId());
		if (cursoClone.getHorarios() != null && !cursoClone.getHorarios().isEmpty()) {
			for (Horario horario : cursoClone.getHorarios()) {
				Horario horarioClone = (Horario) horario.clone();
				horarioClone.setCurso(new Curso(curso.getId()));
				horarioClone.setGradeOficinas(new HashSet<GradeOficina>(0));
				horarioClone.setGradePacotes(new HashSet<GradePacote>(0));
				horarioClone.setId(null);
				dao.save(horarioClone);
			}
		}
		if (cursoClone.getTurmas() != null && !cursoClone.getTurmas().isEmpty()) {
			for (Turma turma : cursoClone.getTurmas()) {
				Turma turmaClone = (Turma) turma.clone();
				turmaClone.setCurso(new Curso(curso.getId()));
				turmaClone.setGradeOficinas(new HashSet<GradeOficina>(0));
				turmaClone.setGradePacotes(new HashSet<GradePacote>(0));
				turmaClone.setInscricaoCursos(new HashSet<InscricaoCurso>(0));
				turmaClone.setId(null);
				dao.save(turmaClone);
			}
		}
		if (cursoClone.getSalas() != null && !cursoClone.getSalas().isEmpty()) {
			for (Sala sala : cursoClone.getSalas()) {
				Sala salaClone = (Sala) sala.clone();
				salaClone.setCurso(new Curso(curso.getId()));
				salaClone.setGradeOficinas(new HashSet<GradeOficina>(0));
				salaClone.setId(null);
				dao.save(salaClone);
			}
		}
		if (cursoClone.getProfessorEventos() != null && !cursoClone.getProfessorEventos().isEmpty()) {
			for (ProfessorEvento professorEvento : cursoClone.getProfessorEventos()) {
				ProfessorEvento professorEventoClone = (ProfessorEvento) professorEvento.clone();
				professorEventoClone.setCurso(new Curso(curso.getId()));
				professorEventoClone.setId(null);
				dao.save(professorEventoClone);
			}
		}
		if (cursoClone.getOficinas() != null && !cursoClone.getOficinas().isEmpty()) {
			for (Oficina oficina : cursoClone.getOficinas()) {
				Oficina oficinaClone = (Oficina) oficina.clone();
				oficinaClone.setCurso(new Curso(curso.getId()));
				oficinaClone.setGradeOficinas(new HashSet<GradeOficina>(0));
				oficinaClone.setPacoteOficinas(new HashSet<PacoteOficina>(0));
				oficinaClone.setId(null);
				dao.save(oficinaClone);
			}
		}
		if (cursoClone.getPacotes() != null && !cursoClone.getPacotes().isEmpty()) {
			for (Pacote pacote : cursoClone.getPacotes()) {
				// Carregando objeto para inicializar as collections
				pacote = (Pacote) dao.get(Pacote.class, pacote.getId());
				List<PacoteOficina> listaPacoteOficina = new ArrayList<PacoteOficina>();
				listaPacoteOficina.addAll(pacote.getPacoteOficinas());

				// Clonando o pacote
				Pacote pacoteClone = (Pacote) pacote.clone();
				pacoteClone.setCurso(new Curso(curso.getId()));
				pacoteClone.setPacoteOficinas(new HashSet<PacoteOficina>());
				pacoteClone.setId(null);
				dao.save(pacoteClone);

				// Clonando as oficinas contidas no pacote
				for (PacoteOficina pacoteOficina : listaPacoteOficina) {
					pacoteOficina = (PacoteOficina) pacoteOficina.clone();
					pacoteOficina.getPacote().setId(pacoteClone.getId());
					pacoteOficina.setId(null);
					dao.save(pacoteOficina);
				}
			}
		}
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void aceitarInscricao(InscricaoCurso inscricaoCurso) throws Exception {
		dao.save(inscricaoCurso);
		
		StatusInscricao ultimoStatus = getUltimoStatusInscricao(inscricaoCurso);
		inscricaoCurso.setUltimoStatus(new StatusInscricao(ultimoStatus.getId()));
		dao.merge(inscricaoCurso);

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
		textoEmail.append("<p>Atenciosamente.</p> ");
		textoEmail.append("<p>Coordena&ccedil;&atilde;o de Eventos<br /> ");
		textoEmail.append("Escola de Administra&ccedil;&atilde;o Fazend&aacute;ria-ESAF</p> ");
		textoEmail.append("<p>Mensagem Autom&aacute;tica - N&atilde;o responder</p>");

		String assunto = "Sistema SISFIE - CONFIRMAÇÃO DA PRE-INSCRIÇÃO";

		// enviando email
		Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, textoEmail.toString(), inscricaoCurso.getCandidato()
				.getEmailInstitucional(), Constantes.EMAIL_SISTEMA, true);
		thread.start();
	}

	public InscricaoCursoDAO getInscricaoCursoDAO() {
		return inscricaoCursoDAO;
	}

	public void setInscricaoCursoDAO(InscricaoCursoDAO inscricaoCursoDAO) {
		this.inscricaoCursoDAO = inscricaoCursoDAO;
	}

	@Override
	public StatusInscricao getUltimoStatusInscricao(InscricaoCurso inscricaoCurso) throws Exception{
		return inscricaoCursoDAO.ultimoStatusInscricao(inscricaoCurso);
	}

	@Override
	public List<EmailCursoPrivado> recuperarParceiros(ParceirosDTO dto) {
		return cursoDAO.recuperarParceiros(dto);
	}

	@Override
	public List<EmailCursoPrivado> recuperarParceirosNaoInscritos(Integer idCurso, List<String> listaEmailParceirosInscritos) {
		return cursoDAO.recuperarParceirosNaoInscritos(idCurso, listaEmailParceirosInscritos);
	}

	@Override
	public List<Curso> recuperarCursosComInscricoes(Curso curso) throws Exception{
		return cursoDAO.recuperarCursosComInscricoes(curso);
	}
}
