package br.com.sisfie.entidade;

import java.sql.Timestamp;

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
@Table(name = "Frequencia", catalog = "SISFIE")
@Audited
public class Frequencia extends Entidade<Integer> {

	private static final long serialVersionUID = 6732893309744157963L;

	@Id
	@Column(name = "id_frequencia", unique = true, nullable = false)
	@SequenceGenerator(name = "Frequencia", allocationSize = 1, sequenceName = "frequencia_id_frequencia_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Frequencia")
	private Integer id;

	@Column(name = "horario_entrada")
	private Timestamp horarioEntrada;

	@Column(name = "horario_saida")
	private Timestamp horarioSaida;

	@Column(name = "num_incricao")
	private String numIncricao;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "id_grade_oficina")
	private GradeOficina gradeOficina;

	public Frequencia() {
	}

	public Frequencia(Integer id) {
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Timestamp getHorarioEntrada() {
		return this.horarioEntrada;
	}

	public void setHorarioEntrada(Timestamp horarioEntrada) {
		this.horarioEntrada = horarioEntrada;
	}

	public Timestamp getHorarioSaida() {
		return this.horarioSaida;
	}

	public void setHorarioSaida(Timestamp horarioSaida) {
		this.horarioSaida = horarioSaida;
	}

	public String getNumIncricao() {
		return this.numIncricao;
	}

	public void setNumIncricao(String numIncricao) {
		this.numIncricao = numIncricao;
	}

	public GradeOficina getGradeOficina() {
		return this.gradeOficina;
	}

	public void setGradeOficina(GradeOficina gradeOficina) {
		this.gradeOficina = gradeOficina;
	}

}