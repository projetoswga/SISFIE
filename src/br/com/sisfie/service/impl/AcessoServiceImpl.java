package br.com.sisfie.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import br.com.arquitetura.DAO.UniversalDAO;
import br.com.sisfie.DAO.AcessoDAO;
import br.com.sisfie.entidade.Funcionalidade;
import br.com.sisfie.entidade.PerfilFuncionalidade;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.AcessoService;

@Service(value = "acessoServiceImpl")
@Transactional(readOnly = true, rollbackFor = Exception.class, propagation = Propagation.SUPPORTS)
public class AcessoServiceImpl implements AcessoService {

	@Autowired(required = true)
	@Qualifier(value = "universalDAO")
	protected UniversalDAO dao;

	@Autowired(required = true)
	@Qualifier(value = "acessoDAO")
	protected AcessoDAO acessoDAO;

	@Override
	public boolean existeFuncionalidade(Integer idPerfilSelecionado, Funcionalidade func) {
		return acessoDAO.existeFuncionalidade(idPerfilSelecionado, func);
	}

	@Override
	public List<Funcionalidade> carregarFilhos(Integer idPai) throws Exception {
		return acessoDAO.carregarFilhos(idPai);
	}

	@Override
	public List<Funcionalidade> carregarPais() throws Exception {
		return acessoDAO.carregarPais();
	}

	@Override
	public Long countPerfilFuncionalidade(PerfilFuncionalidade pf) {
		return acessoDAO.countPerfilFuncionalidade(pf);
	}

	@Override
	/**
	 * Toda vez que for salvar , exclui todos registro anteriores e salva novamente
	 */
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarPerfilFuncionalidade(List<PerfilFuncionalidade> listaSalvar, List<PerfilFuncionalidade> listaExcluir)
			throws Exception {
		for (PerfilFuncionalidade excluir : listaExcluir) {
			dao.remove(PerfilFuncionalidade.class, excluir.getId());
		}

		for (PerfilFuncionalidade salvar : listaSalvar) {
			dao.save(salvar);
		}

	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void salvarFuncionalidade(Funcionalidade funcionalidade) throws Exception {

		// Salva o Pai
		dao.save(funcionalidade);

		// Exclui os filhos
		for (Funcionalidade filhosEx : funcionalidade.getFilhosExcluir()) {
			dao.remove(Funcionalidade.class, filhosEx.getId());
		}

		// Salva os filhos
		for (Funcionalidade func : funcionalidade.getFilhos()) {
			dao.save(func);
		}

	}

	@Override
	@Transactional(readOnly = false, rollbackFor = Exception.class, propagation = Propagation.REQUIRED)
	public void excluirFuncionalidade(Funcionalidade funcionalidade) throws Exception {

		// Remove os filhos
		for (Funcionalidade filho : funcionalidade.getFilhos()) {
			dao.remove(Funcionalidade.class, filho.getId());
		}

		// Remove o pai
		dao.remove(Funcionalidade.class, funcionalidade.getId());

	}

	@Override
	public Long getCount(Funcionalidade model, Map<String, String> filters) {
		return acessoDAO.getCount(model, filters);
	}

	@Override
	public List paginate(int first, int pageSize, Funcionalidade model, Map<String, String> filters, String sortField, boolean sortOrder) {
		return acessoDAO.paginate(first, pageSize, model, filters, sortField, sortOrder);
	}

	@Override
	public List<Funcionalidade> carregarFuncionalidades(Usuario u) {
		return acessoDAO.carregarFuncionalidades(u);
	}

}
