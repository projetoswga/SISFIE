package br.com.sisfie.service;

import org.springframework.mail.SimpleMailMessage;

import br.com.sisfie.entidade.Usuario;

public interface LoginService {

	
	public void esqueciSenha(Usuario user , SimpleMailMessage message) throws Exception;
}
