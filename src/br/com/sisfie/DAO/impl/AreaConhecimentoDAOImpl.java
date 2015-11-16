package br.com.sisfie.DAO.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.AreaConhecimentoDAO;
import br.com.sisfie.entidade.AreaConhecimento;

@Repository(value = "areaConhecimentoDAO")
public class AreaConhecimentoDAOImpl extends HibernateDaoSupport implements AreaConhecimentoDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<AreaConhecimento> pesquisarAreaConhecimento(String query) throws Exception {
		if (query == null || query.isEmpty()) {
			return null;
		}
		String sql = "SELECT * FROM sisfie.area_conhecimento WHERE UPPER(SISFIE.sem_acento(descricao)) ILIKE UPPER(SISFIE.sem_acento(\'%"
				+ query + "%\')) and flg_ativo = 'true' order by descricao asc;";
		return getSession().createSQLQuery(sql).addEntity(AreaConhecimento.class).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public AreaConhecimento pesquisarAreaConhecimentoExata(String query) throws Exception {
		Criteria criteria = getSession().createCriteria(AreaConhecimento.class);
		criteria.add(Restrictions.ilike("descricao", query, MatchMode.EXACT));
		List<AreaConhecimento> list = criteria.list();
		if (list != null && !list.isEmpty()){
			return (AreaConhecimento) list.get(0);
		}else {
			return null;
		}
	}
}