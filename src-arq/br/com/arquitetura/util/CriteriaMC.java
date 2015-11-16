package br.com.arquitetura.util;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

import org.hibernate.Criteria;

public class CriteriaMC implements Serializable {

	private static final long serialVersionUID = -3563134489951040364L;

	private transient Criteria criteria;

	private Map<String, Criteria> criterias = new HashMap<String, Criteria>();

	public Criteria getCriteria() {
		return criteria;
	}

	public void setCriteria(Criteria criteria) {
		this.criteria = criteria;
	}

	public Map<String, Criteria> getCriterias() {
		return criterias;
	}

	public void setCriterias(Map<String, Criteria> criterias) {
		this.criterias = criterias;
	}

}
