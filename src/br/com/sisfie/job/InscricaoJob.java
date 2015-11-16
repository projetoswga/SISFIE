package br.com.sisfie.job;

import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;

import br.com.sisfie.entidade.Curso;
import br.com.sisfie.entidade.InscricaoCurso;
import br.com.sisfie.entidade.Status;
import br.com.sisfie.entidade.StatusInscricao;
import br.com.sisfie.service.CursoService;
import br.com.sisfie.service.InscricaoCursoService;

/**
 * Classe responsável por executar uma rotina todos os dias a meia noite para verificar quais inscrições estão com o status <b> Aguardando
 * Comprovante </b> e cancelá-las. <br/>
 * A rotina verifica os cursos ativos compostos por oficinas e que estão em um período entre a data de finalização da inscrição e data
 * inicialização do curso. <br/>
 * Os candidatos que não anexaram os comprovantes dentro do prazo para pagamento<b>(25 dias depois da data de finalização das
 * inscrições)</b>, terão suas inscrições automaticamente canceladas.
 * 
 * @author Wesley Marra
 */
public class InscricaoJob {

	@Autowired
	private CursoService cursoService;

	@Autowired
	private InscricaoCursoService inscricaoCursoService;

	private Map<InscricaoCurso, StatusInscricao> mapaInscricaoStatus;
	private Date hoje = new Date();

	@Scheduled(cron = "0 0 0 ? * *")
	public void cancelarInscricao() {
		try {
			mapaInscricaoStatus = new HashMap<InscricaoCurso, StatusInscricao>();
			List<Curso> listaCursoAtivos = cursoService.recuperarCursosAtivos();

			if (listaCursoAtivos != null && !listaCursoAtivos.isEmpty()) {
				for (Curso curso : listaCursoAtivos) {
					if (curso.getFlgPossuiOficina()) {
						if (hoje.after(curso.getDtTerminoInscricao()) && hoje.before(curso.getDtRealizacaoInicio())) {

							List<InscricaoCurso> listaInscricoesAguardandoComprovante = inscricaoCursoService
									.recuperarInscricoesAguardandoComprovante(curso.getId());

							if (listaInscricoesAguardandoComprovante != null && !listaInscricoesAguardandoComprovante.isEmpty()) {

								Calendar prazoLimite = Calendar.getInstance();
								prazoLimite.setTime(curso.getDtTerminoInscricao());
								prazoLimite.add(Calendar.DAY_OF_MONTH, 25);

								for (InscricaoCurso inscricaoCurso : listaInscricoesAguardandoComprovante) {
									if (hoje.after(prazoLimite.getTime())) {

										StatusInscricao statusInscricao = new StatusInscricao(new InscricaoCurso(inscricaoCurso.getId()),
												curso.getUsuario(), new Status(Status.CANCELADO), hoje);
										mapaInscricaoStatus.put(inscricaoCurso, statusInscricao);
									}
								}
							}
						}
					}
				}

				if (!mapaInscricaoStatus.isEmpty()) {
					inscricaoCursoService.cancelarCandidato(mapaInscricaoStatus);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Map<InscricaoCurso, StatusInscricao> getMapaInscricaoStatus() {
		return mapaInscricaoStatus;
	}

	public void setMapaInscricaoStatus(Map<InscricaoCurso, StatusInscricao> mapaInscricaoStatus) {
		this.mapaInscricaoStatus = mapaInscricaoStatus;
	}

	public Date getHoje() {
		return hoje;
	}

	public void setHoje(Date hoje) {
		this.hoje = hoje;
	}
}