package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashSet;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.model.SelectItem;

import br.com.arquitetura.bean.BaseBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.ComboUtil;
import br.com.arquitetura.util.ConstantesARQ;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.dataModel.CampoPreenchimentoDataModel;
import br.com.sisfie.dataModel.EsferaGovernoDataModel;
import br.com.sisfie.dataModel.HomologacaoDataModel;
import br.com.sisfie.dataModel.OpcaoDataModel;
import br.com.sisfie.entidade.Area;
import br.com.sisfie.entidade.AreaConhecimento;
import br.com.sisfie.entidade.AreaConhecimentoCurso;
import br.com.sisfie.entidade.CampoPreenchimento;
import br.com.sisfie.entidade.CandidatoPreenchimento;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.EmailCursoPrivado;
import br.com.sisfie.entidade.EsferaCurso;
import br.com.sisfie.entidade.EsferaGoverno;
import br.com.sisfie.entidade.Homologacao;
import br.com.sisfie.entidade.HomologacaoCurso;
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.Localizacao;
import br.com.sisfie.entidade.Municipio;
import br.com.sisfie.entidade.MunicipioCurso;
import br.com.sisfie.entidade.Oficina;
import br.com.sisfie.entidade.OpcaoListaCandidato;
import br.com.sisfie.entidade.Orgao;
import br.com.sisfie.entidade.OrgaoCurso;
import br.com.sisfie.entidade.Pacote;
import br.com.sisfie.entidade.ProfessorEvento;
import br.com.sisfie.entidade.Sala;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusCurso;
import br.com.sisfie.entidade.Turma;
import br.com.sisfie.entidade.Turno;
import br.com.sisfie.entidade.Uf;
import br.com.sisfie.entidade.UfCurso;
import br.com.sisfie.service.AreaConhecimentoService;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.OrgaoService;
import br.com.sisfie.util.Constantes;
import br.com.sisfie.util.EmailUtil;
import br.com.sisfie.util.TipoEmail;

@ManagedBean(name = "CadastrarCursoBean")
@ViewScoped
public class CadastrarCursoBean extends BaseBean<Curso> {

	private static final long serialVersionUID = 1L;

	// service
	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{login}")
	protected LoginBean loginBean;

	@ManagedProperty(value = "#{OrgaoService}")
	protected OrgaoService orgaoService;

	@ManagedProperty(value = "#{areaConhecimentoService}")
	protected AreaConhecimentoService areaConhecimentoService;

	// Listas
	private List<Area> areas;
	private List<Localizacao> locais;
	private List<UfCurso> ufCursos;
	private List<MunicipioCurso> municipioCursos;
	private OpcaoDataModel opcaoDataModel;
	private HomologacaoDataModel homologacaoDataModel;
	private EsferaGovernoDataModel esferaGovernoDataModel;
	private CampoPreenchimentoDataModel preenchimentoDataModel;
	private List<SelectItem> turmas;
	private List<Turno> turnos;
	private List<AreaConhecimentoCurso> areaConhecimentoCursos;
	private List<EmailCursoPrivado> emailsCursoPrivado;
	private List<EmailCursoPrivado> emailsParceiros;
	private List<EmailCursoPrivado> emailsInstrutores;
	private List<OrgaoCurso> orgaoCursos;

	// dto para Model
	private Integer idArea;
	private Integer idLocal;
	private Integer idTurma;
	private Orgao orgaoSelecionado;
	private Integer idTurno;
	private String email;
	private String emailParceiro;
	private String emailInstrutor;

	// 1-Por Data de Fim de Inscrição 2-Determinada pelo Gesto
	private Integer idTipoInscricao;
	private boolean cursoPorRegiao;
	private OpcaoListaCandidato opcaoListaCandidato;
	private Homologacao[] homologacao;
	private EsferaGoverno[] esferaGoverno;
	private CampoPreenchimento[] campoPreenchimento;
	private boolean enviarEmailParceiros = true;

	// Controle de tela
	private Uf uf;
	private Municipio municipio;
	private UfCurso ufCursoDelete;
	private EmailCursoPrivado emailDelete;
	private EmailCursoPrivado emailDeleteParceiro;
	private EmailCursoPrivado emailDeleteInstrutor;
	private MunicipioCurso municipioCurso;
	private Date hoje = new Date();
	private String numeroVagas;
	private AreaConhecimento areaConhecimentoSelecionada;
	private AreaConhecimentoCurso areaConhecimentoCursoExclusao;
	private Orgao orgaoParticipanteSelecionado;
	private OrgaoCurso orgaoCursoExclusao;

	public CadastrarCursoBean() {
		areas = new ArrayList<Area>();
		ufCursos = new ArrayList<UfCurso>();
		municipioCursos = new ArrayList<MunicipioCurso>();
		locais = new ArrayList<Localizacao>();
		turnos = new ArrayList<Turno>();
		areaConhecimentoSelecionada = new AreaConhecimento();
		areaConhecimentoCursoExclusao = new AreaConhecimentoCurso();
		areaConhecimentoCursos = new ArrayList<AreaConhecimentoCurso>();
		emailsCursoPrivado = new ArrayList<EmailCursoPrivado>();
		emailsParceiros = new ArrayList<EmailCursoPrivado>();
		emailsInstrutores = new ArrayList<EmailCursoPrivado>();
		orgaoParticipanteSelecionado = new Orgao();
		orgaoCursoExclusao = new OrgaoCurso();
		orgaoCursos = new ArrayList<>();
	}

	@SuppressWarnings("unchecked")
	@PostConstruct
	public void carregarTela() {
		try {
			verificarAcesso();

			Integer idCurso = (Integer) getSessionMap().remove("idCurso");
			Boolean clone = (Boolean) getSessionMap().remove("clone");
			if (idCurso != null) {
				loadCurso(idCurso);
			}
			if (clone != null && clone) {
				loadCurso(idCurso);
				Curso cursoClone = (Curso) getModel().clone();
				cursoClone.setId(null);
				setModel(cursoClone);
				getModel().setUfCursos(new HashSet<UfCurso>());
				getModel().setMunicipioCursos(new HashSet<MunicipioCurso>());
				getModel().setAreaConhecimentoCursos(new HashSet<AreaConhecimentoCurso>());
				getModel().setOrgaoCursos(new HashSet<OrgaoCurso>());
				getModel().setClonar(clone);

				// Caso o curso clonado ja tenha sido finalizado
				getModel().setFlgFinalizado(false);

				for (UfCurso uf : ufCursos) {
					uf.setId(null);
					uf.setCurso(getModel());
				}
				for (MunicipioCurso muni : municipioCursos) {
					muni.setId(null);
					muni.setCurso(getModel());
				}
				for (AreaConhecimentoCurso areaConhecimentoCurso : areaConhecimentoCursos) {
					areaConhecimentoCurso.setId(null);
					areaConhecimentoCurso.setCurso(getModel());
				}
				for (OrgaoCurso orgaoCurso : orgaoCursos) {
					orgaoCurso.setId(null);
					orgaoCurso.setCurso(getModel());
				}

				// Carregando novamente as turmas pois estava dando a exceção collection is not associated with any session
				if (getModel().getFlgPossuiOficina()) {
					getModel().setHorarios(new HashSet<Horario>(0));
					getModel().setTurmas(new HashSet<Turma>(0));
					getModel().setSalas(new HashSet<Sala>(0));
					getModel().setProfessorEventos(new HashSet<ProfessorEvento>(0));
					getModel().setOficinas(new HashSet<Oficina>(0));
					getModel().setPacotes(new HashSet<Pacote>(0));

					Horario h = new Horario();
					h.setCurso(new Curso(idCurso));
					getModel().getHorarios().addAll(universalManager.listBy(h));

					Turma t = new Turma();
					t.setCurso(new Curso(idCurso));
					getModel().getTurmas().addAll(universalManager.listBy(t));

					Sala s = new Sala();
					s.setCurso(new Curso(idCurso));
					getModel().getSalas().addAll(universalManager.listBy(s));

					ProfessorEvento pe = new ProfessorEvento();
					pe.setCurso(new Curso(idCurso));
					getModel().getProfessorEventos().addAll(universalManager.listBy(pe));

					Oficina o = new Oficina();
					o.setCurso(new Curso(idCurso));
					getModel().getOficinas().addAll(universalManager.listBy(o));

					Pacote p = new Pacote();
					p.setCurso(new Curso(idCurso));
					getModel().getPacotes().addAll(universalManager.listBy(p));
				}
			}

			if (areas.isEmpty()) {
				Area area = new Area();
				area.setFlgAtivo(true);
				areas = universalManager.listBy(area);
				Collections.sort(areas, new Comparator<Area>() {
					@Override
					public int compare(Area o1, Area o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
			}

			if (turmas == null || turmas.isEmpty()) {
				turmas = new ArrayList<SelectItem>();
				Turma turma = new Turma();
				turma.setFlgAtivo(true);
				turmas = ComboUtil.getItens(universalManager.listBy(turma));
				Collections.sort(turmas, new Comparator<SelectItem>() {

					@Override
					public int compare(SelectItem o1, SelectItem o2) {
						return o1.getLabel().trim().compareTo(o2.getLabel().trim());
					}
				});
			}

			if (homologacaoDataModel == null) {
				Homologacao homologacao = new Homologacao();
				homologacao.setFlgAtivo(true);
				List<Homologacao> listaHomologacao = universalManager.listBy(homologacao);
				Collections.sort(listaHomologacao, new Comparator<Homologacao>() {
					@Override
					public int compare(Homologacao o1, Homologacao o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
				homologacaoDataModel = new HomologacaoDataModel(listaHomologacao);
			}
			if (esferaGovernoDataModel == null)

			{
				EsferaGoverno esfera = new EsferaGoverno();
				esfera.setFlgAtivo(true);
				List<EsferaGoverno> listaEsfera = universalManager.listBy(esfera);
				Collections.sort(listaEsfera, new Comparator<EsferaGoverno>() {
					@Override
					public int compare(EsferaGoverno o1, EsferaGoverno o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
				esferaGovernoDataModel = new EsferaGovernoDataModel(listaEsfera);
			}
			if (preenchimentoDataModel == null)

			{
				CampoPreenchimento campo = new CampoPreenchimento();
				campo.setFlgAtivo(true);
				List<CampoPreenchimento> listaCampo = universalManager.listBy(campo);
				Collections.sort(listaCampo, new Comparator<CampoPreenchimento>() {
					@Override
					public int compare(CampoPreenchimento o1, CampoPreenchimento o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
				preenchimentoDataModel = new CampoPreenchimentoDataModel(listaCampo);
			}
			if (opcaoDataModel == null)

			{
				OpcaoListaCandidato opcao = new OpcaoListaCandidato();
				opcao.setFlgAtivo(true);
				List<OpcaoListaCandidato> opcaoListaCandidatos = universalManager.listBy(opcao);
				Collections.sort(opcaoListaCandidatos, new Comparator<OpcaoListaCandidato>() {
					@Override
					public int compare(OpcaoListaCandidato o1, OpcaoListaCandidato o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
				opcaoDataModel = new OpcaoDataModel(opcaoListaCandidatos);
			}
			if (locais.isEmpty())

			{
				locais = universalManager.getAll(Localizacao.class);
				Collections.sort(locais, new Comparator<Localizacao>() {
					@Override
					public int compare(Localizacao o1, Localizacao o2) {
						return o1.getDescricao().trim().compareTo(o2.getDescricao());
					}
				});
			}
			if (turnos.isEmpty())

			{
				turnos = universalManager.getAll(Turno.class);
			}
		} catch (

		Exception e)

		{
			ExcecaoUtil.tratarExcecao(e);
		}

	}

	public void adicionarAreaConhecimento() {
		try {
			if (areaConhecimentoSelecionada == null || areaConhecimentoSelecionada.getId() == null) {
				FacesMessagesUtil.addErrorMessage("Área de Conhecimento ", "Inexistente!");
				return;
			}
			AreaConhecimentoCurso areaConhecimentoCurso = new AreaConhecimentoCurso();
			areaConhecimentoCurso.setAreaConhecimento(areaConhecimentoSelecionada);
			for (AreaConhecimentoCurso area : areaConhecimentoCursos) {
				if (area.getAreaConhecimento().getId().equals(areaConhecimentoSelecionada.getId())) {
					FacesMessagesUtil.addErrorMessage("Área de Conhecimento ", "Já adicionada");
					return;
				}
			}
			areaConhecimentoCursos.add(areaConhecimentoCurso);
			areaConhecimentoSelecionada = new AreaConhecimento();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}
	
	public void adicionarOrgaoParticipante() {
		try {
			if (orgaoParticipanteSelecionado == null || orgaoParticipanteSelecionado.getId() == null) {
				FacesMessagesUtil.addErrorMessage("Órgão Participante ", "Inexistente!");
				return;
			}
			OrgaoCurso orgaoCurso = new OrgaoCurso();
			orgaoCurso.setOrgao(orgaoParticipanteSelecionado);
			for (OrgaoCurso orgaoPart : orgaoCursos) {
				if (orgaoPart.getOrgao().getId().equals(orgaoParticipanteSelecionado.getId())) {
					FacesMessagesUtil.addErrorMessage("Órgão Participante ", "Já adicionado");
					return;
				}
			}
			orgaoCursos.add(orgaoCurso);
			orgaoParticipanteSelecionado = new Orgao();
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void excluirAreaConhecimentoCurso() {
		if (areaConhecimentoCursoExclusao != null) {
			try {
				areaConhecimentoCursos.remove(areaConhecimentoCursoExclusao);
				if (areaConhecimentoCursoExclusao.getId() != null) {
					getModel().getExclusaoAreaConhecimentoCursos().add(areaConhecimentoCursoExclusao);
				}
				FacesMessagesUtil.addInfoMessage("Área de Conhecimento", "Removida com sucesso!");
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
	}
	
	public void excluirOrgaoParticipante() {
		if (orgaoCursoExclusao != null) {
			try {
				orgaoCursos.remove(orgaoCursoExclusao);
				if (orgaoCursoExclusao.getId() != null) {
					getModel().getExclusaoOrgaoParticipanteCursos().add(orgaoCursoExclusao);
				}
				FacesMessagesUtil.addInfoMessage("Órgão Participante", "Removido com sucesso!");
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
	}

	@SuppressWarnings("unchecked")
	public List<AreaConhecimento> completeAreaConhecimento(String query) {
		List<AreaConhecimento> sugestoes = new ArrayList<AreaConhecimento>();
		try {
			if (query != null && !query.isEmpty()) {
				sugestoes = areaConhecimentoService.pesquisarAreaConhecimento(query);
			} else {
				sugestoes.addAll(universalManager.getAll(AreaConhecimento.class));
			}
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;
	}

	public void habilitarAreasConhecimento() {
	}

	public List<Orgao> completeOrgao(String query) {
		List<Orgao> sugestoes = new ArrayList<Orgao>();
		try {
			sugestoes = orgaoService.pesquisarOrgao(query);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}

		return sugestoes;
	}

	@Override
	public void verificarAcesso() {
		acessoBean.bloquearTela("ROLE_CURSO_CADASTRO");
	}

	public void loadCurso(Integer idCurso) {
		setModel((Curso) universalManager.get(Curso.class, idCurso));

		if (getModel().getArea() != null && getModel().getArea().getId() != null) {
			idArea = getModel().getArea().getId();
		}
		if (getModel().getTurno() != null && getModel().getTurno().getId() != null) {
			idTurno = getModel().getTurno().getId();
		}
		idLocal = getModel().getLocalizacao().getId();
		if (getModel().getVagas() != null) {
			numeroVagas = getModel().getVagas().toString();
		} else {
			numeroVagas = null;
		}
		if (getModel().getFlgDataAtivo()) {
			idTipoInscricao = 1;
		} else {
			idTipoInscricao = 2;
		}

		cursoPorRegiao = getModel().getFlgRegiaoAtivo();
		opcaoListaCandidato = getModel().getOpcaoListaCandidato();

		List<Homologacao> listaHomologacao = new ArrayList<Homologacao>();
		for (HomologacaoCurso hom : getModel().getHomologacaoCursos()) {
			listaHomologacao.add(hom.getHomologacao());
		}
		if (listaHomologacao != null && !listaHomologacao.isEmpty()) {
			homologacao = new Homologacao[listaHomologacao.size()];
			for (int i = 0; i < listaHomologacao.size(); i++) {
				homologacao[i] = listaHomologacao.get(i);
			}
		}

		List<EsferaGoverno> listaEsfera = new ArrayList<EsferaGoverno>();
		for (EsferaCurso esfera : getModel().getEsferaCurso()) {
			listaEsfera.add(esfera.getEsferaGoverno());
		}
		if (listaEsfera != null && !listaEsfera.isEmpty()) {
			esferaGoverno = new EsferaGoverno[listaEsfera.size()];
			for (int i = 0; i < listaEsfera.size(); i++) {
				esferaGoverno[i] = listaEsfera.get(i);
			}
		}
		List<CampoPreenchimento> listaCampo = new ArrayList<CampoPreenchimento>();
		for (CandidatoPreenchimento cp : getModel().getCandidatoPreenchimentos()) {
			listaCampo.add(cp.getCampoPreenchimento());
		}
		if (listaCampo != null && !listaCampo.isEmpty()) {
			campoPreenchimento = new CampoPreenchimento[listaCampo.size()];
			for (int i = 0; i < listaCampo.size(); i++) {
				campoPreenchimento[i] = listaCampo.get(i);
			}
		}
		if (getModel().getUfCursos() != null && !getModel().getUfCursos().isEmpty()) {
			ufCursos = new ArrayList<UfCurso>(getModel().getUfCursos());
		}
		if (getModel().getMunicipioCursos() != null && !getModel().getMunicipioCursos().isEmpty()) {
			municipioCursos = new ArrayList<MunicipioCurso>(getModel().getMunicipioCursos());
		}

		if (getModel().getOrgao() != null && getModel().getOrgao().getId() != null) {
			orgaoSelecionado = getModel().getOrgao();
		}

		if (getModel().getAreaConhecimentoCursos() != null && !getModel().getAreaConhecimentoCursos().isEmpty()) {
			areaConhecimentoCursos = new ArrayList<AreaConhecimentoCurso>(getModel().getAreaConhecimentoCursos());
		}
		if (getModel().getOrgaoCursos() != null && !getModel().getOrgaoCursos().isEmpty()) {
			orgaoCursos = new ArrayList<OrgaoCurso>(getModel().getOrgaoCursos());
		}
		if (getModel().getEmailsCursoPrivado() != null && !getModel().getEmailsCursoPrivado().isEmpty()) {
			emailsParceiros = new ArrayList<>();
			emailsCursoPrivado = new ArrayList<>();
			emailsInstrutores = new ArrayList<>();
			for (EmailCursoPrivado email : getModel().getEmailsCursoPrivado()) {
				if (email.getTipo() != null){
					if (email.getTipo().equals(TipoEmail.PRIVADO.getTipo())){
						emailsCursoPrivado.add(email);
					} else if (email.getTipo().equals(TipoEmail.INSTRUTOR.getTipo())){
						emailsInstrutores.add(email);
					} else if (email.getTipo().equals(TipoEmail.PARCEIRO.getTipo())) {
						emailsParceiros.add(email);
					}
				}
			}
		}

		// setando os valores antigos para verificar se manda ou não email na edição
		getModel().setIdLocalOld(idLocal);
		getModel().setDataRealizacaoInicioOld(getModel().getDtRealizacaoInicio());
		getModel().setDataRealizacaoFimOld(getModel().getDtRealizacaoFim());

	}

	public void limparInscricao() {
		getModel().setDtTerminoInscricao(null);
	}

	public void limparRegiao() {
		ufCursos = new ArrayList<UfCurso>();
		municipioCursos = new ArrayList<MunicipioCurso>();
	}

	public List<Uf> completeUF(String query) {
		List<Uf> sugestoes = new ArrayList<Uf>();
		Uf a = new Uf();
		a.setSigla(query);
		a.setDescricao(query);
		try {
			sugestoes = cursoService.completeUF(a);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return sugestoes;

	}

	public List<Uf> completeMunicipio(String query) {
		List<Uf> sugestoes = new ArrayList<Uf>();
		Municipio municipio = new Municipio();
		municipio.setDescricao(query);
		try {
			sugestoes = cursoService.completeMunicipio(municipio, ufCursos);
		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
		return sugestoes;

	}

	public void deleteUf() {
		// se tiver Id tem que remover do BD
		if (ufCursoDelete.getId() != null) {
			getModel().getExclusaoUfCursos().add(ufCursoDelete);
		}

		// se remover uf tem que tirar todos municipios daquela uf
		List<MunicipioCurso> listaMunicpio = new ArrayList<MunicipioCurso>();

		// Cria uma lista com os municipio que devem ficar e no else verifica se
		// tem id, se tiver tem que remover do BD
		for (MunicipioCurso municipioCurso : municipioCursos) {
			Municipio mun = (Municipio) universalManager.get(Municipio.class, municipioCurso.getMunicipio().getId());
			if (!mun.getUf().getId().equals(ufCursoDelete.getUf().getId())) {
				listaMunicpio.add(municipioCurso);
			} else {
				if (municipioCurso.getId() != null) {
					getModel().getExclusaoMunicipioCursos().add(municipioCurso);
				}
			}
		}
		ufCursos.remove(ufCursoDelete);
		municipioCursos = new ArrayList<MunicipioCurso>(listaMunicpio);

	}

	public void deleteMunicipio() {
		// se tiver Id tem que remover do BD
		if (municipioCurso.getId() != null) {
			getModel().getExclusaoMunicipioCursos().add(municipioCurso);
		}

		municipioCursos.remove(municipioCurso);
	}

	public void adicionarUf() {
		if (uf == null) {
			FacesMessagesUtil.addErrorMessage("UF ", Constantes.CAMPO_OBRIGATORIO);
			return;
		} else if (uf.getId() == null) {
			FacesMessagesUtil.addErrorMessage("UF ", "Inexistente!");
			return;
		}
		UfCurso ufCurso = new UfCurso();
		ufCurso.setUf(uf);
		ufCurso.setCurso(getModel());

		boolean contem = false;
		for (UfCurso list : ufCursos) {
			if (list.getUf().getId().equals(uf.getId())) {
				contem = true;
				break;
			}
		}
		if (contem) {
			FacesMessagesUtil.addErrorMessage("UF já adicionada ", " ");
			return;
		} else {
			ufCursos.add(ufCurso);
		}

		uf = new Uf();
	}

	public void adicionarEmail() {
		try {

			// Valida email invalido
			if (!EmailUtil.emailValido(email)) {
				FacesMessagesUtil.addErrorMessage("E-mail inválido ", " ");
				return;
			}

			// Valida se já foi adicionado
			boolean contem = false;
			for (EmailCursoPrivado cursoEmail : emailsCursoPrivado) {
				if (cursoEmail.getEmail().trim().toUpperCase().equals(email.trim().toUpperCase())) {
					contem = true;
					break;
				}
			}
			if (contem) {
				FacesMessagesUtil.addErrorMessage("E-mail ", "Já adicionado.");
				return;
			}

			// Relacionamento com curso será criado no service
			EmailCursoPrivado cursoEmail = new EmailCursoPrivado();
			cursoEmail.setEmail(email.trim());
			cursoEmail.setTipo(TipoEmail.PRIVADO.getTipo());
			emailsCursoPrivado.add(cursoEmail);

			email = "";
			FacesMessagesUtil.addInfoMessage("E-mail", "Adicionado com sucesso!");

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void adicionarEmailParceiro() {
		try {

			// Valida email invalido
			if (!EmailUtil.emailValido(emailParceiro)) {
				FacesMessagesUtil.addErrorMessage("E-mail inválido ", " ");
				return;
			}

			// Valida se já foi adicionado
			boolean contem = false;
			for (EmailCursoPrivado cursoEmail : emailsParceiros) {
				if (cursoEmail.getEmail().trim().toUpperCase().equals(emailParceiro.trim().toUpperCase())) {
					contem = true;
					break;
				}
			}
			if (contem) {
				FacesMessagesUtil.addErrorMessage("E-mail ", "Já adicionado.");
				return;
			}

			// Relacionamento com curso será criado no service
			EmailCursoPrivado cursoEmail = new EmailCursoPrivado();
			cursoEmail.setEmail(emailParceiro.trim());
			cursoEmail.setTipo(TipoEmail.PARCEIRO.getTipo());
			emailsParceiros.add(cursoEmail);

			emailParceiro = "";
			FacesMessagesUtil.addInfoMessage("E-mail", "Adicionado com sucesso!");

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void adicionarEmailInstrutor() {
		try {

			// Valida email invalido
			if (!EmailUtil.emailValido(emailInstrutor)) {
				FacesMessagesUtil.addErrorMessage("E-mail inválido ", " ");
				return;
			}

			// Valida se já foi adicionado
			boolean contem = false;
			for (EmailCursoPrivado cursoEmail : emailsInstrutores) {
				if (cursoEmail.getEmail().trim().toUpperCase().equals(emailInstrutor.trim().toUpperCase())) {
					contem = true;
					break;
				}
			}
			if (contem) {
				FacesMessagesUtil.addErrorMessage("E-mail ", "Já adicionado.");
				return;
			}

			// Relacionamento com curso será criado no service
			EmailCursoPrivado cursoEmail = new EmailCursoPrivado();
			cursoEmail.setEmail(emailInstrutor.trim());
			cursoEmail.setTipo(TipoEmail.INSTRUTOR.getTipo());
			emailsInstrutores.add(cursoEmail);

			emailInstrutor = "";
			FacesMessagesUtil.addInfoMessage("E-mail", "Adicionado com sucesso!");

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	public void deleteEmail() {
		// se tiver Id tem que remover do BD
		if (emailDelete.getId() != null) {
			getModel().getExclusaoCursoEmail().add(emailDelete);
		}

		emailsCursoPrivado.remove(emailDelete);
		FacesMessagesUtil.addInfoMessage("E-mail", "removido com sucesso!");

	}

	public void deleteEmailParceiro() {
		// se tiver Id tem que remover do BD
		if (emailDeleteParceiro.getId() != null) {
			getModel().getExclusaoCursoEmail().add(emailDeleteParceiro);
			getModel().getEmailsCursoPrivado().remove(emailDeleteParceiro);
		}

		emailsParceiros.remove(emailDeleteParceiro);
		FacesMessagesUtil.addInfoMessage("E-mail", "removido com sucesso!");

	}

	public void deleteEmailInstrutor() {
		// se tiver Id tem que remover do BD
		if (emailDeleteInstrutor.getId() != null) {
			getModel().getExclusaoCursoEmail().add(emailDeleteInstrutor);
			getModel().getEmailsCursoPrivado().remove(emailDeleteInstrutor);
		}

		emailsInstrutores.remove(emailDeleteInstrutor);
		FacesMessagesUtil.addInfoMessage("E-mail", "removido com sucesso!");

	}

	public void adicionarMunicipio() {
		if (municipio == null) {
			FacesMessagesUtil.addErrorMessage("Município ", Constantes.CAMPO_OBRIGATORIO);
			return;
		} else if (municipio.getId() == null) {
			FacesMessagesUtil.addErrorMessage("Município ", "Inexistente!");
			return;
		}
		MunicipioCurso municipioCurso = new MunicipioCurso();
		municipioCurso.setMunicipio(municipio);
		municipioCurso.setCurso(getModel());

		boolean contem = false;
		for (MunicipioCurso list : municipioCursos) {
			if (list.getMunicipio().getId().equals(municipio.getId())) {
				contem = true;
				break;
			}
		}
		if (contem) {
			FacesMessagesUtil.addErrorMessage("Município já adicionada ", " ");
			return;
		} else {
			municipioCursos.add(municipioCurso);
		}

		municipio = new Municipio();
	}

	@Override
	public String save() {
		try {
			if (!camposValidos()) {
				return "";
			}

			// Seta numero de vagas
			if (numeroVagas != null && !numeroVagas.trim().isEmpty()) {
				getModel().setVagas(Integer.valueOf(numeroVagas.trim()));
			} else {
				getModel().setVagas(null);
			}

			// Retira a formatação do codigo
			getModel().setCodigo(getModel().getCodigo().replaceAll("[()-.]", ""));

			// area
			if (idArea == null || idArea == 0) {
				getModel().setArea(null);
			} else {
				getModel().setArea(new Area(idArea));
			}
			if (idTurno == null || idTurno == 0) {
				getModel().setTurno(null);
			} else {
				getModel().setTurno(new Turno(idTurno));
			}
			// local
			getModel().setLocalizacao(new Localizacao(idLocal));
			// tipo Incricao
			if (idTipoInscricao.equals(1)) {
				getModel().setFlgDataAtivo(true);
			} else {
				getModel().setFlgDataAtivo(false);
			}
			// Região
			getModel().setFlgRegiaoAtivo(cursoPorRegiao);

			// Lista de espera
			getModel().setOpcaoListaCandidato(opcaoListaCandidato);

			// UF
			if (ufCursos != null && !ufCursos.isEmpty()) {
				getModel().getUfCursos().addAll(ufCursos);
			}
			// Municipio
			if (municipioCursos != null && !municipioCursos.isEmpty()) {
				getModel().getMunicipioCursos().addAll(municipioCursos);
			}

			// Homologacao
			getModel().setHomologacaoCursos(new HashSet<HomologacaoCurso>());
			for (Homologacao hom : homologacao) {
				HomologacaoCurso hc = new HomologacaoCurso();
				hc.setCurso(getModel());
				hc.setHomologacao(hom);
				getModel().getHomologacaoCursos().add(hc);
			}

			// Esfera Curso
			getModel().setEsferaCurso(new HashSet<EsferaCurso>());
			for (EsferaGoverno gov : esferaGoverno) {
				EsferaCurso ec = new EsferaCurso();
				ec.setCurso(getModel());
				ec.setEsferaGoverno(gov);
				getModel().getEsferaCurso().add(ec);
			}

			// Esfera Curso
			getModel().setCandidatoPreenchimentos(new HashSet<CandidatoPreenchimento>());
			for (CampoPreenchimento campo : campoPreenchimento) {
				CandidatoPreenchimento cp = new CandidatoPreenchimento();
				cp.setCurso(getModel());
				cp.setCampoPreenchimento(campo);
				getModel().getCandidatoPreenchimentos().add(cp);
			}

			// cria o status do curso
			if (getModel().getId() == null) {
				// inicializa pois aki sempre vai ser o primeiro cadastro.
				getModel().setStatusCursos(new HashSet<StatusCurso>());
				StatusCurso statusCurso = new StatusCurso();
				statusCurso.setCurso(getModel());
				statusCurso.setDtAtualizacao(new Date());
				statusCurso.setStatus(new Status(Status.CADASTRADO));
				statusCurso.setUsuario(loginBean.getModel());
				getModel().getStatusCursos().add(statusCurso);
			}

			if (areaConhecimentoCursos != null && !areaConhecimentoCursos.isEmpty()) {
				getModel().getAreaConhecimentoCursos().addAll(areaConhecimentoCursos);
			}
			
			if (orgaoCursos != null && !orgaoCursos.isEmpty()) {
				getModel().getOrgaoCursos().addAll(orgaoCursos);
			}

			if (getModel().getId() == null) {
				getModel().setUsuario(loginBean.getModel());
			}

			if (orgaoSelecionado == null || orgaoSelecionado.getId() == null) {
				getModel().setOrgao(null);
			} else {
				getModel().setOrgao(orgaoSelecionado);
			}

			/**
			 * apaga os emails do curso publico caso não seja composto por oficina, atribui os emails dos intrutores caso exista e zera o
			 * percentual de vagas para parceiros
			 **/
			if (getModel().getPublico()) {
				if (!getModel().getFlgPossuiOficina()) {
					getModel().setExclusaoCursoEmail(new ArrayList<EmailCursoPrivado>());
					getModel().setEmailsCursoPrivado(new HashSet<EmailCursoPrivado>());
					getModel().setNumPercentualVagasParceiro(0);
					getModel().getEmailsCursoPrivado().addAll(emailsInstrutores);
				} else {
					/**
					 * Se existir emails de parceiros deverá ser preenchido obrigatoriamente o percentual de vagas de parceiros
					 */
					if (emailsParceiros != null && !emailsParceiros.isEmpty()) {
						if (getModel().getNumPercentualVagasParceiro() != null
								&& getModel().getNumPercentualVagasParceiro() > 0) {
							getModel().getEmailsCursoPrivado().addAll(emailsParceiros);
						} else {
							FacesMessagesUtil.addErrorMessage("Email de Parceiros!",
									"Para adicionar os emails, deve ser informado um percentual de vagas para parceiros maior do que zero.");
							return "";
						}
					}
					/**
					 * Quando é curso composto por oficina remove-se os emails de instrutores caso tenha sido inseridos
					 */
					if (emailsInstrutores != null && !emailsInstrutores.isEmpty()) {
						for (EmailCursoPrivado emailInstrutor : emailsInstrutores) {
							if (emailInstrutor.getId() != null) {
								getModel().getEmailsCursoPrivado().remove(emailInstrutor);
							}
						}
					}
				}
			} else {
				getModel().getEmailsCursoPrivado().addAll(emailsCursoPrivado);
				getModel().getEmailsCursoPrivado().addAll(emailsInstrutores);
			}

			cursoService.save(getModel(), enviarEmailParceiros);

			FacesMessagesUtil.addInfoMessage(this.getQualifiedName(), this.getSaveMessage() + " " + ConstantesARQ.COM_SUCESSO);
			limparCampos();
		} catch (Exception e) {
			FacesMessagesUtil.addErrorMessage(this.getQualifiedName(), ConstantesARQ.ERRO_SALVAR);
			ExcecaoUtil.tratarExcecao(e);
			return ERROR;
		}
		return SUCCESS;
	}

	public void limparCampos() {
		setModel(new Curso());
		orgaoSelecionado = null;
		numeroVagas = null;
		idArea = null;
		idTurma = null;
		idTurno = null;
		idLocal = null;
		idTipoInscricao = null;
		cursoPorRegiao = false;
		opcaoListaCandidato = new OpcaoListaCandidato();
		homologacao = null;
		esferaGoverno = null;
		campoPreenchimento = null;
		uf = new Uf();
		municipio = new Municipio();
		ufCursoDelete = new UfCurso();
		municipioCurso = new MunicipioCurso();
		areaConhecimentoCursos = new ArrayList<AreaConhecimentoCurso>();
		emailsInstrutores = new ArrayList<>(); 
		orgaoCursos = new ArrayList<>();
	}

	public void limparVagas() {
		numeroVagas = null;
	}

	public boolean camposValidos() throws Exception {
		// compara as datas
		if (getModel().getCodigo().trim().length() < 6) {
			FacesMessagesUtil.addErrorMessage(" Número do Projeto", " É necessário ter no minímo 6 caracteres. ");
			return false;
		}
		// compara as datas
		if (getModel().getDtRealizacaoInicio().after(getModel().getDtRealizacaoFim())) {
			FacesMessagesUtil.addErrorMessage(" Data Realização Início é posterior a Data Realização Fim", " ");
			return false;
		}

		if (idTipoInscricao.equals(1)) {
			if (getModel().getDtTerminoInscricao() == null) {
				FacesMessagesUtil.addErrorMessage("Período Inscrição Fim ", Constantes.CAMPO_OBRIGATORIO);
				return false;
			}
			// compara as datas
			if (getModel().getDtInicioInscricao().after(getModel().getDtTerminoInscricao())) {
				FacesMessagesUtil.addErrorMessage("Período Inscrição Início é posterior a Período Inscrição Fim", " ");
				return false;
			}
		}

		// Seta numero de vagas
		if (numeroVagas != null && !numeroVagas.trim().isEmpty() && numeroVagas.trim().equals("0")) {
			FacesMessagesUtil.addErrorMessage("Número de vagas", " inválido.");
			return false;
		}

		// Se habilitar curso por região
		if (cursoPorRegiao) {
			if (ufCursos.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("É necessário adicionar uma UF ", "");
				return false;
			}
		}

		// Lista de espera
		if (opcaoListaCandidato == null || opcaoListaCandidato.getId() == null) {
			FacesMessagesUtil.addErrorMessage("É necessário escolher um item na lista de espera", "");
			return false;
		}
		if (esferaGoverno == null || esferaGoverno.length == 0) {
			FacesMessagesUtil.addErrorMessage("É necessário escolher um item de Esfera de Governo", "");
			return false;
		}

		// Se escolher lista de espera por regiao . ele deve adicionar uma
		// regiao
		if (opcaoListaCandidato.getId().equals(OpcaoListaCandidato.LISTA_ESPERA_REGIAO)) {
			if (cursoPorRegiao == false) {
				FacesMessagesUtil.addErrorMessage("",
						"Se a lista de espera for por região, será necessário Habilitar Curso Por Região.");
				return false;
			}
		}

		// Se escolher Confirmação do Chefe não pode ter outras confirmações.
		boolean confirmacaoChefe = false;
		boolean confirmacaoComprovante = false;
		for (Homologacao h : homologacao) {
			if (h.getId().equals(Homologacao.CONFIRMACAO_CHEFE)) {
				confirmacaoChefe = true;
			} else if (h.getId().equals(Homologacao.CONFIRMACAO_NOTA_EMPENHO)
					|| h.getId().equals(Homologacao.CONFIRMACAO_PAGAMENTO) || h.getId().equals(Homologacao.CONFIRMACAO_VIA_GRU)) {
				confirmacaoComprovante = true;
			}
		}
		if (confirmacaoChefe == true && confirmacaoComprovante == true) {
			FacesMessagesUtil.addErrorMessage("", "Confirmação pelo Chefe não pode ser associadas a outras confirmações.");
			return false;
		}

		/* Valida os emails do curso somente se for privado */
		if (!getModel().getPublico()) {
			if (emailsCursoPrivado == null || emailsCursoPrivado.isEmpty()) {
				FacesMessagesUtil.addErrorMessage("  E-mail Participante Curso Privado:",
						" É necessário ter no minímo 1 participante. ");
				return false;
			}
		}

		if (numeroVagas != null && !numeroVagas.equals("") && emailsCursoPrivado.size() > Integer.valueOf(numeroVagas)) {
			FacesMessagesUtil.addErrorMessage("", "Número de participantes é maior que o número de vagas");
			return false;
		}

		return true;
	}

	@Override
	public Curso createModel() {
		return new Curso();
	}

	@Override
	public String getQualifiedName() {
		return "Curso";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public List<Area> getAreas() {
		return areas;
	}

	public void setAreas(List<Area> areas) {
		this.areas = areas;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Integer getIdArea() {
		return idArea;
	}

	public void setIdArea(Integer idArea) {
		this.idArea = idArea;
	}

	public Integer getIdLocal() {
		return idLocal;
	}

	public void setIdLocal(Integer idLocal) {
		this.idLocal = idLocal;
	}

	public List<Localizacao> getLocais() {
		return locais;
	}

	public void setLocais(List<Localizacao> locais) {
		this.locais = locais;
	}

	public Integer getIdTipoInscricao() {
		return idTipoInscricao;
	}

	public void setIdTipoInscricao(Integer idTipoInscricao) {
		this.idTipoInscricao = idTipoInscricao;
	}

	public boolean isCursoPorRegiao() {
		return cursoPorRegiao;
	}

	public void setCursoPorRegiao(boolean cursoPorRegiao) {
		this.cursoPorRegiao = cursoPorRegiao;
	}

	public Uf getUf() {
		return uf;
	}

	public void setUf(Uf uf) {
		this.uf = uf;
	}

	public List<UfCurso> getUfCursos() {
		return ufCursos;
	}

	public void setUfCursos(List<UfCurso> ufCursos) {
		this.ufCursos = ufCursos;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public UfCurso getUfCursoDelete() {
		return ufCursoDelete;
	}

	public void setUfCursoDelete(UfCurso ufCursoDelete) {
		this.ufCursoDelete = ufCursoDelete;
	}

	public Municipio getMunicipio() {
		return municipio;
	}

	public void setMunicipio(Municipio municipio) {
		this.municipio = municipio;
	}

	public List<MunicipioCurso> getMunicipioCursos() {
		return municipioCursos;
	}

	public void setMunicipioCursos(List<MunicipioCurso> municipioCursos) {
		this.municipioCursos = municipioCursos;
	}

	public MunicipioCurso getMunicipioCurso() {
		return municipioCurso;
	}

	public void setMunicipioCurso(MunicipioCurso municipioCurso) {
		this.municipioCurso = municipioCurso;
	}

	public OpcaoDataModel getOpcaoDataModel() {
		return opcaoDataModel;
	}

	public void setOpcaoDataModel(OpcaoDataModel opcaoDataModel) {
		this.opcaoDataModel = opcaoDataModel;
	}

	public OpcaoListaCandidato getOpcaoListaCandidato() {
		return opcaoListaCandidato;
	}

	public void setOpcaoListaCandidato(OpcaoListaCandidato opcaoListaCandidato) {
		this.opcaoListaCandidato = opcaoListaCandidato;
	}

	public HomologacaoDataModel getHomologacaoDataModel() {
		return homologacaoDataModel;
	}

	public void setHomologacaoDataModel(HomologacaoDataModel homologacaoDataModel) {
		this.homologacaoDataModel = homologacaoDataModel;
	}

	public Homologacao[] getHomologacao() {
		return homologacao;
	}

	public void setHomologacao(Homologacao[] homologacao) {
		this.homologacao = homologacao;
	}

	public EsferaGovernoDataModel getEsferaGovernoDataModel() {
		return esferaGovernoDataModel;
	}

	public void setEsferaGovernoDataModel(EsferaGovernoDataModel esferaGovernoDataModel) {
		this.esferaGovernoDataModel = esferaGovernoDataModel;
	}

	public EsferaGoverno[] getEsferaGoverno() {
		return esferaGoverno;
	}

	public void setEsferaGoverno(EsferaGoverno[] esferaGoverno) {
		this.esferaGoverno = esferaGoverno;
	}

	public CampoPreenchimentoDataModel getPreenchimentoDataModel() {
		return preenchimentoDataModel;
	}

	public void setPreenchimentoDataModel(CampoPreenchimentoDataModel preenchimentoDataModel) {
		this.preenchimentoDataModel = preenchimentoDataModel;
	}

	public CampoPreenchimento[] getCampoPreenchimento() {
		return campoPreenchimento;
	}

	public void setCampoPreenchimento(CampoPreenchimento[] campoPreenchimento) {
		this.campoPreenchimento = campoPreenchimento;
	}

	public LoginBean getLoginBean() {
		return loginBean;
	}

	public void setLoginBean(LoginBean loginBean) {
		this.loginBean = loginBean;
	}

	public Date getHoje() {
		return hoje;
	}

	public void setHoje(Date hoje) {
		this.hoje = hoje;
	}

	public String getNumeroVagas() {
		return numeroVagas;
	}

	public void setNumeroVagas(String numeroVagas) {
		this.numeroVagas = numeroVagas;
	}

	public Orgao getOrgaoSelecionado() {
		return orgaoSelecionado;
	}

	public void setOrgaoSelecionado(Orgao orgaoSelecionado) {
		this.orgaoSelecionado = orgaoSelecionado;
	}

	public OrgaoService getOrgaoService() {
		return orgaoService;
	}

	public void setOrgaoService(OrgaoService orgaoService) {
		this.orgaoService = orgaoService;
	}

	public List<SelectItem> getTurmas() {
		return turmas;
	}

	public void setTurmas(List<SelectItem> turmas) {
		this.turmas = turmas;
	}

	public Integer getIdTurma() {
		return idTurma;
	}

	public void setIdTurma(Integer idTurma) {
		this.idTurma = idTurma;
	}

	public List<Turno> getTurnos() {
		return turnos;
	}

	public void setTurnos(List<Turno> turnos) {
		this.turnos = turnos;
	}

	public Integer getIdTurno() {
		return idTurno;
	}

	public void setIdTurno(Integer idTurno) {
		this.idTurno = idTurno;
	}

	public AreaConhecimento getAreaConhecimentoSelecionada() {
		return areaConhecimentoSelecionada;
	}

	public void setAreaConhecimentoSelecionada(AreaConhecimento areaConhecimentoSelecionada) {
		this.areaConhecimentoSelecionada = areaConhecimentoSelecionada;
	}

	public AreaConhecimentoService getAreaConhecimentoService() {
		return areaConhecimentoService;
	}

	public void setAreaConhecimentoService(AreaConhecimentoService areaConhecimentoService) {
		this.areaConhecimentoService = areaConhecimentoService;
	}

	public AreaConhecimentoCurso getAreaConhecimentoCursoExclusao() {
		return areaConhecimentoCursoExclusao;
	}

	public void setAreaConhecimentoCursoExclusao(AreaConhecimentoCurso areaConhecimentoCursoExclusao) {
		this.areaConhecimentoCursoExclusao = areaConhecimentoCursoExclusao;
	}

	public List<AreaConhecimentoCurso> getAreaConhecimentoCursos() {
		return areaConhecimentoCursos;
	}

	public void setAreaConhecimentoCursos(List<AreaConhecimentoCurso> areaConhecimentoCursos) {
		this.areaConhecimentoCursos = areaConhecimentoCursos;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public List<EmailCursoPrivado> getEmailsCursoPrivado() {
		return emailsCursoPrivado;
	}

	public void setEmailsCursoPrivado(List<EmailCursoPrivado> emailsCursoPrivado) {
		this.emailsCursoPrivado = emailsCursoPrivado;
	}

	public EmailCursoPrivado getEmailDelete() {
		return emailDelete;
	}

	public void setEmailDelete(EmailCursoPrivado emailDelete) {
		this.emailDelete = emailDelete;
	}

	public String getEmailParceiro() {
		return emailParceiro;
	}

	public void setEmailParceiro(String emailParceiro) {
		this.emailParceiro = emailParceiro;
	}

	public List<EmailCursoPrivado> getEmailsParceiros() {
		return emailsParceiros;
	}

	public void setEmailsParceiros(List<EmailCursoPrivado> emailsParceiros) {
		this.emailsParceiros = emailsParceiros;
	}

	public EmailCursoPrivado getEmailDeleteParceiro() {
		return emailDeleteParceiro;
	}

	public void setEmailDeleteParceiro(EmailCursoPrivado emailDeleteParceiro) {
		this.emailDeleteParceiro = emailDeleteParceiro;
	}

	public boolean isEnviarEmailParceiros() {
		return enviarEmailParceiros;
	}

	public void setEnviarEmailParceiros(boolean enviarEmailParceiros) {
		this.enviarEmailParceiros = enviarEmailParceiros;
	}

	public List<EmailCursoPrivado> getEmailsInstrutores() {
		return emailsInstrutores;
	}

	public void setEmailsInstrutores(List<EmailCursoPrivado> emailsInstrutores) {
		this.emailsInstrutores = emailsInstrutores;
	}

	public String getEmailInstrutor() {
		return emailInstrutor;
	}

	public void setEmailInstrutor(String emailInstrutor) {
		this.emailInstrutor = emailInstrutor;
	}

	public EmailCursoPrivado getEmailDeleteInstrutor() {
		return emailDeleteInstrutor;
	}

	public void setEmailDeleteInstrutor(EmailCursoPrivado emailDeleteInstrutor) {
		this.emailDeleteInstrutor = emailDeleteInstrutor;
	}

	public Orgao getOrgaoParticipanteSelecionado() {
		return orgaoParticipanteSelecionado;
	}

	public void setOrgaoParticipanteSelecionado(Orgao orgaoParticipanteSelecionado) {
		this.orgaoParticipanteSelecionado = orgaoParticipanteSelecionado;
	}

	public List<OrgaoCurso> getOrgaoCursos() {
		return orgaoCursos;
	}

	public void setOrgaoCursos(List<OrgaoCurso> orgaoCursos) {
		this.orgaoCursos = orgaoCursos;
	}

	public OrgaoCurso getOrgaoCursoExclusao() {
		return orgaoCursoExclusao;
	}

	public void setOrgaoCursoExclusao(OrgaoCurso orgaoCursoExclusao) {
		this.orgaoCursoExclusao = orgaoCursoExclusao;
	}
}
