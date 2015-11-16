package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.PacoteDAO;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Pacote;
import br.com.sisfie.entidade.PacoteOficina;
import br.com.sisfie.service.PacoteService;

@Service(value = "pacoteService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class PacoteServiceImpl implements PacoteService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "pacoteDAO")
	protected PacoteDAO pacoteDAO;

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void save(List<PacoteOficina> pacoteOficinas, List<PacoteOficina> listaPacoteOficinasExclusao, Pacote pacote) throws Exception {
		
		dao.save(pacote);
		
		if (listaPacoteOficinasExclusao != null && !listaPacoteOficinasExclusao.isEmpty()) {
			for (PacoteOficina pacoteOficina : listaPacoteOficinasExclusao) {
				dao.remove(PacoteOficina.class, pacoteOficina.getId());
			}
		}
			
		for (PacoteOficina pacoteOficina : pacoteOficinas) {
			pacoteOficina.setPacote(pacote);
			dao.save(pacoteOficina);
		}
	}

	@Override
	public PacoteOficina recuperarPacoteOficina(Integer idOficina, Integer idCurso) {
		return pacoteDAO.recuperarPacoteOficina(idOficina, idCurso);
	}

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public PacoteDAO getPacoteDAO() {
		return pacoteDAO;
	}

	public void setPacoteDAO(PacoteDAO pacoteDAO) {
		this.pacoteDAO = pacoteDAO;
	}

	@Override
	public List<PacoteOficina> recuperarPacoteOficina(Integer idCurso) {
		return pacoteDAO.recuperarPacoteOficina(idCurso);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void delete(List<PacoteOficina> listaPacoteOficinas, Pacote pacote) throws Exception {
		if (listaPacoteOficinas != null && !listaPacoteOficinas.isEmpty()){
			for (PacoteOficina pacoteOficina : listaPacoteOficinas) {
				dao.remove(PacoteOficina.class, pacoteOficina.getId());
			}
		}
		dao.remove(Pacote.class, pacote.getId());
	}

	@Override
	public List<PacoteOficina> recuperarPacoteOficina(Pacote model) {
		return pacoteDAO.recuperarPacoteOficina(model);
	}

	@Override
	public List<PacoteOficina> recuperarPacoteOficinaPorPacote(Integer idPacote) {
		return pacoteDAO.recuperarPacoteOficinaPorPacote(idPacote);
	}

	@Override
	public List<Pacote> recuperarPacotes(Integer idCurso) throws Exception {
		return pacoteDAO.recuperarPacotes(idCurso);
	}

	@Override
	public PacoteOficina recuperarPacoteOficina(Pacote pacote, Oficina oficina) {
		return pacoteDAO.recuperarPacoteOficina(pacote, oficina);
	}
}
