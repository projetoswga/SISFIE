package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Horario;

public interface HorarioDAO {

	Long verificarConflitoHorario(Horario model);

	List<Horario> listarHorarios(Integer idCurso);

}
