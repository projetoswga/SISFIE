package br.com.sisfie.DAO.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.OficinaDAO;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.PacoteOficina;

@Repository(value = "oficinaDAO")
public class OficinaDAOImpl extends HibernateDaoSupport implements OficinaDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<Oficina> recuperarOficinasDisponiveis(Integer idCurso) {
		Criteria criteria = getSession().createCriteria(Oficina.class);
		if (idCurso != null && !idCurso.equals(0)) {
			criteria.createAlias("curso", "curso");
			criteria.add(Restrictions.eq("curso.id", idCurso));
			criteria.addOrder(Order.asc("nomOficina"));
		}

		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Oficina> recuperarOficina(Integer idCurso, Integer idPacote) {
		Criteria criteria = getSession().createCriteria(Oficina.class);

		DetachedCriteria subCriteria = DetachedCriteria.forClass(PacoteOficina.class);
		subCriteria.createAlias("pacote", "p");
		subCriteria.add(Restrictions.eq("p.id", idPacote));
		subCriteria.createAlias("p.curso", "c");
		subCriteria.add(Property.forName("c.id").eq(idCurso));
		subCriteria.setProjection(Projections.distinct(Projections.property("oficina.id")));

		criteria.add(Property.forName("id").in(subCriteria));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Oficina> pesquisarOficina(String query, Integer idCurso) throws Exception {
		if (query == null || query.isEmpty()) {
			if (idCurso != null){
				Criteria criteria = getSession().createCriteria(Oficina.class);
				criteria.add(Restrictions.eq("curso.id", idCurso));
				return criteria.list();
			}
			return null;
		}
		String sql = "SELECT * FROM sisfie.oficina WHERE UPPER(SISFIE.sem_acento(nom_oficina)) ILIKE UPPER(SISFIE.sem_acento(\'%" + query
				+ "%\')) and id_curso = " + idCurso + " order by nom_oficina asc;";
		return getSession().createSQLQuery(sql).addEntity(Oficina.class).list();
	}

	@Override
	public Oficina pesquisarOficinaExata(String query) throws Exception {
		Criteria criteria = getSession().createCriteria(Oficina.class);
		criteria.add(Restrictions.ilike("nomOficina", query, MatchMode.EXACT));
		return (Oficina) criteria.uniqueResult();
	}
}
