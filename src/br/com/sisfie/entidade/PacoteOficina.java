package br.com.sisfie.entidade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

/**
 * The persistent class for the pacote_oficinas database table.
 * 
 */
@Entity
@Table(name = "pacote_oficina", catalog = "SISFIE")
@Audited
public class PacoteOficina extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_pacote_oficina", unique = true, nullable = false)
	@SequenceGenerator(name = "PacoteOficina", allocationSize = 1, sequenceName = "pacote_oficina_id_pacote_oficina_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "PacoteOficina")
	private Integer id;

	// bi-directional many-to-one association to Oficina
	@ManyToOne
	@JoinColumn(name = "id_oficina")
	private Oficina oficina;

	// bi-directional many-to-one association to Pacote
	@ManyToOne
	@JoinColumn(name = "id_pacote")
	private Pacote pacote;

	public PacoteOficina() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Oficina getOficina() {
		return this.oficina;
	}

	public void setOficina(Oficina oficina) {
		this.oficina = oficina;
	}

	public Pacote getPacote() {
		return this.pacote;
	}

	public void setPacote(Pacote pacote) {
		this.pacote = pacote;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
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
		PacoteOficina other = (PacoteOficina) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}