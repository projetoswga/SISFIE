package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Horario;

public interface HorarioService {

	Long verificarConflitoHorario(Horario model);

	List<Horario> listarHorarios(Integer idCurso);

	void salvarHorario(Horario horario) throws Exception;

	void excluirHorario(Horario horario) throws Exception;

}
