package br.com.sisfie.dataModel;

import java.util.List;

import javax.faces.model.ListDataModel;

import org.primefaces.model.SelectableDataModel;

import br.com.sisfie.entidade.EsferaGoverno;

public class EsferaGovernoDataModel extends ListDataModel<EsferaGoverno> implements SelectableDataModel<EsferaGoverno> {

	public EsferaGovernoDataModel() {
	}

	public EsferaGovernoDataModel(List<EsferaGoverno> data) {
		super(data);
	}

	@Override
	public EsferaGoverno getRowData(String rowKey) {

		List<EsferaGoverno> lista = (List<EsferaGoverno>) getWrappedData();

		for (EsferaGoverno obj : lista) {
			if (obj.getId().equals(Integer.valueOf(rowKey)))
				return obj;
		}

		return null;
	}

	@Override
	public Object getRowKey(EsferaGoverno obj) {
		return obj.getId();
	}
}