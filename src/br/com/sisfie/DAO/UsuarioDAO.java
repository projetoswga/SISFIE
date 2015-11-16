package br.com.sisfie.DAO;

import java.util.List;

import br.com.sisfie.entidade.Usuario;

public interface UsuarioDAO {

	List<Usuario> completeUsuarioAtivo(Usuario a) throws Exception;

	Usuario carregaUsuarioPorLogin(String login) throws Exception;

}
