package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.AreaConhecimento;

public interface AreaConhecimentoDAO {

	List<AreaConhecimento> pesquisarAreaConhecimento(String query) throws Exception;

	AreaConhecimento pesquisarAreaConhecimentoExata(String query) throws Exception;
}
