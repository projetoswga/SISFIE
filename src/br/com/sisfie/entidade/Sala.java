package br.com.sisfie.entidade;

import java.util.Set;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

/**
 * The persistent class for the sala database table.
 * 
 */
@Entity
@Table(name = "SALA", catalog = "SISFIE")
@Audited
public class Sala extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_sala", unique = true, nullable = false)
	@SequenceGenerator(name = "Sala", allocationSize = 1, sequenceName = "sala_id_sala_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Sala")
	private Integer id;

	@Column(name = "des_localizacao")
	private String desLocalizacao;

	@Column(name = "nom_sala")
	private String nomSala;

	@Column(name = "num_capacidade")
	private Integer numCapacidade;

	// bi-directional many-to-one association to Curso
	@ManyToOne
	@JoinColumn(name = "id_curso")
	private Curso curso;

	// bi-directional many-to-one association to GradeOficina
	@OneToMany(mappedBy = "sala")
	private Set<GradeOficina> gradeOficinas;

	public Sala() {
	}

	public Sala(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDesLocalizacao() {
		return this.desLocalizacao;
	}

	public void setDesLocalizacao(String desLocalizacao) {
		this.desLocalizacao = desLocalizacao;
	}

	public String getNomSala() {
		return this.nomSala;
	}

	public void setNomSala(String nomSala) {
		this.nomSala = nomSala;
	}

	public Integer getNumCapacidade() {
		return this.numCapacidade;
	}

	public void setNumCapacidade(Integer numCapacidade) {
		this.numCapacidade = numCapacidade;
	}

	public Curso getCurso() {
		return curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public Set<GradeOficina> getGradeOficinas() {
		return gradeOficinas;
	}

	public void setGradeOficinas(Set<GradeOficina> gradeOficinas) {
		this.gradeOficinas = gradeOficinas;
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
		Sala other = (Sala) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}