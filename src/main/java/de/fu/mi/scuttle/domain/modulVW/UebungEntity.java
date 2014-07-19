package de.fu.mi.scuttle.domain.modulVW;

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
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_uebung")
public class UebungEntity {
	
	@Id
	@Column(name="ub_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	@Column(name="ub_lvnummer")
	private String lvnummer;
	
	@Column(name="ub_sws")
	private String sws;
	
	@Column(name="ub_anwesenheitspflicht")
	private boolean anwesenheitspflicht;
	
	@Column(name="lv_id")
	private long lv_id;
	
	/*
	 * Begin: FKEY Definition
	 */
	@OneToOne
	@JoinColumn(name="lv_id", referencedColumnName="lv_id", insertable=false, updatable= false)
	private LehrveranstaltungEntity lv;
	
	@OneToMany(mappedBy="uebung", targetEntity=UebungPlanungEntity.class, fetch=FetchType.LAZY)
	private List<UebungPlanungEntity> uplanung;
	/*
	 * END: FKEY Definition
	 */

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getLvnummer() {
		return lvnummer;
	}

	public void setLvnummer(String lvnummer) {
		this.lvnummer = lvnummer;
	}

	public String getSws() {
		return sws;
	}

	public void setSws(String sws) {
		this.sws = sws;
	}

	public boolean isAnwesenheitspflicht() {
		return anwesenheitspflicht;
	}

	public void setAnwesenheitspflicht(boolean anwesenheitspflicht) {
		this.anwesenheitspflicht = anwesenheitspflicht;
	}

	public long getLv_id() {
		return lv_id;
	}

	public void setLv_id(long lv_id) {
		this.lv_id = lv_id;
	}

	public LehrveranstaltungEntity getLv() {
		return lv;
	}

	public void setLv(LehrveranstaltungEntity lv) {
		this.lv = lv;
	}

	public List<UebungPlanungEntity> getUplanung() {
		return uplanung;
	}

	public void setUplanung(List<UebungPlanungEntity> uplanung) {
		this.uplanung = uplanung;
	}

}
