package br.com.sisfie.DAO.impl;

import java.util.Collections;
import java.util.Comparator;
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
		StringBuilder sql = new StringBuilder();
		sql.append(" select max(id_frequencia) from frequencia ");
		sql.append(" where num_incricao like'" + inscricao + "' ");
		sql.append(" group by num_incricao ");
		Integer idFrequencia = (Integer) getSession().createSQLQuery(sql.toString()).uniqueResult();

		if (idFrequencia != null && idFrequencia > 0) {
			Criteria criteria = getSession().createCriteria(Frequencia.class);
			criteria.add(Restrictions.idEq(idFrequencia));
			return (Frequencia) criteria.uniqueResult();
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Frequencia> listarFrequencias(Integer idGradeOficina) throws Exception {
		List<Frequencia> listaFrequencia = null;
		StringBuilder sql = new StringBuilder();
		sql.append(" select max(id_frequencia) from frequencia ");
		sql.append(" where id_grade_oficina = " + idGradeOficina);
		sql.append(" group by num_incricao ");
		List<Integer> idsFrequencia = getSession().createSQLQuery(sql.toString()).list();

		if (idsFrequencia != null && !idsFrequencia.isEmpty()) {
			Criteria criteria = getSession().createCriteria(Frequencia.class);
			criteria.add(Restrictions.in("id", idsFrequencia));
			listaFrequencia = criteria.list();

			if (listaFrequencia != null && !listaFrequencia.isEmpty()) {
				for (Frequencia frequencia : listaFrequencia) {
					InscricaoCurso inscricaoCurso = new InscricaoCurso();
					inscricaoCurso.setInscricao(frequencia.getNumIncricao());
					frequencia.setInscricaoCurso((InscricaoCurso) dao.listBy(inscricaoCurso).get(0));
				}

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
}
