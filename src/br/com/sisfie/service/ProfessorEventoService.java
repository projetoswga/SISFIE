package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.ProfessorEvento;

public interface ProfessorEventoService {

	List<ProfessorEvento> listarProfessores(Integer idCurso);

	void excluirProfessor(ProfessorEvento professor) throws Exception;

	void salvarProfessor(ProfessorEvento professor) throws Exception;

	ProfessorEvento recuperarProfessorEvento(Integer idCandidato, Integer idCurso);

	List<Candidato> listarTodosProfessores();

}
