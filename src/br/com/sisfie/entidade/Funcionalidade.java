package br.com.sisfie.entidade;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;
import javax.persistence.Transient;

import org.hibernate.envers.Audited;
import org.primefaces.model.TreeNode;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "FUNCIONALIDADE", catalog = "SISFIE")
@Audited
public class Funcionalidade extends Entidade<Integer> {

	private static final long serialVersionUID = 688988410344861602L;

	@Id
	@Column(name = "ID_FUNCIONALIDADE", unique = true, nullable = false)
	@SequenceGenerator(name = "Funcionalidade", allocationSize = 1, sequenceName = "funcionalidade_id_funcionalidade_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Funcionalidade")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_FUNCIONAL_PAI", columnDefinition = "int4")
	private Funcionalidade pai;

	@Column(name = "DSC_FUNCIONALIDADE", nullable = false)
	private String detalhamento;

	@Column(name = "NOM_FUNCIONALIDADE", nullable = false)
	private String nome;

	@Column(name = "NOM_ROLE", nullable = false)
	private String role;

	@Transient
	private List<Funcionalidade> filhos = new ArrayList<Funcionalidade>();

	@Transient
	private List<Funcionalidade> filhosExcluir = new ArrayList<Funcionalidade>();

	@Transient
	private TreeNode node;

	public Funcionalidade() {
	}

	public Funcionalidade(Integer id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((detalhamento == null) ? 0 : detalhamento.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((role == null) ? 0 : role.hashCode());
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + ((pai == null) ? 0 : pai.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Funcionalidade other = (Funcionalidade) obj;
		if (detalhamento == null) {
			if (other.detalhamento != null)
				return false;
		} else if (!detalhamento.equals(other.detalhamento))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (role == null) {
			if (other.role != null)
				return false;
		} else if (!role.equals(other.role))
			return false;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		if (pai == null) {
			if (other.pai != null)
				return false;
		} else if (!pai.equals(other.pai))
			return false;
		return true;
	}

	public Funcionalidade getPai() {
		return pai;
	}

	public void setPai(Funcionalidade pai) {
		this.pai = pai;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public List<Funcionalidade> getFilhos() {
		return filhos;
	}

	public void setFilhos(List<Funcionalidade> filhos) {
		this.filhos = filhos;
	}

	public List<Funcionalidade> getFilhosExcluir() {
		return filhosExcluir;
	}

	public void setFilhosExcluir(List<Funcionalidade> filhosExcluir) {
		this.filhosExcluir = filhosExcluir;
	}

	public TreeNode getNode() {
		return node;
	}

	public void setNode(TreeNode node) {
		this.node = node;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public String getDetalhamento() {
		return detalhamento;
	}

	public void setDetalhamento(String detalhamento) {
		this.detalhamento = detalhamento;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
