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

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;


/**
 * The persistent class for the pacote database table.
 * 
 */
@Entity
@Table(name="pacote", catalog = "SISFIE")
@Audited
public class Pacote extends Entidade<Integer>{
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name="id_pacote", unique = true, nullable = false)
	@SequenceGenerator(name="Pacote", allocationSize = 1, sequenceName = "pacote_id_pacote_seq")
	@GeneratedValue(strategy=GenerationType.SEQUENCE, generator="Pacote")
	private Integer id;

	@Column(name="nom_pacote")
	private String nomPacote;

	//bi-directional many-to-one association to PacoteOficina
	@OneToMany(mappedBy="pacote")
	private Set<PacoteOficina> pacoteOficinas = new HashSet<PacoteOficina>(0);

	//bi-directional many-to-one association to Curso
    @ManyToOne
	@JoinColumn(name="id_curso")
	private Curso curso;

    public Pacote() {
    }
    
    public Pacote(Integer id){
    	this.id = id;
    }

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNomPacote() {
		return this.nomPacote;
	}

	public void setNomPacote(String nomPacote) {
		this.nomPacote = nomPacote;
	}

	public Set<PacoteOficina> getPacoteOficinas() {
		return this.pacoteOficinas;
	}

	public void setPacoteOficinas(Set<PacoteOficina> pacoteOficinas) {
		this.pacoteOficinas = pacoteOficinas;
	}
	
	public Curso getCurso() {
		return this.curso;
	}

	public void setCurso(Curso curso) {
		this.curso = curso;
	}
	
}