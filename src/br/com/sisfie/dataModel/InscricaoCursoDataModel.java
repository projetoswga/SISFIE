package br.com.sisfie.dataModel;

import java.util.List;

import javax.faces.model.ListDataModel;

import org.primefaces.model.SelectableDataModel;

import br.com.sisfie.entidade.InscricaoCurso;

public class InscricaoCursoDataModel extends ListDataModel<InscricaoCurso> implements SelectableDataModel<InscricaoCurso> {

	public InscricaoCursoDataModel() {
	}

	public InscricaoCursoDataModel(List<InscricaoCurso> data) {
		super(data);
	}

	@Override
	public InscricaoCurso getRowData(String rowKey) {

		List<InscricaoCurso> lista = (List<InscricaoCurso>) getWrappedData();

		for (InscricaoCurso op : lista) {
			if (op.getId().equals(Integer.valueOf(rowKey)))
				return op;
		}

		return null;
	}

	@Override
	public Object getRowKey(InscricaoCurso op) {
		return op.getId();
	}
}