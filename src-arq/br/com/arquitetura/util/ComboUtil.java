package br.com.arquitetura.util;

import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

public class ComboUtil {

	public static List<SelectItem> getItens(List<Combo> entidades) {
		List<SelectItem> itens = new ArrayList<SelectItem>();
		for (Combo combo : entidades)
			itens.add(new SelectItem(combo.getId(), combo.getValue()));
		return itens;
	}
}
