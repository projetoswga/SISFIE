package br.com.arquitetura.service.impl;

import java.io.Serializable;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.arquitetura.service.UniversalManager;
import br.com.sisfie.entidade.ModeloDocumento;

/*MANDATORY
 Support a current transaction, throw an exception if none exists.
 NESTED
 Execute within a nested transaction if a current transaction exists, behave like PROPAGATION_REQUIRED else.
 NEVER
 Execute non-transactionally, throw an exception if a transaction exists.
 NOT_SUPPORTED
 Execute non-transactionally, suspend the current transaction if one exists.
 REQUIRED
 Support a current transaction, create a new one if none exists.
 REQUIRES_NEW
 Create a new transaction, suspend the current transaction if one exists.
 SUPPORTS
 Support a current transaction, execute non-transactionally if none exists.*/

/**
 * Readonly : true - FlushMode -MANUAL 
 * A sess�o s� � liberado quando j� Session.flush () � explicitamente chamado pelo aplicativo.<br>
 *  Este modo � muito eficiente para transa��es de leitura apenas.
 */
/**
 * Readonly : False - FlushMode -AUTO
 * A sess�o � �s vezes lavada antes da execu��o da consulta, a fim de garantir <br>
 *  que nunca consultas retornam estado obsoleto. Este � o modo padr�o flush.
 */

/**
 * rollbackFor : defini que tipo de exec��o ira dar um rollback
 */
/**
 * noRollbackFor : defini que tipo de exec��o N�O ira dar um rollback
 */

@Service(value = "universalManager")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class UniversalManagerImpl implements UniversalManager {
	private static final long serialVersionUID = 1L;
	
	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("rawtypes")
	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void remove(Class clazz, Serializable id) throws Exception {
		dao.remove(clazz, id);
	}
	
	
	
	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public Object save(Object o) throws Exception {
		return dao.save(o);
	}
	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public Object update(Object o) throws Exception {
		return dao.merge(o);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Object get(Class clazz, Serializable id) {
		return dao.get(clazz, id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List getAll(Class clazz) {
		return dao.getAll(clazz);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List listBy(Object o) throws Exception {
		return dao.listBy(o);
	}

	/**
	 * Paginacao
	 * 
	 * @param first
	 * @param pageSize
	 * @param sortField
	 * @param sortOrder
	 * @param filters
	 * @param o
	 * @return
	 */
	@SuppressWarnings("rawtypes")
	@Override
	public List paginate(int first, int pageSize, String sortField, boolean sortOrder, Map<String, String> filters,
			Class clazz) throws Exception {
		return dao.paginate(first, pageSize, sortField, sortOrder, filters, clazz);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Long getCount(int first, int pageSize, String sortField, boolean sortOrder, Map<String, String> filters,
			Class clazz) throws Exception {
		return dao.getCount(first, pageSize, sortField, sortOrder, filters, clazz);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Long getCount(Class clazz, Map filters) throws Exception {

		return dao.getCount(clazz, filters);
	}

	@Override
	public Long getCount(Object o) {
		return dao.getCount(o);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List listBy(Object o, boolean like) throws Exception {
		return dao.listBy(o, like);
	}



	@Override
	public void anexarDocumento(ModeloDocumento model) throws Exception {
		dao.anexarDocumento(model);
		
	}
}
