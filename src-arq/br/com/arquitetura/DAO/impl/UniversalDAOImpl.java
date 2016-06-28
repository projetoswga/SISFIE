package br.com.arquitetura.DAO.impl;

import java.io.Serializable;
import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Map.Entry;

import javax.persistence.Transient;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.hibernate.Criteria;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.arquitetura.entidade.Entidade;
import br.com.arquitetura.util.ClasseUtil;
import br.com.arquitetura.util.CriteriaMC;
import br.com.arquitetura.util.TypelessLikeExpression;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.ModeloDocumento;
import br.com.sisfie.entidade.StatusInscricao;

@Repository(value = "universalDAO")
public class UniversalDAOImpl extends HibernateDaoSupport implements UniversalDAO {

	private static final long serialVersionUID = 6005144208408623378L;

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	protected final transient Log log = LogFactory.getLog(getClass());

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@Override
	public Object get(Class clazz, Serializable id) {
		return getHibernateTemplate().get(clazz, id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAll(Class clazz) {
		Criteria criteria = getSession().createCriteria(clazz);
		return criteria.list();
	}

	@Override
	public void remove(Class clazz, Serializable id) {
		getHibernateTemplate().delete(get(clazz, id));
	}

	@Override
	public Long getCount(Object o) {
		Criteria c = this.getSession().createCriteria(o.getClass());
		c.setProjection(Projections.rowCount());

		return (Long) c.list().get(0);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Object save(Object o) {

		Entidade entidade = (Entidade) o;

		if (entidade.getId() == null || entidade.getId().equals("")) {
			getHibernateTemplate().persist(o);
		} else {
			getHibernateTemplate().update(o);
		}

		// TODO: WORKAROUD PARA RESOLVER PROBLEMAS NO ULTIMO STATUS DA INSCRICAO
		if (o instanceof StatusInscricao) {
			StatusInscricao si = (StatusInscricao) o;
			InscricaoCurso ic = si.getInscricaoCurso();
			ic.setUltimoStatus(si);
			if (ic.getId() == null || ic.getId().equals("")) {
				getHibernateTemplate().persist(ic);
			} else {
				getHibernateTemplate().update(ic);
			}
		}
		// TODO: FIM WORKAROUND

		return o;
	}

	@Override
	public Object merge(Object o) {

		getHibernateTemplate().merge(o);

		return o;
	}

	@Override
	public List listBy(Object o) throws Exception {
		CriteriaMC c = criarCriteria(o, false);

		return c.getCriteria().list();
	}

	/**
	 * Paginacao e sorting. Baseado no lazydatamodel do primefaces
	 * 
	 * @param sortOrder
	 *            (true asc / false desc)
	 * @throws Exception
	 */
	public List paginate(int first, int pageSize, String sortField, boolean sortOrder, Map<String, String> filters, Class clazz)
			throws Exception {

		CriteriaMC criteriaMC = createCriteriaPaginate(first, pageSize, sortField, sortOrder, filters, clazz);

		// Adicionando Sorting
		criteriaMC = this.addOrderBy(criteriaMC, sortField, sortOrder);

		List list = criteriaMC.getCriteria().list();
		return list;
	}

	/**
	 * Metodo que rebe os inputs do LazyDataModel(Primefaces) e cria uma
	 * criteria com filtros e ordenacao
	 * 
	 * @param first
	 * @param pageSize
	 * @param sortField
	 * @param sortOrder
	 * @param filters
	 * @param o
	 * @return
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws Exception
	 */
	private CriteriaMC createCriteriaPaginate(int first, int pageSize, String sortField, boolean sortOrder, Map<String, String> filters,
			Class clazz) throws IllegalArgumentException, IllegalAccessException, Exception {

		Object o = clazz.newInstance();
		Criteria criteria = getSession().createCriteria(clazz);
		CriteriaMC criteriaMC = new CriteriaMC();

		criteriaMC.setCriteria(criteria);
		if (first != 0)
			criteria.setFirstResult(first);
		if (pageSize != 0)
			criteria.setMaxResults(pageSize);

		// Adicionando os filtros
		Iterator<Entry<String, String>> it = filters.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, String> pairs = (Map.Entry<String, String>) it.next();
			ClasseUtil.setValorPropriedade(o, pairs.getKey().toString(), pairs.getValue().trim());
			criteriaMC = this.criarCriteria(o, true);
		}

		return criteriaMC;
	}

	private CriteriaMC createCriteriaPaginate(Class clazz, Map filters) throws IllegalArgumentException, IllegalAccessException, Exception {

		Object o = clazz.newInstance();

		Criteria criteria = getSession().createCriteria(o.getClass());
		CriteriaMC criteriaMC = new CriteriaMC();

		criteriaMC.setCriteria(criteria);

		// Adicionando os filtros
		Iterator<Entry<String, String>> it = filters.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, String> pairs = (Map.Entry<String, String>) it.next();
			ClasseUtil.setValorPropriedade(o, pairs.getKey().toString(), pairs.getValue().trim());
			criteriaMC = this.criarCriteria(o, true);
		}

		return criteriaMC;
	}

	/**
	 * Metodo que rebe os inputs do LazyDataModel(Primefaces) e gera uma query
	 * de Count trazendo o numero total de objetos que respeitem os filstors
	 * passados
	 */
	@Override
	public Long getCount(int first, int pageSize, String sortField, boolean sortOrder, Map<String, String> filters, Class clazz)
			throws Exception {

		CriteriaMC c = createCriteriaPaginate(0, 0, sortField, sortOrder, filters, clazz);
		c.getCriteria().setProjection(Projections.rowCount());

		return (Long) c.getCriteria().list().get(0);
	}

	@Override
	public Long getCount(Class clazz, Map filters) throws Exception {
		CriteriaMC c = createCriteriaPaginate(clazz, filters);
		c.getCriteria().setProjection(Projections.rowCount());

		return (Long) c.getCriteria().list().get(0);
	}

	/**
	 * Adicionando Sorting
	 * 
	 * @param criteria
	 * @param propriedade
	 * @param sortOrder
	 *            (true asc / false desc)
	 * @return
	 */
	public CriteriaMC addOrderBy(CriteriaMC criteriaMC, String propriedade, boolean sortOrder) {
		if (propriedade == null)
			return criteriaMC;
		String[] campos = propriedade.split("\\.");
		int lastIndexOf = propriedade.lastIndexOf(".");
		if (lastIndexOf != -1) {

			String ultimoCampo = "";
			Criteria alias = null;
			for (int i = 0; i < campos.length; i++) {
				String campo = campos[i];
				if (i == 0) {
					if (criteriaMC.getCriterias().containsKey(campo))
						alias = criteriaMC.getCriterias().get(campo);
					else {
						alias = criteriaMC.getCriteria().createCriteria(campo, campo, Criteria.LEFT_JOIN);
						criteriaMC.getCriterias().put(campo, alias);
					}
				} else {
					if (i != campos.length - 1) {
						String a = campos[i - 1] + "." + campo;
						if (criteriaMC.getCriterias().containsKey(campo))
							alias = criteriaMC.getCriterias().get(campo);
						else {
							alias = criteriaMC.getCriteria().createCriteria(a, campo, Criteria.LEFT_JOIN);
							criteriaMC.getCriterias().put(campo, alias);
						}
						ultimoCampo = campo;
					}
				}
			}

			if (!ultimoCampo.isEmpty())
				propriedade = ultimoCampo + propriedade.substring(lastIndexOf);
			if (sortOrder)
				alias.addOrder(Order.asc(propriedade));
			else
				alias.addOrder(Order.desc(propriedade));
		} else {
			if (sortOrder)
				criteriaMC.getCriteria().addOrder(Order.asc(propriedade));
			else
				criteriaMC.getCriteria().addOrder(Order.desc(propriedade));

		}
		return criteriaMC;
	}

	/**
	 * Adiciona um field a criteria dependendo do seu tipo Se for de um tipo
	 * complexo ele ir� criar um alias e seguir com a inser��o
	 * 
	 * @param criteria
	 * @param field
	 * @param o
	 * @param subCriteria
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws Exception
	 */
	private void addFieldOnCriteria(CriteriaMC criteriaMC, Field field, Object o, boolean subCriteria, boolean todosLike)
			throws IllegalArgumentException, IllegalAccessException, Exception {
		if (subCriteria) {
			o = field.get(o);
			if (!criteriaMC.getCriterias().containsKey(field.getName())) {
				criteriaMC.getCriterias().put(field.getName(), criteriaMC.getCriteria().createCriteria(field.getName(), field.getName()));
			}

			for (final Field f : o.getClass().getDeclaredFields())
				this.addFieldCriteria(f, criteriaMC, o, subCriteria, field.getName(), todosLike);
		} else
			this.addFieldCriteria(field, criteriaMC, o, subCriteria, field.getName(), todosLike);
	}

	/**
	 * Insercao de criteria baseado no tipo do field(campo) usando o ilike para
	 * Strig`s
	 * 
	 * @param field
	 * @param criteria
	 * @param o
	 * @throws Exception
	 */
	private void addFieldCriteria(Field field, CriteriaMC criteriaMC, Object o, boolean subCriteria, String alias, boolean todosLike)
			throws Exception {
		field.setAccessible(true);

		if (field.get(o) != null) {
			if (!field.isAnnotationPresent(Transient.class)) {
				if (!field.getName().contains("serialVersion"))
					/* if para eliminar os atributos transient */
					if (!Modifier.isTransient(field.getModifiers()))
						/* if para eliminar as constantes criadas na class */
						if (!(Modifier.isFinal(field.getModifiers()) && field.getAnnotations().length == 0))
							if (field.getType().getName().contains("java")) {
								if (field.getType().getName().contains("java.lang") || field.getType().getName().contains("java.util.Date")) {
									String campo = alias;
									if (field.getType().getName().contains("String") || todosLike) {
										if (subCriteria) {

											if (field.getType().getName().contains("Long") || field.getType().getName().contains("Integer")) {
												criteriaMC
														.getCriterias()
														.get(campo)
														.add(new TypelessLikeExpression(field.getName(), field.get(o).toString(),
																MatchMode.START));
											} else if (field.getType().getName().contains("Double")
													|| field.getType().getName().contains("Float")) {
												criteriaMC
														.getCriterias()
														.get(campo)
														.add(new TypelessLikeExpression(field.getName(), field.get(o).toString(),
																MatchMode.ANYWHERE));
											} else if (field.getType().getName().contains("Date")) {
												criteriaMC.getCriterias().get(campo).add(Restrictions.eq(field.getName(), field.get(o)));
											} else {
												criteriaMC
														.getCriterias()
														.get(campo)
														.add(new TypelessLikeExpression(field.getName(), field.get(o).toString(),
																MatchMode.ANYWHERE));
											}

										} else {
											if (field.getType().getName().contains("Long") || field.getType().getName().contains("Integer")) {

												criteriaMC.getCriteria().add(
														new TypelessLikeExpression(field.getName(), field.get(o).toString(),
																MatchMode.START));

											} else if (field.getType().getName().contains("Double")
													|| field.getType().getName().contains("Float")) {
												criteriaMC.getCriteria().add(
														new TypelessLikeExpression(field.getName(), field.get(o).toString(),
																MatchMode.ANYWHERE));
											} else if (field.getType().getName().contains("Date")) {
												criteriaMC.getCriteria().add(Restrictions.eq(field.getName(), field.get(o)));
											} else {
												criteriaMC.getCriteria().add(
														new TypelessLikeExpression(field.getName(), field.get(o).toString(),
																MatchMode.ANYWHERE));
											}

										}
									} else {
										if (subCriteria)
											criteriaMC.getCriterias().get(campo).add(Restrictions.eq(field.getName(), field.get(o)));
										else
											criteriaMC.getCriteria().add(Restrictions.eq(field.getName(), field.get(o)));
									}
								}
							} else {
								addFieldOnCriteria(criteriaMC, field, o, true, todosLike);
							}
			}
		}

	}

	/**
	 * Cria uma criteria baseado no objeto e nos tipos de seus fields(campos)
	 * 
	 * @param o
	 * @return
	 * @throws Exception
	 */
	private CriteriaMC criarCriteria(Object o, boolean todosLike) throws Exception {
		if (o != null) {
			Class clazz = o.getClass();

			Criteria criteria = getSession().createCriteria(clazz);
			CriteriaMC criteriaMC = new CriteriaMC();
			criteriaMC.setCriteria(criteria);

			for (final Field f : clazz.getDeclaredFields())
				this.addFieldOnCriteria(criteriaMC, f, o, false, todosLike);

			return criteriaMC;
		}
		return null;
	}

	@Override
	public Session getCurrentSession() {
		return getSession();
	}

	@Override
	public List listBy(Object o, boolean like) throws Exception {
		CriteriaMC c = criarCriteria(o, like);

		return c.getCriteria().list();
	}

	@Override
	public Integer max(Class clazz) {
		Criteria c =getSession().createCriteria(clazz);
		c.setProjection(Projections.max("id"));  
		return (Integer) c.uniqueResult();
	}

	@Override
	public void anexarDocumento(ModeloDocumento model) throws Exception {
		save(model);
		
	}

	
}
