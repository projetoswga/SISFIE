package br.com.arquitetura.DAO;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.hibernate.Session;

import br.com.arquitetura.util.CriteriaMC;
import br.com.sisfie.entidade.CodigoLivroAnual;
import br.com.sisfie.entidade.ModeloDocumento;

public interface UniversalDAO extends Serializable {

	@SuppressWarnings("rawtypes")
	Object get(Class clazz, Serializable id);

	@SuppressWarnings("rawtypes")
	List getAll(Class clazz);
	
	@SuppressWarnings("rawtypes")
	Integer max(Class clazz);

	@SuppressWarnings("rawtypes")
	Long getCount(Class clazz, Map filters) throws Exception;

	Long getCount(Object o);

	@SuppressWarnings("rawtypes")
	public List listBy(Object o, boolean like) throws Exception;

	Object save(Object o) throws Exception;

	Object merge(Object o) throws Exception;

	@SuppressWarnings("rawtypes")
	List listBy(Object o) throws Exception;

	Session getCurrentSession();

	CriteriaMC addOrderBy(CriteriaMC criteriaMC, String propriedade, boolean sortOrder);

	@SuppressWarnings("rawtypes")
	void remove(Class clazz, Serializable id) throws Exception;

	@SuppressWarnings("rawtypes")
	List paginate(int first, int pageSize, String sortField, boolean sortOrder, Map<String, String> filters, Class clazz) throws Exception;

	@SuppressWarnings("rawtypes")
	Long getCount(int first, int pageSize, String sortField, boolean sortOrder, Map<String, String> filters, Class clazz) throws Exception;

	void anexarDocumento(ModeloDocumento model) throws Exception;

}