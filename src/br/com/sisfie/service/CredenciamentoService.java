package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Credenciamento;

public interface CredenciamentoService {

	List<Credenciamento> listarCredenciamento(Integer idCurso, Integer idTurma);

}
