package br.com.arquitetura.util;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.config.BeanDefinition;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextAware;
import org.springframework.context.annotation.ClassPathScanningCandidateComponentProvider;
import org.springframework.core.type.filter.AnnotationTypeFilter;
import org.springframework.orm.jpa.persistenceunit.MutablePersistenceUnitInfo;
import org.springframework.orm.jpa.persistenceunit.PersistenceUnitPostProcessor;

public class AnnotatedEntityDetector implements ApplicationContextAware, PersistenceUnitPostProcessor {

	private ClassPathScanningCandidateComponentProvider scanningProvider;

	private String basePackage = ""; 

	private ApplicationContext applicationContext;

	private List<Class<? extends Object>> classes = null;

	public AnnotatedEntityDetector() {
		this.scanningProvider = new ClassPathScanningCandidateComponentProvider(false);
		this.scanningProvider.addIncludeFilter(new AnnotationTypeFilter(javax.persistence.Entity.class));
	}

	public void setBasePackage(String basePackage) {
		this.basePackage = basePackage;
	}

	public List<Class<? extends Object>> getClasses() throws ClassNotFoundException {
		if (this.classes == null) {
			this.classes = new ArrayList<Class<? extends Object>>();
			for (BeanDefinition beanDef : this.scanningProvider.findCandidateComponents(this.basePackage)) {
				this.classes.add(Class.forName(beanDef.getBeanClassName()));
			}
		}
		return this.classes;
	}

	@Override
	public void postProcessPersistenceUnitInfo(MutablePersistenceUnitInfo pui) {
		try {
			for (Class<? extends Object> clazz : getClasses()) {

				pui.addManagedClassName(clazz.getName());

			}
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

	}

	public ApplicationContext getApplicationContext() {
		return applicationContext;
	}

	@Override
	public void setApplicationContext(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
	}
}
