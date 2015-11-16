package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.GradePacoteDAO;
import br.com.sisfie.entidade.GradePacote;
import br.com.sisfie.service.GradePacoteService;

@Service(value = "gradePacoteService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class GradePacoteServiceImpl implements GradePacoteService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "gradePacoteDAO")
	protected GradePacoteDAO gradePacoteDAO;

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public GradePacoteDAO getGradePacoteDAO() {
		return gradePacoteDAO;
	}

	public void setGradePacoteDAO(GradePacoteDAO gradePacoteDAO) {
		this.gradePacoteDAO = gradePacoteDAO;
	}

	@Override
	public List<GradePacote> listarGradePacotes(Integer idPacote) {
		return gradePacoteDAO.listarGradePacotes(idPacote);
	}

	@Override
	public Long countGradePacote(GradePacote model) {
		return gradePacoteDAO.countGradePacote(model);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void removerOficinaGradePacote(GradePacote model) throws Exception {
		dao.remove(GradePacote.class, model.getId());
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void alterarOficinaGradePacote(GradePacote model) throws Exception{
		dao.save(model);
	}

	@Override
	public Long countGradePacote(Integer idPacote) {
		return gradePacoteDAO.countGradePacote(idPacote);
	}

	@Override
	public List<GradePacote> listarGradePacotes(int first, int pageSize, Integer idPacote) {
		return gradePacoteDAO.listarGradePacotes(first, pageSize, idPacote);
	}
}
