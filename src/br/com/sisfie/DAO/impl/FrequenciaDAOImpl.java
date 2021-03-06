package br.com.sisfie.DAO.impl;

import java.sql.Timestamp;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
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
import br.com.sisfie.DAO.FrequenciaDAO;
import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.InscricaoCurso;

@Repository(value = "frequenciaDAO")
public class FrequenciaDAOImpl extends HibernateDaoSupport implements FrequenciaDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Override
	public Frequencia recuperarUltimaFrequencia(String inscricao) {
		/* getHibernateTemplate() com SQL Livre
		getHibernateTemplate().execute(new HibernateCallback<Frequencia>() {
	
			@Override
			public Frequencia doInHibernate(Session session)
					throws HibernateException, SQLException {
				session.createQuery(" ............ ").uniqueResult()
			}
			
			});
			*/

		StringBuilder sql = new StringBuilder();
		sql.append(" select max(id_frequencia) from frequencia f ");
		sql.append(" join inscricao_curso ic on ic.id_inscricao_curso = f.id_inscricao_curso ");
		sql.append(" where ic.num_inscricao like'" + inscricao + "' ");
		sql.append(" group by ic.num_inscricao ");

		
		Integer idFrequencia = (Integer) getSession().createSQLQuery(sql.toString()).uniqueResult();

		if (idFrequencia != null && idFrequencia > 0) {
			return recuperarPorId(idFrequencia);
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Frequencia> listarFrequencias(Integer idGradeOficina) throws Exception {
		List<Frequencia> listaFrequencia = null;

		StringBuilder sql = new StringBuilder();
		sql.append(" select max(id_frequencia) from frequencia f ");
		sql.append(" join inscricao_curso ic on ic.id_inscricao_curso = f.id_inscricao_curso ");
		sql.append(" where f.id_grade_oficina = " + idGradeOficina);
		sql.append(" group by ic.num_inscricao ");
		List<Integer> idsFrequencia = getSession().createSQLQuery(sql.toString()).list();

		if (idsFrequencia != null && !idsFrequencia.isEmpty()) {
			Criteria criteria = getSession().createCriteria(Frequencia.class);
			criteria.add(Restrictions.in("id", idsFrequencia));
			listaFrequencia = criteria.list();

			if (listaFrequencia != null && !listaFrequencia.isEmpty()) {
				Collections.sort(listaFrequencia, new Comparator<Frequencia>() {
					@Override
					public int compare(Frequencia o1, Frequencia o2) {
						return o1.getInscricaoCurso().getCandidato().getNome()
								.compareTo(o2.getInscricaoCurso().getCandidato().getNome());
					}
				});
			}
		}
		return listaFrequencia;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Frequencia> pesquisarFrequenciasAbertas(Integer idGradeOficina) {
		Criteria criteria = getSession().createCriteria(Frequencia.class);
		criteria.createAlias("gradeOficina", "go");
		criteria.add(Restrictions.eq("go.id", idGradeOficina));
		criteria.add(Restrictions.isNull("horarioSaida"));
		criteria.addOrder(Order.asc("horarioEntrada"));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Frequencia> listarFrequenciasSemOficina(List<InscricaoCurso> listaInscricaoCurso) {
		List<Frequencia> listaFrequencia = null;
		StringBuilder sql = new StringBuilder();
		
		sql.append(" select max(id_frequencia) from frequencia f ");
		sql.append(" join inscricao_curso ic on ic.id_inscricao_curso = f.id_inscricao_curso ");
		sql.append(" where ic.id_curso = " + listaInscricaoCurso.get(0).getCurso().getId());
		sql.append(" group by ic.num_inscricao ");
		List<Integer> idsFrequencia = getSession().createSQLQuery(sql.toString()).list();

		if (idsFrequencia != null && !idsFrequencia.isEmpty()) {
			Criteria criteria = getSession().createCriteria(Frequencia.class);
			criteria.add(Restrictions.in("id", idsFrequencia));
			listaFrequencia = criteria.list();

			if (listaFrequencia != null && !listaFrequencia.isEmpty()) {
				Collections.sort(listaFrequencia, new Comparator<Frequencia>() {
					@Override
					public int compare(Frequencia o1, Frequencia o2) {
						return o1.getInscricaoCurso().getCandidato().getNome()
								.compareTo(o2.getInscricaoCurso().getCandidato().getNome());
					}
				});
			}
		}
		return listaFrequencia;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Frequencia> pesquisarFrequenciasAbertasSemOficina(Integer idInscricaoCurso) {
		Criteria criteria = getSession().createCriteria(Frequencia.class);
		criteria.createAlias("inscricaoCurso", "ic");
		criteria.add(Restrictions.eq("ic.id", idInscricaoCurso));
		criteria.add(Restrictions.isNull("horarioSaida"));
		criteria.addOrder(Order.asc("horarioEntrada"));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Frequencia> pesquisarFrequenciasData(String inscricao, Calendar datFrequencia) {

		Calendar dataFreqEntrada = Calendar.getInstance(); // locale-specific
		dataFreqEntrada.setTime(datFrequencia.getTime());
		dataFreqEntrada.set(Calendar.HOUR_OF_DAY, 0);
		dataFreqEntrada.set(Calendar.MINUTE, 0);
		dataFreqEntrada.set(Calendar.SECOND, 0);
		dataFreqEntrada.set(Calendar.MILLISECOND, 0);
		Date fromDate = dataFreqEntrada.getTime();
		
		dataFreqEntrada.set(Calendar.HOUR_OF_DAY, 23);
		dataFreqEntrada.set(Calendar.MINUTE, 59);
		dataFreqEntrada.set(Calendar.SECOND, 59);
		dataFreqEntrada.set(Calendar.MILLISECOND, 999);
		Date toDate = dataFreqEntrada.getTime();
		
		Criteria criteria = getSession().createCriteria(Frequencia.class);
		criteria.createAlias("inscricaoCurso", "ic");
		criteria.add(Restrictions.eq("ic.inscricao", inscricao));
		criteria.add(Restrictions.between("horarioEntrada", new Timestamp(fromDate.getTime()), new Timestamp(toDate.getTime())));
		//criteria.add(Restrictions.lt("horarioSaida", dataEntradaFim.getTime()));
		criteria.addOrder(Order.asc("horarioEntrada"));
		return criteria.list();
	}
	

	@SuppressWarnings("unchecked")
	@Override
	public List<Frequencia> carregarFrequencias(Integer idCurso) {
		Criteria criteria = getSession().createCriteria(Frequencia.class);
		criteria.createAlias("inscricaoCurso", "ic");
		criteria.createAlias("ic.curso", "c");
		criteria.add(Restrictions.like("c.id", idCurso));
		return criteria.list();
	}

	@Override
	public Frequencia recuperarPorId(Integer id) {
		Criteria criteria = getHibernateTemplate().getSessionFactory().getCurrentSession().createCriteria(Frequencia.class);
		criteria.add(Restrictions.idEq(id));
		return (Frequencia) criteria.uniqueResult();
	}
}
