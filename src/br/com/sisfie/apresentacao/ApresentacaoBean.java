package br.com.sisfie.apresentacao;

import java.io.Serializable;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.util.DateUtil;

@ManagedBean(name = "apresentacao")
@ViewScoped
public class ApresentacaoBean implements Serializable {

	private static final long serialVersionUID = 1L;

	private Date date1;
	private Date date2;
	private List<String> ufs = new ArrayList<String>();
	private List<String> municipios = new ArrayList<String>();
	private List<String> dados = new ArrayList<String>();
	private List<ComunicadoDTO> comunicados = new ArrayList<ComunicadoDTO>();
	private List<ComunicadoDTO> candidatos = new ArrayList<ComunicadoDTO>();
	private List<ComunicadoDTO> inscricoes = new ArrayList<ComunicadoDTO>();
	private List<ComunicadoDTO> localizar = new ArrayList<ComunicadoDTO>();

	public ApresentacaoBean() throws ParseException {
		date1 = DateUtil.getDataHora("01/08/2012", "dd/MM/yyyy");
		date2 = DateUtil.getDataHora("10/08/2012", "dd/MM/yyyy");
		ufs.add("AL");
		ufs.add("AM");
		ufs.add("GO");
		municipios.add("Maceió");
		municipios.add("Manaus");
		municipios.add("Anápolis");
		dados.add("Nome");
		dados.add("CPF");
		dados.add("Endereço");
		dados.add("Email Pessoal");
		dados.add("Email Institucional");
		dados.add("Email Chefe");

		comunicados.add(new ComunicadoDTO("Antonio José da Silva", "Maria Abadia", "23/07/2011", "Homologado"));
		comunicados.add(new ComunicadoDTO("Carlos Luiz Souza", "Maria Abadia", "23/07/2011", "Homologado"));

		candidatos.add(new ComunicadoDTO("Antonio José da Silva", "Maria Abadia", "23/07/2011", "Em Andamento"));
		candidatos.add(new ComunicadoDTO("Carlos Luiz Souza", "Maria Abadia", "23/07/2011", "Em Andamentoo"));

		inscricoes.add(new ComunicadoDTO("Maria Abadia", "Contabilidade Aplicada", "21/07/2012", "27/07/2012", true, "Aguardando comprovante"));
		inscricoes.add(new ComunicadoDTO("Weskley Silva", "Gestão de Pessoas", "10/03/2012", "27/03/2012", false, "Cancelado"));
		
		localizar.add(new ComunicadoDTO("Maria Abadia", "Contabilidade Aplicada", "21/07/2012", "27/07/2012", false, "Em adandamento"));
		localizar.add(new ComunicadoDTO("Weskley Silva", "Gestão de Pessoas", "10/03/2012", "27/03/2012", true, "Finalizado"));
	}

	public Date getDate1() {
		return date1;
	}

	public void setDate1(Date date1) {
		this.date1 = date1;
	}

	public Date getDate2() {
		return date2;
	}

	public void setDate2(Date date2) {
		this.date2 = date2;
	}

	public List<String> getUfs() {
		return ufs;
	}

	public void setUfs(List<String> ufs) {
		this.ufs = ufs;
	}

	public List<String> getMunicipios() {
		return municipios;
	}

	public void setMunicipios(List<String> municipios) {
		this.municipios = municipios;
	}

	public List<String> getDados() {
		return dados;
	}

	public void setDados(List<String> dados) {
		this.dados = dados;
	}

	public List<ComunicadoDTO> getComunicados() {
		return comunicados;
	}

	public void setComunicados(List<ComunicadoDTO> comunicados) {
		this.comunicados = comunicados;
	}

	public List<ComunicadoDTO> getCandidatos() {
		return candidatos;
	}

	public void setCandidatos(List<ComunicadoDTO> candidatos) {
		this.candidatos = candidatos;
	}

	public List<ComunicadoDTO> getInscricoes() {
		return inscricoes;
	}

	public void setInscricoes(List<ComunicadoDTO> inscricoes) {
		this.inscricoes = inscricoes;
	}

	public List<ComunicadoDTO> getLocalizar() {
		return localizar;
	}

	public void setLocalizar(List<ComunicadoDTO> localizar) {
		this.localizar = localizar;
	}

}
