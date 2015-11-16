package br.com.sisfie.dataModel;

import java.util.List;

import javax.faces.model.ListDataModel;

import org.primefaces.model.SelectableDataModel;

import br.com.sisfie.entidade.OpcaoListaCandidato;

public class OpcaoDataModel extends ListDataModel<OpcaoListaCandidato> implements SelectableDataModel<OpcaoListaCandidato> {

	public OpcaoDataModel() {
	}

	public OpcaoDataModel(List<OpcaoListaCandidato> data) {
		super(data);
	}

	@Override
	public OpcaoListaCandidato getRowData(String rowKey) {

		List<OpcaoListaCandidato> lista = (List<OpcaoListaCandidato>) getWrappedData();

		for (OpcaoListaCandidato op : lista) {
			if (op.getId().equals(Integer.valueOf(rowKey)))
				return op;
		}

		return null;
	}

	@Override
	public Object getRowKey(OpcaoListaCandidato op) {
		return op.getId();
	}
}