package br.com.arquitetura.util;

import java.util.Arrays;

import org.hibernate.Criteria;
import org.hibernate.EntityMode;
import org.hibernate.HibernateException;
import org.hibernate.criterion.CriteriaQuery;
import org.hibernate.criterion.Criterion;
import org.hibernate.criterion.MatchMode;
import org.hibernate.dialect.Dialect;
import org.hibernate.dialect.function.CastFunction;
import org.hibernate.engine.TypedValue;

public class TypelessLikeExpression implements Criterion {

	private static final long serialVersionUID = 1L;

	private String propertyName;
	private String value;
	private MatchMode matchMode;

	public TypelessLikeExpression(String propertyName, String value, MatchMode matchMode) {
		this.propertyName = propertyName;
		this.value = value;
		this.matchMode = matchMode;
	}

	public String toSqlString(Criteria criteria, CriteriaQuery criteriaQuery) throws HibernateException {
		Dialect dialect = criteriaQuery.getFactory().getDialect();
		String[] columns = criteriaQuery.getColumnsUsingProjection(criteria, propertyName);
		if (columns.length != 1) {
			throw new HibernateException("Like may only be used with single-column properties");
		}
		CastFunction cast = (CastFunction) dialect.getFunctions().get("cast");
		String lhs = dialect.getLowercaseFunction() + '('
				+ cast.render(Arrays.asList(columns[0], "java.lang.String"), criteriaQuery.getFactory()) + ')';
		return lhs + " like ?";

	}

	public TypedValue[] getTypedValues(Criteria criteria, CriteriaQuery criteriaQuery) throws HibernateException {
		return new TypedValue[] { new TypedValue(new org.hibernate.type.StringType(), matchMode.toMatchString(value.toLowerCase()),
				EntityMode.POJO) };
	}

}