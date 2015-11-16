package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.DistribuicaoSofGrade;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.SelecaoOficina;
import br.com.sisfie.entidade.SelecaoPacote;

public interface DistribuirDAO {

	List<SelecaoOficina> carregarOficinas(InscricaoCurso inscricaoCurso) throws Exception;

	List<GradeOficina> carregarGradeOficinas(Oficina oficina) throws Exception;

	Long quantidadeInscritosSala(GradeOficina gradeOficinas) throws Exception;

	List<InscricaoCurso> carregarInscritosOficinas(Curso curso) throws Exception;

	List<SelecaoPacote> carregarPacotes(InscricaoCurso inscricaoCurso);

	List<DistribuicaoSofGrade> recuperarDistribuicao(Curso curso);
	
	List<Integer> devolveGradesPorCursoOficinaDescTurma(Integer idCurso, Integer idOficina, String descTurma);

	List<Object> gerarArquivoEventoFrequencia(Integer idCurso);

	List<Object> gerarArquivoTurmasFrequencia(Integer idCurso);

	List<Object> gerarArquivoParticipantesFrequencia(Integer idCurso);


}
