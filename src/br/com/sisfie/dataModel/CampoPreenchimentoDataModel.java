package br.com.sisfie.dataModel;

import java.util.List;

import javax.faces.model.ListDataModel;

import org.primefaces.model.SelectableDataModel;

import br.com.sisfie.entidade.CampoPreenchimento;

public class CampoPreenchimentoDataModel extends ListDataModel<CampoPreenchimento> implements SelectableDataModel<CampoPreenchimento> {

	public CampoPreenchimentoDataModel() {
	}

	public CampoPreenchimentoDataModel(List<CampoPreenchimento> data) {
		super(data);
	}

	@Override
	public CampoPreenchimento getRowData(String rowKey) {

		List<CampoPreenchimento> lista = (List<CampoPreenchimento>) getWrappedData();

		for (CampoPreenchimento obj : lista) {
			if (obj.getId().equals(Integer.valueOf(rowKey)))
				return obj;
		}

		return null;
	}

	@Override
	public Object getRowKey(CampoPreenchimento obj) {
		return obj.getId();
	}
}