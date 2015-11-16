package br.com.sisfie.teste;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.entidade.Area;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:applicationContext-teste.xml" })
public class TestDAO {

	 @Autowired(required = true)
	 @Qualifier(value = "universalDAO")
	 UniversalDAO dao;

	@Test
	public void metodo1() throws Exception {
		Area area = new Area();

		area.setDescricao("descricao");
		area.setDetalhamento("Detalhamento");

		 dao.save(area);
	}

}
