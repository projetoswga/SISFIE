package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.DistribuicaoSofGrade;

public interface DistribuirService {

	void distrbuirInscritos(Curso curso) throws Exception;

	List<DistribuicaoSofGrade> recuperarDistribuicao(Curso curso);

	List<Object> gerarArquivoEventoFrequencia(Integer idCurso);

	List<Object> gerarArquivoTurmasFrequencia(Integer idCurso);

	List<Object> gerarArquivoParticipantesFrequencia(Integer idCurso);

}
