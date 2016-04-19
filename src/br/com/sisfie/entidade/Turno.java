package br.com.sisfie.entidade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

/**
 * The persistent class for the turno database table.
 * 
 */
@Entity
@Table(name = "turno", catalog = "SISFIE")
@Audited
public class Turno extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;
	
	public static final Integer MATUTINO = 1;
	public static final Integer VESPERTINO = 2;
	public static final Integer AMBOS = 3;

	@Id
	@Column(name = "id_turno", unique = true, nullable = false)
	private Integer id;

	@Column(name = "des_turno")
	private String desTurno;
	
	public Turno() {
	}
	
	public Turno(Integer id){
		this.id = id;
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getDesTurno() {
		return this.desTurno;
	}

	public void setDesTurno(String desTurno) {
		this.desTurno = desTurno;
	}

}