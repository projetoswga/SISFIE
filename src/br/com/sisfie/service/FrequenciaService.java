package br.com.sisfie.service;

import java.util.Calendar;
import java.util.List;

import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.InscricaoCurso;

public interface FrequenciaService {
	
	void salvarListaFrequencia(List<Frequencia> listaFrequencias) throws Exception;

	Frequencia recuperarUltimaFrequencia(String inscricao);

	List<Frequencia> listarFrequencias(Integer idGradeOficina) throws Exception ;

	void salvar(Frequencia frequencia) throws Exception;

	List<Frequencia> pesquisarFrequenciasAbertas(Integer idGradeOficina);

	List<Frequencia> listarFrequenciasSemOficina(InscricaoCurso inscricaoCurso);

	List<Frequencia> pesquisarFrequenciasAbertasSemOficina(Integer idInscricaoCurso);

	List<Frequencia> pesquisarFrequenciasData(String inscricao, Calendar datFrequencia);

	List<Frequencia> carregarFrequencias(Integer idCurso);

}
