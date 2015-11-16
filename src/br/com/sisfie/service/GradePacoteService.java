package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.GradePacote;

public interface GradePacoteService {

	List<GradePacote> listarGradePacotes(Integer idPacote);

	Long countGradePacote(GradePacote model);

	void removerOficinaGradePacote(GradePacote model) throws Exception;

	void alterarOficinaGradePacote(GradePacote model) throws Exception;

	Long countGradePacote(Integer idPacote);

	List<GradePacote> listarGradePacotes(int first, int pageSize, Integer idPacote);

}
