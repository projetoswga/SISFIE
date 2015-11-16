package br.com.sisfie.util;

import java.util.Random;

public class PasswordUtil {

	private static final char[] ALL_CHARS = new char[62];
	private static final Random RANDOM = new Random();

	static {
		for (int i = 48, j = 0; i < 123; i++) {
			if (Character.isLetterOrDigit(i)) {
				ALL_CHARS[j] = (char) i;
				j++;
			}
		}
	}

	public static String gerarPassword(final int length) {
		final char[] result = new char[length];
		for (int i = 0; i < length; i++) {
			result[i] = ALL_CHARS[RANDOM.nextInt(ALL_CHARS.length)];
		}
		return new String(result);
	}
	
	public static void main(String[] args) {
		System.out.println(PasswordUtil.gerarPassword(8));
	}

}
