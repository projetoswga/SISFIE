package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Frequencia;

public interface FrequenciaDAO {

	Frequencia recuperarUltimaFrequencia(String inscricao);

	List<Frequencia> listarFrequencias(Integer idGradeOficina) throws Exception ;

}
