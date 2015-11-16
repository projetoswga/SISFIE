package br.com.sisfie.bean;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.faces.bean.ManagedBean;
import javax.faces.bean.ManagedProperty;
import javax.faces.bean.ViewScoped;
import javax.faces.event.AjaxBehaviorEvent;

import br.com.arquitetura.bean.PaginableBean;
import br.com.arquitetura.excecao.ExcecaoUtil;
import br.com.arquitetura.util.FacesMessagesUtil;
import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.Horario;
import br.com.sisfie.entidade.Usuario;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.HorarioService;
import br.com.sisfie.util.Constantes;

@ManagedBean(name = "horarioBean")
@ViewScoped
public class HorarioBean extends PaginableBean<Horario> {

	@ManagedProperty(value = "#{CursoService}")
	protected CursoService cursoService;

	@ManagedProperty(value = "#{horarioService}")
	protected HorarioService horarioService;

	private static final long serialVersionUID = -7179986118925624412L;
	private List<Curso> cursos;
	private Integer idCurso;
	private Date hoje = new Date();
	private Date dataFimMinima = new Date();

	public HorarioBean() {
		cursos = new ArrayList<Curso>();
	}

	@PostConstruct
	public void carregarTela() {
		verificarAcesso();
		if (cursos.isEmpty()) {
			try {
				Usuario user = (Usuario) getSessionMap().get(Constantes.USUARIO_SESSAO);
//				cursos = cursoService.recuperarCursosComOficina(user);
				cursos = cursoService.recuperarCursosAtivos(user);
				Collections.sort(cursos, new Comparator<Curso>() {
					@Override
					public int compare(Curso o1, Curso o2) {
						return o1.getTitulo().trim().compareTo(o2.getTitulo());
					}
				});
			} catch (Exception e) {
				ExcecaoUtil.tratarExcecao(e);
			}
		}
	}

	public void sugerirDataHoras(AjaxBehaviorEvent evt) {
		if (getModel().getDatHoraInicio() != null) {
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(getModel().getDatHoraInicio());
			calendar.add(Calendar.HOUR_OF_DAY, 4);
			getModel().setDatHoraFim(calendar.getTime());
			dataFimMinima = calendar.getTime();
		}
	}

	@Override
	public String save() {
		getModel().setCurso(new Curso(idCurso));
		Integer count = horarioService.verificarConflitoHorario(getModel()).intValue();
		if (count > 0) {
			FacesMessagesUtil.addErrorMessage("Conflitos entre horários",
					"Exitem horários que conflitam com o curso, datas e horários selecionados!");
			return "";
		}
		idCurso = 0;
		return super.save();
	}

	@Override
	public String load() {
		idCurso = getModel().getCurso().getId();
		return super.load();
	}

	@Override
	public Map<String, String> getFilters() {
		return null;
	}

	@Override
	public void verificarAcesso() {

	}

	@Override
	public Horario createModel() {
		return new Horario();
	}

	@Override
	public String getQualifiedName() {
		return "Horário";
	}

	@Override
	public boolean isFeminino() {
		return false;
	}

	public CursoService getCursoService() {
		return cursoService;
	}

	public void setCursoService(CursoService cursoService) {
		this.cursoService = cursoService;
	}

	public List<Curso> getCursos() {
		return cursos;
	}

	public void setCursos(List<Curso> cursos) {
		this.cursos = cursos;
	}

	public Integer getIdCurso() {
		return idCurso;
	}

	public void setIdCurso(Integer idCurso) {
		this.idCurso = idCurso;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public Date getHoje() {
		return hoje;
	}

	public void setHoje(Date hoje) {
		this.hoje = hoje;
	}

	public Date getDataFimMinima() {
		return dataFimMinima;
	}

	public void setDataFimMinima(Date dataFimMinima) {
		this.dataFimMinima = dataFimMinima;
	}

	public HorarioService getHorarioService() {
		return horarioService;
	}

	public void setHorarioService(HorarioService horarioService) {
		this.horarioService = horarioService;
	}

}
