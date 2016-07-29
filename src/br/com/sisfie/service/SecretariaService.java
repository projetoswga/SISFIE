package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCursoCertificado;

public interface SecretariaService {

	List<InscricaoCursoCertificado> recuperarInscricoesJaHomologadas(List<Integer> idsInscricoesAprovadas);

	List<InscricaoCursoCertificado> listarInscricaoCursoCertificados(Curso curso, Candidato candidato);
}
