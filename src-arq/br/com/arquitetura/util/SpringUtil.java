package br.com.arquitetura.util;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class SpringUtil {

	public static Object getBean(String bean, String applicationContext) {
		ApplicationContext context = new ClassPathXmlApplicationContext("classpath:"+applicationContext);
		return context.getBean(bean);
	}
}
