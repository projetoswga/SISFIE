package br.com.sisfie.entidade;

import java.util.HashSet;
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
import javax.persistence.Transient;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

/**
 * The persistent class for the oficina database table.
 * 
 */
@Entity
@Table(name = "oficina", catalog = "SISFIE")
@Audited
public class Oficina extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_oficina", unique = true, nullable = false)
	@SequenceGenerator(name = "Oficina", allocationSize = 1, sequenceName = "oficina_id_oficina_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Oficina")
	private Integer id;

	@Column(name = "cod_oficina")
	private String codOficina;

	@Column(name = "nom_oficina")
	private String nomOficina;

	@Column(name = "num_carga_horaria")
	private Short numCargaHoraria;

	// bi-directional many-to-one association to Curso
	@ManyToOne
	@JoinColumn(name = "id_curso")
	private Curso curso;

	// bi-directional many-to-one association to PacoteOficina
	@OneToMany(mappedBy = "oficina")
	private Set<PacoteOficina> pacoteOficinas = new HashSet<PacoteOficina>(0);
	
	@OneToMany(mappedBy = "oficina")
	private Set<GradeOficina> gradeOficinas = new HashSet<GradeOficina>(0);

	@Transient
	private String cargaHorariaFormat;

	@Transient
	private ProfessorEvento professor;

	public Oficina() {
	}

	public Oficina(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getCodOficina() {
		return this.codOficina;
	}

	public void setCodOficina(String codOficina) {
		this.codOficina = codOficina;
	}

	public String getNomOficina() {
		return this.nomOficina;
	}

	public void setNomOficina(String nomOficina) {
		this.nomOficina = nomOficina;
	}

	public Curso getCurso() {
		return this.curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public Set<PacoteOficina> getPacoteOficinas() {
		return this.pacoteOficinas;
	}

	public void setPacoteOficinas(Set<PacoteOficina> pacoteOficinas) {
		this.pacoteOficinas = pacoteOficinas;
	}

	public Short getNumCargaHoraria() {
		return numCargaHoraria;
	}

	public void setNumCargaHoraria(Short numCargaHoraria) {
		this.numCargaHoraria = numCargaHoraria;
	}

	public String getCargaHorariaFormat() {
		if (numCargaHoraria != null) {
			cargaHorariaFormat = numCargaHoraria + ":00";
		}
		return cargaHorariaFormat;
	}

	public void setCargaHorariaFormat(String cargaHorariaFormat) {
		this.cargaHorariaFormat = cargaHorariaFormat;
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
		Oficina other = (Oficina) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

	public ProfessorEvento getProfessor() {
		return professor;
	}

	public void setProfessor(ProfessorEvento professor) {
		this.professor = professor;
	}

	public Set<GradeOficina> getGradeOficinas() {
		return gradeOficinas;
	}

	public void setGradeOficinas(Set<GradeOficina> gradeOficinas) {
		this.gradeOficinas = gradeOficinas;
	}
}