package br.com.sisfie.teste;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import org.hibernate.Session;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.core.type.filter.AnnotationTypeFilter;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import br.com.arquitetura.DAO.UniversalDAO;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext-teste.xml" })
public class ConferirSequence {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	UniversalDAO dao;

	private ClassPathScanningCandidateComponentProvider scanningProvider;
	private List<SelectItem> sequences = new ArrayList<SelectItem>();
	private List<String> duplicadas = new ArrayList<String>();

	@SuppressWarnings("rawtypes")
	@Test
	public void metodo1() throws IllegalArgumentException, Exception {
		this.scanningProvider = new ClassPathScanningCandidateComponentProvider(false);
		this.scanningProvider.addIncludeFilter(new AnnotationTypeFilter(javax.persistence.Entity.class));

		List<Class<? extends Object>> classes = new ArrayList<Class<? extends Object>>();
		for (BeanDefinition beanDef : this.scanningProvider.findCandidateComponents("br.com")) {
			classes.add(Class.forName(beanDef.getBeanClassName()));
		}

		CLAZZ: for (Class clazz : classes) {

			Field listaCampo[] = clazz.getDeclaredFields();
			for (Field campo : listaCampo) {
				if (campo.getName().trim().equalsIgnoreCase("id")) {

					for (Annotation anotacao : campo.getAnnotations()) {
						if (anotacao.toString().contains("sequenceName")) {
							String array[] = anotacao.toString().split(",");
							String sequence = "";
							for (String item : array) {
								if (item.contains("sequenceName")) {
									sequence = item.replace("sequenceName=", "");
									break;
								}
							}
							if (sequence != null && !sequence.equals("")) {
								// Descobre o maior id do banco
								Integer ultimoId = dao.max(clazz);
								if (ultimoId == null) {
									ultimoId = 1;
								}
								Session session = dao.getCurrentSession();

								String sql = "SELECT setval('SISFIE." + sequence.trim() + "', " + ultimoId + ");";

								if (duplicadas.contains(sequence.trim())) {
									throw new IllegalArgumentException();
								}
								duplicadas.add(sequence.trim());
								session.createSQLQuery(sql).uniqueResult();
								sequences.add(new SelectItem(ultimoId, sequence.trim()));
								continue CLAZZ;
							}
						}
					}

				}
			}

		}
		System.out.println("Total :" + sequences.size());
		for (SelectItem item : sequences) {
			System.out.println(item.getLabel() + ": " + item.getValue());
		}

	}
}
