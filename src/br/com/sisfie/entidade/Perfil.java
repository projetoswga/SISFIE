package br.com.sisfie.entidade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;
import br.com.arquitetura.util.Combo;

@Entity
@Table(name = "PERFIL", catalog = "SISFIE")
@Audited
public class Perfil extends Entidade<Integer> implements Combo {

	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "ID_PERFIL", unique = true, nullable = false)
	@SequenceGenerator(name = "Perfil", allocationSize = 1, sequenceName = "perfil_id_perfil_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Perfil")
	private Integer id;

	@Column(name = "DSC_DESCRICAO", nullable = false)
	private String descricao;

	public Perfil() {
	}

	public Perfil(Integer id) {
		this.id = id;
	}

	public String getDescricao() {
		return descricao;
	}

	public void setDescricao(String descricao) {
		this.descricao = descricao;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((descricao == null) ? 0 : descricao.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
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
		Perfil other = (Perfil) obj;
		if (descricao == null) {
			if (other.descricao != null)
				return false;
		} else if (!descricao.equals(other.descricao))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	@Override
	public String getValue() {
		return this.descricao;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
