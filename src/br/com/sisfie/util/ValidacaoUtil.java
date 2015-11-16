package br.com.sisfie.util;

public class ValidacaoUtil {

	public static boolean doubleValido(String doubleToString) {

		if (doubleToString == null || doubleToString.trim().equals("")) {
			return false;
		}

		int qtdPonto = 0;
		int qtdVirgula = 0;
		int cont = 0;
		for (Character numero : doubleToString.toCharArray()) {
			if (!numero.isDigit(numero) && !numero.equals('.') && !numero.equals(',')) {
				return false;
			} else if (numero.equals('.')) {
				// primera posicao com ponto
				if (cont == 0) {
					return false;
				}
				qtdPonto++;
			} else if (numero.equals(',')) {
				// primera posicao com virgula
				if (cont == 0) {
					return false;
				}
				qtdVirgula++;
			}
			cont++;
		}
		if (qtdPonto > 1 || qtdVirgula > 1) {
			return false;
		}

		return true;
	}

	public static boolean isNumeric(String str) {
		boolean isNumeric = true;
		int size = str.length();
		for (int i = 0; (i < size) && isNumeric; i++) {
			// Para caracter individual, Java tem um método para avaliar
			if (!Character.isDigit(str.charAt(i))) {
				isNumeric = false;
				break;
			}
		}
		return isNumeric;
	}
	
	public static String somenteNumero(String str) {
		StringBuilder numero = new StringBuilder();
		int size = str.length();
		for (int i = 0; i < size; i++) {
			// Para caracter individual, Java tem um método para avaliar
			if (Character.isDigit(str.charAt(i))) {
				numero.append(str.charAt(i));
			}
		}
		return numero.toString();
	}
}
