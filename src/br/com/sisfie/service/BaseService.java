package br.com.sisfie.service;

//Migrar métodos comuns para esta Interface
public interface BaseService<T> {

	T recuperarPorId(Integer id);
}
