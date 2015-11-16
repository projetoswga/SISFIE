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
import br.com.sisfie.DAO.SalaDAO;
import br.com.sisfie.entidade.Sala;

@Repository(value = "salaDAO")
public class SalaDAOImpl extends HibernateDaoSupport implements SalaDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<Sala> recuperarSalas(List<Integer> listaIdCursos) {
		Criteria criteria = getSession().createCriteria(Sala.class);
		criteria.add(Restrictions.in("curso.id", listaIdCursos));
		criteria.addOrder(Order.asc("nomSala"));
		return criteria.list();
	}

}
