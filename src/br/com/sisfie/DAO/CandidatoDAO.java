package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.dto.CandidatoDTO;
import br.com.sisfie.dto.RelatorioPesquisaDTO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.CandidatoComplemento;
import br.com.sisfie.entidade.InscricaoCurso;

public interface CandidatoDAO {

	Long countCandidato(CandidatoDTO dto);

	List<Candidato> paginateCandidato(int first, int pageSize, CandidatoDTO dto);

	List<InscricaoCurso> listarCandidatosInscritos(RelatorioPesquisaDTO dto) throws Exception;

	String recuperarCargoAtivo(Integer idCandidato);

	List<Candidato> recuperarInstrutores(InscricaoCurso inscricaoCurso);

	List<Candidato> pesquisarCandidato(String query);

	List<Candidato> pesquisarCandidato(String query, String idCandidatos);

	Candidato recuperarCandidato(Integer idCandidato);

	CandidatoComplemento recuperarCandidatoComplemento(Integer idCandidato);

}
