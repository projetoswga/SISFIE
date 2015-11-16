package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.StatusInscricao;

public interface InscricaoCursoDAO {

	List<InscricaoCurso> recuperarInscricoes(Integer idCurso);

	Long countPesquisaInscricaoCandidato(InscricaoCurso model, Integer cancelada, Integer paga, Integer homologada);

	List<InscricaoCurso> paginatePesquisaInscricaoCandidato(int first, int pageSize, InscricaoCurso model, Integer cancelada, Integer paga,
			Integer homologada);

	List<InscricaoCurso> consultarInscricoesParaHomologacao(Curso curso, Integer quantidadeVagas, boolean dentroRegiao) throws Exception;

	Long consultarInscricoes(Curso curso, boolean dentroRegiao) throws Exception;

	Long countPesquisaInscricaoCandidato(InscricaoCurso model, Integer idStatus, List<Curso> listaCursos, boolean semSelecaoOficina);

	List<InscricaoCurso> paginatePesquisaInscricaoCandidato(int first, int pageSize, InscricaoCurso model, Integer idStatus,
			List<Curso> listaCursos, boolean semSelecaoOficina);

	Integer recuperarQuantidadeInscricoesPorOrgao(Integer idOpcaoRegiao, Integer idCurso, Integer quantidadeVagas);

	List<InscricaoCurso> recuperarInscricoesPorOrgao(Integer idOpcaoRegiao, Integer idCurso, Integer quantidadeVagas);

	StatusInscricao ultimoStatusInscricao(InscricaoCurso inscricaoCurso);

	List<InscricaoCurso> recuperarInscricoesAguardandoComprovante(Integer idCurso);

	List<InscricaoCurso> recuperarParceirosInscritos(List<String> listaEmailParceiros, List<Integer> listaIdsCursos);

	InscricaoGrade recuperarParceiroInscrito(EmailCursoPrivado emailCursoParceiro);

	List<InscricaoCurso> recuperarParceirosInscritos(Integer idCurso);

	Long recuperInscricoesSemUltimoStatus(Curso curso);

}
