package br.com.sisfie.log.entidade;

import br.com.sisfie.entidade.Candidato;
import br.com.sisfie.log.base.LogBase;

public class LogCandidato extends LogBase<Candidato> {

	private static final long serialVersionUID = 1L;

	@Override
	public void implementsColumns() {
		labelTable = "Candidato(s)";

		ColumnModel columNome = new ColumnModel();
		columNome.setHeader("Nome");
		columNome.setProperty("nome");

		ColumnModel columCpf = new ColumnModel();
		columCpf.setHeader("CPF");
		columCpf.setProperty("cpf");

		ColumnModel columOrgao = new ColumnModel();
		columOrgao.setHeader("Órgão");
		columOrgao.setProperty("orgao");
		columOrgao.setSubProperty("nome");
		
		columns.add(columNome);
		columns.add(columCpf);
		columns.add(columOrgao);

	}

}
