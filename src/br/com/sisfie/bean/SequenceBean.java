package br.com.sisfie.bean;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.model.SelectItem;

import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.service.SequenceService;

@ManagedBean(name = "sequenceBean")
@ViewScoped
public class SequenceBean implements Serializable {

	private static final long serialVersionUID = 1L;

	@ManagedProperty(value = "#{sequenceService}")
	private SequenceService sequenceService;

	private List<SelectItem> lista = new ArrayList<SelectItem>();
	private String total;

	public void organizarSequence() {
		try {
			lista = sequenceService.organizarSequence();
			total = new Integer(lista.size()).toString();
			FacesMessagesUtil.addInfoMessage("Sequence ", " Organizada com sucesso");
		} catch (IllegalArgumentException e) {
			FacesMessagesUtil.addFatalMessage("ERRO ",e.getMessage());
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage("ERRO  ", " Ao organizar sequence");
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public SequenceService getSequenceService() {
		return sequenceService;
	}

	public void setSequenceService(SequenceService sequenceService) {
		this.sequenceService = sequenceService;
	}

	public List<SelectItem> getLista() {
		return lista;
	}

	public void setLista(List<SelectItem> lista) {
		this.lista = lista;
	}

	public String getTotal() {
		return total;
	}

	public void setTotal(String total) {
		this.total = total;
	}

}
