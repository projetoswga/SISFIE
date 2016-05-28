package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.InscricaoCursoCertificado;

public interface SecretariaDAO {

	List<InscricaoCursoCertificado> recuperarInscricoesJaHomologadas(List<Integer> idsInscricoesAprovadas);

}
