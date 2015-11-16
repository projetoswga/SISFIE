package br.com.sisfie.DAO.impl;

import java.util.ArrayList;
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
import br.com.sisfie.DAO.HorarioDAO;
import br.com.sisfie.entidade.Horario;

@Repository(value = "horarioDAO")
public class HorarioDAOImpl extends HibernateDaoSupport implements HorarioDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Override
	public Long verificarConflitoHorario(Horario model) {
		Criteria criteria = getSession().createCriteria(Horario.class);

		// Removendo da pesquisa o proprio registro quando for edição
		if (model.getId() != null && !model.getId().equals(0)) {
			List<Integer> listaIds = new ArrayList<Integer>();
			listaIds.add(model.getId());
			criteria.add(Restrictions.not(Restrictions.in("id", listaIds)));
		}

		criteria.add(Restrictions.eq("curso.id", model.getCurso().getId()));
		criteria.add(Restrictions.or(
				Restrictions.or(Restrictions.between("datHoraInicio", model.getDatHoraInicio(), model.getDatHoraFim()),
						Restrictions.between("datHoraFim", model.getDatHoraInicio(), model.getDatHoraFim())),
				Restrictions.and(
						Restrictions.and(Restrictions.le("datHoraInicio", model.getDatHoraInicio()),
								Restrictions.ge("datHoraFim", model.getDatHoraInicio())),
						Restrictions.and(Restrictions.le("datHoraInicio", model.getDatHoraFim()),
								Restrictions.ge("datHoraFim", model.getDatHoraFim())))));
		criteria.setProjection(Projections.rowCount());

		Long result = (Long) criteria.list().get(0);
		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Horario> listarHorarios(Integer idCurso) {
		Criteria criteria = getSession().createCriteria(Horario.class);
		if (idCurso != null && !idCurso.equals(0)){
			criteria.add(Restrictions.eq("curso.id", idCurso));
		}
		criteria.addOrder(Order.asc("desHorario"));
		return criteria.list();
	}

}
