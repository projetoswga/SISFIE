package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Credenciamento;

public interface CredenciamentoDAO {

	List<Credenciamento> listarCredenciamento(Integer idCurso, Integer idTurma);

	Credenciamento recuperarCredenciamento(String inscricao);

}
