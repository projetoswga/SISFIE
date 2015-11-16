package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Oficina;

public interface OficinaDAO {

	List<Oficina> recuperarOficinasDisponiveis(Integer idCurso);

	List<Oficina> recuperarOficina(Integer idCurso, Integer idPacote);

	List<Oficina> pesquisarOficina(String query, Integer idCurso) throws Exception;

	Oficina pesquisarOficinaExata(String query) throws Exception;

}
