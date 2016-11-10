package br.com.sisfie.DAO.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.CredenciamentoDAO;
import br.com.sisfie.entidade.Credenciamento;
import br.com.sisfie.entidade.Turma;

@Repository(value = "credenciamentoDAO")
public class CredenciamentoDAOImpl extends HibernateDaoSupport implements CredenciamentoDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<Credenciamento> listarCredenciamento(Integer idCurso, Integer idTurma) {
		Criteria criteria = getSession().createCriteria(Credenciamento.class);
		criteria.createAlias("curso", "c");
		criteria.add(Restrictions.eq("c.id", idCurso));
		if (idTurma != null && idTurma > 0){
			criteria.createAlias("c.turmas", "turmas");
			criteria.add(Restrictions.eq("turmas.id", idTurma));
		}
		return criteria.list();
	}

	@Override
	public Credenciamento recuperarCredenciamento(String inscricao) {
		Criteria criteria = getSession().createCriteria(Credenciamento.class);
		criteria.add(Restrictions.eq("numInscricao", inscricao));
		List<Credenciamento> results = criteria.list();
		if (null != results && !results.isEmpty()) {
			return results.get(0);
		} else {
			return null;
		}
		
	}
}