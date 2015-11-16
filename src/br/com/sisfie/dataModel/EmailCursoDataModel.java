package br.com.sisfie.dataModel;

import java.util.List;

import javax.faces.model.ListDataModel;

import org.primefaces.model.SelectableDataModel;

import br.com.sisfie.entidade.EmailCursoPrivado;

public class EmailCursoDataModel extends ListDataModel<EmailCursoPrivado> implements
		SelectableDataModel<EmailCursoPrivado> {

	public EmailCursoDataModel() {
	}

	public EmailCursoDataModel(List<EmailCursoPrivado> data) {
		super(data);
	}

	@Override
	public EmailCursoPrivado getRowData(String rowKey) {

		List<EmailCursoPrivado> lista = (List<EmailCursoPrivado>) getWrappedData();

		for (EmailCursoPrivado op : lista) {
			if (op.getId().equals(Integer.valueOf(rowKey)))
				return op;
		}

		return null;
	}

	@Override
	public Object getRowKey(EmailCursoPrivado op) {
		return op.getId();
	}
}