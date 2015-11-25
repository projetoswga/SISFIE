package br.com.sisfie.service;

import java.util.List;
import java.util.Map;

import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.StatusInscricao;

public interface InscricaoCursoService {

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

	void isentarInscricao(InscricaoCurso inscricaoCurso) throws Exception;

	void inscreverCandidatoForaPrazo(InscricaoCurso inscricaoCurso, StatusInscricao statusInscricao) throws Exception;

	void confirmarCandidato(InscricaoCurso inscricaoCurso, StatusInscricao statusInscricao) throws Exception;

	List<InscricaoCurso> recuperarInscricoesAguardandoComprovante(Integer idCurso);

	void cancelarCandidato(Map<InscricaoCurso, StatusInscricao> mapaInscricaoStatus) throws Exception;

	List<InscricaoCurso> recuperarParceirosInscritos(List<String> listaEmailParceiros, List<Integer> listaIdsCursos);

	InscricaoGrade recuperarParceiroInscrito(EmailCursoPrivado emailCursoParceiro);

	List<InscricaoCurso> recuperarParceirosInscritos(Integer idCurso);

	void atualizarUltimoStatusInscricao(List<InscricaoCurso> listaInscricaoCurso) throws Exception;

	Long recuperInscricoesSemUltimoStatus(Curso curso);

	InscricaoCurso recuperarInscricaoComColecoes(Integer idInscricao);

	InscricaoCurso recupararInscricao(String numInscricao, Integer idCurso, Integer idTurma, Integer idHorario);

	InscricaoGrade recupararInscricaoGrade(String numInscricao, Integer idCurso, Integer idTurma, Integer idHorario);

	InscricaoCurso recuperarInscricao(Integer idCurso, Integer idTurma, Integer idTurno);

	InscricaoCurso recupararInscricaoSemOficina(String inscricao, Integer idCurso, Integer idTurma, Integer idTurno);

}