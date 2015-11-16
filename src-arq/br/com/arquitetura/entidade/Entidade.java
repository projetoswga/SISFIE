package br.com.arquitetura.entidade;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

public abstract class Entidade<T extends Serializable> implements Serializable {

	private static final long serialVersionUID = 1L;

	public abstract T getId();

	public abstract void setId(T id);

	public Object clone() {
		Object newObject = null;
		try {
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			ObjectOutputStream oos = new ObjectOutputStream(baos);
			oos.writeObject(this);
			ObjectInputStream ois = new ObjectInputStream(new ByteArrayInputStream(baos.toByteArray()));
			newObject = ois.readObject();
			ois.close();
			oos.close();
			baos.close();
		} catch (IOException ioe) {
		} catch (ClassNotFoundException cnfe) {
		}
		return newObject;
	}

}
