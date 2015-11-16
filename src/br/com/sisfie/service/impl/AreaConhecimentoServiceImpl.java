package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.AreaConhecimentoDAO;
import br.com.sisfie.entidade.AreaConhecimento;
import br.com.sisfie.entidade.AreaConhecimentoCurso;
import br.com.sisfie.service.AreaConhecimentoService;

@Service(value = "areaConhecimentoService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class AreaConhecimentoServiceImpl implements AreaConhecimentoService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "areaConhecimentoDAO")
	protected AreaConhecimentoDAO areaConhecimentolDAO;

	@Override
	public List<AreaConhecimento> pesquisarAreaConhecimento(String query) throws Exception {
		return areaConhecimentolDAO.pesquisarAreaConhecimento(query);
	}

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public AreaConhecimentoDAO getAreaConhecimentolDAO() {
		return areaConhecimentolDAO;
	}

	public void setAreaConhecimentolDAO(AreaConhecimentoDAO areaConhecimentolDAO) {
		this.areaConhecimentolDAO = areaConhecimentolDAO;
	}

	@Override
	public AreaConhecimento pesquisarAreaConhecimentoExata(String query) throws Exception {
		return areaConhecimentolDAO.pesquisarAreaConhecimentoExata(query);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void excluirAreaConhecimentoCurso(AreaConhecimentoCurso areaConhecimentoCursoExclusao) throws Exception {
		dao.remove(AreaConhecimentoCurso.class, areaConhecimentoCursoExclusao.getId());
	}
}