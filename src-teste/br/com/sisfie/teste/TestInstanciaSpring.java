package br.com.sisfie.teste;

import junit.framework.TestCase;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import br.com.arquitetura.mail.SimpleMailSender;

public class TestInstanciaSpring extends TestCase {

	public void test1() throws Exception {

		ApplicationContext context = new ClassPathXmlApplicationContext(
				"classpath:applicationContext-service-teste.xml");
		SimpleMailSender simpleMailSender = (SimpleMailSender) context.getBean("simpleMailSender");

	}
}
