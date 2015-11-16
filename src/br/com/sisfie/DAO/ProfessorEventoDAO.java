package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.ProfessorEvento;

public interface ProfessorEventoDAO {

	List<ProfessorEvento> listarProfessores(Integer idCurso);

	ProfessorEvento recuperarProfessorEvento(Integer idCandidato, Integer idCurso);

	List<Candidato> listarTodosProfessores();

}
