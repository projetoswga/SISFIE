package br.com.sisfie.service.impl;

import java.lang.annotation.Annotation;
import java.lang.reflect.Field;
import java.util.ArrayList;
import java.util.List;

import javax.faces.model.SelectItem;

import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.core.type.filter.AnnotationTypeFilter;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.service.SequenceService;

@Service(value = "sequenceService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
public class SequenceServiceImpl implements SequenceService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@SuppressWarnings("rawtypes")
	@Override
	public List<SelectItem> organizarSequence() throws IllegalArgumentException, Exception {
		ClassPathScanningCandidateComponentProvider scanningProvider;
		List<SelectItem> sequences = new ArrayList<SelectItem>();
		List<String> duplicadas = new ArrayList<String>();

		scanningProvider = new ClassPathScanningCandidateComponentProvider(false);
		scanningProvider.addIncludeFilter(new AnnotationTypeFilter(javax.persistence.Entity.class));

		List<Class<? extends Object>> classes = new ArrayList<Class<? extends Object>>();
		for (BeanDefinition beanDef : scanningProvider.findCandidateComponents("br.com")) {
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
									throw new IllegalArgumentException("Sequence: "+sequence.trim() + " DUPLICADA");
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
		return sequences;
	}

}
