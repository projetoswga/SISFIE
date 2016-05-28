package br.com.sisfie.DAO.impl;

import java.util.ArrayList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.Subqueries;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.InscricaoCursoDAO;
import br.com.sisfie.bean.GerenciarCursoBean;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.InscricaoGrade;
import br.com.sisfie.entidade.MunicipioCurso;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.entidade.UfCurso;

@Repository(value = "inscricaoCursoDAO")
public class InscricaoCursoDAOImpl extends HibernateDaoSupport implements InscricaoCursoDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> recuperarInscricoes(Integer idCurso) {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		criteria.add(Restrictions.eq("curso.id", idCurso));
		criteria.add(Restrictions.eq("flgInstrutor", false));
		return criteria.list();
	}

	@Override
	public Long countPesquisaInscricaoCandidato(InscricaoCurso model, Integer idStatus, List<Curso> listaCursos,
			boolean semSelecaoOficina) {
		Criteria c = retornarCriteria(model, idStatus, listaCursos, semSelecaoOficina);
		c.setProjection(Projections.rowCount());

		Long result = (Long) c.list().get(0);
		return result;
	}

	private Criteria retornarCriteria(InscricaoCurso model, Integer idStatus, List<Curso> listaCursos,
			boolean semSelecaoOficina) {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		criteria.createAlias("curso", "c");
		if (listaCursos != null && !listaCursos.isEmpty()) {
			List<Integer> listaIdsCursos = new ArrayList<Integer>();
			for (Curso curso : listaCursos) {
				listaIdsCursos.add(curso.getId());
			}
			if (!listaIdsCursos.isEmpty()) {
				criteria.add(Restrictions.in("c.id", listaIdsCursos));
			}
		}
		if (model.getCurso() != null && model.getCurso().getCodigo() != null) {
			criteria.add(Restrictions.ilike("c.codigo", "%" + model.getCurso().getCodigo()));
		}
		if (model.getInscricao() != null && !model.getInscricao().isEmpty()) {
			criteria.add(Restrictions.ilike("inscricao", "%" + model.getInscricao() + "%"));
		}
		if (model.getCandidato() != null) {
			criteria.createAlias("candidato", "cand");
			if (model.getCandidato().getNome() != null && !model.getCandidato().getNome().isEmpty()) {
				criteria.add(Restrictions.ilike("cand.nome", "%" + model.getCandidato().getNome() + "%"));
			}
			if (model.getCandidato().getOrgao() != null && model.getCandidato().getOrgao().getId() != null) {
				criteria.createAlias("cand.orgao", "org");
				criteria.add(Restrictions.eq("org.id", model.getCandidato().getOrgao().getId()));
			}
		}

		if (semSelecaoOficina)
			criteria.add(Restrictions.or(Restrictions.isNull("selecaoOficina"), Restrictions.isEmpty("selecaoOficina")));

		if (idStatus != null && idStatus > 0)
			montarCriteriaOpcoes(criteria, idStatus);

		return criteria;
	}

	public void montarCriteriaOpcoes(Criteria criteria, Integer idStatus) {
		DetachedCriteria subCriteria = DetachedCriteria.forClass(StatusInscricao.class);
		subCriteria.createAlias("inscricaoCurso", "insc");
		subCriteria.setProjection(Property.forName("insc.id"));

		List<Integer> idsStatus = new ArrayList<Integer>();
		idsStatus.add(idStatus);
		subCriteria.add(Property.forName("status.id").in(idsStatus));

		DetachedCriteria subCriteriaMax = DetachedCriteria.forClass(StatusInscricao.class);
		subCriteriaMax.setProjection(Projections.max("id"));
		subCriteriaMax.add(Property.forName("inscricaoCurso.id").eqProperty("insc.id"));
		subCriteria.add(Subqueries.propertyEq("id", subCriteriaMax));

		criteria.add(Subqueries.propertyIn("id", subCriteria));
	}

	@Override
	public Long countPesquisaInscricaoCandidato(InscricaoCurso model, Integer cancelada, Integer paga, Integer homologada) {
		Criteria c = retornarCriteria(model, cancelada, paga, homologada);
		c.setProjection(Projections.rowCount());

		Long result = (Long) c.list().get(0);
		return result;
	}

	private Criteria retornarCriteria(InscricaoCurso model, Integer cancelada, Integer paga, Integer homologada) {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		if (model.getCurso() != null) {
			criteria.createAlias("curso", "c");
			if (model.getCurso().getTitulo() != null) {
				criteria.add(Restrictions.ilike("c.titulo", "%" + model.getCurso().getTitulo()));
			}
			if (model.getCurso().getCodigo() != null) {
				criteria.add(Restrictions.ilike("c.codigo", "%" + model.getCurso().getCodigo()));
			}
		}
		if (model.getInscricao() != null && !model.getInscricao().isEmpty()) {
			criteria.add(Restrictions.ilike("inscricao", "%" + model.getInscricao() + "%"));
		}
		if (model.getCandidato() != null && model.getCandidato().getNome() != null && !model.getCandidato().getNome().isEmpty()) {
			criteria.createAlias("candidato", "cand");
			criteria.add(Restrictions.ilike("cand.nome", "%" + model.getCandidato().getNome() + "%"));
		}

		List<Integer> listaSim = new ArrayList<Integer>();
		List<Integer> listaNao = new ArrayList<Integer>();
		if (cancelada == 1) {
			listaSim.add(Status.CANCELADO);
		} else if (cancelada == 2) {
			listaNao.add(Status.CANCELADO);
		}

		if (paga == 1) {
			listaSim.add(Status.AGUARDANDO_HOMOLOGACAO);
		} else if (paga == 2) {
			listaNao.add(Status.AGUARDANDO_HOMOLOGACAO);
		}

		if (homologada == 1) {
			listaSim.add(Status.HOMOLOGADO);
		} else if (homologada == 2) {
			listaNao.add(Status.HOMOLOGADO);
		}

		if (!listaNao.isEmpty() || !listaSim.isEmpty()) {
			montarCriteriaOpcoes(criteria, listaSim, listaNao);
		}
		return criteria;
	}

	public void montarCriteriaOpcoes(Criteria criteria, List<Integer> listaSim, List<Integer> listaNao) {
		DetachedCriteria subCriteria = DetachedCriteria.forClass(StatusInscricao.class);
		subCriteria.createAlias("inscricaoCurso", "insc");
		subCriteria.setProjection(Property.forName("insc.id"));

		if (!listaSim.isEmpty()) {
			subCriteria.add(Property.forName("status.id").in(listaSim));
		}
		if (!listaNao.isEmpty()) {
			subCriteria.add(Restrictions.not(Property.forName("status.id").in(listaNao)));
		}

		DetachedCriteria subCriteriaMax = DetachedCriteria.forClass(StatusInscricao.class);
		subCriteriaMax.setProjection(Projections.max("id"));
		subCriteriaMax.add(Property.forName("inscricaoCurso.id").eqProperty("insc.id"));
		subCriteria.add(Subqueries.propertyEq("id", subCriteriaMax));

		criteria.add(Subqueries.propertyIn("id", subCriteria));
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> paginatePesquisaInscricaoCandidato(int first, int pageSize, InscricaoCurso model,
			Integer cancelada, Integer paga, Integer homologada) {
		Criteria c = retornarCriteria(model, cancelada, paga, homologada);

		if (first != 0)
			c.setFirstResult(first);
		if (pageSize != 0)
			c.setMaxResults(pageSize);

		return c.list();
	}

	@SuppressWarnings("unchecked")
	public Long consultarInscricoes(Curso curso, boolean dentroRegiao) {
		Criteria criteria = montarCriteria(curso, dentroRegiao);
		criteria.createAlias("c.orgao", "o");
		ProjectionList projectionList = Projections.projectionList();
		projectionList.add(Projections.rowCount());
		projectionList.add(Projections.groupProperty("curso.id"));
		projectionList.add(Projections.groupProperty("o.id"));
		projectionList.add(Projections.groupProperty("mo.id"));
		criteria.setProjection(projectionList);
		if (criteria.list() != null && !criteria.list().isEmpty()) {
			List<Object[]> listaResultado = criteria.list();
			Long retorno = new Long(0);
			for (Object[] object : listaResultado) {
				retorno += (Long) object[0];
			}
			return retorno;
		} else {
			return new Long(0);
		}
	}

	private Criteria montarCriteria(Curso curso, boolean dentroRegiao) {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		criteria.add(Restrictions.eq("curso.id", curso.getId()));
		criteria.createAlias("candidato", "c");
		criteria.createAlias("c.municipioOrgao", "mo");
		if (curso.getMunicipioCursos() != null && !curso.getMunicipioCursos().isEmpty()) {
			List<Integer> listaIds = new ArrayList<Integer>();
			for (MunicipioCurso municipioCurso : curso.getMunicipioCursos()) {
				listaIds.add(municipioCurso.getMunicipio().getId());
			}
			if (dentroRegiao) {
				criteria.add(Restrictions.in("mo.id", listaIds));
			} else {
				criteria.add(Restrictions.not(Restrictions.in("mo.id", listaIds)));
			}
		}
		if (curso.getUfCursos() != null && !curso.getUfCursos().isEmpty()) {
			List<Integer> listaIds = new ArrayList<Integer>();
			for (UfCurso ufCurso : curso.getUfCursos()) {
				listaIds.add(ufCurso.getUf().getId());
			}
			criteria.createAlias("mo.uf", "uf");
			if (dentroRegiao) {
				criteria.add(Restrictions.in("uf.id", listaIds));
			} else {
				criteria.add(Restrictions.not(Restrictions.in("uf.id", listaIds)));
			}
		}
		criteria.addOrder(Order.asc("curso.id"));
		return criteria;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> consultarInscricoesParaHomologacao(Curso curso, Integer quantidadeVagas, boolean dentroRegiao)
			throws Exception {
		Criteria criteria = montarCriteria(curso, dentroRegiao);
		criteria.setMaxResults(quantidadeVagas);
		return criteria.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> paginatePesquisaInscricaoCandidato(int first, int pageSize, InscricaoCurso model,
			Integer idStatus, List<Curso> listaCursos, boolean semSelecaoOficina) {
		Criteria c = retornarCriteria(model, idStatus, listaCursos, semSelecaoOficina);

		if (first != 0)
			c.setFirstResult(first);
		if (pageSize != 0)
			c.setMaxResults(pageSize);

		List<InscricaoCurso> listaRetorno = c.list();
		if (listaRetorno != null) {
			for (InscricaoCurso inscricaoCurso : listaRetorno) {
				Hibernate.initialize(inscricaoCurso.getCandidato());
				Hibernate.initialize(inscricaoCurso.getCandidato().getOrgao());
				Hibernate.initialize(inscricaoCurso.getCurso());
				Hibernate.initialize(inscricaoCurso.getCurso().getLocalizacao());
			}
		}

		return c.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public Integer recuperarQuantidadeInscricoesPorOrgao(Integer idOpcaoRegiao, Integer idCurso, Integer quantidadeVagas) {

		Criteria criteria = retornarCriteriaInscricaoPorOrgao(idOpcaoRegiao, idCurso);

		Integer total = 0;
		List<Object> listaCounts = criteria.list();
		if (listaCounts != null && !listaCounts.isEmpty()) {
			for (Object object : listaCounts) {
				if (object != null) {
					Object[] count = (Object[]) object;
					total += Math.min(((Long) count[0]).intValue(), quantidadeVagas);
				}
			}
		}

		return total;
	}

	private Criteria retornarCriteriaInscricaoPorOrgao(Integer idOpcaoRegiao, Integer idCurso) {

		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);

		criteria.createAlias("candidato", "cand");
		criteria.createAlias("cand.orgao", "o");
		criteria.createAlias("cand.municipioOrgao", "mo");
		criteria.createAlias("curso", "c");
		criteria.createAlias("statusInscricoes", "ic");
		criteria.createAlias("ic.inscricaoCurso", "ici");
		criteria.createAlias("ic.status", "s");

		criteria.add(Restrictions.eq("c.id", idCurso));

		DetachedCriteria subCriteriaStatusInscricao = DetachedCriteria.forClass(StatusInscricao.class);
		subCriteriaStatusInscricao.createAlias("inscricaoCurso", "sic");
		subCriteriaStatusInscricao.add(Restrictions.eqProperty("sic.id", Property.forName("ici.id").getPropertyName()));
		subCriteriaStatusInscricao.add(Restrictions.eq("sic.curso.id", idCurso));
		subCriteriaStatusInscricao.setProjection(Projections.max("id"));
		criteria.add((Property.forName("ic.id").in(subCriteriaStatusInscricao)));

		criteria.add(Restrictions.not(Restrictions.in("s.id", listarStatus())));

		Curso curso = (Curso) getSession().get(Curso.class, idCurso);
		if (idOpcaoRegiao.equals(GerenciarCursoBean.DENTRO_REGIAO)) {
			if (curso.getMunicipioCursos() != null && !curso.getMunicipioCursos().isEmpty()) {
				criteria.add(Subqueries.exists(criarDetachedCriteriaMunicipio(idCurso)));
			} else if (curso.getUfCursos() != null && !curso.getUfCursos().isEmpty()) {
				criteria.add(Subqueries.exists(criarDetachedCriteriaUf(idCurso)));
			}
		} else if (idOpcaoRegiao.equals(GerenciarCursoBean.FORA_REGIAO)) {
			if (curso.getMunicipioCursos() != null && !curso.getMunicipioCursos().isEmpty()) {
				criteria.add(Subqueries.notExists(criarDetachedCriteriaMunicipio(idCurso)));
			} else if (curso.getUfCursos() != null && !curso.getUfCursos().isEmpty()) {
				criteria.add(Subqueries.notExists(criarDetachedCriteriaUf(idCurso)));
			}
		}

		criteria.setProjection(Projections.projectionList().add(Projections.rowCount()).add(Projections.groupProperty("o.id"))
				.add(Projections.groupProperty("mo.id")));

		return criteria;
	}

	private List<Integer> listarStatus() {
		List<Integer> listaIdsStatus = new ArrayList<Integer>();
		listaIdsStatus.add(Status.AGUARDANDO_COMPROVANTE);
		listaIdsStatus.add(Status.AGUARDANDO_HOMOLOGACAO);
		listaIdsStatus.add(Status.AGUARDANDO_VALIDACAO_COMPROVANTE);
		listaIdsStatus.add(Status.INVALIDAR_COMPROVANTE);
		listaIdsStatus.add(Status.HOMOLOGADO);
		listaIdsStatus.add(Status.CANCELADO);
		listaIdsStatus.add(Status.PRESENCA_CONFIRMADA);
		return listaIdsStatus;
	}

	private DetachedCriteria criarDetachedCriteriaUf(Integer idCurso) {
		DetachedCriteria subCriteriaUf = DetachedCriteria.forClass(UfCurso.class);
		subCriteriaUf.createAlias("uf", "u");
		subCriteriaUf.add(Restrictions.eqProperty("u.id", Property.forName("mo.uf.id").getPropertyName()));
		subCriteriaUf.add(Restrictions.eq("curso.id", idCurso));
		subCriteriaUf.setProjection(Projections.distinct(Projections.property("id")));
		return subCriteriaUf;
	}

	private DetachedCriteria criarDetachedCriteriaMunicipio(Integer idCurso) {
		DetachedCriteria subCriteriaMunicipio = DetachedCriteria.forClass(MunicipioCurso.class);
		subCriteriaMunicipio.add(Restrictions.eqProperty("municipio.id", Property.forName("mo.id").getPropertyName()));
		subCriteriaMunicipio.add(Restrictions.eq("curso.id", idCurso));
		subCriteriaMunicipio.setProjection(Projections.distinct(Projections.property("id")));
		return subCriteriaMunicipio;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> recuperarInscricoesPorOrgao(Integer idOpcaoRegiao, Integer idCurso, Integer quantidadeVagas) {

		Criteria criteria = retornarCriteriaInscricaoPorOrgao(idOpcaoRegiao, idCurso);

		List<InscricaoCurso> inscricoes = new ArrayList<InscricaoCurso>();
		List<Object> listaCounts = criteria.list();
		if (listaCounts != null && !listaCounts.isEmpty()) {
			for (Object object : listaCounts) {
				if (object != null) {
					Object[] obj = (Object[]) object;
					
					criteria = getSession().createCriteria(InscricaoCurso.class);

					criteria.createAlias("candidato", "cand");
					criteria.createAlias("cand.orgao", "o");
					criteria.createAlias("cand.municipioOrgao", "mo");
					criteria.createAlias("curso", "c");
					criteria.createAlias("statusInscricoes", "ic");
					criteria.createAlias("ic.inscricaoCurso", "ici");
					criteria.createAlias("ic.status", "s");

					criteria.add(Restrictions.eq("c.id", idCurso));

					DetachedCriteria subCriteriaStatusInscricao = DetachedCriteria.forClass(StatusInscricao.class);
					subCriteriaStatusInscricao.createAlias("inscricaoCurso", "sic");
					subCriteriaStatusInscricao
							.add(Restrictions.eqProperty("sic.id", Property.forName("ici.id").getPropertyName()));
					subCriteriaStatusInscricao.add(Restrictions.eq("sic.curso.id", idCurso));
					subCriteriaStatusInscricao.add(Restrictions.eq("sic.flgInstrutor", false));
					subCriteriaStatusInscricao.setProjection(Projections.max("id"));
					criteria.add((Property.forName("ic.id").in(subCriteriaStatusInscricao)));

					criteria.add(Restrictions.not(Restrictions.in("s.id", listarStatus())));

					criteria.add(Restrictions.eq("o.id", obj[1]));
					criteria.add(Restrictions.eq("mo.id", obj[2]));
					criteria.add(Restrictions.eq("c.id", idCurso));

					Curso curso = (Curso) getSession().get(Curso.class, idCurso);
					if (idOpcaoRegiao.equals(GerenciarCursoBean.DENTRO_REGIAO)) {
						if (curso.getMunicipioCursos() != null && !curso.getMunicipioCursos().isEmpty()) {
							criteria.add(Subqueries.exists(criarDetachedCriteriaMunicipio(idCurso)));
						} else if (curso.getUfCursos() != null && !curso.getUfCursos().isEmpty()) {
							criteria.add(Subqueries.exists(criarDetachedCriteriaUf(idCurso)));
						}
					} else if (idOpcaoRegiao.equals(GerenciarCursoBean.FORA_REGIAO)) {
						if (curso.getMunicipioCursos() != null && !curso.getMunicipioCursos().isEmpty()) {
							criteria.add(Subqueries.notExists(criarDetachedCriteriaMunicipio(idCurso)));
						} else if (curso.getUfCursos() != null && !curso.getUfCursos().isEmpty()) {
							criteria.add(Subqueries.notExists(criarDetachedCriteriaUf(idCurso)));
						}
					}
					criteria.addOrder(Order.asc("id"));

					criteria.setMaxResults(quantidadeVagas);
					inscricoes.addAll(criteria.list());
				}
			}
		}
		for (InscricaoCurso inscricaoCurso : inscricoes) {
			Hibernate.initialize(inscricaoCurso.getCurso().getLocalizacao());
		}
		return inscricoes;
	}

	@Override
	public StatusInscricao ultimoStatusInscricao(InscricaoCurso inscricaoCurso) {
		// Pega ultimo Status
		Criteria cStatus = getSession().createCriteria(StatusInscricao.class);

		cStatus.createAlias("inscricaoCurso", "i");
		cStatus.add(Restrictions.eq("i.id", inscricaoCurso.getId()));
		cStatus.setProjection(Projections.max("id"));

		Integer id = (Integer) cStatus.uniqueResult();

		if (id != null) {
			StatusInscricao statusInscricao = (StatusInscricao) getSession().get(StatusInscricao.class, id);
			Hibernate.initialize(statusInscricao.getStatus());
			Hibernate.initialize(statusInscricao.getInscricaoCurso());
			return statusInscricao;
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> recuperarInscricoesAguardandoComprovante(Integer idCurso) {
		Criteria c = getSession().createCriteria(InscricaoCurso.class);
		c.add(Restrictions.eq("flgInstrutor", false));
		c.createAlias("curso", "c");
		c.add(Restrictions.eq("c.id", idCurso));
		montarCriteriaOpcoes(c, Status.AGUARDANDO_COMPROVANTE);
		return c.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> recuperarParceirosInscritos(List<String> listaEmailParceiros, List<Integer> listaIdsCursos) {
		Criteria criteria = getSession().createCriteria(InscricaoGrade.class);
		criteria.createAlias("inscricaoCurso", "ic");
		if (listaEmailParceiros != null && !listaEmailParceiros.isEmpty()) {
			criteria.createAlias("ic.candidato", "cand");
			criteria.add(Restrictions.in("cand.emailInstitucional", listaEmailParceiros));
		}
		if (listaIdsCursos != null && !listaIdsCursos.isEmpty()) {
			criteria.createAlias("ic.curso", "c");
			criteria.add(Restrictions.in("c.id", listaIdsCursos));
		}

		criteria.createAlias("ic.ultimoStatus", "us");
		criteria.createAlias("us.status", "s");
		criteria.add(Restrictions.eq("s.id", Status.PRESENCA_CONFIRMADA));
		criteria.setProjection(Projections.distinct(Projections.property("ic.id")));

		List<Integer> idsInscritos = criteria.list();
		if (idsInscritos != null && !idsInscritos.isEmpty()) {
			Criteria criteriaInscrito = getSession().createCriteria(InscricaoCurso.class);
			criteriaInscrito.add(Restrictions.in("id", idsInscritos));
			return criteriaInscrito.list();
		}
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public InscricaoGrade recuperarParceiroInscrito(EmailCursoPrivado emailCursoParceiro) {
		Criteria criteria = getSession().createCriteria(InscricaoGrade.class);
		if (emailCursoParceiro != null) {
			criteria.createAlias("inscricaoCurso", "ic");
			criteria.createAlias("ic.candidato", "cand");
			criteria.createAlias("ic.curso", "c");
			criteria.createAlias("ic.ultimoStatus", "us");
			criteria.createAlias("us.status", "s");
			criteria.add(Restrictions.eq("s.id", Status.PRESENCA_CONFIRMADA));
			criteria.add(Restrictions.eq("c.id", emailCursoParceiro.getCurso().getId()));
			criteria.add(Restrictions.ilike("cand.emailInstitucional", emailCursoParceiro.getEmail()));
		}
		List<InscricaoGrade> lista = criteria.list();
		if (lista != null && !lista.isEmpty()) {
			return lista.get(0);
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> recuperarParceirosInscritos(Integer idCurso) {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		criteria.createAlias("curso", "c");
		criteria.add(Restrictions.eq("c.id", idCurso));
		criteria.add(Restrictions.eq("flgParceiro", true));
		return criteria.list();
	}

	@Override
	public Long recuperInscricoesSemUltimoStatus(Curso curso) {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		criteria.createAlias("curso", "c");
		criteria.add(Restrictions.eq("c.id", curso.getId()));
		criteria.add(Restrictions.isNull("ultimoStatus"));
		criteria.setProjection(Projections.rowCount());
		Long result = (Long) criteria.list().get(0);
		return result;
	}

	@Override
	public InscricaoCurso recupararInscricao(String numInscricao, Integer idCurso, Integer idTurma, Integer idHorario) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select ic.* from inscricao_curso ic ");
		sql.append(" join inscricao_grade ig on ig.id_inscricao_curso = ic.id_inscricao_curso ");
		sql.append(" join grade_oficina gro on gro.id_grade_oficina = ig.id_grade_oficina ");
		sql.append(" join turma t on t.id_turma = gro.id_turma ");
		sql.append(" join horario h on h.id_horario = gro.id_horario ");
		sql.append(" join curso c on c.id_curso = ic.id_curso ");
		sql.append(" where c.id_curso = " + idCurso);
		sql.append(" and ic.num_inscricao like '" + numInscricao + "' ");
		if (idTurma != null && idTurma > 0) {
			sql.append(" and t.id_turma = " + idTurma);
		}
		if (idHorario != null && idHorario > 0) {
			sql.append(" and h.id_horario = " + idHorario);
		}
		return (InscricaoCurso) getSession().createSQLQuery(sql.toString()).addEntity(InscricaoCurso.class).uniqueResult();
	}

	@Override
	public InscricaoGrade recupararInscricaoGrade(String numInscricao, Integer idCurso, Integer idTurma, Integer idHorario) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select ig.* from inscricao_grade ig ");
		sql.append(" join inscricao_curso ic on ic.id_inscricao_curso = ig.id_inscricao_curso ");
		sql.append(" join grade_oficina gro on gro.id_grade_oficina = ig.id_grade_oficina ");
		sql.append(" join turma t on t.id_turma = gro.id_turma ");
		sql.append(" join horario h on h.id_horario = gro.id_horario ");
		sql.append(" join curso c on c.id_curso = ic.id_curso ");
		sql.append(" where c.id_curso = " + idCurso);
		if (numInscricao != null && !numInscricao.isEmpty()) {
			sql.append(" and ic.num_inscricao like '" + numInscricao + "' ");
		}
		if (idTurma != null && idTurma > 0) {
			sql.append(" and t.id_turma = " + idTurma);
		}
		if (idHorario != null && idHorario > 0) {
			sql.append(" and h.id_horario = " + idHorario);
		}
		return (InscricaoGrade) getSession().createSQLQuery(sql.toString()).addEntity(InscricaoGrade.class).uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> recuperarInscricao(Integer idCurso, Integer idTurma, Integer idTurno) {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		criteria.createAlias("curso", "c");
		criteria.add(Restrictions.eq("c.id", idCurso));
		if (idTurma != null && idTurma != 0) {
			criteria.createAlias("turma", "ta");
			criteria.add(Restrictions.eq("ta.id", idTurma));
		}
		if (idTurno != null && idTurno != 0) {
			criteria.createAlias("c.turno", "tu");
			criteria.add(Restrictions.eq("tu.id", idTurno));
		}
		
		return criteria.list();
	}

	@Override
	public InscricaoCurso recupararInscricaoSemOficina(String inscricao, Integer idCurso, Integer idTurma, Integer idTurno) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select ic.* from inscricao_curso ic ");
		sql.append(" join curso c on c.id_curso = ic.id_curso ");
		if (idTurma != null && idTurma > 0) {
			sql.append(" join turma ta on ta.id_turma = ic.id_turma ");
		}
		if (idTurno != null && idTurno > 0) {
			sql.append(" join turno tu on tu.id_turno = c.id_turno ");
		}
		sql.append(" where c.id_curso = " + idCurso);
		sql.append(" and ic.num_inscricao like '" + inscricao + "' ");
		if (idTurma != null && idTurma > 0) {
			sql.append(" and ta.id_turma = " + idTurma);
		}
		if (idTurno != null && idTurno > 0) {
			sql.append(" and tu.id_turno = " + idTurno);
		}
		return (InscricaoCurso) getSession().createSQLQuery(sql.toString()).addEntity(InscricaoCurso.class).uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> listarInscricoes(Curso curso, InscricaoCurso inscricaoCurso, Integer idTurma) {
		if (curso.getFlgPossuiOficina()) {
			Criteria c = getSession().createCriteria(InscricaoGrade.class);
			c.createAlias("inscricaoCurso", "ic");
			c.createAlias("ic.ultimoStatus", "us");
			c.createAlias("us.status", "s");
			c.add(Restrictions.eq("s.id", Status.PRESENCA_CONFIRMADA));
			c.add(Restrictions.eq("ic.flgInstrutor", false));
			c.createAlias("ic.curso", "c");
			c.add(Restrictions.eq("c.id", curso.getId()));
			c.setProjection(Projections.distinct(Projections.property("ic.id")));
			if (inscricaoCurso != null) {
				if (inscricaoCurso.getInscricao() != null && !inscricaoCurso.getInscricao().isEmpty()) {
					c.add(Restrictions.like("ic.inscricao", inscricaoCurso.getInscricao()));
				}
				if (inscricaoCurso.getCandidato() != null && inscricaoCurso.getCandidato().getNome() != null
						&& !inscricaoCurso.getCandidato().getNome().isEmpty()) {
					c.createAlias("ic.candidato", "cand");
					c.add(Restrictions.like("cand.nome", inscricaoCurso.getCandidato().getNome()));
				}
			}
			if (idTurma != null && idTurma > 0) {
				c.createAlias("gradeOficina", "gro");
				c.createAlias("gro.turma", "tu");
				c.add(Restrictions.eq("tu.id", idTurma));
			}
			List<Integer> idsInscricaoCurso = c.list();
			if (idsInscricaoCurso != null && !idsInscricaoCurso.isEmpty()) {
				List<InscricaoCurso> listaRetorno = new ArrayList<InscricaoCurso>();
				for (Integer idInscricao : idsInscricaoCurso) {
					listaRetorno.add((InscricaoCurso) dao.get(InscricaoCurso.class, idInscricao));
				}
				return listaRetorno;
			}
		} else {
			Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
			criteria.createAlias("ultimoStatus", "us");
			criteria.createAlias("us.status", "s");
			criteria.add(Restrictions.eq("s.id", Status.PRESENCA_CONFIRMADA));
			criteria.createAlias("curso", "c");
			criteria.add(Restrictions.eq("c.id", curso.getId()));
			if (inscricaoCurso != null) {
				if (inscricaoCurso.getInscricao() != null && !inscricaoCurso.getInscricao().isEmpty()) {
					criteria.add(Restrictions.like("inscricao", inscricaoCurso.getInscricao()));
				}
				if (inscricaoCurso.getCandidato() != null && inscricaoCurso.getCandidato().getNome() != null
						&& !inscricaoCurso.getCandidato().getNome().isEmpty()) {
					criteria.createAlias("candidato", "cand");
					criteria.add(Restrictions.like("cand.nome", inscricaoCurso.getCandidato().getNome()));
				}
			}
			if (idTurma != null && idTurma > 0) {
				criteria.createAlias("turma", "t");
				criteria.add(Restrictions.eq("t.id", idTurma));
			}
			return criteria.list();
		}
		return null;
	}

	@Override
	public InscricaoCurso recuperarInscricao(String numInscricao) {
		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);
		criteria.add(Restrictions.like("inscricao", numInscricao));
		return (InscricaoCurso) criteria.uniqueResult();
	}
}
