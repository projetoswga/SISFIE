package br.com.sisfie.util;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import net.sf.jasperreports.engine.JRDataSource;
import net.sf.jasperreports.engine.JRException;
import net.sf.jasperreports.engine.JRExporter;
import net.sf.jasperreports.engine.JRExporterParameter;
import net.sf.jasperreports.engine.JasperFillManager;
import net.sf.jasperreports.engine.JasperPrint;
import net.sf.jasperreports.engine.data.JRBeanCollectionDataSource;
import net.sf.jasperreports.engine.export.JRPdfExporter;
import br.com.sisfie.bean.RelatorioFrequenciaBean;
import br.com.sisfie.dto.EtiquetaDTO;

public class RelatorioEtiquetaTest {
	
	public static void main(String[] args) throws JRException, IOException {
		List<EtiquetaDTO> listaEtiquetaDTO = new ArrayList<EtiquetaDTO>();
		listaEtiquetaDTO.add(new EtiquetaDTO("ANDREAZO JOSE DOS SANTOS",
				"12345678912345"));

		String caminho = "/Web/jasper/etiqueta.jasper";

		FileOutputStream fos = new FileOutputStream(new File("D:/java/relatorio.pdf"));

		JRDataSource dataSource = new JRBeanCollectionDataSource(
				listaEtiquetaDTO == null ? new ArrayList() : listaEtiquetaDTO);
		JasperPrint jasperPrint = JasperFillManager.fillReport(new FileInputStream("D:/java/SISFIE/Web/jasper/etiqueta.jasper"),new HashMap<String, Object>(), dataSource);
		JRExporter jrExporter = new JRPdfExporter();
		jrExporter.setParameter(JRExporterParameter.JASPER_PRINT, jasperPrint);
		jrExporter.setParameter(JRExporterParameter.OUTPUT_STREAM, fos);
		jrExporter.exportReport();
		fos.flush();
		fos.close();
	}
}
