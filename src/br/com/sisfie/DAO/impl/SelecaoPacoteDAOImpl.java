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
import br.com.sisfie.DAO.SelecaoPacoteDAO;
import br.com.sisfie.entidade.SelecaoPacote;

@Repository(value = "selecaoPacoteDAO")
public class SelecaoPacoteDAOImpl extends HibernateDaoSupport implements SelecaoPacoteDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<SelecaoPacote> listarSelecaoPacote(Integer idPacote) {
		Criteria criteria = getSession().createCriteria(SelecaoPacote.class);
		criteria.add(Restrictions.eq("pacote.id", idPacote));
		return criteria.list();
	}

}
