package br.com.sisfie.converter;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;

import br.com.arquitetura.util.StringUtil;

public class NumeroProjetoConverter implements Converter {

	@Override
	public Object getAsObject(FacesContext arg0, UIComponent arg1, String arg2) {
		return null;
	}
	
	@Override
	public String getAsString(FacesContext facesContext, UIComponent uiComponent, Object valor) {
		if (valor != null && valor.toString() != null && !valor.toString().isEmpty()){
			return StringUtil.format("##.##.##.#####.##.##", valor.toString());
		}
		return null;
	}
}
