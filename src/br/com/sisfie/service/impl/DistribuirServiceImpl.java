package br.com.sisfie.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.CursoDAO;
import br.com.sisfie.DAO.DistribuirDAO;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.DistribuicaoSofGrade;
import br.com.sisfie.entidade.GradeOficina;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.SelecaoOficina;
import br.com.sisfie.excecao.DistribuicaoException;
import br.com.sisfie.service.DistribuirService;

@Service(value = "distribuirService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class DistribuirServiceImpl implements DistribuirService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "distribuirDAO")
	protected DistribuirDAO distribuirDAO;

	@Autowired(required = true)
	@Qualifier(value = "CursoDAO")
	protected CursoDAO cursoDAO;

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void distrbuirInscritos(Curso curso) throws Exception {
		// Carrega lista de inscritos, ordenado por data de cadastro
		// List<InscricaoCurso> listaInscrito = distribuirDAO.carregarInscritosOficinas(curso);
		List<InscricaoCurso> listaInscrito = cursoDAO.carregarListaCandidatoConfirmados(curso);

		// Percorre o candidato fazendo as inscrições nas oficinas caso exista inscrições.
		if (listaInscrito != null && !listaInscrito.isEmpty()) {
			
			final long DAY_IN_MILLIS = 1000 * 60 * 60 * 24;
			int diffInDays = (int) ((curso.getDtRealizacaoFim().getTime() - curso.getDtRealizacaoInicio().getTime())/ DAY_IN_MILLIS );
			int qtdCargaHorarioCurso = ((diffInDays + 1) * 8) - 4;
			
			for (InscricaoCurso inscricaoCurso : listaInscrito) {
				
				int numCargaHorarioTotal = 0;
				List<DistribuicaoSofGrade> listaDistribuicaoGrade = new ArrayList<DistribuicaoSofGrade>();

				// Recupera as oficinas escolhidas do candidato pela order de
				// preferencia.
				List<SelecaoOficina> selecaoOficinas = distribuirDAO.carregarOficinas(inscricaoCurso);

				if (selecaoOficinas == null || selecaoOficinas.isEmpty()) {
					throw new DistribuicaoException("Existe candidato com inscrição sem seleção de oficinas ou pacotes.");
				}
				
				loop_sel_ofic: for (SelecaoOficina selecaoOficina : selecaoOficinas) {

					// Pega as turmas daquela oficina.
					// Organizadas por turmar que tenha a maior quantidade de vagas.
					List<GradeOficina> gradeOficinas = distribuirDAO.carregarGradeOficinas(selecaoOficina.getOficina());

					if (gradeOficinas == null || gradeOficinas.isEmpty()) {
						continue loop_sel_ofic;
						//throw new DistribuicaoException("Não é possível realizar a distribuição sem uma grade de oficina: "
								//+ selecaoOficina.getOficina().getId());
					}

					// Coloca o candidato em uma turma.
					if (gradeOficinas != null && !gradeOficinas.isEmpty()) {
						GradeOficina go = gradeOficinas.get(0);
						List<Integer> idsGradesMesmaTurmaPorNomeDaTurma = distribuirDAO.devolveGradesPorCursoOficinaDescTurma(go
								.getOficina().getCurso().getId(), go.getOficina().getId(), go.getTurma().getDescricao());

						for (Integer id : idsGradesMesmaTurmaPorNomeDaTurma) {
							DistribuicaoSofGrade distribuicaoSofGrade = new DistribuicaoSofGrade();
							// Pega a grade com mais vagas disponivels
							distribuicaoSofGrade.setGradeOficina((GradeOficina) dao.get(GradeOficina.class, id));
							distribuicaoSofGrade.setSelecaoOficina(selecaoOficina);
							listaDistribuicaoGrade.add(distribuicaoSofGrade);

							numCargaHorarioTotal += 4;

							if (numCargaHorarioTotal >= qtdCargaHorarioCurso)
								break loop_sel_ofic;
						}
					}
				}

				// Verifica Conflitos.
				for (DistribuicaoSofGrade dsg : listaDistribuicaoGrade) {

					boolean conflito = existeConflito(dsg, listaDistribuicaoGrade);

					if (conflito) {

						// Tenta resolver o conflito.
						boolean resolveuConflito = resolverConflito(dsg, listaDistribuicaoGrade);

						if (!resolveuConflito) {
							dsg.setIndConflito(true);
						}

					}
					dao.merge(dsg);
				}
			}
		} else {
			throw new DistribuicaoException("Existe(m) candidato(s) sem seleção de oficinas/pacotes.");
		}
	}

	/**
	 * 
	 * @param distribuicaoa
	 * @param listaDistribuicaoGrade
	 * @return TRUE- CONFLITO RESOLVIDO. FALSE - CONFLITO NÂO RESOLVIDO.
	 * @throws Exception
	 */
	private boolean resolverConflito(DistribuicaoSofGrade distribuicaoa, List<DistribuicaoSofGrade> listaDistribuicaoGrade)
			throws Exception {

		// Verifica se a turma A tem outra turma disponivel
		List<GradeOficina> gradeOficinasA = distribuirDAO.carregarGradeOficinas(distribuicaoa.getGradeOficina().getOficina());

		for (GradeOficina grade : gradeOficinasA) {
			if (grade.getId().equals(distribuicaoa.getGradeOficina().getId())) {
				continue;
			} else {
				// Cria o Objeto para verificar Conflitos novos.
				DistribuicaoSofGrade aux = (DistribuicaoSofGrade) distribuicaoa.clone();
				aux.setGradeOficina(grade);

				// Verifica se o proximo horario vai dar conflito
				boolean conflito = existeConflito(aux, listaDistribuicaoGrade);

				if (!conflito) {
					// Resolveu o conflito.
					distribuicaoa.setGradeOficina(grade);
					return true;
				}
			}
		}

		return false;

	}

	private Boolean existeConflito(DistribuicaoSofGrade distribuicao, List<DistribuicaoSofGrade> lista) throws Exception {
		DistribuicaoSofGrade item;
		for (int z = lista.size() - 1; z > -1; z--) {
			item = lista.get(z);

			// Feito para não retorna o mesmo Objeto
			if (distribuicao.equals(item)) {
				continue;
			} else if (!item.getIndConflito()
					&& item.getGradeOficina().getHorario().getId().equals(distribuicao.getGradeOficina().getHorario().getId())) {
				return true;
			}
		}
		return false;
	}

	@Override
	public List<DistribuicaoSofGrade> recuperarDistribuicao(Curso curso) {
		return distribuirDAO.recuperarDistribuicao(curso);
	}

	@Override
	public List<Object> gerarArquivoEventoFrequencia(Integer idCurso) {
		return distribuirDAO.gerarArquivoEventoFrequencia(idCurso);
	}

	@Override
	public List<Object> gerarArquivoTurmasFrequencia(Integer idCurso) {
		return distribuirDAO.gerarArquivoTurmasFrequencia(idCurso);
	}

	@Override
	public List<Object> gerarArquivoParticipantesFrequencia(Integer idCurso) {
		return distribuirDAO.gerarArquivoParticipantesFrequencia(idCurso);
	}
}
