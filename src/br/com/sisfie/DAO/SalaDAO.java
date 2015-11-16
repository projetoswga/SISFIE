package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Sala;

public interface SalaDAO {

	List<Sala> recuperarSalas(List<Integer> listaIdCursos);

}
