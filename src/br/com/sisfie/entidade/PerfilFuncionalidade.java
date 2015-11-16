package br.com.sisfie.entidade;

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

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "PERFIL_FUNCIONALIDADE", catalog = "SISFIE")
@Audited
public class PerfilFuncionalidade extends Entidade<Integer> {

	private static final long serialVersionUID = 4396997992050270252L;

	@Id
	@Column(name = "ID_PERFIL_FUNCIONALIDADE", unique = true, nullable = false)
	@SequenceGenerator(name = "PerfilFuncionalidade", allocationSize = 1, sequenceName = "perfil_funcionalidade_id_perfil_funcionalidade_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PerfilFuncionalidade")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_FUNCIONALIDADE", referencedColumnName = "ID_FUNCIONALIDADE", nullable = false)
	private Funcionalidade funcionalidade;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_PERFIL", referencedColumnName = "ID_PERFIL")
	private Perfil perfil;

	public PerfilFuncionalidade() {
	}

	public PerfilFuncionalidade(Integer id) {
		this.id = id;
	}

	public Funcionalidade getFuncionalidade() {
		return funcionalidade;
	}

	public void setFuncionalidade(Funcionalidade funcionalidade) {
		this.funcionalidade = funcionalidade;
	}

	public Perfil getPerfil() {
		return perfil;
	}

	public void setPerfil(Perfil perfil) {
		this.perfil = perfil;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((funcionalidade == null) ? 0 : funcionalidade.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((perfil == null) ? 0 : perfil.hashCode());
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
		PerfilFuncionalidade other = (PerfilFuncionalidade) obj;
		if (funcionalidade == null) {
			if (other.funcionalidade != null)
				return false;
		} else if (!funcionalidade.equals(other.funcionalidade))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (perfil == null) {
			if (other.perfil != null)
				return false;
		} else if (!perfil.equals(other.perfil))
			return false;
		return true;
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

}
