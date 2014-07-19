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
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_huelsen")
public class HuelsenEntity {

	@Column(name="h_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
		
	@Column(name="h_ects")
	private String ects;
	
	@Column(name="h_sws1")
	private String sws;
	
	@Column(name="h_kuerzel1")
	private String kuerzel;
	
	@Column(name="h_sws2")
	private String sws2;
	
	@Column(name="lvt_id1")
	private long lvt_id;
	
	@Column(name="lvt_id2")
	private long lvt_id2;

	@OneToMany(mappedBy="huelse", targetEntity=ModulHuelsenEntity.class, fetch=FetchType.LAZY)
	private List<ModulHuelsenEntity> modulHuelsen;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="lvt_id1", referencedColumnName="lvt_id", insertable=false, updatable= false)
	private LvTypEntity lvTyp;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="lvt_id2", referencedColumnName="lvt_id", insertable=false, updatable= false)
	private LvTypEntity lvTyp2;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getSws() {
		return sws;
	}

	public void setSws(String sws) {
		this.sws = sws;
	}

	public String getEcts() {
		return ects;
	}

	public void setEcts(String ects) {
		this.ects = ects;
	}

	public String getKuerzel() {
		return kuerzel;
	}

	public void setKuerzel(String kuerzel) {
		this.kuerzel = kuerzel;
	}
	
	public String getSws2() {
		return sws2;
	}

	public void setSws2(String sws2) {
		this.sws2 = sws2;
	}

	public List<ModulHuelsenEntity> getModulHuelsen() {
		return modulHuelsen;
	}

	public void setModulHuelsen(List<ModulHuelsenEntity> modulHuelsen) {
		this.modulHuelsen = modulHuelsen;
	}

	public long getLvt_id() {
		return lvt_id;
	}

	public void setLvt_id(long lvt_id) {
		this.lvt_id = lvt_id;
	}

	public long getLvt_id2() {
		return lvt_id2;
	}

	public void setLvt_id2(long lvt_id2) {
		this.lvt_id2 = lvt_id2;
	}

	public LvTypEntity getLvTyp() {
		return lvTyp;
	}

	public void setLvTyp(LvTypEntity lvTyp) {
		this.lvTyp = lvTyp;
	}

	public LvTypEntity getLvTyp2() {
		return lvTyp2;
	}

	public void setLvTyp2(LvTypEntity lvTyp2) {
		this.lvTyp2 = lvTyp2;
	}
}
