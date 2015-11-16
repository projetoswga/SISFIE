package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.GradePacote;

public interface GradePacoteDAO {

	List<GradePacote> listarGradePacotes(Integer idPacote);

	Long countGradePacote(GradePacote model);

	Long countGradePacote(Integer idPacote);

	List<GradePacote> listarGradePacotes(int first, int pageSize, Integer idPacote);

}
