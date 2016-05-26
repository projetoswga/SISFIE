package br.com.sisfie.DAO.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.List;
import java.util.Set;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.MatchMode;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.arquitetura.util.DateUtil;
import br.com.sisfie.DAO.CursoDAO;
import br.com.sisfie.dto.CursoDTO;
import br.com.sisfie.dto.ParceirosDTO;
import br.com.sisfie.entidade.CandidatoPreenchimento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.DistribuicaoSofGrade;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.EsferaCurso;
import br.com.sisfie.entidade.HomologacaoCurso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.Municipio;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.Situacao;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusCurso;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.entidade.Uf;
import br.com.sisfie.entidade.UfCurso;
import br.com.sisfie.entidade.Usuario;

@Repository(value = "CursoDAO")
public class CursoDAOImpl extends HibernateDaoSupport implements CursoDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<Uf> completeUF(Uf uf) {
		Criteria c = getSession().createCriteria(Uf.class);

		c.add(Restrictions.or(Restrictions.ilike("descricao", uf.getDescricao(), MatchMode.START),
				Restrictions.ilike("sigla", uf.getSigla(), MatchMode.START)));
		return c.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Uf> completeMunicipio(Municipio municipio, List<UfCurso> ufCursos) {
		List<Integer> ids = new ArrayList<Integer>();

		for (UfCurso ufCurso : ufCursos) {
			ids.add(ufCurso.getUf().getId());
		}

		Criteria c = getSession().createCriteria(Municipio.class);

		c.add(Restrictions.ilike("descricao", municipio.getDescricao(), MatchMode.ANYWHERE));
		c.createAlias("uf", "uf");

		c.add(Restrictions.in("uf.id", ids));

		return c.list();
	}

	@Override
	public Long countCurso(CursoDTO dto) {
		Criteria c = retornarCriteria(dto);
		c.setProjection(Projections.rowCount());

		Long result = (Long) c.list().get(0);
		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Curso> paginateCurso(int first, int pageSize, CursoDTO dto) {
		Criteria c = retornarCriteria(dto);

		if (first != 0)
			c.setFirstResult(first);
		if (pageSize != 0)
			c.setMaxResults(pageSize);

		return c.list();
	}

	public Criteria retornarCriteria(CursoDTO dto) {
		if (dto == null) {
			return null;
		}

		Criteria criteria = getSession().createCriteria(Curso.class);

		if (dto.getCodigo() != null && !dto.getCodigo().isEmpty()) {
			criteria.add(Restrictions.ilike("codigo", dto.getCodigo(), MatchMode.ANYWHERE));
		}

		if (dto.getTitulo() != null && !dto.getTitulo().isEmpty()) {
			criteria.add(Restrictions.ilike("titulo", dto.getTitulo(), MatchMode.ANYWHERE));
		}
		if (dto.getIdSetor() != null && !dto.getIdSetor().equals(0)) {
			criteria.createAlias("usuario", "usuario").add(Restrictions.eq("usuario.setorResponsavelEsaf.id", dto.getIdSetor()));

		}
		if (dto.getIdArea() != null && !dto.getIdArea().equals(0)) {
			criteria.add(Restrictions.eq("area.id", dto.getIdArea()));
		}
		if (dto.getIdLocal() != null && !dto.getIdLocal().equals(0)) {
			criteria.add(Restrictions.eq("localizacao.id", dto.getIdLocal()));
		}

		if (dto.getDtRealizacaoInicio() != null && dto.getDtRealizacaoFim() == null) {
			criteria.add(Restrictions.ge("dtRealizacaoInicio", dto.getDtRealizacaoInicio()));

		} else if (dto.getDtRealizacaoInicio() == null && dto.getDtRealizacaoFim() != null) {
			criteria.add(Restrictions.le("dtRealizacaoFim", dto.getDtRealizacaoFim()));
		} else if (dto.getDtRealizacaoInicio() != null && dto.getDtRealizacaoFim() != null) {
			criteria.add(Restrictions.and(Restrictions.ge("dtRealizacaoInicio", dto.getDtRealizacaoInicio()),
					Restrictions.le("dtRealizacaoFim", dto.getDtRealizacaoFim())));

		}
		return criteria;
	}

	@Override
	public Long existehomologacaoCurso(HomologacaoCurso hc) {
		Criteria c = getSession().createCriteria(HomologacaoCurso.class);

		c.createAlias("homologacao", "h");
		c.createAlias("curso", "c");

		c.add(Restrictions.eq("h.id", hc.getHomologacao().getId()));
		c.add(Restrictions.eq("c.id", hc.getCurso().getId()));

		c.setProjection(Projections.rowCount());

		Long result = (Long) c.list().get(0);
		return result;
	}

	@Override
	public Long existeEsferaCurso(EsferaCurso ec) {
		Criteria c = getSession().createCriteria(EsferaCurso.class);

		c.createAlias("esferaGoverno", "e");
		c.createAlias("curso", "c");

		c.add(Restrictions.eq("e.id", ec.getEsferaGoverno().getId()));
		c.add(Restrictions.eq("c.id", ec.getCurso().getId()));

		c.setProjection(Projections.rowCount());

		Long result = (Long) c.list().get(0);
		return result;
	}

	@Override
	public Long existeCandidatoPreenchimento(CandidatoPreenchimento cp) {
		Criteria c = getSession().createCriteria(CandidatoPreenchimento.class);

		c.createAlias("campoPreenchimento", "cp");
		c.createAlias("curso", "c");

		c.add(Restrictions.eq("cp.id", cp.getCampoPreenchimento().getId()));
		c.add(Restrictions.eq("c.id", cp.getCurso().getId()));

		c.setProjection(Projections.rowCount());

		Long result = (Long) c.list().get(0);
		return result;
	}

	@SuppressWarnings("unchecked")
	public List<InscricaoCurso> carregarListaCandidato(Curso curso, Integer idStatus) {
		Criteria c = getSession().createCriteria(InscricaoCurso.class);
		c.add(Restrictions.eq("flgInstrutor", false));
		c.createAlias("curso", "c");
		c.add(Restrictions.eq("c.id", curso.getId()));
		c.createAlias("statusInscricoes", "st");
		c.createAlias("st.status", "status");
		c.add(Restrictions.eq("status.id", idStatus));
		c.setProjection(Projections.distinct(Projections.property("id")));
		List<Integer> ids = c.list();

		if (ids != null && !ids.isEmpty()) {
			Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
			c2.add(Restrictions.in("id", ids));

			List<InscricaoCurso> lista = c2.list();
			List<InscricaoCurso> listaRetorno = new ArrayList<InscricaoCurso>();

			if (lista != null && !lista.isEmpty()) {
				for (InscricaoCurso obj : lista) {
					if (obj.getUltimoStatus() != null && obj.getUltimoStatus().getStatus().getId().equals(idStatus)) {
						listaRetorno.add(obj);
					}
				}
				return listaRetorno;
			}
		}

		return new ArrayList<InscricaoCurso>();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> carregarListaCandidatoParticipante(Curso curso) {
		// Status

		List<Integer> idsStatus = new ArrayList<Integer>();
		idsStatus.add(Status.PRE_INSCRITO);
		idsStatus.add(Status.AGUARDANDO_COMPROVANTE);
		idsStatus.add(Status.CONFIRMADO_PELO_CHEFE);
		idsStatus.add(Status.INVALIDAR_COMPROVANTE);
		idsStatus.add(Status.HOMOLOGADO);
		idsStatus.add(Status.AGUARDANDO_VALIDACAO_COMPROVANTE);
		idsStatus.add(Status.AGUARDANDO_HOMOLOGACAO);
		idsStatus.add(Status.AGUARDANDO_ACEITE_INSCRICAO);

		Criteria c = getSession().createCriteria(InscricaoCurso.class);
		c.createAlias("curso", "c");
		c.add(Restrictions.eq("c.id", curso.getId()));
		c.createAlias("situacao", "s");
		c.add(Restrictions.eq("s.id", Situacao.INSCRITO));
		c.createAlias("statusInscricoes", "st");
		c.createAlias("st.status", "status");
		c.add(Restrictions.in("status.id", idsStatus));
		c.setProjection(Projections.distinct(Projections.property("id")));
		List<Integer> ids = c.list();

		if (ids != null && !ids.isEmpty()) {
			Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
			c2.add(Restrictions.in("id", ids));
			// Inicializa todos os dados de candidato
			c2.setFetchMode("candidato", FetchMode.JOIN);

			List<InscricaoCurso> lista = c2.list();
			List<InscricaoCurso> listaRetorno = new ArrayList<InscricaoCurso>();

			if (lista != null && !lista.isEmpty()) {
				for (InscricaoCurso obj : lista) {
					if (obj.getFlgInstrutor()){
						continue;
					}
					for (Integer id : idsStatus) {
						if (obj.getUltimoStatus() != null && obj.getUltimoStatus().getStatus().getId().equals(id)) {
							listaRetorno.add(obj);
							break;
						}
					}
				}
				return listaRetorno;
			}
		}

		return new ArrayList<InscricaoCurso>();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> carregarListaCandidatoConfirmados(Curso curso) {
		// Status

		List<Integer> idsStatus = new ArrayList<Integer>();
		idsStatus.add(Status.PRESENCA_CONFIRMADA);

		Criteria c = getSession().createCriteria(InscricaoCurso.class);
		c.createAlias("curso", "c");
		c.add(Restrictions.eq("c.id", curso.getId()));
		c.createAlias("situacao", "s");
		c.add(Restrictions.eq("s.id", Situacao.INSCRITO));
		c.createAlias("statusInscricoes", "st");
		c.createAlias("st.status", "status");
		c.add(Restrictions.in("status.id", idsStatus));
		c.setProjection(Projections.distinct(Projections.property("id")));
		List<Integer> ids = c.list();

		if (ids != null && !ids.isEmpty()) {
			Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
			c2.add(Restrictions.in("id", ids));
			c2.setFetchMode("candidato", FetchMode.JOIN);

			List<InscricaoCurso> lista = c2.list();
			List<InscricaoCurso> listaRetorno = new ArrayList<InscricaoCurso>();

			if (lista != null && !lista.isEmpty()) {
				for (InscricaoCurso obj : lista) {
					if (obj.getFlgInstrutor()){
						continue;
					}
					for (Integer id : idsStatus) {
						if (obj.getUltimoStatus() != null && obj.getUltimoStatus().getStatus().getId().equals(id)) {
							listaRetorno.add(obj);
							break;
						}
					}
				}
				return listaRetorno;
			}
		}

		return new ArrayList<InscricaoCurso>();

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> carregarListaEspera(Curso curso) {
		List<Integer> idsStatus = new ArrayList<Integer>();
		idsStatus.add(Status.AGUARDANDO_VAGA);
		idsStatus.add(Status.AGUARDANDO_VAGA_PRIORIDADE);
		idsStatus.add(Status.CONFIRMADO_PELO_CHEFE);

		Criteria c = getSession().createCriteria(InscricaoCurso.class);
		c.createAlias("curso", "c");
		c.add(Restrictions.eq("c.id", curso.getId()));
		c.createAlias("situacao", "s");
		c.add(Restrictions.eq("s.id", Situacao.ESPERA));
		c.createAlias("statusInscricoes", "st");
		c.createAlias("st.status", "status");
		c.add(Restrictions.in("status.id", idsStatus));
		// Usa desc pois o id do prioritario e 13 do normal e 11.
		// Depois ordena que sem inscreveu primeiro.
		c.addOrder(Order.desc("status.id")).addOrder(Order.asc("dtCadastro"));

		c.setProjection(Projections.property("id"));

		List<Integer> ids = new LinkedList<Integer>(c.list());

		if (ids != null && !ids.isEmpty()) {
			List<InscricaoCurso> listaRetorno = new ArrayList<InscricaoCurso>();
			for (Integer id : ids) {

				Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
				c2.add(Restrictions.eq("id", id));
				c2.setFetchMode("candidato", FetchMode.JOIN);

				InscricaoCurso inscricaoCurso = (InscricaoCurso) c2.uniqueResult();
				
				if (inscricaoCurso.getFlgInstrutor()){
					continue;
				}
				
				for (Integer idStatus : idsStatus) {
					if (inscricaoCurso.getUltimoStatus() != null && inscricaoCurso.getUltimoStatus().getStatus().getId().equals(idStatus)) {
						if (!listaRetorno.contains(inscricaoCurso)) {
							listaRetorno.add(inscricaoCurso);
							break;
						}
					}
				}

			}
			return listaRetorno;

		}

		return new ArrayList<InscricaoCurso>();
	}

	@Override
	public StatusCurso ultimoStatusCurso(Curso curso) {
		// Pega ultimo Status
		Criteria cStatus = getSession().createCriteria(StatusCurso.class);

		cStatus.createAlias("curso", "c");
		cStatus.add(Restrictions.eq("c.id", curso.getId()));
		cStatus.setProjection(Projections.max("id"));

		Integer id = (Integer) cStatus.uniqueResult();

		if (id != null) {
			return (StatusCurso) getSession().get(StatusCurso.class, id);
		} else {
			return null;
		}

	}

	@Override
	public boolean existeInscricoes(Curso curso) throws Exception {
		Criteria c = getSession().createCriteria(InscricaoCurso.class);

		c.add(Restrictions.eq("flgInstrutor", false));
		c.createAlias("curso", "c");
		c.add(Restrictions.eq("c.id", curso.getId()));

		c.setProjection(Projections.rowCount());

		Long result = (Long) c.list().get(0);
		if (result > 0l) {
			return true;
		} else {
			return false;
		}

	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Municipio> pesquisarMunicipio(String nome) {
		Criteria c = getSession().createCriteria(Municipio.class);

		c.add(Restrictions.ilike("descricao", nome, MatchMode.EXACT));

		return c.list();
	}

	@Override
	public Integer ultimaInscricao() {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		// pega a maior inscricao do ano
		Integer anoAtual = Integer.valueOf(DateUtil.getDataHora(new Date(), "yyyy"));
		criteria.add(Restrictions.eq("anoHomologacao", anoAtual));
		criteria.setProjection(Projections.max("inscricao"));

		Integer numInscricao = (Integer) criteria.uniqueResult();

		if (numInscricao != null) {
			return numInscricao;
		}

		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Status> carregarStatus(List<Integer> idsStatus) {
		Criteria c = getSession().createCriteria(Status.class);

		c.add(Restrictions.in("id", idsStatus));
		return c.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Integer retornarQuantidadeInscritos(Curso curso) {
		List<Integer> idsStatus = new ArrayList<Integer>();
		idsStatus.add(Status.CANCELADO);
		idsStatus.add(Status.AGUARDANDO_VAGA_PRIORIDADE);
		idsStatus.add(Status.AGUARDANDO_VAGA);

		Criteria c = getSession().createCriteria(InscricaoCurso.class);
		c.add(Restrictions.eq("flgInstrutor", false));
		c.createAlias("curso", "c");
		c.add(Restrictions.eq("c.id", curso.getId()));
		c.createAlias("statusInscricoes", "st");
		c.createAlias("st.status", "status");
		c.add(Restrictions.not(Restrictions.in("status.id", idsStatus)));
		c.setProjection(Projections.distinct(Projections.property("id")));
		List<Integer> ids = c.list();

		if (ids != null && !ids.isEmpty()) {
			Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
			c2.add(Restrictions.in("id", ids));

			List<InscricaoCurso> lista = c2.list();
			Set<Integer> qtd = new HashSet<Integer>();

			if (lista != null && !lista.isEmpty()) {
				for (InscricaoCurso obj : lista) {
					if (!obj.getUltimoStatus().getStatus().getId().equals(Status.CANCELADO)
							&& !obj.getUltimoStatus().getStatus().getId().equals(Status.AGUARDANDO_VAGA)
							&& !obj.getUltimoStatus().getStatus().getId().equals(Status.AGUARDANDO_VAGA_PRIORIDADE)) {
						qtd.add(obj.getId());
					}
				}
				return qtd.size();
			}
		}

		return 0;

	}

	@Override
	public InscricaoCurso recuperarInscricaoPeloHash(String hashCandidato) throws Exception {
		// Sql com hash para descobrir a inscricao do curso.
		StringBuilder sql = new StringBuilder();
		sql.append("select i.id_inscricao_curso from sisfie.candidato as c, sisfie.inscricao_curso i where ");
		sql.append(" md5(c.id_candidato || '_' || i.id_inscricao_curso) = '" + hashCandidato + "'");

		Integer idInscricao = (Integer) getSession().createSQLQuery(sql.toString()).uniqueResult();
		if (idInscricao != null) {
			InscricaoCurso inscricaoCurso = (InscricaoCurso) dao.get(InscricaoCurso.class, idInscricao);
			// verifica se a inscricao ta com o ultimo status pre inscrito.
			// Senão achar retorna null.
			StatusInscricao ultimoStatus = inscricaoCurso.getUltimoStatus();
			if (ultimoStatus.getStatus().getId().equals(Status.PRE_INSCRITO)) {
				return inscricaoCurso;
			} else {
				return null;
			}

		}

		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Curso> recuperarCursosComOficina(Usuario user) {
		Criteria criteria = getSession().createCriteria(Curso.class);
		criteria.add(Restrictions.eq("flgPossuiOficina", Boolean.TRUE));
		criteria.add(Restrictions.ge("dtRealizacaoInicio", new Date()));
		criteria.add(Restrictions.eq("usuario.id", user.getId()));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Curso> recuperarCursosAtivos(Usuario user) {
		Criteria criteria = getSession().createCriteria(Curso.class);
		criteria.add(Restrictions.or(Restrictions.isNull("flgFinalizado"), Restrictions.eq("flgFinalizado", false)));
		criteria.add(Restrictions.eq("usuario.id", user.getId()));
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Curso> recuperarCursosAtivos() {
		Criteria criteria = getSession().createCriteria(Curso.class);
		criteria.add(Restrictions.or(Restrictions.isNull("flgFinalizado"), Restrictions.eq("flgFinalizado", false)));
		return criteria.list();
	}

	@Override
	public List<Curso> recuperarCursosComOficinaNaoDistribuidos(Usuario user) {

		List<Curso> cursos = recuperarCursosComOficina(user);
		List<Curso> listRetorno = new ArrayList<Curso>();
		for (Curso curso : cursos) {
			if (!cursoJaDistribuido(curso)) {
				listRetorno.add(curso);
			}
		}
		return listRetorno;
	}

	private boolean cursoJaDistribuido(Curso curso) {
		Criteria c = getSession().createCriteria(DistribuicaoSofGrade.class);
		c.createAlias("gradeOficina", "g");
		c.createAlias("g.oficina", "o");
		c.createAlias("o.curso", "c");
		c.add(Restrictions.eq("c.id", curso.getId()));

		c.setProjection(Projections.rowCount());

		Long result = (Long) c.list().get(0);

		if (result != null && result > 0) {
			return true;
		} else {
			return false;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Curso> recuperarCursos(Curso curso) throws Exception {
		StringBuilder sql = new StringBuilder("SELECT * FROM sisfie.curso WHERE 1=1 ");
		if (curso != null && curso.getTitulo() != null && !curso.getTitulo().isEmpty()) {
			sql.append(" AND UPPER(SISFIE.sem_acento(titulo)) ILIKE UPPER(SISFIE.sem_acento(\'%" + curso.getTitulo() + "%\'))");
		}

		if (curso != null && curso.getUsuario() != null && curso.getUsuario().getId() != null) {
			sql.append(" and id_usuario_gestor = " + curso.getUsuario().getId());
		}
		sql.append("order by titulo asc;");

		return getSession().createSQLQuery(sql.toString()).addEntity(Curso.class).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Curso> recuperarCursosSemOficina(Curso curso) throws Exception {
		StringBuilder sql = new StringBuilder("SELECT * FROM sisfie.curso WHERE flg_possui_oficina = 'false' ");
		if (curso != null && curso.getTitulo() != null && !curso.getTitulo().isEmpty()) {
			sql.append(" AND UPPER(SISFIE.sem_acento(titulo)) ILIKE UPPER(SISFIE.sem_acento(\'%" + curso.getTitulo() + "%\'))");
		}

		if (curso.getUsuario() != null && curso.getUsuario().getId() != null) {
			sql.append(" and id_usuario_gestor = " + curso.getUsuario().getId());
		}
		sql.append("order by titulo asc;");

		return getSession().createSQLQuery(sql.toString()).addEntity(Curso.class).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Curso> recuperarCursosComOficina(Curso curso) throws Exception {
		StringBuilder sql = new StringBuilder("SELECT * FROM sisfie.curso WHERE flg_possui_oficina = 'true' ");
		if (curso != null && curso.getTitulo() != null && !curso.getTitulo().isEmpty()) {
			sql.append(" AND UPPER(SISFIE.sem_acento(titulo)) ILIKE UPPER(SISFIE.sem_acento(\'%" + curso.getTitulo() + "%\'))");
		}

		if (curso.getUsuario() != null && curso.getUsuario().getId() != null) {
			sql.append(" and id_usuario_gestor = " + curso.getUsuario().getId());
		}
		sql.append("order by titulo asc;");

		return getSession().createSQLQuery(sql.toString()).addEntity(Curso.class).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> carregarListaCandidatoCancelados(Curso cursoPesqCandidatoCancelado) throws Exception {
		Criteria c = getSession().createCriteria(InscricaoCurso.class);
		c.add(Restrictions.eq("flgInstrutor", false));
		c.createAlias("curso", "c");
		c.add(Restrictions.eq("c.id", cursoPesqCandidatoCancelado.getId()));
		c.createAlias("statusInscricoes", "st");
		c.createAlias("st.status", "status");
		c.add(Restrictions.eq("status.id", Status.CANCELADO));
		c.setProjection(Projections.distinct(Projections.property("id")));
		List<Integer> ids = c.list();

		if (ids != null && !ids.isEmpty()) {
			Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
			c2.add(Restrictions.in("id", ids));

			List<InscricaoCurso> lista = c2.list();
			List<InscricaoCurso> listaRetorno = new ArrayList<InscricaoCurso>();

			if (lista != null && !lista.isEmpty()) {
				for (InscricaoCurso obj : lista) {
					if (obj.getUltimoStatus().getStatus().getId().equals(Status.CANCELADO)) {
						listaRetorno.add(obj);
					}
				}
				return listaRetorno;
			}
		}

		return new ArrayList<InscricaoCurso>();
	}

	@Override
	public boolean verificarDistribuicaoCurso(Curso curso) {
		return cursoJaDistribuido(curso);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Oficina> recuperarOficinas(Curso curso) {
		Criteria criteria = getSession().createCriteria(Oficina.class);
		criteria.createAlias("curso", "c");
		criteria.add(Restrictions.eq("c.id", curso.getId()));
		return criteria.list();
	}

	@Override
	public Integer retornarQuantidadeInscritos(Curso curso, Oficina oficina, List<Integer> idsInscritos,
			List<Integer> idsInscritosCancelados) {
		Criteria criteria = getSession().createCriteria(InscricaoGrade.class);
		criteria.createAlias("gradeOficina", "go");
		criteria.createAlias("go.oficina", "o");
		criteria.createAlias("inscricaoCurso", "ic");
		criteria.createAlias("ic.curso", "c");
		criteria.add(Restrictions.eq("o.id", oficina.getId()));
		criteria.add(Restrictions.eq("c.id", curso.getId()));

		if (!idsInscritos.isEmpty()) {
			criteria.add(Restrictions.in("ic.id", idsInscritos));
		}

		if (!idsInscritosCancelados.isEmpty()) {
			criteria.add(Restrictions.not(Restrictions.in("ic.id", idsInscritosCancelados)));
		}

		criteria.setProjection(Projections.rowCount());
		return ((Long) criteria.list().get(0)).intValue();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<EmailCursoPrivado> recuperarParceiros(ParceirosDTO dto) {
		Criteria criteria = getSession().createCriteria(EmailCursoPrivado.class);
		if (dto.getCurso() != null && dto.getCurso().getId() != null){
			criteria.add(Restrictions.eq("curso.id", dto.getCurso().getId()));
		}
		if (dto.getEmail() != null && !dto.getEmail().equals("")){
			criteria.add(Restrictions.eq("email", dto.getEmail()));
		}
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<EmailCursoPrivado> recuperarParceirosNaoInscritos(Integer idCurso, List<String> listaEmailParceirosInscritos) {
		Criteria criteria = getSession().createCriteria(EmailCursoPrivado.class);
		if (idCurso != null){
			criteria.add(Restrictions.eq("curso.id", idCurso));
		}
		if (listaEmailParceirosInscritos != null && !listaEmailParceirosInscritos.isEmpty()){
			criteria.add(Restrictions.not(Restrictions.in("email", listaEmailParceirosInscritos)));
		}
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Curso> recuperarCursosComInscricoes(Curso curso) throws Exception {
		StringBuilder sql = new StringBuilder("SELECT * FROM sisfie.curso WHERE 1=1 ");
		if (curso != null && curso.getTitulo() != null && !curso.getTitulo().isEmpty()) {
			sql.append(" AND UPPER(SISFIE.sem_acento(titulo)) ILIKE UPPER(SISFIE.sem_acento(\'%" + curso.getTitulo() + "%\'))");
		}

		if (curso != null && curso.getUsuario() != null && curso.getUsuario().getId() != null) {
			sql.append(" and id_usuario_gestor = " + curso.getUsuario().getId());
		}
		sql.append("order by titulo asc;");

		List<Curso> listaCurso = getSession().createSQLQuery(sql.toString()).addEntity(Curso.class).list();
		List<Curso> listaRetorno = new ArrayList<Curso>();
		if (listaCurso != null && !listaCurso.isEmpty()){
			for (Curso c : listaCurso) {
				if (existeInscricoes(c)){
					listaRetorno.add(c);
				}
			}
		}
		return listaRetorno;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> carregarListaInstrutores(Curso curso) {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		criteria.createAlias("curso", "c");
		criteria.add(Restrictions.eq("c.id", curso.getId()));
		criteria.add(Restrictions.eq("flgInstrutor", true));
		criteria.createAlias("ultimoStatus", "us");
		criteria.createAlias("us.status", "s");
		criteria.add(Restrictions.not(Restrictions.eq("s.id", Status.CANCELADO)));
		return criteria.list();
	}
}
