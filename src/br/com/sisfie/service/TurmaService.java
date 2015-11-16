package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Turma;

public interface TurmaService {

	void salvarTurma(Turma turma) throws Exception;

	List<Turma> listarTurmas(Integer idCurso);

	void excluirTurma(Turma turma) throws Exception;

}
