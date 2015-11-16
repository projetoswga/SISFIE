package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Oficina;

public interface OficinaService {

	List<Oficina> recuperarOficinasDisponiveis(Integer idCurso);

	List<Oficina> recuperarOficina(Integer idCurso, Integer idPacote);

	List<Oficina> pesquisarOficina(String query, Integer idCurso) throws Exception;

	Oficina pesquisarOficinaExata(String query) throws Exception;

	void salvarOficina(Oficina oficina) throws Exception;

	void excluirOficina(Oficina oficina) throws Exception;

}
