package br.com.sisfie.dataModel;

import java.util.List;

import javax.faces.model.ListDataModel;

import org.primefaces.model.SelectableDataModel;

import br.com.sisfie.entidade.Homologacao;

public class HomologacaoDataModel extends ListDataModel<Homologacao> implements SelectableDataModel<Homologacao> {

	public HomologacaoDataModel() {
	}

	public HomologacaoDataModel(List<Homologacao> data) {
		super(data);
	}

	@Override
	public Homologacao getRowData(String rowKey) {

		List<Homologacao> lista = (List<Homologacao>) getWrappedData();

		for (Homologacao obj : lista) {
			if (obj.getId().equals(Integer.valueOf(rowKey)))
				return obj;
		}

		return null;
	}

	@Override
	public Object getRowKey(Homologacao obj) {
		return obj.getId();
	}
}