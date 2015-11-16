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
import br.com.sisfie.DAO.ProfessorEventoDAO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.ProfessorEvento;

@Repository(value = "professorEventoDAO")
public class ProfessorEventoDAOImpl extends HibernateDaoSupport implements ProfessorEventoDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<ProfessorEvento> listarProfessores(Integer idCurso) {
		Criteria criteria = getSession().createCriteria(ProfessorEvento.class);
		criteria.add(Restrictions.eq("curso.id", idCurso));
		criteria.createAlias("candidato", "cand");
		criteria.addOrder(Order.asc("cand.nome"));
		return criteria.list();
	}

	@Override
	public ProfessorEvento recuperarProfessorEvento(Integer idCandidato, Integer idCurso) {
		Criteria criteria = getSession().createCriteria(ProfessorEvento.class);
		criteria.add(Restrictions.eq("curso.id", idCurso));
		criteria.add(Restrictions.eq("candidato.id", idCandidato));
		return (ProfessorEvento) criteria.uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Candidato> listarTodosProfessores() {
		Criteria criteria = getSession().createCriteria(ProfessorEvento.class);
		criteria.setProjection(Projections.distinct(Projections.property("candidato.id")));
		List<Integer> ids = criteria.list();
		if (ids != null && !ids.isEmpty()){
			Criteria criteriaCandidato = getSession().createCriteria(Candidato.class);
			criteriaCandidato.add(Restrictions.in("id", ids));
			return criteriaCandidato.list();
		}
		return null;
	}

}
