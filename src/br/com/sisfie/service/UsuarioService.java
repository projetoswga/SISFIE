package br.com.sisfie.service;

import java.util.List;

import br.com.sisfie.entidade.Usuario;

public interface UsuarioService {

	List<Usuario> completeUsuarioAtivo(Usuario a) throws Exception;

	void restaurarSenha(Usuario clone) throws Exception;

	Usuario carregaUsuarioPorLogin(String login) throws Exception;

}
