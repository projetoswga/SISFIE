package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.HorarioDAO;
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.service.HorarioService;

@Service(value = "horarioService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class HorarioServiceImpl implements HorarioService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "horarioDAO")
	protected HorarioDAO horarioDAO;

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public HorarioDAO getHorarioDAO() {
		return horarioDAO;
	}

	public void setHorarioDAO(HorarioDAO horarioDAO) {
		this.horarioDAO = horarioDAO;
	}

	@Override
	public Long verificarConflitoHorario(Horario model) {
		return horarioDAO.verificarConflitoHorario(model);
	}

	@Override
	public List<Horario> listarHorarios(Integer idCurso) {
		return horarioDAO.listarHorarios(idCurso);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarHorario(Horario horario) throws Exception {
		dao.save(horario);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void excluirHorario(Horario horario) throws Exception {
		dao.remove(Horario.class, horario.getId());
	}
}
