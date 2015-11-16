package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.SalaDAO;
import br.com.sisfie.entidade.Sala;
import br.com.sisfie.service.SalaService;

@Service(value = "salaService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class SalaServiceImpl implements SalaService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "salaDAO")
	protected SalaDAO salaDAO;

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public SalaDAO getSalaDAO() {
		return salaDAO;
	}

	public void setSalaDAO(SalaDAO salaDAO) {
		this.salaDAO = salaDAO;
	}

	@Override
	public List<Sala> recuperarSalas(List<Integer> listaIdCursos) {
		return salaDAO.recuperarSalas(listaIdCursos);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarSala(Sala sala) throws Exception {
		dao.save(sala);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void excluirSala(Sala sala) throws Exception {
		dao.remove(Sala.class, sala.getId());
	}
}
