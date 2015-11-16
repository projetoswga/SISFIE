package br.com.arquitetura.util;

import java.lang.reflect.Field;
import java.text.SimpleDateFormat;

public class ClasseUtil {

	public static Object setValorPropriedade(Object objeto, String filtro, String valor) throws Exception {
		String[] campos = filtro.split("\\.");
		Object novo = new Object();
		for (int i = 0; i < campos.length; i++) {
			String campo = campos[i];
			boolean ultimo = false;
			if (i == campos.length - 1)
				ultimo = true;
			if (i == 0)
				novo = setValor(objeto, campo, valor, ultimo);
			else
				novo = setValor(novo, campo, valor, ultimo);
		}
		return objeto;
	}

	private static Object setValor(Object objeto, String campo, String valor, boolean ultimo) throws Exception {
		Object novo = new Object();

		Field field = objeto.getClass().getDeclaredField(campo);
		field.setAccessible(true);
		if (!ultimo) {
			novo = Class.forName(field.getType().getCanonicalName()).newInstance();
			field.set(objeto, novo);
		} else {
			if (field.getType().equals(java.lang.String.class)) {
				field.set(objeto, valor);
			} else if (field.getType().equals(java.lang.Long.class)) {
				field.set(objeto, Long.valueOf(Mascara.retirarMascara(valor)));
			} else if (field.getType().equals(java.lang.Double.class)) {
				field.set(objeto, Double.valueOf(Mascara.retirarMascara(valor)));
			} else if (field.getType().equals(java.lang.Integer.class)) {
				field.set(objeto, Integer.valueOf(Mascara.retirarMascara(valor)));
			} else if (field.getType().equals(java.lang.Character.class)) {
				field.set(objeto, valor.charAt(0));
			} else if (field.getType().equals(java.util.Date.class)) {
				if (!valor.contains("/")) {
					valor = StringUtil.format("##/##/####", valor);
				}
				SimpleDateFormat format = new SimpleDateFormat("dd/MM/yyyy");
				field.set(objeto, format.parseObject(valor));
			}
		}
		return novo;
	}

}
