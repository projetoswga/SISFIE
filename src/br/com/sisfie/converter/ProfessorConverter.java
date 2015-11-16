package br.com.sisfie.converter;

import java.io.Serializable;

import javax.faces.component.UIComponent;
import javax.faces.context.FacesContext;
import javax.faces.convert.Converter;
import javax.servlet.ServletContext;

import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import br.com.arquitetura.entidade.Entidade;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.service.UniversalManager;
import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.util.ValidacaoUtil;

public class ProfessorConverter implements Converter {

	@SuppressWarnings("rawtypes")
	private static final Class clazz = Candidato.class;

	@Override
	public Object getAsObject(FacesContext context, UIComponent component, String value) {
		try {

			if (value == null || value.isEmpty()) {
				throw new Exception("Erro na class: " + this.getClass().getSimpleName());
			}
			
			if (!ValidacaoUtil.isNumeric(value)) {
				return null;
			}

			Serializable id = Integer.valueOf(value);
			return this.getUniversalManager().get(clazz, id);

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return null;
	}

	@SuppressWarnings("rawtypes")
	@Override
	public String getAsString(FacesContext arg0, UIComponent component, Object object) {
		try {
			if (object == null || object.equals("")) {
				throw new Exception("Erro na class: " + this.getClass().getSimpleName());
			}
			if (object instanceof Integer) {
				Serializable id = (Serializable) object;
				if (id != null) {
					return String.valueOf(id);
				}
			} else if (object instanceof Entidade) {
				Entidade entidade = (Entidade) object;
				if (entidade != null && entidade.getId() != null) {
					return String.valueOf(entidade.getId());
				}
			} else {
				throw new Exception("Erro na class: " + this.getClass().getSimpleName());
			}

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return "";

	}

	public UniversalManager getUniversalManager() {
		ServletContext context = (ServletContext) FacesContext.getCurrentInstance().getExternalContext().getContext();
		WebApplicationContext springContext = WebApplicationContextUtils.getWebApplicationContext(context);
		return (UniversalManager) springContext.getBean("universalManager");
	}

}
