package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.SecretariaDAO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCursoCertificado;
import br.com.sisfie.service.SecretariaService;

@Service(value = "secretariaService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class SecretariaServiceImpl implements SecretariaService {
	
	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "secretariaDAO")
	protected SecretariaDAO secretariaDAO;

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public SecretariaDAO getSecretariaDAO() {
		return secretariaDAO;
	}

	public void setSecretariaDAO(SecretariaDAO secretariaDAO) {
		this.secretariaDAO = secretariaDAO;
	}

	@Override
	public List<InscricaoCursoCertificado> recuperarInscricoesJaHomologadas(List<Integer> idsInscricoesAprovadas) {
		return secretariaDAO.recuperarInscricoesJaHomologadas(idsInscricoesAprovadas);
	}

	@Override
	public List<InscricaoCursoCertificado> listarInscricaoCursoCertificados(Curso curso, Candidato candidato) {
		return secretariaDAO.listarInscricaoCursoCertificados(curso, candidato);
	}

}
