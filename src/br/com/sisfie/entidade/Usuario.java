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
import javax.persistence.Transient;

import org.hibernate.envers.Audited;
import org.hibernate.validator.constraints.Email;

import br.com.arquitetura.entidade.Entidade;

@Entity
@Table(name = "USUARIO", catalog = "SISFIE")
@Audited
public class Usuario extends Entidade<Integer> {

	private static final long serialVersionUID = -4934269009612475727L;

	@Id
	@Column(name = "ID_USUARIO", unique = true, nullable = false)
	@SequenceGenerator(name = "Usuario", allocationSize = 1, sequenceName = "usuario_id_usuario_seq")
	@GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "Usuario")
	private Integer id;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_PERFIL", referencedColumnName = "ID_PERFIL")
	private Perfil perfil;
	
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "ID_SETOR_RESPONSAVEL_ESAF", referencedColumnName = "id_setor_responsavel_esaf")
	private SetorResponsavelEsaf setorResponsavelEsaf;


	@Column(name = "NOM_USUARIO", nullable = false)
	private String nome;

	@Column(name = "LOGIN", nullable = false, unique = true)
	private String login;

	@Column(name = "SENHA", nullable = false)
	private String senha;

	@Email(message = "Email inválido")
	@Column(name = "EMAIL", nullable = false)
	private String email;

	@Column(name = "FLG_ATIVO", nullable = false)
	private Boolean flgAtivo;

	@Transient
	private String ativoFormat;

	public Usuario() {
	}

	public Usuario(Integer id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}

	public void setNome(String nome) {
		this.nome = nome;
	}

	public String getLogin() {
		return login;
	}

	public void setLogin(String login) {
		this.login = login;
	}

	public String getSenha() {
		return senha;
	}

	public void setSenha(String senha) {
		this.senha = senha;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((email == null) ? 0 : email.hashCode());
		result = prime * result + ((id == null) ? 0 : id.hashCode());
		result = prime * result + ((login == null) ? 0 : login.hashCode());
		result = prime * result + ((nome == null) ? 0 : nome.hashCode());
		result = prime * result + ((senha == null) ? 0 : senha.hashCode());
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
		Usuario other = (Usuario) obj;
		if (email == null) {
			if (other.email != null)
				return false;
		} else if (!email.equals(other.email))
			return false;
		if (id == null) {
			if (other.id != null)
				return false;
		} else if (!id.equals(other.id))
			return false;
		if (login == null) {
			if (other.login != null)
				return false;
		} else if (!login.equals(other.login))
			return false;
		if (nome == null) {
			if (other.nome != null)
				return false;
		} else if (!nome.equals(other.nome))
			return false;
		if (senha == null) {
			if (other.senha != null)
				return false;
		} else if (!senha.equals(other.senha))
			return false;
		return true;
	}

	public String getAtivoFormat() {
		if (flgAtivo != null && flgAtivo) {
			return "Sim";
		} else {
			return "Não";
		}
	}

	public void setAtivoFormat(String ativoFormat) {
		this.ativoFormat = ativoFormat;
	}

	public Boolean getFlgAtivo() {
		return flgAtivo;
	}

	public void setFlgAtivo(Boolean flgAtivo) {
		this.flgAtivo = flgAtivo;
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

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public SetorResponsavelEsaf getSetorResponsavelEsaf() {
		return setorResponsavelEsaf;
	}

	public void setSetorResponsavelEsaf(SetorResponsavelEsaf setorResponsavelEsaf) {
		this.setorResponsavelEsaf = setorResponsavelEsaf;
	}
	
	

}
