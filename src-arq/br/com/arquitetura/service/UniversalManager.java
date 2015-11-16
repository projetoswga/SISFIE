package br.com.arquitetura.service;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

public interface UniversalManager extends Serializable {

	Object get(Class clazz, Serializable id);

	List getAll(Class clazz);

	Long getCount(Class clazz, Map filters) throws Exception;

	Long getCount(Object o);

	@SuppressWarnings("rawtypes")
	public List listBy(Object o, boolean like) throws Exception;

	Object save(Object o) throws Exception;

	List listBy(Object o) throws Exception;

	void remove(Class clazz, Serializable id) throws Exception;

	List paginate(int first, int pageSize, String sortField, boolean sortOrder, Map<String, String> filters, Class clazz) throws Exception;

	Long getCount(int first, int pageSize, String sortField, boolean sortOrder, Map<String, String> filters, Class clazz) throws Exception;
}