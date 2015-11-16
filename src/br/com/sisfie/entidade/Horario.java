package br.com.sisfie.entidade;

import java.util.Date;
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
import br.com.arquitetura.util.DateUtil;

/**
 * The persistent class for the horario database table.
 * 
 */
@Entity
@Table(name = "horario", catalog = "SISFIE")
@Audited
public class Horario extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_horario", unique = true, nullable = false)
	@SequenceGenerator(name = "horario", allocationSize = 1, sequenceName = "horario_id_horario_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "horario")
	private Integer id;

	@Column(name = "dat_hora_fim")
	private Date datHoraFim;

	@Column(name = "dat_hora_inicio")
	private Date datHoraInicio;

	@Column(name = "des_horario")
	private String desHorario;

	// bi-directional many-to-one association to GradePacote
	@OneToMany(mappedBy = "horario")
	private Set<GradePacote> gradePacotes = new HashSet<GradePacote>(0);

	@OneToMany(mappedBy = "horario")
	private Set<GradeOficina> gradeOficinas = new HashSet<GradeOficina>(0);

	// bi-directional many-to-one association to Curso
	@ManyToOne
	@JoinColumn(name = "id_curso")
	private Curso curso;

	@Transient
	private String datHoraInicioFormat;

	@Transient
	private String datHoraFimFormat;

	public Horario() {
	}

	public Horario(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getDatHoraFim() {
		return this.datHoraFim;
	}

	public void setDatHoraFim(Date datHoraFim) {
		this.datHoraFim = datHoraFim;
	}

	public Date getDatHoraInicio() {
		return this.datHoraInicio;
	}

	public void setDatHoraInicio(Date datHoraInicio) {
		this.datHoraInicio = datHoraInicio;
	}

	public String getDesHorario() {
		return this.desHorario;
	}

	public void setDesHorario(String desHorario) {
		this.desHorario = desHorario;
	}

	public Set<GradePacote> getGradePacotes() {
		return this.gradePacotes;
	}

	public void setGradePacotes(Set<GradePacote> gradePacotes) {
		this.gradePacotes = gradePacotes;
	}

	public Curso getCurso() {
		return this.curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}

	public String getDatHoraInicioFormat() {
		if (datHoraInicio != null) {
			return DateUtil.getDataHora(datHoraInicio, "dd/MM/yyyy HH:mm");
		}
		return datHoraInicioFormat;
	}

	public void setDatHoraInicioFormat(String datHoraInicioFormat) {
		this.datHoraInicioFormat = datHoraInicioFormat;
	}

	public String getDatHoraFimFormat() {
		if (datHoraFim != null) {
			return DateUtil.getDataHora(datHoraFim, "dd/MM/yyyy HH:mm");
		}
		return datHoraFimFormat;
	}

	public void setDatHoraFimFormat(String datHoraFimFormat) {
		this.datHoraFimFormat = datHoraFimFormat;
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
		Horario other = (Horario) obj;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		return true;
	}

}