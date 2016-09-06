package br.com.sisfie.DAO;

//Migrar método comuns para esta interface
public interface BaseDAO<T> {

	T recuperarPorId(Integer id);	
	
}
