package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.GradeOficinaDAO;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.service.GradeOficinaService;

@Service(value = "gradeOficinaService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class GradeOficinaServiceImpl implements GradeOficinaService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "gradeOficinaDAO")
	protected GradeOficinaDAO gradeOficinaDAO;

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public GradeOficinaDAO getGradeOficinaDAO() {
		return gradeOficinaDAO;
	}

	public void setGradeOficinaDAO(GradeOficinaDAO gradeOficinaDAO) {
		this.gradeOficinaDAO = gradeOficinaDAO;
	}

	@Override
	public Long verificarRestricoes(GradeOficina model) {
		return gradeOficinaDAO.verificarRestricoes(model);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarGradeOficina(GradeOficina gradeOficina) throws Exception {
		dao.save(gradeOficina);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void excluirGradeOficina(GradeOficina gradeOficina) throws Exception {
		dao.remove(GradeOficina.class, gradeOficina.getId());
	}

	@Override
	public List<GradeOficina> listarGradeOficinas(Integer idCurso) throws Exception {
		return gradeOficinaDAO.listarGradeOficinas(idCurso);
	}
	
	@Override
	public List<Object> gerarArquivoEventoFrequencia(Integer idCurso) {
		return gradeOficinaDAO.gerarArquivoEventoFrequencia(idCurso);
	}

	@Override
	public List<Object> gerarArquivoTurmasFrequencia(Integer idCurso) {
		return gradeOficinaDAO.gerarArquivoTurmasFrequencia(idCurso);
	}

	@Override
	public List<Object> gerarArquivoParticipantesFrequencia(Integer idCurso) {
		return gradeOficinaDAO.gerarArquivoParticipantesFrequencia(idCurso);
	}

	@Override
	public List<InscricaoGrade> listarInscricaoGrades(Integer idCurso, List<Integer> idsCandidatosConfirmados) {
		return gradeOficinaDAO.listarInscricaoGrades(idCurso, idsCandidatosConfirmados);
	}

	@Override
	public Integer recuperarCapacidadeMaximaInscritos(Integer idCurso) {
		return gradeOficinaDAO.recuperarCapacidadeMaximaInscritos(idCurso);
	}

	@Override
	public GradeOficina recupararGradeOficina(Integer idCurso, Integer idTurma, Integer idHorario) {
		return gradeOficinaDAO.recupararGradeOficina(idCurso, idTurma, idHorario);
	}
}
