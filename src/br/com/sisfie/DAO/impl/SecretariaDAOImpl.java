package br.com.sisfie.DAO.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.SecretariaDAO;
import br.com.sisfie.entidade.InscricaoCursoCertificado;

@Repository(value = "secretariaDAO")
public class SecretariaDAOImpl extends HibernateDaoSupport implements SecretariaDAO {
	
	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCursoCertificado> recuperarInscricoesJaHomologadas(List<Integer> idsInscricoesAprovadas) {
		Criteria criteria = getSession().createCriteria(InscricaoCursoCertificado.class);
		criteria.createAlias("inscricaoCurso", "ic");
		criteria.add(Restrictions.in("ic.id", idsInscricoesAprovadas));
		criteria.add(Restrictions.eq("flgHomologado", true));
		return criteria.list();
	}

}
