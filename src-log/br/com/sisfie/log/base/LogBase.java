package br.com.sisfie.log.base;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

import br.com.arquitetura.entidade.Entidade;
import br.com.sisfie.log.entidade.ColumnModel;

public abstract class LogBase<T extends Entidade> implements Serializable {

	private static final long serialVersionUID = 1L;

	protected List<T> objects;

	protected List<ColumnModel> columns = new ArrayList<ColumnModel>();

	protected String labelTable;
	
	public abstract void implementsColumns();
	
	public LogBase() {
		implementsColumns();
	}


	public List<ColumnModel> getColumns() {
		
		return columns;
	}

	public void setColumns(List<ColumnModel> columns) {
		this.columns = columns;
	}

	public String getLabelTable() {
		return labelTable;
	}

	public void setLabelTable(String labelTable) {
		this.labelTable = labelTable;
	}

	public List<T> getObjects() {
		return objects;
	}

	public void setObjects(List<T> objects) {
		this.objects = objects;
	}

}
