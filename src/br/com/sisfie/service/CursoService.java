package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.dto.CursoDTO;
import br.com.sisfie.dto.ParceirosDTO;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoInfoComplementar;
import br.com.sisfie.entidade.Municipio;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusCurso;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.entidade.Uf;
import br.com.sisfie.entidade.UfCurso;
import br.com.sisfie.entidade.Usuario;

public interface CursoService {

	List<Uf> completeUF(Uf a);

	List<Uf> completeMunicipio(Municipio municipio, List<UfCurso> ufCursos);

	Long countCurso(CursoDTO dto);

	List<Curso> paginateCurso(int first, int pageSize, CursoDTO dto);

	void save(Curso model, boolean enviarEmailParceiros) throws Exception;

	List<InscricaoCurso> carregarListaCandidato(Curso curso, Integer idStatus);

	List<InscricaoCurso> carregarListaEspera(Curso curso);

	void homologarCurso(InscricaoCurso inscricaoCurso) throws Exception;

	void invalidarComprovante(InscricaoCurso inscricaoCurso, String textoInvalidarComprovante) throws Exception;

	void cancelarInscricao(InscricaoCurso inscricaoCurso, String textoInvalidarComprovante, StatusInscricao statusInscricao) throws Exception;

	StatusCurso ultimoStatusCurso(Curso curso);

	void deleteCurso(Curso cursoSelect) throws Exception;

	void enviarEmails(InscricaoCurso[] inscricoes, String assunto, String corpoEmail, String emailResponsavel)
			throws Exception;

	boolean existeInscricoes(Curso curso) throws Exception;

	List<Municipio> pesquisarMunicipio(String nome);

	List<Status> carregarStatus(List<Integer> idsStatus);

	List<InscricaoCurso> carregarListaCandidatoParticipante(Curso curso);

	List<InscricaoCurso> carregarListaCandidatoConfirmados(Curso curso);

	void elegerCandidato(InscricaoCurso inscricaoCurso, Status status) throws Exception;

	Integer retornarQuantidadeInscritos(Curso curso);

	InscricaoCurso recuperarInscricaoPeloHash(String hashCandidato) throws Exception;

	List<Curso> recuperarCursosComOficina(Usuario user);

	List<Curso> recuperarCursosComOficinaNaoDistribuidos(Usuario user);

	List<Curso> recuperarCursosAtivos(Usuario user);

	void desfazerHomologacao(InscricaoCurso inscricaoCurso, StatusInscricao statusInscricao) throws Exception;

	List<Curso> recuperarCursosSemOficina(Curso a) throws Exception;
	
	List<Curso> recuperarCursos(Curso a) throws Exception;

	List<Curso> recuperarCursosComOficina(Curso curso) throws Exception;

	void salvarInscricaoCursoTurma(InscricaoCurso[] inscricoesCursoConfirmados, Integer idTurma) throws Exception;

	List<InscricaoCurso> carregarListaCandidatoCancelados(Curso cursoPesqCandidatoCancelado) throws Exception;

	void autorizarPagamento(InscricaoCurso inscricaoCurso) throws Exception;

	List<Curso> recuperarCursosAtivos();

	void salvarAnexos(InscricaoCurso inscricaoCurso) throws Exception;
	
	boolean verificarDistribuicaoCurso(Curso curso);
	
	void enviarEmails(EmailCursoPrivado[] emailCursoPrivado, String assunto, String corpoEmail,
			String emailResponsavel, boolean cursoPrivado) throws Exception;

	void salvarInscricaoInfoComplementar(InscricaoInfoComplementar inscricaoInfoComplementar) throws Exception;

	void desfazerCancelamento(InscricaoCurso model, StatusInscricao statusInscricao) throws Exception;

	List<Oficina> recuperarOficinas(Curso curso);

	Integer retornarQuantidadeInscritos(Curso curso, Oficina oficina, List<Integer> idsInscritos, List<Integer> idsInscritosCancelados);

	void clonarApoio(Curso curso, Curso cursoClone) throws Exception;

	void aceitarInscricao(InscricaoCurso inscricaoCurso) throws Exception;

	StatusInscricao getUltimoStatusInscricao(InscricaoCurso inscricaoCurso) throws Exception;

	List<EmailCursoPrivado> recuperarParceiros(ParceirosDTO dto);

	List<EmailCursoPrivado> recuperarParceirosNaoInscritos(Integer idCurso, List<String> listaEmailParceirosInscritos);

	List<Curso> recuperarCursosComInscricoes(Curso curso) throws Exception;
}
