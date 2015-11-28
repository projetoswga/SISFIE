package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.CredenciamentoDAO;
import br.com.sisfie.entidade.Credenciamento;
import br.com.sisfie.service.CredenciamentoService;

@Service(value = "credenciamentoService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class CredenciamentoServiceImpl implements CredenciamentoService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "credenciamentoDAO")
	protected CredenciamentoDAO credenciamentoDAO;

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public CredenciamentoDAO getCredenciamentoDAO() {
		return credenciamentoDAO;
	}

	public void setCredenciamentoDAO(CredenciamentoDAO credenciamentoDAO) {
		this.credenciamentoDAO = credenciamentoDAO;
	}

	@Override
	public List<Credenciamento> listarCredenciamento(Integer idCurso, Integer idTurma) {
		return credenciamentoDAO.listarCredenciamento(idCurso, idTurma);
	}

	@Override
	public Credenciamento recuperarCredenciamento(String inscricao) {
		return credenciamentoDAO.recuperarCredenciamento(inscricao);
	}
}