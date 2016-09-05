package br.com.sisfie.service.impl;

import java.util.Calendar;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.DAO.FrequenciaDAO;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Turno;
import br.com.sisfie.service.FrequenciaService;

@Service(value = "frequenciaService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class FrequenciaServiceImpl implements FrequenciaService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "frequenciaDAO")
	protected FrequenciaDAO frequenciaDAO;

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarListaFrequencia(List<Frequencia> listaFrequencias) throws Exception {
		for (Frequencia frequencia : listaFrequencias) {
			dao.save(frequencia);
		}
	}

	public UniversalDAO getDao() {
		return dao;
	}

	public void setDao(UniversalDAO dao) {
		this.dao = dao;
	}

	public FrequenciaDAO getFrequenciaDAO() {
		return frequenciaDAO;
	}

	public void setFrequenciaDAO(FrequenciaDAO frequenciaDAO) {
		this.frequenciaDAO = frequenciaDAO;
	}

	@Override
	public Frequencia recuperarUltimaFrequencia(String inscricao) {
		return frequenciaDAO.recuperarUltimaFrequencia(inscricao);
	}

	@Override
	public List<Frequencia> listarFrequencias(Integer idGradeOficina) throws Exception {
		return frequenciaDAO.listarFrequencias(idGradeOficina);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvar(Frequencia frequencia) throws Exception {
		dao.save(frequencia);
	}

	@Override
	public List<Frequencia> pesquisarFrequenciasAbertas(Integer idGradeOficina) {
		return frequenciaDAO.pesquisarFrequenciasAbertas(idGradeOficina);
	}

	@Override
	public List<Frequencia> listarFrequenciasSemOficina(List<InscricaoCurso> listaInscricaoCurso) {
		return frequenciaDAO.listarFrequenciasSemOficina(listaInscricaoCurso);
	}

	@Override
	public List<Frequencia> pesquisarFrequenciasAbertasSemOficina(Integer idInscricaoCurso) {
		return frequenciaDAO.pesquisarFrequenciasAbertasSemOficina(idInscricaoCurso);
	}

	@Override
	public List<Frequencia> pesquisarFrequenciasData(String inscricao, Calendar datFrequencia) {
		return frequenciaDAO.pesquisarFrequenciasData(inscricao, datFrequencia);
	}

	@Override
	public List<Frequencia> carregarFrequencias(Integer idCurso) {
		return frequenciaDAO.carregarFrequencias(idCurso);
	}

	@Override
	public boolean carregarListas(List<InscricaoCurso> listaInscricoesAprovadas,
			List<InscricaoCurso> listaInscricoesReprovadas, List<Curso> listaArquivosFrequencia,
			List<InscricaoCurso> listaCandidatoConfirmados, Curso curso) throws Exception {
		
		if (curso.getNomeArquivoFrequencia() != null && !curso.getNomeArquivoFrequencia().isEmpty()) {
			listaArquivosFrequencia.add(curso);
		}

		int cargaHorariaCurso = 0;

		if (curso.getFlgPossuiOficina()) {
			if(curso.getCargaHoraria()==null){
				throw new Exception("O curso Não possui carga horária definida.Preencha o campo em Gerenciar Curso.");
			}
			cargaHorariaCurso = curso.getCargaHoraria();
		} else {
			Calendar inicioCurso = Calendar.getInstance();
			inicioCurso.setTime(curso.getDtRealizacaoInicio());

			Calendar fimCurso = Calendar.getInstance();
			fimCurso.setTime(curso.getDtRealizacaoFim());

			int qtdDiasCurso = fimCurso.get(Calendar.DAY_OF_YEAR) - inicioCurso.get(Calendar.DAY_OF_YEAR);
			cargaHorariaCurso = qtdDiasCurso * 8;

			if (curso.getTurno() != null && curso.getTurno().getId() != null && !curso.getTurno().getId().equals(Turno.AMBOS)) {
				cargaHorariaCurso /= 2;
			}
		}

		if (curso.getPorcentagem() == null) {
			FacesMessagesUtil.addErrorMessage("",
					"É necessário informar um percentual de frequência para aprovação na edição do curso.");
			return false;
		}

		Integer porcentagemAprovacao = cargaHorariaCurso * curso.getPorcentagem() / 100;

		for (InscricaoCurso inscricaoCurso : listaCandidatoConfirmados) {

			long diferencaEmMinutos = 0;
			for (Frequencia frequencia : inscricaoCurso.getFrequencias()) {
				if (frequencia.getHorarioSaida() == null) {
					FacesMessagesUtil.addErrorMessage("", "Exite candidato com registro de frequência não finalizada.");
					return false;
				}
				diferencaEmMinutos += ((frequencia.getHorarioSaida().getTime() - frequencia.getHorarioEntrada().getTime())
						/ (60 * 1000)) + 1;
			}

			long horas = diferencaEmMinutos / 60;
			long minutosRestantes = diferencaEmMinutos % 60;
			inscricaoCurso.setTotalFrequencia(String.format("%d:%02d", horas, minutosRestantes));

			// Caso tenha alguma aprovação ou reprovação
			if (inscricaoCurso.getStatus() != null) {
				inscricaoCurso.setTotalFrequencia(
						String.format("%s (%s)", inscricaoCurso.getTotalFrequencia(), "Alterado pelo gestor"));
				if (inscricaoCurso.getStatus().equals(Frequencia.APROVADO)) {
					listaInscricoesAprovadas.add(inscricaoCurso);
				} else if (inscricaoCurso.getStatus().equals(Frequencia.REPROVADO)) {
					listaInscricoesReprovadas.add(inscricaoCurso);
				}
				continue;
			}

			if (horas >= porcentagemAprovacao) {
				listaInscricoesAprovadas.add(inscricaoCurso);
			} else {
				listaInscricoesReprovadas.add(inscricaoCurso);
			}
		}
		return true;
	}

	@Override
	public Frequencia recuperarPorId(Integer id) {
		return frequenciaDAO.recuperarPorId(id);
	}
}
