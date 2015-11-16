package br.com.sisfie.util;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class EmailUtil {

	public static boolean emailValido(String email) {
		System.out.println("Metodo de validacao de email");
		Pattern p = Pattern.compile("^[\\w-]+(\\.[\\w-]+)*@([\\w-]+\\.)+[a-zA-Z]{2,7}$");
		Matcher m = p.matcher(email);
		if (m.find()) {
			return true;
		} else {
			return false;
		}
	}
}
