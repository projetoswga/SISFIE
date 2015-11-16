package br.com.sisfie.entidade;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToOne;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import org.hibernate.envers.Audited;

import br.com.arquitetura.entidade.Entidade;

/**
 * The persistent class for the selecao_pacote database table.
 * 
 */
@Entity
@Table(name = "selecao_pacote", catalog = "SISFIE")
@Audited
public class SelecaoPacote extends Entidade<Integer> {
	private static final long serialVersionUID = 1L;

	@Id
	@Column(name = "id_selecao_pacote", unique = true, nullable = false)
	@SequenceGenerator(name = "selecaoPacote", allocationSize = 1, sequenceName = "selecao_pacote_id_selecao_pacote_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "selecaoPacote")
	private Integer id;

	// bi-directional one-to-one association to InscricaoCurso
	@OneToOne
	@JoinColumn(name = "id_inscricao_curso")
	private InscricaoCurso inscricaoCurso;

	// bi-directional many-to-one association to Pacote
	@ManyToOne
	@JoinColumn(name = "id_pacote")
	private Pacote pacote;

	public SelecaoPacote() {
	}

	public Integer getId() {
		return this.id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public InscricaoCurso getInscricaoCurso() {
		return this.inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	public Pacote getPacote() {
		return this.pacote;
	}

	public void setPacote(Pacote pacote) {
		this.pacote = pacote;
	}

}