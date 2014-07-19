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
@Table(name="modulverwaltung1_gebaeude")
public class GebaeudeEntity {

	@Column(name="g_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="g_name")
	private String name;
	
	@Column(name="g_strasse")
	private String strasse;
	
	@Column(name="g_strassen_nummer")
	private String strassenNr;
	
	@Column(name="g_kuerzel")
	private String kuerzel;
	
	@OneToMany(mappedBy="gebaeude", targetEntity=RaumEntity.class, fetch=FetchType.LAZY)
	private List<RaumEntity> raeume;

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

	public String getStrasse() {
		return strasse;
	}

	public void setStrasse(String strasse) {
		this.strasse = strasse;
	}

	public String getStrassenNr() {
		return strassenNr;
	}

	public void setStrassenNr(String strassenNr) {
		this.strassenNr = strassenNr;
	}

	public String getKuerzel() {
		return kuerzel;
	}

	public void setKuerzel(String kuerzel) {
		this.kuerzel = kuerzel;
	}

	public List<RaumEntity> getRaeume() {
		return raeume;
	}

	public void setRaeume(List<RaumEntity> raeume) {
		this.raeume = raeume;
	}
	
	
}
