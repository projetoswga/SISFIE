package br.com.sisfie.DAO.impl;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.FetchMode;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.DetachedCriteria;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Property;
import org.hibernate.criterion.Restrictions;
import org.hibernate.criterion.Subqueries;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.CandidatoDAO;
import br.com.sisfie.bean.RelatorioCandidatoInscritoBean;
import br.com.sisfie.dto.CandidatoDTO;
import br.com.sisfie.dto.RelatorioPesquisaDTO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.entidade.CandidatoCargo;
import br.com.sisfie.entidade.CandidatoComplemento;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Situacao;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusInscricao;

@Repository(value = "candidatoDAO")
public class CandidatoDAOImpl extends HibernateDaoSupport implements CandidatoDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Override
	public Long countCandidato(CandidatoDTO dto) {
		Criteria c = retornarCriteria(dto);
		c.setProjection(Projections.rowCount());
		Long result = (Long) c.list().get(0);
		return result;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Candidato> paginateCandidato(int first, int pageSize, CandidatoDTO dto) {
		Criteria c = retornarCriteria(dto);
		if (first != 0)
			c.setFirstResult(first);
		if (pageSize != 0)
			c.setMaxResults(pageSize);
		return c.list();
	}

	@SuppressWarnings("unchecked")
	private Criteria retornarCriteria(CandidatoDTO dto) {
		if (dto == null) {
			return null;
		}

		Criteria criteria = getSession().createCriteria(Candidato.class);

		if (dto.getDtNascimento() != null) {
			criteria.add(Restrictions.eq("dataNascimento", dto.getDtNascimento()));
		}
		if (dto.getCpf() != null && !dto.getCpf().isEmpty()) {
			criteria.add(Restrictions.ilike("cpf", dto.getCpf().replaceAll("\\D", "")));
		}
		if (dto.getDocEstrangeiro() != null && !dto.getDocEstrangeiro().isEmpty()) {
			criteria.add(Restrictions.ilike("docEstrangeiro", dto.getDocEstrangeiro()));
		}
		if (dto.getEmailInstitucional() != null && !dto.getEmailInstitucional().isEmpty()) {
			criteria.add(Restrictions.ilike("emailInstitucional", "%" + dto.getEmailInstitucional() + "%"));
		}
		if (dto.getIdCurso() != null && !dto.getIdCurso().equals(0)) {
			DetachedCriteria subCriteria = DetachedCriteria.forClass(InscricaoCurso.class);
			subCriteria.add(Property.forName("curso.id").eq(dto.getIdCurso()));
			subCriteria.setProjection(Projections.distinct(Projections.property("candidato.id")));

			criteria.add(Property.forName("id").in(subCriteria));
		}
		if (dto.getIdMunicipioSelecionado() != null && !dto.getIdMunicipioSelecionado().equals(0)) {
			criteria.add(Restrictions.eq("municipioOrgao.id", dto.getIdMunicipioSelecionado()));
		}
		if (dto.getIdUfOrgaoSelecionado() != null && !dto.getIdUfOrgaoSelecionado().equals(0)) {
			criteria.createAlias("municipioOrgao", "mo");
			criteria.add(Restrictions.eq("mo.uf.id", dto.getIdUfOrgaoSelecionado()));
		}
		if (dto.getIdMunicipioEnderecoSelecionado() != null && !dto.getIdMunicipioEnderecoSelecionado().equals(0)) {
			criteria.add(Restrictions.eq("municipioEndereco.id", dto.getIdMunicipioEnderecoSelecionado()));
		}
		if (dto.getIdUfEnderecoSelecionado() != null && !dto.getIdUfEnderecoSelecionado().equals(0)) {
			criteria.createAlias("municipioEndereco", "me");
			criteria.add(Restrictions.eq("me.uf.id", dto.getIdUfEnderecoSelecionado()));
		}

		if (dto.getInscricao() != null && !dto.getInscricao().isEmpty()) {
			criteria.createAlias("inscricoes", "ins");
			criteria.add(Restrictions.eq("ins.inscricao", dto.getInscricao()));
		}

		if (dto.getNome() != null && !dto.getNome().isEmpty()) {
			criteria.add(Restrictions.ilike("nome", "%" + dto.getNome() + "%"));
		}
		if (dto.getOrgaoSelecionado() != null && dto.getOrgaoSelecionado().getId() != null && !dto.getOrgaoSelecionado().getId().equals(0)) {
			criteria.add(Restrictions.eq("orgao.id", dto.getOrgaoSelecionado().getId()));
		}
		
		if (dto.getIdStatus() != null && !dto.getIdStatus().equals(0)) {
			Criteria criteriaInscricaoCurso = getSession().createCriteria(InscricaoCurso.class);
			
			DetachedCriteria subCriteria = DetachedCriteria.forClass(StatusInscricao.class);
			subCriteria.createAlias("inscricaoCurso", "insc");
			subCriteria.setProjection(Property.forName("insc.id"));

			List<Integer> idsStatus = new ArrayList<Integer>();
			idsStatus.add(dto.getIdStatus());
			subCriteria.add(Property.forName("status.id").in(idsStatus));

			DetachedCriteria subCriteriaMax = DetachedCriteria.forClass(StatusInscricao.class);
			subCriteriaMax.setProjection(Projections.max("id"));
			subCriteriaMax.add(Property.forName("inscricaoCurso.id").eqProperty("insc.id"));
			subCriteria.add(Subqueries.propertyEq("id", subCriteriaMax));

			criteriaInscricaoCurso.add(Subqueries.propertyIn("id", subCriteria));
			
			// Caso o usuario selecionou algum curso
			if (dto.getIdCurso() != null && !dto.getIdCurso().equals(0)){
				criteriaInscricaoCurso.add(Restrictions.eq("curso.id", dto.getIdCurso()));
			}
			criteriaInscricaoCurso.setProjection(Projections.distinct(Projections.property("id")));
			
			List<Integer> idsInscricaoCurso = criteriaInscricaoCurso.list();
			
			if (idsInscricaoCurso != null && !idsInscricaoCurso.isEmpty()){
				// Retorna os ids dos candidatos de acordo com a lista de ids de InscricaoCurso. Caso exista inscrição
				DetachedCriteria subCriteriaInscricaoCurso = DetachedCriteria.forClass(InscricaoCurso.class);
				subCriteriaInscricaoCurso.add(Property.forName("id").in(idsInscricaoCurso));
				subCriteriaInscricaoCurso.setProjection(Projections.distinct(Projections.property("candidato.id")));
				
				criteria.add(Property.forName("id").in(subCriteriaInscricaoCurso));
			}
		}
		return criteria;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> listarCandidatosInscritos(RelatorioPesquisaDTO dto) throws Exception {

		Criteria criteria = getSession().createCriteria(InscricaoCurso.class);

		criteria.createAlias("curso", "c");
		criteria.createAlias("candidato", "ca");

		if (dto.getCurso() != null && dto.getCurso().getId() != null && dto.getCurso().getId() != 0) {
			criteria.add(Restrictions.eq("c.id", dto.getCurso().getId()));
		}
		if (dto.getOrgaoCandidato() != null && dto.getOrgaoCandidato().getId() != null && !dto.getOrgaoCandidato().getId().equals(0)) {
			criteria.createAlias("ca.orgao", "or");
			criteria.add(Restrictions.eq("or.id", dto.getOrgaoCandidato().getId()));
		}
		if (dto.getDataInicial() != null){
			criteria.add(Restrictions.ge("c.dtRealizacaoInicio", dto.getDataInicial()));
		}
		if (dto.getDataFinal() != null) {
			criteria.add(Restrictions.le("c.dtRealizacaoFim", dto.getDataFinal()));
		}
		if (dto.getTurma() != null && dto.getTurma().getId() != null && dto.getTurma().getId() != 0) {
			criteria.createAlias("turma", "t");
			criteria.add(Restrictions.eq("t.id", dto.getTurma().getId()));
		}
		if (dto.getOrgaoSolicitante() != null && dto.getOrgaoSolicitante().getId() != 0) {
			criteria.createAlias("c.orgao", "orSol");
			criteria.add(Restrictions.eq("orSol.id", dto.getOrgaoSolicitante().getId()));

		}
		if (dto.getIdSituacaoInscricao() != null && !dto.getIdSituacaoInscricao().equals(0)) {
			if (dto.getIdSituacaoInscricao().equals(RelatorioCandidatoInscritoBean.CONFIRMADO)) {
				List<Integer> idsStatus = new ArrayList<Integer>();
				idsStatus.add(Status.PRESENCA_CONFIRMADA);
				criteria.createAlias("situacao", "s");
				criteria.add(Restrictions.eq("s.id", Situacao.INSCRITO));
				criteria.createAlias("statusInscricoes", "st");
				criteria.createAlias("st.status", "status");
				criteria.add(Restrictions.in("status.id", idsStatus));
				criteria.setProjection(Projections.distinct(Projections.property("id")));
				List<Integer> ids = criteria.list();

				if (ids != null && !ids.isEmpty()) {
					Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
					c2.add(Restrictions.in("id", ids));
					c2.setFetchMode("candidato", FetchMode.JOIN);

					List<InscricaoCurso> lista = c2.list();
					List<InscricaoCurso> listaRetorno = new ArrayList<InscricaoCurso>();

					if (lista != null && !lista.isEmpty()) {
						for (InscricaoCurso obj : lista) {
							obj.setUltimoStatus(ultimoStatusInscricao(obj));
							for (Integer id : idsStatus) {
								if (obj.getUltimoStatus().getStatus().getId().equals(id)) {
									listaRetorno.add(obj);
									break;
								}
							}
						}
						return listaRetorno;
					}
				}
			} else if (dto.getIdSituacaoInscricao().equals(RelatorioCandidatoInscritoBean.PENDENTE)) {
				List<Integer> idsStatus = new ArrayList<Integer>();
				idsStatus.add(Status.PRE_INSCRITO);
				idsStatus.add(Status.AGUARDANDO_COMPROVANTE);
				idsStatus.add(Status.CONFIRMADO_PELO_CHEFE);
				idsStatus.add(Status.INVALIDAR_COMPROVANTE);
				idsStatus.add(Status.HOMOLOGADO);
				idsStatus.add(Status.AGUARDANDO_VALIDACAO_COMPROVANTE);
				idsStatus.add(Status.AGUARDANDO_HOMOLOGACAO);
				idsStatus.add(Status.AGUARDANDO_ACEITE_INSCRICAO);

				criteria.createAlias("situacao", "s");
				criteria.add(Restrictions.eq("s.id", Situacao.INSCRITO));
				criteria.createAlias("statusInscricoes", "st");
				criteria.createAlias("st.status", "status");
				criteria.add(Restrictions.in("status.id", idsStatus));
				criteria.setProjection(Projections.distinct(Projections.property("id")));
				List<Integer> ids = criteria.list();

				if (ids != null && !ids.isEmpty()) {
					Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
					c2.add(Restrictions.in("id", ids));
					// Inicializa todos os dados de candidato
					c2.setFetchMode("candidato", FetchMode.JOIN);

					List<InscricaoCurso> lista = c2.list();
					List<InscricaoCurso> listaRetorno = new ArrayList<InscricaoCurso>();

					if (lista != null && !lista.isEmpty()) {
						for (InscricaoCurso obj : lista) {
							obj.setUltimoStatus(ultimoStatusInscricao(obj));
							for (Integer id : idsStatus) {
								if (obj.getUltimoStatus().getStatus().getId().equals(id)) {
									listaRetorno.add(obj);
									break;
								}
							}
						}
						return listaRetorno;
					}
				}
			} else if (dto.getIdSituacaoInscricao().equals(RelatorioCandidatoInscritoBean.LISTA_ESPERA)) {
				List<Integer> idsStatus = new ArrayList<Integer>();
				idsStatus.add(Status.AGUARDANDO_VAGA);
				idsStatus.add(Status.AGUARDANDO_VAGA_PRIORIDADE);
				idsStatus.add(Status.CONFIRMADO_PELO_CHEFE);

				criteria.createAlias("situacao", "s");
				criteria.add(Restrictions.eq("s.id", Situacao.ESPERA));
				criteria.createAlias("statusInscricoes", "st");
				criteria.createAlias("st.status", "status");
				criteria.add(Restrictions.in("status.id", idsStatus));
				// Usa desc, pois o id do prioritario é 13 e do normal é 11.
				// Depois ordena quem se inscreveu primeiro.
				criteria.addOrder(Order.desc("status.id")).addOrder(Order.asc("dtCadastro"));

				criteria.setProjection(Projections.property("id"));

				List<Integer> ids = new LinkedList<Integer>(criteria.list());

				if (ids != null && !ids.isEmpty()) {
					List<InscricaoCurso> listaRetorno = new ArrayList<InscricaoCurso>();
					for (Integer id : ids) {

						Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
						c2.add(Restrictions.eq("id", id));
						c2.setFetchMode("candidato", FetchMode.JOIN);

						InscricaoCurso inscricaoCurso = (InscricaoCurso) c2.uniqueResult();
						inscricaoCurso.setUltimoStatus(ultimoStatusInscricao(inscricaoCurso));
						for (Integer idStatus : idsStatus) {
							if (inscricaoCurso.getUltimoStatus().getStatus().getId().equals(idStatus)) {
								if (!listaRetorno.contains(inscricaoCurso)) {
									listaRetorno.add(inscricaoCurso);
									break;
								}
							}
						}

					}
					return listaRetorno;
				}
			}
		}

		return criteria.list();
	}
	
	public StatusInscricao ultimoStatusInscricao(InscricaoCurso inscricaoCurso) {
		// Pega ultimo Status
		Criteria cStatus = getSession().createCriteria(StatusInscricao.class);

		cStatus.createAlias("inscricaoCurso", "i");
		cStatus.add(Restrictions.eq("i.id", inscricaoCurso.getId()));
		cStatus.setProjection(Projections.max("id"));

		Integer id = (Integer) cStatus.uniqueResult();

		if (id != null) {
			return (StatusInscricao) getSession().get(StatusInscricao.class, id);
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public String recuperarCargoAtivo(Integer idCandidato) {
		Criteria criteria = getSession().createCriteria(CandidatoCargo.class);
		criteria.add(Restrictions.eq("candidato.id", idCandidato));
		criteria.createAlias("cargo", "c");
		criteria.add(Restrictions.eq("c.flgAtivo", Boolean.TRUE));
		criteria.addOrder(Order.desc("id"));
		List<CandidatoCargo> candidatoCargos = criteria.list();
		if (candidatoCargos != null && !candidatoCargos.isEmpty()) {
			return candidatoCargos.get(0).getCargo().getDescricao();
		} else {
			return "";
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Candidato> recuperarInstrutores(InscricaoCurso inscricaoCurso) {
		List<Candidato> listaRetorno = new ArrayList<Candidato>();
		Criteria criteria = getSession().createCriteria(GradeOficina.class);
		if (inscricaoCurso.getCandidato() != null && inscricaoCurso.getCandidato().getId() != null) {
			criteria.add(Restrictions.eq("candidato.id", inscricaoCurso.getCandidato().getId()));
		}
		if (inscricaoCurso.getTurma() != null && inscricaoCurso.getTurma().getId() != null) {
			criteria.add(Restrictions.eq("turma.id", inscricaoCurso.getTurma().getId()));
		}
		List<GradeOficina> gradeOficinas = criteria.list();
		if (gradeOficinas != null && !gradeOficinas.isEmpty()) {
			for (GradeOficina gradeOficina : gradeOficinas) {
				listaRetorno.add(gradeOficina.getProfessorEvento().getCandidato());
			}
			return listaRetorno;
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Candidato> pesquisarCandidato(String query) {
		if (query == null || query.isEmpty()) {
			return null;
		}
		String sql = "SELECT * FROM sisfie.candidato WHERE UPPER(SISFIE.sem_acento(nome)) ILIKE UPPER(SISFIE.sem_acento(\'%" + query
				+ "%\')) order by nome asc;";
		return getSession().createSQLQuery(sql).addEntity(Candidato.class).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Candidato> pesquisarCandidato(String query, String idCandidatos) {
		if (query == null || query.isEmpty()) {
			return null;
		}
		String sql = "SELECT * FROM sisfie.candidato WHERE UPPER(SISFIE.sem_acento(nome)) ILIKE UPPER(SISFIE.sem_acento(\'%" + query
				+ "%\')) and id_candidato in(" + idCandidatos + ") order by nome asc;";
		return getSession().createSQLQuery(sql).addEntity(Candidato.class).list();
	}

	@Override
	public Candidato recuperarCandidato(Integer idCandidato) {
		Criteria criteria = getSession().createCriteria(Candidato.class);
		criteria.add(Restrictions.idEq(idCandidato));
		return (Candidato) criteria.uniqueResult();
	}

	@Override
	public CandidatoComplemento recuperarCandidatoComplemento(Integer idCandidato) {
		Criteria criteria = getSession().createCriteria(CandidatoComplemento.class);
		criteria.add(Restrictions.eq("candidato.id", idCandidato));
		return (CandidatoComplemento) criteria.uniqueResult();
	}
}
