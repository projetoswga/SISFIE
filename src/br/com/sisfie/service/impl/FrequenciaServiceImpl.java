package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.FrequenciaDAO;
import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.InscricaoCurso;
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
	public List<Frequencia> listarFrequencias(Integer idGradeOficina) throws Exception  {
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
	public List<Frequencia> listarFrequenciasSemOficina(InscricaoCurso inscricaoCurso) {
		return frequenciaDAO.listarFrequenciasSemOficina(inscricaoCurso);
	}

	@Override
	public List<Frequencia> pesquisarFrequenciasAbertasSemOficina(Integer idInscricaoCurso) {
		return frequenciaDAO.pesquisarFrequenciasAbertasSemOficina(idInscricaoCurso);
	}
}
