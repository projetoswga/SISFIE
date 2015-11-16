package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.InscricaoGrade;

public interface GradeOficinaService {

	Long verificarRestricoes(GradeOficina model);

	void salvarGradeOficina(GradeOficina gradeOficina) throws Exception;

	void excluirGradeOficina(GradeOficina gradeOficina) throws Exception;

	List<GradeOficina> listarGradeOficinas(Integer idCurso) throws Exception;
	
	List<Object> gerarArquivoEventoFrequencia(Integer idCurso);

	List<Object> gerarArquivoTurmasFrequencia(Integer idCurso);

	List<Object> gerarArquivoParticipantesFrequencia(Integer idCurso);

	List<InscricaoGrade> listarInscricaoGrades(Integer idCurso, List<Integer> idsCandidatosConfirmados);

	Integer recuperarCapacidadeMaximaInscritos(Integer idCurso);

}
