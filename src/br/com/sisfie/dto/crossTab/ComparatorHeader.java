package br.com.sisfie.dto.crossTab;

import java.util.Comparator;

public class ComparatorHeader implements Comparator<Header>{

	public int compare(Header o1, Header o2) {
		return o1.getPosicao().compareTo(o2.getPosicao());
	}

}
