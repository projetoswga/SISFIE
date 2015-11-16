package br.com.arquitetura.util;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

import javax.faces.context.FacesContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRHtmlExporter;
import net.sf.jasperreports.engine.export.JRHtmlExporterParameter;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import net.sf.jasperreports.engine.export.JRXlsExporter;
import net.sf.jasperreports.engine.export.JRXlsExporterParameter;
import br.com.sisfie.util.Constantes;

/**
 * @author Igor Galv�o <br/>
 *         Class Util para gerar Relatorios.<br/>
 *         Pode ser exibido no browser
 * @version 1.0
 * @date 23/09/2011
 */

public class RelatorioUtil {

	/**
	 * 
	 * @param lista
	 * @param parametros
	 * @param caminho
	 * @param nomePDF
	 * @param formato
	 * - Excel, PDF e HTML
	 * @throws JRException
	 * @throws IOException
	 * @funcionalidade: Gerar relatorio com lista e parametos
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void gerarRelatorio(Collection lista, Map parametros, String caminho, String nome, String formato) throws JRException,
			IOException {
		FacesContext context = FacesContext.getCurrentInstance();
		/* Cria o response */
		HttpServletResponse response = (HttpServletResponse) context.getExternalContext().getResponse();


		/* Coloca o nome do arquivo e o Tipo que o browser deve interpretar */
		response.setHeader("Content-Disposition", "attachment; filename=" + nome + "." + formato);

		/* Cria o Stream com o caminho */
		InputStream stream = context.getExternalContext().getResourceAsStream(caminho);

		/* Cria a lista do relatorio */
		JRDataSource colecao = new JRBeanCollectionDataSource(lista == null ? new ArrayList() : lista);
		JasperPrint jasperPrint = JasperFillManager.fillReport(stream, parametros, colecao);
		ServletOutputStream outputStream = response.getOutputStream();
		JRExporter jrExporter = getExporter(formato, response);
		jrExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
		jrExporter.exportReport();
		outputStream.flush();
		outputStream.close();
		context.renderResponse();
		context.responseComplete();
	}

	/**
	 * 
	 * @param parametros
	 * @param caminho
	 * @param nome
	 *            - Sem extensão. ex: NomePDF
	 * @param formato
	 *            - Excel, PDF e HTML
	 * @throws JRException
	 * @throws IOException
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void gerarRelatorio(Map parametros, String caminho, String nome, String formato) throws JRException, IOException {
		FacesContext context = FacesContext.getCurrentInstance();
		/* Cria o response */
		HttpServletResponse response = (HttpServletResponse) context.getExternalContext().getResponse();

		/* Coloca o nome do arquivo e o Tipo que o browser deve interpretar */
		response.setHeader("Content-Disposition", "attachment; filename=" + nome + "." + formato);

		/* Cria o Stream com o caminho */
		InputStream stream = context.getExternalContext().getResourceAsStream(caminho);

		/* Quando nao passa a lista da erro */
		/* Para resolver vou criar uma lista sem nada */
		Collection lista = new ArrayList();
		lista.add(new Object());
		JRDataSource colecao = new JRBeanCollectionDataSource(lista);
		JasperPrint jasperPrint = JasperFillManager.fillReport(stream, parametros, colecao);
		ServletOutputStream outputStream = response.getOutputStream();

		JRExporter jrExporter = getExporter(formato, response);

		jrExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
		jrExporter.exportReport();
		outputStream.flush();
		outputStream.close();
		context.renderResponse();
		context.responseComplete();

	}

	/**
	 * 
	 * @param lista
	 * @param parametros
	 * @param caminho
	 * @param nomePDF
	 * @throws JRException
	 * @throws IOException
	 * @funcionalidade: Gerar relatorio com Lista
	 */
	@SuppressWarnings("rawtypes")
	public static void gerarRelatorio(Collection lista, String caminho, String nome,String formato) throws JRException, IOException {
		FacesContext context = FacesContext.getCurrentInstance();
		/* Cria o response */
		HttpServletResponse response = (HttpServletResponse) context.getExternalContext().getResponse();

		/* Coloca o nome do arquivo e o Tipo que o browser deve interpretar */
		response.setHeader("Content-Disposition", "attachment; filename=" + nome + "." + formato);

		/* Cria o Stream com o caminho */
		InputStream stream = context.getExternalContext().getResourceAsStream(caminho);

		/* Cria a lista do relatorio */
		JRDataSource dataSource = new JRBeanCollectionDataSource(lista == null ? new ArrayList() : lista);
		JasperPrint jasperPrint = JasperFillManager.fillReport(stream, new HashMap<String, Object>(), dataSource);
		ServletOutputStream outputStream = response.getOutputStream();
		JRExporter jrExporter = getExporter(formato, response);
		jrExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
		jrExporter.exportReport();
		outputStream.flush();
		outputStream.close();
		context.renderResponse();
		context.responseComplete();
	}

	/**
	 * 
	 * @param lista
	 * @param parametros
	 * @param caminho
	 * @param nomePDF
	 * @throws JRException
	 * @throws IOException
	 * @funcionalidade: Gerar relatorio
	 */
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public static void gerarRelatorio(String caminho, String nome,String formato) throws JRException, IOException {
		FacesContext context = FacesContext.getCurrentInstance();
		/* Cria o response */
		HttpServletResponse response = (HttpServletResponse) context.getExternalContext().getResponse();

		/* Coloca o nome do arquivo e o Tipo que o browser deve interpretar */
		response.setHeader("Content-Disposition", "attachment; filename=" + nome + "." + formato);

		/* Cria o Stream com o caminho */
		InputStream stream = context.getExternalContext().getResourceAsStream(caminho);
		/* Quando nao passa a lista da erro */
		/* Para resolver vou criar uma lista sem nada */
		Collection lista = new ArrayList();
		lista.add(new Object());
		JRDataSource colecao = new JRBeanCollectionDataSource(lista);
		JasperPrint jasperPrint = JasperFillManager.fillReport(stream, new HashMap<String, Object>(), colecao);
		ServletOutputStream outputStream = response.getOutputStream();
		JRExporter jrExporter = getExporter(formato, response);
		jrExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
		jrExporter.exportReport();
		outputStream.flush();
		outputStream.close();
		context.renderResponse();
		context.responseComplete();
	}

	/**
	 * @param lista
	 * @param caminho
	 * @param nomeXLS
	 * @throws JRException
	 * @throws IOException
	 * @funcionalidade: Gerar relatorio
	 */
	@SuppressWarnings("rawtypes")
	public static void gerarRelatorioExcel(Collection lista, String caminho, String nomeXLS) throws JRException, IOException {
		FacesContext context = FacesContext.getCurrentInstance();
		/* Cria o response */
		HttpServletResponse response = (HttpServletResponse) context.getExternalContext().getResponse();

		/* Coloca o nome do XLS e o Tipo que o browser deve interpretar */
		response.setHeader("Content-Disposition", "attachment; filename=" + nomeXLS);
		response.setContentType("application/vnd.ms-excel");

		/* Cria o Stream com o caminho */
		InputStream stream = context.getExternalContext().getResourceAsStream(caminho);

		/* Cria a lista do relatorio */
		JRDataSource dataSource = new JRBeanCollectionDataSource(lista == null ? new ArrayList() : lista);
		JasperPrint jasperPrint = JasperFillManager.fillReport(stream, new HashMap<String, Object>(), dataSource);
		ServletOutputStream outputStream = response.getOutputStream();
		JRExporter jrExporter = new JRXlsExporter();
		jrExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, outputStream);
		jrExporter.exportReport();
		outputStream.flush();
		outputStream.close();
		context.renderResponse();
		context.responseComplete();
	}

	/**
	 * Definir o Tipo do relatorio. HTML, PDF, EXCEL
	 * 
	 * @param formato
	 * @return
	 */
	private static JRExporter getExporter(String formato, HttpServletResponse response) {
		JRExporter exporter = null;

		if (Constantes.HTML.toString().trim().equalsIgnoreCase(formato.toString().trim())) {
			exporter = new JRHtmlExporter();
			complementaHtmlExport(exporter);
			response.setContentType("text/html; charset=UTF-8");

		}
		if (formato == null || formato.isEmpty() || Constantes.PDF.toString().trim().equalsIgnoreCase(formato.toString().trim())) {
			exporter = new JRPdfExporter();
			response.setContentType("application/pdf");

		}
		if (Constantes.EXCEL.toString().trim().equalsIgnoreCase(formato.toString().trim())) {
			exporter = new JRXlsExporter();
			complementaExcelExport(exporter);
			response.setContentType("application/vnd.ms-excel");

		}

		return exporter;
	}

	private static void complementaExcelExport(JRExporter exporter) {
		exporter.setParameter(JRXlsExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_FONT_SIZE_FIX_ENABLED, Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_DETECT_CELL_TYPE, Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_COLUMNS, Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
		exporter.setParameter(JRXlsExporterParameter.IS_ONE_PAGE_PER_SHEET, Boolean.FALSE);
		exporter.setParameter(JRXlsExporterParameter.IS_COLLAPSE_ROW_SPAN, Boolean.FALSE);
	}

	private static void complementaHtmlExport(JRExporter exporter) {
		exporter.setParameter(JRHtmlExporterParameter.IMAGES_URI, "imagemServlet?image=");
		exporter.setParameter(JRHtmlExporterParameter.IGNORE_PAGE_MARGINS, Boolean.TRUE);
		exporter.setParameter(JRHtmlExporterParameter.IS_WRAP_BREAK_WORD, Boolean.TRUE);
		exporter.setParameter(JRHtmlExporterParameter.IS_WHITE_PAGE_BACKGROUND, Boolean.TRUE);
		exporter.setParameter(JRHtmlExporterParameter.IS_REMOVE_EMPTY_SPACE_BETWEEN_ROWS, Boolean.TRUE);
		exporter.setParameter(JRHtmlExporterParameter.IS_USING_IMAGES_TO_ALIGN, Boolean.FALSE);
		exporter.setParameter(JRHtmlExporterParameter.SIZE_UNIT, JRHtmlExporterParameter.SIZE_UNIT_POINT);
	}

}
