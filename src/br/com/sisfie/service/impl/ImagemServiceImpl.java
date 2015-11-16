package br.com.sisfie.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.sisfie.DAO.ImagemDAO;
import br.com.sisfie.entidade.InscricaoComprovante;
import br.com.sisfie.service.ImagemService;

@Service(value = "ImagemService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class ImagemServiceImpl implements ImagemService {

	@Autowired(required = true)
	@Qualifier(value = "ImagemDAO")
	protected ImagemDAO imagemDAO;

	@Override
	public InscricaoComprovante carregarImagemId(Integer id) throws Exception {
		return imagemDAO.carregarImagemId(id);
	}
}
