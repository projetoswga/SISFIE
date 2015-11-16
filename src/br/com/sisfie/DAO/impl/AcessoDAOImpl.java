package br.com.sisfie.DAO.impl;

import java.util.List;
import java.util.Map;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.arquitetura.util.CriteriaMC;
import br.com.sisfie.DAO.AcessoDAO;
import br.com.sisfie.entidade.Funcionalidade;
import br.com.sisfie.entidade.PerfilFuncionalidade;
import br.com.sisfie.entidade.Usuario;

@Repository(value = "acessoDAO")
public class AcessoDAOImpl extends HibernateDaoSupport implements AcessoDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Override
	public boolean existeFuncionalidade(Integer idPerfilSelecionado, Funcionalidade func) {
		Criteria c = getSession().createCriteria(PerfilFuncionalidade.class);
		c.createAlias("perfil", "p");
		c.createAlias("funcionalidade", "f");
		c.add(Restrictions.eq("p.id", idPerfilSelecionado));
		c.add(Restrictions.eq("f.id", func.getId()));
		c.setProjection(Projections.rowCount());
		Long result = (Long) c.list().get(0);

		if (result != null && result > 0) {
			return true;
		} else {
			return false;
		}

	}

	@Override
	public List<Funcionalidade> carregarFilhos(Integer idPai) throws Exception {
		if (idPai == null) {
			return null;
		}
		Criteria c = getSession().createCriteria(Funcionalidade.class);
		c.add(Restrictions.eq("pai.id", idPai));
		return c.list();
	}

	@Override
	public List<Funcionalidade> carregarPais() throws Exception {
		Criteria c = getSession().createCriteria(Funcionalidade.class);
		c.add(Restrictions.isNull("pai.id"));
		c.addOrder(Order.asc("nome"));
		return c.list();
	}

	@Override
	public Long countPerfilFuncionalidade(PerfilFuncionalidade pf) {

		Criteria c = getSession().createCriteria(PerfilFuncionalidade.class);
		if (pf.getPerfil() != null && pf.getPerfil().getId() != null) {
			c.add(Restrictions.eq("perfil.id", pf.getPerfil().getId()));
		}
		if (pf.getFuncionalidade() != null && pf.getFuncionalidade().getId() != null) {
			c.add(Restrictions.eq("funcionalidade.id", pf.getFuncionalidade().getId()));
		}
		c.setProjection(Projections.rowCount());

		return (Long) c.list().get(0);

	}

	@Override
	public Long getCount(Funcionalidade model, Map<String, String> filters) {
		Criteria c = retornarCriteria(model, filters);
		c.setProjection(Projections.rowCount());

		return (Long) c.list().get(0);
	}

	@Override
	public List paginate(int first, int pageSize, Funcionalidade model, Map<String, String> filters, String sortField, boolean sortOrder) {
		Criteria c = retornarCriteria(model, filters);

		if (first != 0)
			c.setFirstResult(first);
		if (pageSize != 0)
			c.setMaxResults(pageSize);

		CriteriaMC criteriaMC = new CriteriaMC();
		criteriaMC.setCriteria(c);

		// Adicionando Sorting
		criteriaMC = dao.addOrderBy(criteriaMC, sortField, sortOrder);

		return criteriaMC.getCriteria().list();
	}

	public Criteria retornarCriteria(Funcionalidade model, Map<String, String> filters) {
		if (model == null) {
			return null;
		}
		Criteria c = getSession().createCriteria(model.getClass());
		c.add(Restrictions.isNull("pai.id"));

		if (filters != null) {
			Set<String> chaves = filters.keySet();
			for (String fil : chaves) {
				if (fil.trim().equalsIgnoreCase("nome")) {
					c.add(Restrictions.ilike("nome", filters.get(fil), MatchMode.ANYWHERE));
				}
				if (fil.trim().equalsIgnoreCase("role")) {
					c.add(Restrictions.ilike("role", filters.get(fil), MatchMode.ANYWHERE));
				}
				if (fil.trim().equalsIgnoreCase("detalhamento")) {
					c.add(Restrictions.ilike("detalhamento", filters.get(fil), MatchMode.ANYWHERE));
				}
			}
		}

		return c;
	}

	@Override
	public List<Funcionalidade> carregarFuncionalidades(Usuario u) {
		if (u == null || u.getId() == null) {
			return null;
		}

		StringBuilder sql = new StringBuilder();

		sql.append("from Funcionalidade f where f.id in (  ");
		sql.append(" select pf.funcionalidade.id from PerfilFuncionalidade pf where pf.perfil.id in (");
		sql.append(" select p.id from Perfil p,Usuario u  where p.id = u.perfil.id and u.id = ? ");
		sql.append(")");
		sql.append(")");

		return getSession().createQuery(sql.toString()).setParameter(0, u.getId()).list();
	}

}
