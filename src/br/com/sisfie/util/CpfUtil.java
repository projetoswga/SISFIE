package br.com.sisfie.util;

public class CpfUtil {
	private static final int[] pesocpf = { 11, 10, 9, 8, 7, 6, 5, 4, 3, 2 };

	private static int calcularDigito(String str, int[] peso) {
		int soma = 0;
		for (int indice = str.length() - 1, digito; indice >= 0; indice--) {
			digito = Integer.parseInt(str.substring(indice, indice + 1));
			soma += digito * peso[peso.length - str.length() + indice];
		}
		soma = 11 - soma % 11;
		return soma > 9 ? 0 : soma;
	}

	public static boolean isValidCPF(String cpf) {
		if ((cpf == null) || (cpf.length() != 11)) {
			return false;
		}
		// considera-se erro cpf's formados por uma sequencia de numeros iguais
		if (cpf.equals("00000000000") || cpf.equals("11111111111") || cpf.equals("22222222222") || cpf.equals("33333333333")
				|| cpf.equals("44444444444") || cpf.equals("55555555555") || cpf.equals("66666666666") || cpf.equals("77777777777")
				|| cpf.equals("88888888888") || cpf.equals("99999999999") || (cpf.length() != 11))
			return (false);

		if (cpf.contains(".") || cpf.contains("-")) {
			cpf = cpf.replaceAll("[.-]", "");
		}

		Integer digito1 = calcularDigito(cpf.substring(0, 9), pesocpf);
		Integer digito2 = calcularDigito(cpf.substring(0, 9) + digito1, pesocpf);
		return cpf.equals(cpf.substring(0, 9) + digito1.toString() + digito2.toString());
	}

}