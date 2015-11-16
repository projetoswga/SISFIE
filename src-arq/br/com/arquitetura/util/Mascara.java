package br.com.arquitetura.util;

public class Mascara {

	@SuppressWarnings("static-access")
	public static String retirarMascara(String valor) {
		String format = null;
		for (Character letra : valor.toCharArray()) {
			if (letra.isDigit(letra)) {
				if (format == null) {
					format = "";
				}
				format += letra;
			}
		}
		return format;
	}

	public static Double marcarDouble(String doubleToString) throws NumberFormatException {

		if (doubleToString.contains(",")) {
			doubleToString = doubleToString.trim().replaceAll("[,]", ".");
		}

		return Double.valueOf(doubleToString);
	}
}
