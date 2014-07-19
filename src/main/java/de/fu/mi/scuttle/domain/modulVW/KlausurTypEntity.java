package de.fu.mi.scuttle.domain.modulVW;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_klausur_typ")
public class KlausurTypEntity {

	@Column(name="kt_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="kt_name")
	private String name;
	
	@OneToMany(mappedBy="klausurTyp", targetEntity=KlausurEntity.class, fetch=FetchType.LAZY)
	private List<KlausurEntity> klausuren;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<KlausurEntity> getKlausuren() {
		return klausuren;
	}

	public void setKlausuren(List<KlausurEntity> klausuren) {
		this.klausuren = klausuren;
	}
	
}
