package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.ProfessorEventoDAO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.ProfessorEvento;
import br.com.sisfie.service.ProfessorEventoService;

@Service(value = "professorEventoService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class ProfessorEventoServiceImpl implements ProfessorEventoService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "professorEventoDAO")
	protected ProfessorEventoDAO professorEventoDAO;

	@Override
	public List<ProfessorEvento> listarProfessores(Integer IdCurso) {
		return professorEventoDAO.listarProfessores(IdCurso);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void excluirProfessor(ProfessorEvento professor) throws Exception {
		dao.remove(ProfessorEvento.class, professor.getId());
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarProfessor(ProfessorEvento professor) throws Exception {
		dao.save(professor);
	}

	@Override
	public ProfessorEvento recuperarProfessorEvento(Integer idCandidato, Integer idCurso) {
		return professorEventoDAO.recuperarProfessorEvento(idCandidato, idCurso);
	}

	@Override
	public List<Candidato> listarTodosProfessores() {
		return professorEventoDAO.listarTodosProfessores();
	}
}
