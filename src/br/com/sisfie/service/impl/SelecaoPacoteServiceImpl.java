package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.SelecaoPacoteDAO;
import br.com.sisfie.entidade.SelecaoPacote;
import br.com.sisfie.service.SelecaoPacoteService;

@Service(value = "selecaoPacoteService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class SelecaoPacoteServiceImpl implements SelecaoPacoteService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "selecaoPacoteDAO")
	protected SelecaoPacoteDAO selecaoPacoteDAO;

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public SelecaoPacoteDAO getSelecaoPacoteDAO() {
		return selecaoPacoteDAO;
	}

	public void setSelecaoPacoteDAO(SelecaoPacoteDAO selecaoPacoteDAO) {
		this.selecaoPacoteDAO = selecaoPacoteDAO;
	}

	@Override
	public List<SelecaoPacote> listarSelecaoPacote(Integer idPacote) {
		return selecaoPacoteDAO.listarSelecaoPacote(idPacote);
	}
}
