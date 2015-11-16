package br.com.sisfie.service;

import java.util.List;
import java.util.Map;

import br.com.sisfie.entidade.Funcionalidade;
import br.com.sisfie.entidade.PerfilFuncionalidade;
import br.com.sisfie.entidade.Usuario;

public interface AcessoService {

	boolean existeFuncionalidade(Integer idPerfilSelecionado, Funcionalidade func);

	List<Funcionalidade> carregarFilhos(Integer idPai) throws Exception;

	List<Funcionalidade> carregarPais() throws Exception;

	Long countPerfilFuncionalidade(PerfilFuncionalidade pf);

	void salvarPerfilFuncionalidade(List<PerfilFuncionalidade> listaSalvar, List<PerfilFuncionalidade> listaExcluir) throws Exception;

	void salvarFuncionalidade(Funcionalidade funcionalidade) throws Exception;

	void excluirFuncionalidade(Funcionalidade funcionalidade) throws Exception;

	Long getCount(Funcionalidade model, Map<String, String> filters);

	@SuppressWarnings("rawtypes")
	List paginate(int first, int pageSize, Funcionalidade model, Map<String, String> filters, String sortField, boolean sortOrder);

	List<Funcionalidade> carregarFuncionalidades(Usuario u);

}
