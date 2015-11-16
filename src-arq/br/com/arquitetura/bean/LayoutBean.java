package br.com.arquitetura.bean;

import javax.faces.application.FacesMessage;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.SessionScoped;
import javax.faces.context.FacesContext;

import org.primefaces.component.layout.LayoutUnit;
import org.primefaces.event.ToggleEvent;

@ManagedBean(name = "layoutBean")
@SessionScoped
public class LayoutBean {

	public void handleToggle(ToggleEvent event) {
		FacesMessage message = new FacesMessage(FacesMessage.SEVERITY_INFO,
				((LayoutUnit) event.getComponent()).getPosition() + " toggled", "Status:"
						+ event.getVisibility().name());

		addMessage(message);
	}

	private void addMessage(FacesMessage message) {
		FacesContext.getCurrentInstance().addMessage(null, message);
	}

}
