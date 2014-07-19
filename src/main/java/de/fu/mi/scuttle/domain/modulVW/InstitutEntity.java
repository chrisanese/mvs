package de.fu.mi.scuttle.domain.modulVW;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_institut")
public class InstitutEntity {

	@Column(name="i_id", nullable=false)
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	@Column(name="i_name")
	private String name;
	
	@Column(name="i_kuerzel")
	private String kuerzel;
	
	// Foreign Key
	@Column(name="fb_id")
	private long fb_id;
	
	/*
	 * Begin FKEY Definition
	 */
	@ManyToOne(optional=false)
	@JoinColumn(name="fb_id",referencedColumnName="fb_id",insertable=false, updatable=false)
	private FachbereichEntity fachbereich;
	
	@OneToMany(mappedBy="institut", targetEntity=StudienordnungEntity.class, fetch=FetchType.LAZY)
	private List<StudienordnungEntity> sto;
	
	@OneToMany(mappedBy="institut", targetEntity=ModulCounterEntity.class, fetch=FetchType.LAZY)
	private List<ModulCounterEntity> counter;
	
	@OneToMany(mappedBy="institut", targetEntity=ModulKategorieEntity.class, fetch=FetchType.LAZY)
	private List<ModulKategorieEntity> kategorien;
	
	/*
	 * End: FKEY Definition
	 */

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

	public String getKuerzel() {
		return kuerzel;
	}

	public void setKuerzel(String kuerzel) {
		this.kuerzel = kuerzel;
	}

	public long getFb_id() {
		return fb_id;
	}

	public void setFb_id(long fb_id) {
		this.fb_id = fb_id;
	}

	public FachbereichEntity getFachbereich() {
		return fachbereich;
	}

	public void setFachbereich(FachbereichEntity fachbereich) {
		this.fachbereich = fachbereich;
	}

	public List<StudienordnungEntity> getSto() {
		return sto;
	}

	public void setSto(List<StudienordnungEntity> sto) {
		this.sto = sto;
	}

	public List<ModulCounterEntity> getCounter() {
		return counter;
	}

	public void setCounter(List<ModulCounterEntity> counter) {
		this.counter = counter;
	}

	public List<ModulKategorieEntity> getKategorien() {
		return kategorien;
	}

	public void setKategorien(List<ModulKategorieEntity> kategorien) {
		this.kategorien = kategorien;
	}
	
	public List<StudienordnungEntity> getCurrentSto(){
		List<StudienordnungEntity> stoList = this.getSto();
		List<StudienordnungEntity> ret = new ArrayList<StudienordnungEntity>();
		for(StudienordnungEntity sto: stoList){
			if(sto.getAktuell() == 1)
				ret.add(sto);
		}
		if(!ret.isEmpty())
			return ret;
		return null;
	}
}
