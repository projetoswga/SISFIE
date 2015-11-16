package br.com.sisfie.DAO.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.PacoteDAO;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Pacote;
import br.com.sisfie.entidade.PacoteOficina;

@Repository(value = "pacoteDAO")
public class PacoteDAOImpl extends HibernateDaoSupport implements PacoteDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Override
	public PacoteOficina recuperarPacoteOficina(Integer idOficina, Integer idCurso) {
		Criteria criteria = getSession().createCriteria(PacoteOficina.class);
		criteria.createAlias("oficina", "o");
		criteria.add(Restrictions.eq("o.id", idOficina));
		criteria.createAlias("pacote", "p");
		criteria.createAlias("p.curso", "c");
		criteria.add(Restrictions.eq("c.id", idCurso));
		return (PacoteOficina) criteria.uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PacoteOficina> recuperarPacoteOficina(Integer idCurso) {
		Criteria criteria = getSession().createCriteria(PacoteOficina.class);
		criteria.createAlias("pacote", "p");
		criteria.createAlias("p.curso", "c");
		criteria.add(Restrictions.eq("c.id", idCurso));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PacoteOficina> recuperarPacoteOficina(Pacote model) {
		Criteria criteria = getSession().createCriteria(PacoteOficina.class);
		criteria.createAlias("pacote", "p");
		criteria.createAlias("p.curso", "c");
		criteria.add(Restrictions.eq("p.id", model.getId()));
		criteria.add(Restrictions.eq("c.id", model.getCurso().getId()));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<PacoteOficina> recuperarPacoteOficinaPorPacote(Integer idPacote) {
		Criteria criteria = getSession().createCriteria(PacoteOficina.class);
		criteria.createAlias("pacote", "p");
		criteria.add(Restrictions.eq("p.id", idPacote));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Pacote> recuperarPacotes(Integer idCurso) throws Exception {
		Criteria criteria = getSession().createCriteria(Pacote.class);
		criteria.add(Restrictions.eq("curso.id", idCurso));
		criteria.addOrder(Order.asc("nomPacote"));
		return criteria.list();
	}

	@Override
	public PacoteOficina recuperarPacoteOficina(Pacote pacote, Oficina oficina) {
		Criteria criteria = getSession().createCriteria(PacoteOficina.class);
		criteria.add(Restrictions.eq("pacote.id", pacote.getId()));
		criteria.add(Restrictions.eq("oficina.id", oficina.getId()));
		return (PacoteOficina) criteria.uniqueResult();
	}
}
