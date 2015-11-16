package br.com.arquitetura.bean;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.primefaces.model.LazyDataModel;
import org.primefaces.model.SortOrder;

import br.com.arquitetura.entidade.Entidade;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ConstantesARQ;

@SuppressWarnings("rawtypes")
public abstract class PaginableBean<T extends Entidade> extends BaseBean<T> {

	private static final long serialVersionUID = 6758303059773814977L;

	protected LazyDataModel<T> lazyDataModel;

	public Map<String, String> filters = new HashMap<String, String>();

	public abstract Map<String, String> getFilters();

	@SuppressWarnings("unchecked")
	public LazyDataModel<T> getLazyDataModel() {
		try {
			if (lazyDataModel == null)
				lazyDataModel = new LazyDataModel() {

					private static final long serialVersionUID = 2595093445602418759L;

					@Override
					public List load(int first, int pageSize, String sortField, SortOrder sortOrder, Map filters) {
						try {

							boolean order = false;
							if (sortOrder.equals(SortOrder.ASCENDING)) {
								order = true;
							}

							if (getFilters() != null && !getFilters().isEmpty()) {
								filters.putAll(getFilters());
							}

							// Reduzindo o contador depois de filtrado
							int rowCount = universalManager.getCount(first, pageSize, sortField, order, filters, getModel().getClass())
									.intValue();
							lazyDataModel.setRowCount(rowCount);
							return universalManager.paginate(first, pageSize, sortField, order, filters, getModel().getClass());
						} catch (Exception e) {
							ExcecaoUtil.tratarExcecao(e);
						}
						return null;
					}
				};

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return lazyDataModel;
	}

	public void setLazyDataModel(LazyDataModel<T> lazyDataModel) {
		this.lazyDataModel = lazyDataModel;
	}

	public String getPaginacao() {
		return ConstantesARQ.PAGINACAO;
	}
}
