package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Pacote;
import br.com.sisfie.entidade.PacoteOficina;

public interface PacoteService {

	void save(List<PacoteOficina> pacoteOficinas, List<PacoteOficina> listaPacoteOficinasExclusao, Pacote pacote) throws Exception;

	PacoteOficina recuperarPacoteOficina(Integer idOficina, Integer idCurso);

	List<PacoteOficina> recuperarPacoteOficina(Integer idCurso);

	void delete(List<PacoteOficina> listaPacoteOficinas, Pacote pacote) throws Exception;

	List<PacoteOficina> recuperarPacoteOficina(Pacote model);

	List<PacoteOficina> recuperarPacoteOficinaPorPacote(Integer idPacote);

	List<Pacote> recuperarPacotes(Integer idCurso) throws Exception;

	PacoteOficina recuperarPacoteOficina(Pacote pacote, Oficina oficina);
}
