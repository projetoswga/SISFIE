package br.com.sisfie.util;

import java.io.Serializable;
import java.util.ArrayList;

import org.primefaces.model.DefaultTreeNode;
import org.primefaces.model.TreeNode;

public class CustomTreeNode extends DefaultTreeNode {

	private static final long serialVersionUID = -6898581029360579931L;

	public CustomTreeNode(Object data, TreeNode parent, Serializable idObject) {
		this.idObject = idObject;
		this.setType(DEFAULT_TYPE);
		this.setData(data);
		this.setChildren(new ArrayList<TreeNode>());
		this.setParent(parent);
		// if (this.getParent() != null)
		// this.getParent().getChildren().add(this);
	}

	public CustomTreeNode(String type, Object data, TreeNode parent, Serializable idObject) {
		this.idObject = idObject;
		this.setType(type);
		this.setData(data);
		this.setChildren(new ArrayList<TreeNode>());
		this.setParent(parent);
		// if (this.getParent() != null)
		// this.getParent().getChildren().add(this);
	}

	private Serializable idObject;

	public Serializable getIdObject() {
		return idObject;
	}

	public void setIdObject(Serializable idObject) {
		this.idObject = idObject;
	}

}
