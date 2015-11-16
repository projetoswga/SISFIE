package br.com.sisfie.DAO.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.sisfie.DAO.OrgaoDAO;
import br.com.sisfie.entidade.Orgao;

@Repository(value = "OrgaoDAO")
public class OrgaoDAOImpl extends HibernateDaoSupport implements OrgaoDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Override
	public List<Orgao> pesquisarOrgao(String query) throws Exception {
		if (query == null || query.isEmpty()) {
			return null;
		}
		String sql = "SELECT * FROM sisfie.orgao WHERE UPPER(SISFIE.sem_acento(nom_sigla)) ILIKE UPPER(SISFIE.sem_acento(\'%"+query+"%\')) order by nom_sigla asc,nom_orgao asc;";
		return  getSession().createSQLQuery(sql).addEntity(Orgao.class).list();
	}

	@Override
	public Orgao pesquisarOrgaoExata(String query) throws Exception {
		Criteria criteria = getSession().createCriteria(Orgao.class);
		criteria.add(Restrictions.ilike("nomeSiglaFormat", query,MatchMode.EXACT));
		List<Orgao>list = criteria.list();
		return (Orgao) list.get(0);
	}

	@Override
	public List<Orgao> pesquisarOrgaoSigla(String sigla) throws Exception {
		Criteria c = getSession().createCriteria(Orgao.class);
		
		c.add(Restrictions.ilike("sigla", sigla.trim()));
		
		
		return c.list();
	}
}
