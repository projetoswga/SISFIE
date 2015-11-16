package br.com.sisfie.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.UsuarioDAO;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.UsuarioService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.CriptoUtil;

@Service(value = "usuarioService")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class UsuarioServiceImpl implements UsuarioService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "usuarioDAO")
	protected UsuarioDAO usuarioDAO;

	@Override
	public List<Usuario> completeUsuarioAtivo(Usuario a) throws Exception {
		return usuarioDAO.completeUsuarioAtivo(a);
	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void restaurarSenha(Usuario clone) throws Exception {
		Usuario user  = (Usuario) dao.get(Usuario.class, clone.getId());
		user.setSenha(CriptoUtil.getCriptografia(Constantes.SENHA_DEFAULT));
		dao.merge(user);

	}

	@Override
	public Usuario carregaUsuarioPorLogin(String login) throws Exception {
		try{
		Usuario user = usuarioDAO.carregaUsuarioPorLogin(login);
		if(user==null){
			throw new Exception("Login não encontrado");
		}else{
			return user;
		}
		}catch(Exception e){
			e.printStackTrace();
			throw new Exception(e);
		}
		
	}

}
