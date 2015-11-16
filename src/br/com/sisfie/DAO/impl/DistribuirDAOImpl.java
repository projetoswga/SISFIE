package br.com.sisfie.DAO.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.hibernate.Criteria;
import org.hibernate.Hibernate;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Order;
import org.hibernate.criterion.Projections;
import org.hibernate.criterion.Restrictions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.orm.hibernate3.support.HibernateDaoSupport;
import org.springframework.stereotype.Repository;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.DistribuirDAO;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.DistribuicaoSofGrade;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.SelecaoOficina;
import br.com.sisfie.entidade.SelecaoPacote;

@Repository(value = "distribuirDAO")
public class DistribuirDAOImpl extends HibernateDaoSupport implements DistribuirDAO {

	@Autowired(required = true)
	public void setFactory(SessionFactory factory) {
		super.setSessionFactory(factory);
	}

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("unchecked")
	@Override
	public List<SelecaoOficina> carregarOficinas(InscricaoCurso inscricaoCurso) throws Exception {
		Criteria c = getSession().createCriteria(SelecaoOficina.class);

		c.createAlias("inscricaoCurso", "ic");

		c.add(Restrictions.eq("ic.id", inscricaoCurso.getId()));
		// TODO detectado que haviam selecaooficina duplicados, então foi necessário ordernar pelo ID
		c.addOrder(Order.asc("id"));
		// c.addOrder(Order.asc("numOrdemSelecao"));
		return c.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	/**
	 * Devolve uma lista ordenada pela sala que possui mais vagas disponiveis. A
	 * lista irá conter somente as salar que tenham capacidade.
	 * 
	 * @param gradeOficinas
	 * @return
	 * @throws Exception
	 */
	public List<GradeOficina> carregarGradeOficinas(Oficina oficina) throws Exception {
		Criteria c = getSession().createCriteria(GradeOficina.class);

		c.createAlias("oficina", "o");

		c.add(Restrictions.eq("o.id", oficina.getId()));

		List<GradeOficina> lista = c.list();

		// Descobre a turma que te menos aluno.
		return gradeValida(lista);
	}

	/**
	 * Devolve uma lista ordenada pela sala que possui mais vagas disponiveis. A lista irá conter somente as salar que tenham capacidade.
	 * 
	 * @param gradeOficinas
	 * @return
	 * @throws Exception
	 */
	private List<GradeOficina> gradeValida(List<GradeOficina> gradeOficinas) throws Exception {

		List<GradeOficina> listRetorno = new ArrayList<GradeOficina>();

		for (GradeOficina item : gradeOficinas) {
			Long vagasDisponivel = quantidadeDisponivelSala(item);
			// So coloca na lista turmas que tenha capacidade
			if (vagasDisponivel > 0) {
				item.setVagasDisponiveis(vagasDisponivel);
				listRetorno.add(item);
			}
		}

		Collections.sort(listRetorno, new Comparator<GradeOficina>() {

			@Override
			public int compare(GradeOficina o1, GradeOficina o2) {
				return o2.getVagasDisponiveis().compareTo(o1.getVagasDisponiveis());
			}
		});

		return listRetorno;
	}

	/**
	 * Devolve a quantidade disponivel naquela sala
	 * 
	 * @param gradeOficinas
	 * @return
	 * @throws Exception
	 */
	private Long quantidadeDisponivelSala(GradeOficina gradeOficinas) throws Exception {

		Long quantidadeInscritos = quantidadeInscritosSala(gradeOficinas);

		if (quantidadeInscritos == null) {
			quantidadeInscritos = 0l;
		}

		return gradeOficinas.getSala().getNumCapacidade().longValue() - quantidadeInscritos;

	}

	@Override
	public Long quantidadeInscritosSala(GradeOficina gradeOficinas) throws Exception {
		Criteria c = getSession().createCriteria(DistribuicaoSofGrade.class);

		c.createAlias("gradeOficina", "g");

		c.add(Restrictions.eq("g.id", gradeOficinas.getId()));

		c.setProjection(Projections.rowCount());

		return (Long) c.list().get(0);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<InscricaoCurso> carregarInscritosOficinas(Curso curso) throws Exception {
		Criteria c = getSession().createCriteria(SelecaoOficina.class);
		c.createAlias("oficina", "o");
		c.createAlias("o.curso", "c");
		c.createAlias("inscricaoCurso", "i");
		c.add(Restrictions.eq("c.id", curso.getId()));
		c.setProjection(Projections.distinct(Projections.property("i.id")));

		List<Integer> ids = c.list();

		if (ids != null && !ids.isEmpty()) {
			Criteria c2 = getSession().createCriteria(InscricaoCurso.class);
			c2.add(Restrictions.in("id", ids));
			c2.addOrder(Order.asc("dtCadastro"));
			return c2.list();
		} else {
			return null;
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<SelecaoPacote> carregarPacotes(InscricaoCurso inscricaoCurso) {
		Criteria c = getSession().createCriteria(SelecaoPacote.class);

		c.createAlias("inscricaoCurso", "ic");

		c.add(Restrictions.eq("ic.id", inscricaoCurso.getId()));
		c.createAlias("pacote", "p");
		c.createAlias("p.pacoteOficinas", "po");
		c.addOrder(Order.asc("po.id"));

		return c.list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<DistribuicaoSofGrade> recuperarDistribuicao(Curso curso) {
		Criteria c = getSession().createCriteria(DistribuicaoSofGrade.class);
		c.createAlias("selecaoOficina", "so");
		c.createAlias("so.inscricaoCurso", "ic");
		c.createAlias("ic.curso", "c");
		c.add(Restrictions.eq("c.id", curso.getId()));
		List<DistribuicaoSofGrade> listaRetorno = c.list();
		for (DistribuicaoSofGrade distribuicaoSofGrade : listaRetorno) {
			Hibernate.initialize(distribuicaoSofGrade.getSelecaoOficina());
			Hibernate.initialize(distribuicaoSofGrade.getSelecaoOficina().getInscricaoCurso());
			Hibernate.initialize(distribuicaoSofGrade.getSelecaoOficina().getInscricaoCurso().getCandidato());
		}
		return listaRetorno;
	}

	@SuppressWarnings("unchecked")
	public List<Integer> devolveGradesPorCursoOficinaDescTurma(Integer idCurso, Integer idOficina, String descTurma) {
		Pattern p = Pattern.compile("-?\\d+");
		Matcher m = p.matcher(descTurma);
		while (m.find()) {
			descTurma = m.group();
		}

		StringBuffer sb = new StringBuffer();
		sb.append("select go.id_grade_oficina ");
		sb.append("from grade_oficina go, turma t, horario h, oficina o ");
		sb.append("where go.id_oficina = ").append(idOficina);
		sb.append(" and t.id_turma = go.id_turma ");
		sb.append(" and h.id_horario = go.id_horario ");
		sb.append(" and h.id_curso = ").append(idCurso);
		sb.append(" and o.id_oficina = go.id_oficina ");
		sb.append(" and CAST(SUBSTRING(T.descricao,1,length(T.descricao)-1) AS integer)  = CAST(").append(descTurma)
				.append(" AS integer) ");

		return getSession().createSQLQuery(sb.toString()).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> gerarArquivoEventoFrequencia(Integer idCurso) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select CAST(c.id_curso as text), c.titulo, to_char(c.dt_realizacao_inicio, 'dd/MM/yyyy') as dtInicio, to_char(c.dt_realizacao_fim, 'dd/MM/yyyy') as dtFim ");
		sb.append(" from curso c ");
		sb.append(" where c.id_curso = " + idCurso);
		return getSession().createSQLQuery(sb.toString()).list();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Object> gerarArquivoTurmasFrequencia(Integer idCurso) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select o.nom_oficina, CAST(s.num_capacidade as text) as numCapacidade, prof.nome as instrutor, t.descricao as turma, s.des_localizacao,  CAST(go.id_grade_oficina as text) as idGrade ");
		sb.append(" from grade_oficina go, oficina o, sala s, professor_evento pe, candidato prof, turma t ");
		sb.append(" where ");
		sb.append(" exists (select 1 from distribuicao_sof_grade dsg where dsg.id_grade_oficina = go.id_grade_oficina) ");
		sb.append(" and go.id_oficina = o.id_oficina ");
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
		sb.append(" select ic.num_inscricao, org.nom_orgao, org.sgl_orgao, c.nome,  CAST(go.id_grade_oficina as text) as idGrade ");
		sb.append(" from distribuicao_sof_grade dsg, grade_oficina go, selecao_oficina so, oficina o, inscricao_curso ic, candidato c, turma t, orgao org ");
		sb.append(" where dsg.id_grade_oficina = go.id_grade_oficina ");
		sb.append(" and dsg.id_selecao_oficina = so.id_selecao_oficina ");
		sb.append(" and dsg.ind_conflito = false ");
		sb.append(" and so.id_oficina = o.id_oficina ");
		sb.append(" and go.id_turma = t.id_turma ");
		sb.append(" and o.id_curso = " + idCurso);
		sb.append(" and ic.id_inscricao_curso = so.id_inscricao_curso ");
		sb.append(" and c.id_candidato = ic.id_candidato ");
		sb.append(" and c.id_orgao_divisao = org.id_orgao ");
		sb.append(" and exists (select 1 from status_inscricao sc where sc.id_inscricao_curso = ic.id_inscricao_curso and sc.id_status = 3) ");
		sb.append(" order by ic.num_inscricao ");
		return getSession().createSQLQuery(sb.toString()).list();
	}
}
