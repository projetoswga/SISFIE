package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.dto.CursoDTO;
import br.com.sisfie.dto.ParceirosDTO;
import br.com.sisfie.entidade.CandidatoPreenchimento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.EsferaCurso;
import br.com.sisfie.entidade.HomologacaoCurso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Municipio;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusCurso;
import br.com.sisfie.entidade.Uf;
import br.com.sisfie.entidade.UfCurso;
import br.com.sisfie.entidade.Usuario;

public interface CursoDAO {

	List<Uf> completeUF(Uf a);

	List<Uf> completeMunicipio(Municipio municipio, List<UfCurso> ufCursos);

	Long countCurso(CursoDTO dto);

	List<Curso> paginateCurso(int first, int pageSize, CursoDTO dto);

	Long existehomologacaoCurso(HomologacaoCurso hc);

	Long existeEsferaCurso(EsferaCurso ec);

	Long existeCandidatoPreenchimento(CandidatoPreenchimento cp);

	List<InscricaoCurso> carregarListaCandidato(Curso curso, Integer idStatus);

	List<InscricaoCurso> carregarListaEspera(Curso curso);

	StatusCurso ultimoStatusCurso(Curso curso);

//	StatusInscricao ultimoStatusInscricao(InscricaoCurso inscricaoCurso);

	boolean existeInscricoes(Curso curso) throws Exception;

	List<Municipio> pesquisarMunicipio(String nome);

	List<Status> carregarStatus(List<Integer> idsStatus);

	List<InscricaoCurso> carregarListaCandidatoParticipante(Curso curso);

	Integer ultimaInscricao();

	Integer retornarQuantidadeInscritos(Curso curso);

	InscricaoCurso recuperarInscricaoPeloHash(String hashCandidato) throws Exception;

	List<Curso> recuperarCursosComOficina(Usuario user);

	List<Curso> recuperarCursosComOficinaNaoDistribuidos(Usuario user);

	List<Curso> recuperarCursosAtivos(Usuario user);

	List<Curso> recuperarCursosSemOficina(Curso a) throws Exception;

	List<Curso> recuperarCursos(Curso a) throws Exception;

	List<InscricaoCurso> carregarListaCandidatoConfirmados(Curso curso);

	List<Curso> recuperarCursosComOficina(Curso curso) throws Exception;

	List<InscricaoCurso> carregarListaCandidatoCancelados(Curso cursoPesqCandidatoCancelado) throws Exception;

	List<Curso> recuperarCursosAtivos();

	boolean verificarDistribuicaoCurso(Curso curso);

	List<Oficina> recuperarOficinas(Curso curso);

	Integer retornarQuantidadeInscritos(Curso curso, Oficina oficina, List<Integer> idsInscritos, List<Integer> idsInscritosCancelados);

	List<EmailCursoPrivado> recuperarParceiros(ParceirosDTO dto);

	List<EmailCursoPrivado> recuperarParceirosNaoInscritos(Integer idCurso, List<String> listaEmailParceirosInscritos);

	List<Curso> recuperarCursosComInscricoes(Curso curso) throws Exception;

	List<InscricaoCurso> carregarListaInstrutores(Curso curso);
}
