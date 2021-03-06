package br.com.sisfie.DAO;

import java.util.Calendar;
import java.util.List;

import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.InscricaoCurso;

public interface FrequenciaDAO extends BaseDAO<Frequencia> {

	Frequencia recuperarUltimaFrequencia(String inscricao);

	List<Frequencia> listarFrequencias(Integer idGradeOficina) throws Exception ;

	List<Frequencia> pesquisarFrequenciasAbertas(Integer idGradeOficina);

	List<Frequencia> listarFrequenciasSemOficina(List<InscricaoCurso> listaInscricaoCurso);

	List<Frequencia> pesquisarFrequenciasAbertasSemOficina(Integer idInscricaoCurso);

	List<Frequencia> pesquisarFrequenciasData(String inscricao, Calendar datFrequencia);

	List<Frequencia> carregarFrequencias(Integer idCurso);

}
