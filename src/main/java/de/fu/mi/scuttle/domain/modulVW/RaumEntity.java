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
@Table(name="modulverwaltung1_raum")
public class RaumEntity {

	@Column(name="r_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="r_name")
	private String name;
	
	@Column(name="r_kuerzel")
	private String kuerzel;
	
	@Column(name="r_kapazitaet")
	private long kapazitaet;
	
	// Foreign Key
	
	@Column(name="g_id")
	private long g_id;
	
	@OneToMany(mappedBy="raum", targetEntity=PlanungEntity.class, fetch=FetchType.LAZY)
	private List<PlanungEntity> planung;
	
	@OneToMany(mappedBy="raum", targetEntity=UebungPlanungEntity.class, fetch=FetchType.LAZY)
	private List<UebungPlanungEntity> uplanung;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="g_id", referencedColumnName="g_id", insertable=false, updatable= false)
	private GebaeudeEntity gebaeude;
	
	@OneToMany(mappedBy="raum", targetEntity=KlausurEntity.class, fetch=FetchType.LAZY)
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

	public String getKuerzel() {
		return kuerzel;
	}

	public void setKuerzel(String kuerzel) {
		this.kuerzel = kuerzel;
	}

	public long getKapazitaet() {
		return kapazitaet;
	}

	public void setKapazitaet(long kapazitaet) {
		this.kapazitaet = kapazitaet;
	}

	public long getG_id() {
		return g_id;
	}

	public void setG_id(long g_id) {
		this.g_id = g_id;
	}

	public List<PlanungEntity> getPlanung() {
		return planung;
	}

	public void setPlanung(List<PlanungEntity> planung) {
		this.planung = planung;
	}

	public GebaeudeEntity getGebaeude() {
		return gebaeude;
	}

	public void setGebaeude(GebaeudeEntity gebaeude) {
		this.gebaeude = gebaeude;
	}

	public List<KlausurEntity> getKlausuren() {
		return klausuren;
	}

	public void setKlausuren(List<KlausurEntity> klausuren) {
		this.klausuren = klausuren;
	}

	public List<UebungPlanungEntity> getUplanung() {
		return uplanung;
	}

	public void setUplanung(List<UebungPlanungEntity> uplanung) {
		this.uplanung = uplanung;
	}
	
}
