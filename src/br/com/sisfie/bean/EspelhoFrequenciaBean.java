package br.com.sisfie.bean;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.List;
import java.util.Map;

import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Frequencia;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.service.CredenciamentoService;
import br.com.sisfie.service.FrequenciaService;
import br.com.sisfie.service.InscricaoCursoService;

/**
 * @author Wesley Marra
 *
 */
@ManagedBean(name = "espelhoFrequenciaBean")
@ViewScoped
public class EspelhoFrequenciaBean extends PaginableBean<Frequencia> {

	private static final long serialVersionUID = 1L;
	private final Integer MINIMO_HORAS_FREQUENCIA_TURNO = 3;

	@ManagedProperty(value = "#{inscricaoCursoService}")
	protected InscricaoCursoService inscricaoCursoService;

	@ManagedProperty(value = "#{frequenciaService}")
	protected FrequenciaService frequenciaService;

	@ManagedProperty(value = "#{credenciamentoService}")
	protected CredenciamentoService credenciamentoService;

	private Frequencia frequencia;
	private InscricaoCurso inscricaoCurso;
	private String display;

	public EspelhoFrequenciaBean() {
		inscricaoCurso = new InscricaoCurso();
		frequencia = new Frequencia();
	}

	public void pesquisar() {
		try {
			inscricaoCurso = inscricaoCursoService.recuperarInscricao(inscricaoCurso.getInscricao());
			if (!validarCampos()) {
				inscricaoCurso = new InscricaoCurso();
				return;
			}
			StringBuilder sb = new StringBuilder();
			DateFormat df = new SimpleDateFormat("dd/MM/yyyy");
			DateFormat hf = new SimpleDateFormat("HH:mm:ss");

			sb.append(inscricaoCurso.getCurso().getCursoData());
			sb.append("\nInscrição: " + inscricaoCurso.getInscricao());
			sb.append("\nNome     : " + inscricaoCurso.getCandidato().getNome());
			sb.append("\nÓrgão    : " + inscricaoCurso.getCandidato().getOrgao().getNomeSiglaFormat() + "\n\n");

			// Esta será incrementada em um dia até atingir a data final do evento
			Calendar datFrequencia = new GregorianCalendar();
			datFrequencia.setTimeInMillis(inscricaoCurso.getCurso().getDtRealizacaoInicio().getTime());

			// Data inicio do evento
			Calendar datInicioEvento = new GregorianCalendar();
			datInicioEvento.setTimeInMillis(inscricaoCurso.getCurso().getDtRealizacaoInicio().getTime());

			// Data fim do evento
			Calendar datFimEvento = new GregorianCalendar();
			datFimEvento.setTimeInMillis(inscricaoCurso.getCurso().getDtRealizacaoFim().getTime());

			// Data corrente do evento
			Calendar datCorrente = Calendar.getInstance();

			do {
				Calendar datHorFreqMANHA_INI = new GregorianCalendar(datFrequencia.get(Calendar.YEAR),
						datFrequencia.get(Calendar.MONTH), datFrequencia.get(Calendar.DAY_OF_MONTH), 8, 30);
				Calendar datHorFreqMANHA_FIM = new GregorianCalendar(datFrequencia.get(Calendar.YEAR),
						datFrequencia.get(Calendar.MONTH), datFrequencia.get(Calendar.DAY_OF_MONTH), 12, 30);
				Calendar datHorFreqTARDE_INI = new GregorianCalendar(datFrequencia.get(Calendar.YEAR),
						datFrequencia.get(Calendar.MONTH), datFrequencia.get(Calendar.DAY_OF_MONTH), 14, 00);
				Calendar datHorFreqTARDE_FIM = new GregorianCalendar(datFrequencia.get(Calendar.YEAR),
						datFrequencia.get(Calendar.MONTH), datFrequencia.get(Calendar.DAY_OF_MONTH), 18, 00);

				Integer minutosFrequenciaTurno = 0;
				String descTurmaCurso;
				if (datHorFreqMANHA_INI.before(datCorrente)) {

					sb.append(df.format(datFrequencia.getTime()) + "\n");

					List<Frequencia> frequencias = new ArrayList<Frequencia>(inscricaoCurso.getFrequencias());
					if (null == frequencias || frequencias.isEmpty()) {
						sb.append("\tMANHÃ\n\tAUSENTE\n");
						sb.append("\tTARDE\n\tAUSENTE\n");
					} else {
						/**
						 * Manhã
						 */
						sb.append("\tMANHÃ\n");
						boolean manha = true;
						for (Frequencia fre : frequencias) {
							int diffInMin = 0;
							if (null != fre.getHorarioSaida() && null != fre.getHorarioEntrada())
							  diffInMin = (int) ((fre.getHorarioSaida().getTime() - fre.getHorarioEntrada().getTime())
									/ (1000 * 60));

							if (manha && !fre.getHorarioEntrada().before(datHorFreqMANHA_FIM.getTime())) {
								manha = false;

								// Primeiro dia a frequência da manhã é por meio do credenciamento, se for credenciado tem frequencia
								if (minutosFrequenciaTurno == 0 && datFrequencia.get(Calendar.DAY_OF_MONTH) == datInicioEvento
										.get(Calendar.DAY_OF_MONTH)) {
									if (credenciamentoService.recuperarCredenciamento(inscricaoCurso.getInscricao()) != null) {
										sb.append("\tPRESENTE / CREDENCIADO\n\n");
									}
								} else {
									appendResumoTextArea(datCorrente, datHorFreqMANHA_INI, datHorFreqMANHA_FIM,
											minutosFrequenciaTurno, sb);
								}

								minutosFrequenciaTurno = 0;
								sb.append("\tTARDE\n");
								// FIM MANHÃ
							}
							if (null != fre.getGradeOficina()) 
								descTurmaCurso = fre.getGradeOficina().getTurma().getDescricao();
							else if (null != inscricaoCurso.getTurma())
								descTurmaCurso = inscricaoCurso.getTurma().getDescricao();
							else
								descTurmaCurso = "";
							sb.append(String.format("\t\t%-30s: %8s a %8s (%s)\n",descTurmaCurso
									.substring(0,
											Math.min(30, descTurmaCurso.length())),
									hf.format(fre.getHorarioEntrada().getTime()), fre.getHorarioSaida() != null ? hf.format(fre.getHorarioSaida().getTime()) : "??:??:??",
									getMinutosEmHora(diffInMin)));
							minutosFrequenciaTurno += diffInMin;
						}

						// Teve frequência só pela manhã nesse dia para o candidato
						if (manha) {
							appendResumoTextArea(datCorrente, datHorFreqMANHA_INI, datHorFreqMANHA_FIM, minutosFrequenciaTurno,
									sb);
							minutosFrequenciaTurno = 0;
							sb.append("\tTARDE\n");
						}
						appendResumoTextArea(datCorrente, datHorFreqTARDE_INI, datHorFreqTARDE_FIM, minutosFrequenciaTurno, sb);
					}
				}

				// Próxima dia do Evento
				datFrequencia.add(Calendar.DAY_OF_MONTH, 1);
			} while (datFrequencia.before(datFimEvento) || datFrequencia.compareTo(datFimEvento) == 0);

			sb.append("\nFIM ESPELHO DE FREQUÊNCIA");
			display = sb.toString();

		} catch (Exception e) {
			ExcecaoUtil.tratarExcecao(e);
		}
	}

	private void appendResumoTextArea(Calendar datCorrente, Calendar datHorFreqMANHA_INI, Calendar datHorFreqMANHA_FIM,
			Integer minutosFrequenciaTurno, StringBuilder sb) {
		if (minutosFrequenciaTurno >= MINIMO_HORAS_FREQUENCIA_TURNO * 60)
			sb.append("\tPRESENTE");
		else if (datHorFreqMANHA_INI.before(datCorrente) && datHorFreqMANHA_FIM.after(datCorrente) && minutosFrequenciaTurno > 0)
			sb.append("\tPRESENÇA PARCIAL");
		else
			sb.append("\tAUSENTE");
		sb.append("(" + getMinutosEmHora(minutosFrequenciaTurno) + ") \n\n");
	}

	private String getMinutosEmHora(Integer minutos) {
		if (minutos == 0)
			return "00:00";
		DecimalFormat df = new DecimalFormat("00");
		int inteira = minutos / 60;
		int resto = minutos % 60;
		return df.format(inteira) + ":" + df.format(resto);
	}

	private boolean validarCampos() throws Exception {
		if (inscricaoCurso == null || inscricaoCurso.getInscricao() == null || inscricaoCurso.getInscricao().isEmpty()) {
			FacesMessagesUtil.addErrorMessage("", "Nenhuma inscrição informada ou inscrição inválida.");
			return Boolean.FALSE;
		}
		return Boolean.TRUE;
	}

	public void copiarExtrato() {
		// TODO: Implementar.....
	}

	public InscricaoCurso getInscricaoCurso() {
		return inscricaoCurso;
	}

	public void setInscricaoCurso(InscricaoCurso inscricaoCurso) {
		this.inscricaoCurso = inscricaoCurso;
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {
	}

	@Override
	public Frequencia createModel() {
		return new Frequencia();
	}

	@Override
	public String getQualifiedName() {
		return "Frequência";
	}

	@Override
	public boolean isFeminino() {
		return true;
	}

	public Frequencia getFrequencia() {
		return frequencia;
	}

	public void setFrequencia(Frequencia frequencia) {
		this.frequencia = frequencia;
	}

	public InscricaoCursoService getInscricaoCursoService() {
		return inscricaoCursoService;
	}

	public void setInscricaoCursoService(InscricaoCursoService inscricaoCursoService) {
		this.inscricaoCursoService = inscricaoCursoService;
	}

	public String getDisplay() {
		return display;
	}

	public void setDisplay(String display) {
		this.display = display;
	}

	public FrequenciaService getFrequenciaService() {
		return frequenciaService;
	}

	public void setFrequenciaService(FrequenciaService frequenciaService) {
		this.frequenciaService = frequenciaService;
	}

	public CredenciamentoService getCredenciamentoService() {
		return credenciamentoService;
	}

	public void setCredenciamentoService(CredenciamentoService credenciamentoService) {
		this.credenciamentoService = credenciamentoService;
	}
}
