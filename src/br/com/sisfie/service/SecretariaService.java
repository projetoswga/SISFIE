package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.InscricaoCursoCertificado;

public interface SecretariaService {

	List<InscricaoCursoCertificado> recuperarInscricoesJaHomologadas(List<Integer> idsInscricoesAprovadas);


}
