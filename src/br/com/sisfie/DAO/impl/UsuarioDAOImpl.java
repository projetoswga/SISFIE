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
import br.com.sisfie.DAO.UsuarioDAO;
import br.com.sisfie.entidade.Usuario;

@Repository(value = "usuarioDAO")
public class UsuarioDAOImpl extends HibernateDaoSupport implements UsuarioDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<Usuario> completeUsuarioAtivo(Usuario a) throws Exception {
		Criteria c = getSession().createCriteria(Usuario.class);
		c.add(Restrictions.ilike("nome", a.getNome(), MatchMode.ANYWHERE));
		c.add(Restrictions.eq("flgAtivo", true));
		return c.list();
	}

	@Override
	public Usuario carregaUsuarioPorLogin(String login) throws Exception {
		
		Usuario us =  (Usuario) getSession().createQuery("from Usuario  us where us.login= '"+login+"'").uniqueResult();
		return us;
	}

}
