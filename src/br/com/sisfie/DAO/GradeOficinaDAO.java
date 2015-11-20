package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.InscricaoGrade;

public interface GradeOficinaDAO {

	Long verificarRestricoes(GradeOficina model);

	List<GradeOficina> listarGradeOficinas(Integer idCurso) throws Exception;
	
	List<Object> gerarArquivoEventoFrequencia(Integer idCurso);

	List<Object> gerarArquivoTurmasFrequencia(Integer idCurso);

	List<Object> gerarArquivoParticipantesFrequencia(Integer idCurso);

	List<InscricaoGrade> listarInscricaoGrades(Integer idCurso, List<Integer> idsCandidatosConfirmados);

	Integer recuperarCapacidadeMaximaInscritos(Integer idCurso);

	GradeOficina recupararGradeOficina(Integer idCurso, Integer idTurma, Integer idHorario);

}
