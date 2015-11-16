package br.com.sisfie.DAO.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.GradePacoteDAO;
import br.com.sisfie.entidade.GradePacote;

@Repository(value = "gradePacoteDAO")
public class GradePacoteDAOImpl extends HibernateDaoSupport implements GradePacoteDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<GradePacote> listarGradePacotes(Integer idPacote) {
		Criteria criteria = getSession().createCriteria(GradePacote.class);
		criteria.createAlias("pacoteOficina", "po");
		criteria.createAlias("po.pacote", "p");
		criteria.add(Restrictions.eq("p.id", idPacote));
		criteria.addOrder(Order.asc("id"));
		return criteria.list();
	}

	@Override
	public Long countGradePacote(GradePacote model) {
		Criteria criteria = getSession().createCriteria(GradePacote.class);
		criteria.createAlias("pacoteOficina", "po");
		criteria.createAlias("po.pacote", "p");
		criteria.add(Restrictions.eq("p.id", model.getPacoteOficina().getPacote().getId()));
		criteria.add(Restrictions.eq("horario.id", model.getHorario().getId()));
		criteria.add(Restrictions.eq("turma.id", model.getTurma().getId()));
		criteria.setProjection(Projections.rowCount());
		Long result = (Long) criteria.list().get(0);
		return result;
	}

	@Override
	public Long countGradePacote(Integer idPacote) {
		Criteria c = retornarCriteria(idPacote);
		c.setProjection(Projections.rowCount());

		Long result = (Long) c.list().get(0);
		return result;
	}

	private Criteria retornarCriteria(Integer idPacote) {
		Criteria criteria = getSession().createCriteria(GradePacote.class);
		criteria.createAlias("pacoteOficina", "po");
		criteria.createAlias("po.pacote", "p");
		criteria.add(Restrictions.eq("p.id", idPacote));
		criteria.addOrder(Order.asc("id"));
		return criteria;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GradePacote> listarGradePacotes(int first, int pageSize, Integer idPacote) {
		Criteria c = retornarCriteria(idPacote);

		if (first != 0)
			c.setFirstResult(first);
		if (pageSize != 0)
			c.setMaxResults(pageSize);

		return c.list();
	}
}
