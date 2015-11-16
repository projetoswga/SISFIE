package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.arquitetura.util.ThreadEnviarEmail;
import br.com.sisfie.DAO.CandidatoDAO;
import br.com.sisfie.dto.CandidatoDTO;
import br.com.sisfie.dto.RelatorioPesquisaDTO;
import br.com.sisfie.entidade.AtuacaoCandidato;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.CandidatoCargo;
import br.com.sisfie.entidade.CandidatoComplemento;
import br.com.sisfie.entidade.InscricaoComprovante;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoInfoComplementar;
import br.com.sisfie.entidade.ProfessorEvento;
import br.com.sisfie.entidade.SelecaoOficina;
import br.com.sisfie.entidade.SelecaoPacote;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.service.CandidatoService;
import br.com.sisfie.util.Constantes;

@Service(value = "candidatoService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class CandidatoServiceImpl implements CandidatoService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "candidatoDAO")
	protected CandidatoDAO candidatoDAO;

	@Autowired(required = true)
	@Qualifier(value = "mailSender")
	private JavaMailSender simpleMailSender;

	@Override
	public Long countCandidato(CandidatoDTO dto) {
		return candidatoDAO.countCandidato(dto);
	}

	@Override
	public List<Candidato> paginateCandidato(int first, int pageSize, CandidatoDTO dto) {
		return candidatoDAO.paginateCandidato(first, pageSize, dto);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void save(Candidato candidato, String senhaGerada) throws Exception {
		dao.save(candidato);

		// prepara conteudo do email
		StringBuilder textoEmail = new StringBuilder("Senha redefinida com sucesso!");
		textoEmail.append("<br/>");
		textoEmail.append("<b>Login:</b>" + candidato.getEmailInstitucional());
		textoEmail.append("<br/>");
		textoEmail.append("<b>Senha:</b>" + senhaGerada);
		textoEmail.append("<br/>");
		textoEmail.append("Mensagem Autom&aacute;tica - N&atilde;o Responder.");

		String assunto = "Sistema SISFIE - Informação sobre redefinição de senha do usuário " + candidato.getNome();

		// envia email
		Thread thread = new ThreadEnviarEmail(simpleMailSender, assunto, textoEmail.toString(), candidato.getEmailInstitucional(),
				Constantes.EMAIL_SISTEMA, true);
		thread.start();
	}

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public JavaMailSender getSimpleMailSender() {
		return simpleMailSender;
	}

	public void setSimpleMailSender(JavaMailSender simpleMailSender) {
		this.simpleMailSender = simpleMailSender;
	}

	public CandidatoDAO getCandidatoDAO() {
		return candidatoDAO;
	}

	public void setCandidatoDAO(CandidatoDAO candidatoDAO) {
		this.candidatoDAO = candidatoDAO;
	}

	@Override
	public List<InscricaoCurso> listarCandidatosInscritos(RelatorioPesquisaDTO dto) throws Exception {
		return candidatoDAO.listarCandidatosInscritos(dto);
	}

	@Override
	public String recuperarCargoAtivo(Integer idCandidato) throws Exception {
		return candidatoDAO.recuperarCargoAtivo(idCandidato);
	}

	@Override
	public List<Candidato> recuperarInstrutores(InscricaoCurso inscricaoCurso) {
		return candidatoDAO.recuperarInstrutores(inscricaoCurso);
	}

	@Override
	public List<Candidato> pesquisarCandidato(String query) {
		return candidatoDAO.pesquisarCandidato(query);
	}

	@Override
	public List<Candidato> pesquisarCandidato(String query, String idCandidatos) {
		return candidatoDAO.pesquisarCandidato(query, idCandidatos);
	}

	@SuppressWarnings("unchecked")
	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void excluirCandidato(Candidato candidato) throws Exception {
		AtuacaoCandidato atuacao = new AtuacaoCandidato();
		atuacao.setCandidato(new Candidato(candidato.getId()));;
		List<AtuacaoCandidato> listaAtuacaoCandidatos = dao.listBy(atuacao);
		if (listaAtuacaoCandidatos != null && !listaAtuacaoCandidatos.isEmpty()){
			for (AtuacaoCandidato atuacaoCandidato : listaAtuacaoCandidatos){
				dao.remove(AtuacaoCandidato.class, atuacaoCandidato.getId());
			}
		}
		
		CandidatoCargo cc = new CandidatoCargo();
		cc.setCandidato(new Candidato(candidato.getId()));
		List<CandidatoCargo> listaCandidatoCargos = dao.listBy(cc);
		if (listaCandidatoCargos != null && !listaCandidatoCargos.isEmpty()){
			for (CandidatoCargo candidatoCargo : listaCandidatoCargos){
				dao.remove(CandidatoCargo.class, candidatoCargo.getId());
			}
		}
		
		CandidatoComplemento complemento = new CandidatoComplemento();
		complemento.setCandidato(new Candidato(candidato.getId()));
		List<CandidatoComplemento> listaCandidatoComplementos = dao.listBy(complemento);
		if (listaCandidatoComplementos != null && !listaCandidatoComplementos.isEmpty()){
			for (CandidatoComplemento candidatoComplemento : listaCandidatoComplementos){
				dao.remove(CandidatoComplemento.class, candidatoComplemento.getId());
			}
		}
		
		ProfessorEvento pe = new ProfessorEvento();
		pe.setCandidato(new Candidato(candidato.getId()));
		List<ProfessorEvento> listaProfessorEvento = dao.listBy(pe);
		if (listaProfessorEvento != null && !listaProfessorEvento.isEmpty()){
			for (ProfessorEvento professorEvento : listaProfessorEvento){
				dao.remove(ProfessorEvento.class, professorEvento.getId());
			}
		}
		
		InscricaoCurso ic = new InscricaoCurso();
		ic.setCandidato(new Candidato(candidato.getId()));
		List<InscricaoCurso> listaInscricaoCursos = dao.listBy(ic);
		if (listaInscricaoCursos != null && !listaInscricaoCursos.isEmpty()){
			for (InscricaoCurso inscricaoCurso : listaInscricaoCursos){
				SelecaoOficina so = new SelecaoOficina();
				so.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));
				List<SelecaoOficina> listaSelecaoOficinas = dao.listBy(so);
				if (listaSelecaoOficinas != null && !listaSelecaoOficinas.isEmpty()){
					for (SelecaoOficina selecaoOficina : listaSelecaoOficinas){
						dao.remove(SelecaoOficina.class, selecaoOficina.getId());
					}
				}
				
				SelecaoPacote sp = new SelecaoPacote();
				sp.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));
				List<SelecaoPacote> listaSelecaoPacotes = dao.listBy(sp);
				if (listaSelecaoPacotes != null && !listaSelecaoPacotes.isEmpty()){
					for (SelecaoPacote selecaoPacote : listaSelecaoPacotes){
						dao.remove(SelecaoPacote.class, selecaoPacote.getId());
					}
				}
				
				StatusInscricao si = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()), null, null, null);
				List<StatusInscricao> listaStatusInscricao = dao.listBy(si);
				if (listaStatusInscricao != null && !listaStatusInscricao.isEmpty()){
					for (StatusInscricao statusInscricao : listaStatusInscricao){
						dao.remove(StatusInscricao.class, statusInscricao.getId());
					}
				}
				
				InscricaoComprovante comprovante = new InscricaoComprovante();
				comprovante.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));
				List<InscricaoComprovante> listaInscricaoComprovantes = dao.listBy(comprovante);
				if (listaInscricaoComprovantes != null && !listaInscricaoComprovantes.isEmpty()){
					for (InscricaoComprovante inscricaoComprovante : listaInscricaoComprovantes){
						dao.remove(InscricaoComprovante.class, inscricaoComprovante.getId());
					}
				}
				
				InscricaoInfoComplementar iic = new InscricaoInfoComplementar();
				iic.setInscricaoCurso(new InscricaoCurso(inscricaoCurso.getId()));
				List<InscricaoInfoComplementar> listaInscricaoInfoComplementar = dao.listBy(iic);
				if (listaInscricaoInfoComplementar != null && !listaInscricaoInfoComplementar.isEmpty()){
					for (InscricaoInfoComplementar inscricaoInfoComplementar : listaInscricaoInfoComplementar){
						dao.remove(InscricaoInfoComplementar.class, inscricaoInfoComplementar.getId());
					}
				}
				
				dao.remove(InscricaoCurso.class, inscricaoCurso.getId());
			}
		}
		dao.remove(Candidato.class, candidato.getId());
	}

	@Override
	public CandidatoComplemento recuperarCandidatoComplemento(Integer idCandidato) {
		return candidatoDAO.recuperarCandidatoComplemento(idCandidato);
	}
}
