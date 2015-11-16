package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.sisfie.DAO.OrgaoDAO;
import br.com.sisfie.entidade.Orgao;
import br.com.sisfie.service.OrgaoService;

@Service(value = "OrgaoService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class OrgaoServiceImpl implements OrgaoService {

	@Autowired(required = true)
	@Qualifier(value = "OrgaoDAO")
	protected OrgaoDAO orgaoDAO;

	@Override
	public List<Orgao> pesquisarOrgao(String query) throws Exception {
		return orgaoDAO.pesquisarOrgao(query);
	}

	@Override
	public Orgao pesquisarOrgaoExata(String query) throws Exception {
		return orgaoDAO.pesquisarOrgaoExata(query);
	}

	@Override
	public List<Orgao> pesquisarOrgaoSigla(String sigla) throws Exception {
		return orgaoDAO.pesquisarOrgaoSigla(sigla);
	}

}
