package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.AreaConhecimento;
import br.com.sisfie.entidade.AreaConhecimentoCurso;

public interface AreaConhecimentoService {

	List<AreaConhecimento> pesquisarAreaConhecimento(String query) throws Exception;

	br.com.sisfie.entidade.AreaConhecimento pesquisarAreaConhecimentoExata(String query) throws Exception;

	void excluirAreaConhecimentoCurso(AreaConhecimentoCurso areaConhecimentoCursoExclusao) throws Exception;
}
