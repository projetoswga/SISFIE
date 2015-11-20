package br.com.sisfie.DAO.impl;

import java.util.List;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.ProjectionList;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.GradeOficinaDAO;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.InscricaoGrade;

@Repository(value = "gradeOficinaDAO")
public class GradeOficinaDAOImpl extends HibernateDaoSupport implements GradeOficinaDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Override
	public Long verificarRestricoes(GradeOficina model) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select count(*) from GradeOficina go where");
		// Quando for edição remove-se o próprio registro
		if (model.getId() != null && !model.getId().equals(0)) {
			sql.append(" go.id not in(" + model.getId() + ") and");
		}
		sql.append(" ((go.horario.id = " + model.getHorario().getId());
		sql.append(" and go.professorEvento.id = " + model.getProfessorEvento().getId() + ") or");
		sql.append(" (go.horario.id = " + model.getHorario().getId());
		sql.append(" and go.sala.id = " + model.getSala().getId() + ") or");
		sql.append(" (go.horario.id = " + model.getHorario().getId());
		sql.append(" and go.turma.id = " + model.getTurma().getId() + "))");
		return (Long) getSession().createQuery(sql.toString()).uniqueResult();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<GradeOficina> listarGradeOficinas(Integer idCurso) throws Exception {
		Criteria criteria = getSession().createCriteria(GradeOficina.class);
		criteria.createAlias("oficina", "o");
		criteria.createAlias("o.curso", "c");
		criteria.add(Restrictions.eq("c.id", idCurso));
		criteria.addOrder(Order.asc("o.nomOficina"));
		return criteria.list();
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public List<Object> gerarArquivoEventoFrequencia(Integer idCurso) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select CAST(c.id_curso as text), c.titulo, to_char(c.dt_realizacao_inicio, 'dd/MM/yyyy') as dtInicio, to_char(c.dt_realizacao_fim, 'dd/MM/yyyy') as dtFim, l.den_localizacao ");
		sb.append(" from curso c, localizacao l ");
		sb.append(" where c.id_curso = " + idCurso);
		sb.append(" and c.id_localizacao = l.id_localizacao");
		return getSession().createSQLQuery(sb.toString()).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> gerarArquivoTurmasFrequencia(Integer idCurso) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select o.nom_oficina, CAST(s.num_capacidade as text) as numCapacidade, prof.nome as instrutor, t.descricao as turma, s.des_localizacao,  CAST(go.id_grade_oficina as text) as idGrade, h.des_horario as horario, CAST(o.id_curso as text) ");
		sb.append(" from grade_oficina go, oficina o, sala s, professor_evento pe, candidato prof, turma t, horario h ");
		sb.append(" where ");
		sb.append(" exists (select 1 from inscricao_grade ig where ig.id_grade_oficina = go.id_grade_oficina) ");
		sb.append(" and go.id_oficina = o.id_oficina ");
		sb.append(" and go.id_horario = h.id_horario ");
		sb.append(" and go.id_sala = s.id_sala ");
		sb.append(" and go.id_professor_evento = pe.id_professor_evento ");
		sb.append(" and prof.id_candidato = pe.id_candidato ");
		sb.append(" and go.id_turma = t.id_turma ");
		sb.append(" and o.id_curso = " + idCurso);
		return getSession().createSQLQuery(sb.toString()).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> gerarArquivoParticipantesFrequencia(Integer idCurso) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select distinct(ic.num_inscricao), org.nom_orgao, org.sgl_orgao, c.nome,  CAST(go.id_grade_oficina as text) as idGrade ");
		sb.append(" from inscricao_grade ig, grade_oficina go, oficina o, inscricao_curso ic, candidato c, turma t, orgao org ");
		sb.append(" where ig.id_grade_oficina = go.id_grade_oficina ");
		sb.append(" and ig.id_inscricao_curso = ic.id_inscricao_curso ");
		sb.append(" and go.id_turma = t.id_turma ");
		sb.append(" and go.id_oficina = o.id_oficina ");
		sb.append(" and o.id_curso = " + idCurso);
		sb.append(" and c.id_candidato = ic.id_candidato ");
		sb.append(" and c.id_orgao_divisao = org.id_orgao ");
		sb.append(" and ic.id_ultimo_status_inscricao in (select sc.id_status_inscricao from status_inscricao sc where sc.id_inscricao_curso = ic.id_inscricao_curso and sc.id_status = 3) ");
		sb.append(" order by ic.num_inscricao ");
		return getSession().createSQLQuery(sb.toString()).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoGrade> listarInscricaoGrades(Integer idCurso, List<Integer> idsCandidatosConfirmados) {
		Criteria criteria = getSession().createCriteria(InscricaoGrade.class);
		criteria.createAlias("inscricaoCurso", "ic");
		criteria.createAlias("ic.curso", "c");
		criteria.add(Restrictions.eq("c.id", idCurso));
		if (idsCandidatosConfirmados != null && !idsCandidatosConfirmados.isEmpty()){
			criteria.add(Restrictions.in("ic.id", idsCandidatosConfirmados));
		}
		List<InscricaoGrade> listaRetorno = criteria.list();
		
		if (listaRetorno != null && !listaRetorno.isEmpty()){
			for (InscricaoGrade inscricaoGrade : listaRetorno) {
				Hibernate.initialize(inscricaoGrade.getInscricaoCurso());
				Hibernate.initialize(inscricaoGrade.getInscricaoCurso().getCandidato());
			}
			return listaRetorno;
		} 
		return null;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Integer recuperarCapacidadeMaximaInscritos(Integer idCurso) {
		Criteria criteria = getSession().createCriteria(GradeOficina.class);
		criteria.createAlias("oficina", "o");
		criteria.createAlias("o.curso", "c");
		criteria.createAlias("sala", "s");
		criteria.createAlias("horario", "h");
		criteria.add(Restrictions.eq("c.id", idCurso));
		ProjectionList projectionList = Projections.projectionList();
		projectionList.add(Projections.sum("s.numCapacidade"), "capacidade");
		projectionList.add(Projections.groupProperty("h.id"));
		criteria.setProjection(projectionList);
		criteria.addOrder(Order.asc("capacidade"));
		List<Object []> listaCapacidadePorHorario = criteria.list();
		if (listaCapacidadePorHorario != null && !listaCapacidadePorHorario.isEmpty()){
			return Integer.parseInt(listaCapacidadePorHorario.get(0)[0].toString());
		}
		return null;
	}

	@Override
	public GradeOficina recupararGradeOficina(Integer idCurso, Integer idTurma, Integer idHorario) {
		Criteria criteria = getSession().createCriteria(GradeOficina.class);
		criteria.createAlias("turma", "t");
		criteria.createAlias("t.curso", "c");
		criteria.add(Restrictions.eq("c.id", idCurso));
		criteria.add(Restrictions.eq("t.id", idTurma));
		criteria.createAlias("horario", "h");
		criteria.add(Restrictions.eq("h.id", idHorario));
		return (GradeOficina) criteria.uniqueResult();
	}
}
