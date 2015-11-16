package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.dto.CandidatoDTO;
import br.com.sisfie.dto.RelatorioPesquisaDTO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.CandidatoComplemento;
import br.com.sisfie.entidade.InscricaoCurso;

public interface CandidatoService {

	Long countCandidato(CandidatoDTO dto);

	List<Candidato> paginateCandidato(int first, int pageSize, CandidatoDTO dto);

	void save(Candidato candidato, String senhaGerada) throws Exception;

	List<InscricaoCurso> listarCandidatosInscritos(RelatorioPesquisaDTO dto) throws Exception;

	String recuperarCargoAtivo(Integer idCandidato) throws Exception;

	List<Candidato> recuperarInstrutores(InscricaoCurso inscricaoCurso);

	List<Candidato> pesquisarCandidato(String query);

	List<Candidato> pesquisarCandidato(String query, String string);

	void excluirCandidato(Candidato candidato) throws Exception;

	CandidatoComplemento recuperarCandidatoComplemento(Integer idCandidato);

}
