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
@Table(name="modulverwaltung1_lv_typ")
public class LvTypEntity {

	@Column(name="lvt_id")
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="lvt_name")
	private String name;
	
	@Column(name="lvt_kuerzel")
	private String kuerzel;
	
	@OneToMany(mappedBy="lvTyp", targetEntity=LehrveranstaltungEntity.class, fetch=FetchType.LAZY)
	private List<LehrveranstaltungEntity> lehrveranstaltungen;

	@OneToMany(mappedBy="lvTyp", targetEntity=ModulLvsEntity.class, fetch=FetchType.LAZY)
	private List<ModulLvsEntity> modulLvs;
	
	@OneToMany(mappedBy="lvTyp", targetEntity=HuelsenEntity.class, fetch=FetchType.LAZY)
	private List<HuelsenEntity> huelsen;
	
	@OneToMany(mappedBy="lvTyp2", targetEntity=HuelsenEntity.class, fetch=FetchType.LAZY)
	private List<HuelsenEntity> huelsen2;
	
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

	public List<LehrveranstaltungEntity> getLehrveranstaltungen() {
		return lehrveranstaltungen;
	}

	public void setLehrveranstaltungen(
			List<LehrveranstaltungEntity> lehrveranstaltungen) {
		this.lehrveranstaltungen = lehrveranstaltungen;
	}

	public List<ModulLvsEntity> getModulLvs() {
		return modulLvs;
	}

	public void setModulLvs(List<ModulLvsEntity> modulLvs) {
		this.modulLvs = modulLvs;
	}

	public List<HuelsenEntity> getHuelsen() {
		return huelsen;
	}

	public void setHuelsen(List<HuelsenEntity> huelsen) {
		this.huelsen = huelsen;
	}

	public List<HuelsenEntity> getHuelsen2() {
		return huelsen2;
	}

	public void setHuelsen2(List<HuelsenEntity> huelsen2) {
		this.huelsen2 = huelsen2;
	}
	
}
