package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Orgao;

public interface OrgaoService {

	List<Orgao> pesquisarOrgao(String query) throws Exception;

	Orgao pesquisarOrgaoExata(String query) throws Exception;

	List<Orgao> pesquisarOrgaoSigla(String sigla) throws Exception;

}
