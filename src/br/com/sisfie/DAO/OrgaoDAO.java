package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Orgao;

public interface OrgaoDAO {

	List<Orgao> pesquisarOrgao(String query) throws Exception;
	
	Orgao pesquisarOrgaoExata(String query) throws Exception;
	
	List<Orgao> pesquisarOrgaoSigla(String sigla) throws Exception;


}
