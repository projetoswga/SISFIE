package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Frequencia;

public interface FrequenciaService {
	
	void salvarListaFrequencia(List<Frequencia> listaFrequencias) throws Exception;

	Frequencia recuperarUltimaFrequencia(String inscricao);

	List<Frequencia> listarFrequencias(Integer idGradeOficina) throws Exception ;

	void salvar(Frequencia frequencia) throws Exception;

	List<Frequencia> pesquisarFrequenciasAbertas(Integer idGradeOficina);

}
