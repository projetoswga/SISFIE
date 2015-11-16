package br.com.sisfie.excecao;

public class DistribuicaoException extends Exception {

	private static final long serialVersionUID = -6206127099430991333L;

	public DistribuicaoException(String mensagem) {
		super(mensagem);
	}

	public DistribuicaoException(String mensagem, Throwable paramThrowable) {
		super(mensagem, paramThrowable);
	}

	public DistribuicaoException(Throwable paramThrowable) {
		super(paramThrowable);
	}

}
