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
import br.com.sisfie.DAO.TurmaDAO;
import br.com.sisfie.entidade.Turma;

@Repository(value = "turmaDAO")
public class TurmaDAOImpl extends HibernateDaoSupport implements TurmaDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<Turma> listarTurmas(Integer idCurso) {
		Criteria criteria = getSession().createCriteria(Turma.class);
		if (idCurso != null && !idCurso.equals(0)) {
			criteria.add(Restrictions.eq("curso.id", idCurso));
			criteria.addOrder(Order.asc("descricao"));
		}
		return criteria.list();
	}
}
