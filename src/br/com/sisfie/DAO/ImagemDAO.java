package br.com.sisfie.DAO;

import br.com.sisfie.entidade.InscricaoComprovante;

public interface ImagemDAO {

	InscricaoComprovante carregarImagemId(Integer id) throws Exception;

}
