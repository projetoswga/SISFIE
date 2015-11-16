package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.OficinaDAO;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.service.OficinaService;

@Service(value = "oficinaService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class OficinaServiceImpl implements OficinaService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "oficinaDAO")
	protected OficinaDAO oficinaDAO;

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public OficinaDAO getOficinaDAO() {
		return oficinaDAO;
	}

	public void setOficinaDAO(OficinaDAO oficinaDAO) {
		this.oficinaDAO = oficinaDAO;
	}

	@Override
	public List<Oficina> recuperarOficinasDisponiveis(Integer idCurso) {
		return oficinaDAO.recuperarOficinasDisponiveis(idCurso);
	}

	@Override
	public List<Oficina> recuperarOficina(Integer idCurso, Integer idPacote) {
		return oficinaDAO.recuperarOficina(idCurso, idPacote);
	}

	@Override
	public List<Oficina> pesquisarOficina(String query, Integer idCurso) throws Exception{
		return oficinaDAO.pesquisarOficina(query, idCurso);
	}

	@Override
	public Oficina pesquisarOficinaExata(String query) throws Exception {
		return oficinaDAO.pesquisarOficinaExata(query);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarOficina(Oficina oficina) throws Exception {
		dao.save(oficina);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void excluirOficina(Oficina oficina) throws Exception {
		dao.remove(Oficina.class, oficina.getId());
	}

}
