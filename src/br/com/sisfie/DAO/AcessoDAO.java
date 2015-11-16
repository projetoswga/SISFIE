package br.com.sisfie.DAO;

import java.util.List;
import java.util.Map;

import br.com.sisfie.entidade.Funcionalidade;
import br.com.sisfie.entidade.PerfilFuncionalidade;
import br.com.sisfie.entidade.Usuario;

public interface AcessoDAO {

	boolean existeFuncionalidade(Integer idPerfilSelecionado, Funcionalidade func);

	List<Funcionalidade> carregarFilhos(Integer idPai) throws Exception;

	List<Funcionalidade> carregarPais() throws Exception;

	Long countPerfilFuncionalidade(PerfilFuncionalidade pf);

	Long getCount(Funcionalidade model, Map<String, String> filters);

	@SuppressWarnings("rawtypes")
	List paginate(int first, int pageSize, Funcionalidade model, Map<String, String> filters, String sortField, boolean sortOrder);
	
	List<Funcionalidade> carregarFuncionalidades(Usuario u);

}
