package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Sala;

public interface SalaService {

	List<Sala> recuperarSalas(List<Integer> listaIdCursos);

	void salvarSala(Sala sala) throws Exception;

	void excluirSala(Sala sala) throws Exception;

}
