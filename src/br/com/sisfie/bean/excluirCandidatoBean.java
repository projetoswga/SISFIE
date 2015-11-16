package br.com.sisfie.bean;

import java.util.List;
import java.util.Map;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import org.primefaces.model.LazyDataModel;
import org.primefaces.model.SortOrder;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.dto.CandidatoDTO;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.service.CandidatoService;

@ManagedBean(name = "excluirCandidatoBean")
@ViewScoped
public class excluirCandidatoBean extends PaginableBean<Candidato> {

	private static final long serialVersionUID = -824400653648583655L;

	@ManagedProperty(value = "#{candidatoService}")
	protected CandidatoService candidatoService;

	private CandidatoDTO dto;
	private Candidato candidatoSelect;
	private boolean solicitarPesquisa;
	private int rowCount;

	public excluirCandidatoBean() {
		dto = new CandidatoDTO();
	}

	public void pesquisar() {
		try {
			solicitarPesquisa = Boolean.TRUE;
			getLazyDataModel();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@Override
	public LazyDataModel<Candidato> getLazyDataModel() {
		if (lazyDataModel == null && solicitarPesquisa)
			
		lazyDataModel = new LazyDataModel<Candidato>() {

			private static final long serialVersionUID = -3128388997477577261L;

			@SuppressWarnings("rawtypes")
			@Override
			public List<Candidato> load(int first, int pageSize, String sortField, SortOrder sortOrder, Map filters) {
				// Reduzindo o contador depois de filtrado
				try {
					rowCount = candidatoService.countCandidato(dto).intValue();
					lazyDataModel.setRowCount(rowCount);
					List<Candidato> list = candidatoService.paginateCandidato(first, pageSize, dto);
					return list;
				} catch (Exception e) {
					ExcecaoUtil.tratarExcecao(e);
				}
				return null;
			}
		};
		solicitarPesquisa = Boolean.FALSE;
		return lazyDataModel;
	}

	public void limparCampoPesquisa() {
		if (dto.getNacionalidadeBrasil()) {
			dto.setDocEstrangeiro(null);
		} else {
			dto.setCpf(null);
		}
	}
	
	public void excluirCandidato(){
		try {
			candidatoService.excluirCandidato(candidatoSelect);
			FacesMessagesUtil.addInfoMessage("Exclusão de Candidato", "Candidato Excluído com sucesso!");
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("Exclusão de Candidato", "Erro ao tentar excluir o candidato!");
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {
	}

	@Override
	public Candidato createModel() {
		return new Candidato();
	}

	@Override
	public String getQualifiedName() {
		return "Candidato";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public CandidatoService getCandidatoService() {
		return candidatoService;
	}

	public void setCandidatoService(CandidatoService candidatoService) {
		this.candidatoService = candidatoService;
	}

	public CandidatoDTO getDto() {
		return dto;
	}

	public void setDto(CandidatoDTO dto) {
		this.dto = dto;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public int getRowCount() {
		return rowCount;
	}

	public void setRowCount(int rowCount) {
		this.rowCount = rowCount;
	}

	public Candidato getCandidatoSelect() {
		return candidatoSelect;
	}

	public void setCandidatoSelect(Candidato candidatoSelect) {
		this.candidatoSelect = candidatoSelect;
	}

	public boolean isSolicitarPesquisa() {
		return solicitarPesquisa;
	}

	public void setSolicitarPesquisa(boolean solicitarPesquisa) {
		this.solicitarPesquisa = solicitarPesquisa;
	}
}
