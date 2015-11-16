package br.com.arquitetura.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtil {

	/**
	 * @param date
	 * @return
	 */
	public static String getDataHora(Date date, String format) {
		SimpleDateFormat formatter = new SimpleDateFormat(format);

		return formatter.format(date);
	}

	/**
	 * @param date
	 * @return
	 * @throws ParseException
	 */
	public static Date getDataHora(String date, String format) throws ParseException {
		SimpleDateFormat formatter = new SimpleDateFormat(format);
		return formatter.parse(date);
	}
	
	public static Date getDateSemHora(String date) throws ParseException {
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		return format.parse(date);
	}

	public static Date getDateSemHora(Date date) throws ParseException {
		DateFormat format = new SimpleDateFormat("dd/MM/yyyy");
		String dtString = format.format(date);
		return (Date) format.parse(dtString);
	}
	
	/**
	 * Método responsável por retornar a dirferença entre duas datas sem levar em consideração as horas <br/>
	 * <b>Exemplo:</b> Diferença entre 02/05 e 25/05 tem como resultado --> 23 dias
	 * 
	 * @author Wesley Marra
	 * @param dataInicio
	 * @param dataFim
	 * @return diferença em dias
	 * @throws ParseException 
	 */
	public static int diferencaEntreDatas(Date dataInicio, Date dataFim) throws ParseException {
		long tempoInicio = getDateSemHora(dataInicio).getTime();
		long tempoFim = getDateSemHora(dataFim).getTime();
		long diferenca = tempoFim - tempoInicio;
		return (int) ((diferenca + 60L * 60 * 1000) / (24L * 60 * 60 * 1000));
	}
	
//	public static void main(String[] args) {
//		try {
//			Calendar hoje = Calendar.getInstance();
//			hoje.set(2015, 3, 2);
//			Calendar inicioCurso = Calendar.getInstance();
//			inicioCurso.set(2015, 3, 13);
//			System.out.println(diferencaEntreDatas(hoje.getTime(), inicioCurso.getTime()) + " dias");
//			System.out.println("Hoje: " + hoje.getTime());
//			System.out.println("Data Futura : " + inicioCurso.getTime());
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
}
