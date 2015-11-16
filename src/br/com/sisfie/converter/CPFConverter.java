package br.com.sisfie.converter;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;

import br.com.arquitetura.util.StringUtil;

public class CPFConverter implements Converter {

	@Override
	public Object getAsObject(FacesContext arg0, UIComponent arg1, String arg2) {
		return null;
	}

	@Override
	public String getAsString(FacesContext arg0, UIComponent arg1, Object valor) {
		if (valor != null && valor.toString() != null && !valor.toString().isEmpty()){
			return StringUtil.format("###.###.###-##", valor.toString());
		}
		return null;
	}
}
