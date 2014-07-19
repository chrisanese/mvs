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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_lehrveranstaltung")
@NamedQueries({
	@NamedQuery(
			name = LehrveranstaltungEntity.GET_LV_BY_MODUL_LVT,
			query = "SELECT lv FROM LehrveranstaltungEntity lv "
				+ "WHERE lv.m_id = :mId "
				+ "AND lv.lvt_id = :lvtId "
				+ "ORDER BY lv.name "
			),
			@NamedQuery(
					name = LehrveranstaltungEntity.GET_LV_BY_SEMESTER,
					query = "SELECT lv FROM LehrveranstaltungEntity lv, PlanungEntity p, SemesterLecturerEntity sl "
						+ "WHERE p.s_id = :sId "
						+ " AND p.lv_id = lv.id "
						+ " AND p.id = sl.p_id "
						+ " AND sl.l_id = :lId"
						+ " GROUP BY lv "
						+ " ORDER BY lv.name"
					)
})
public class LehrveranstaltungEntity {

	public static final String GET_LV_BY_MODUL_LVT = "lv.modullvt";
	public static final String GET_LV_BY_SEMESTER = "lv.semester";
	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="lv_id",nullable=false)
	@Id
	private long id;
	
	@Column(name="lv_name")
	private String name;
	
	@Column(name="lv_sws")
	private String sws;
	
	@Column(name="lv_nummer")
	private String nummer;
	
	@Column(name="lv_inhalt")
	private String inhalt;
	
	@Column(name="lv_ziel")
	private String ziel;
	
	@Column(name="lv_literatur")
	private String literatur;
	
	@Column(name="lv_voraussetzung")
	private String voraussetzung;
	
	@Column(name="lv_anwesenheitspflicht")
	private boolean anwesenheitspflicht;
	
	@Column(name="m_id")
	private long m_id;
	
	@Column(name="lvt_id")
	private long lvt_id;
	
	/*
	 * Begin: FKEY Definition
	 */
	@ManyToOne(optional=false)
	@JoinColumn(name="m_id", referencedColumnName="m_id", insertable=false, updatable= false)
	private ModulEntity modul;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="lvt_id", referencedColumnName="lvt_id", insertable=false, updatable= false)
	private LvTypEntity lvTyp;
	
	@OneToMany(mappedBy="veranstaltung", targetEntity=PlanungEntity.class, fetch=FetchType.LAZY)
	private List<PlanungEntity> planung;
	
	@OneToMany(mappedBy="lv", targetEntity=KlausurEntity.class, fetch=FetchType.LAZY)
	private List<KlausurEntity> klausuren;
	
	@OneToOne(fetch=FetchType.LAZY, mappedBy="lv")
	private UebungEntity uebung;
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

	public String getSws() {
		return sws;
	}

	public void setSws(String sws) {
		this.sws = sws;
	}

	public String getNummer() {
		return nummer;
	}

	public void setNummer(String nummer) {
		this.nummer = nummer;
	}
	
	public String getInhalt() {
		return inhalt;
	}

	public void setInhalt(String inhalt) {
		this.inhalt = inhalt;
	}

	public String getZiel() {
		return ziel;
	}

	public void setZiel(String ziel) {
		this.ziel = ziel;
	}

	public String getLiteratur() {
		return literatur;
	}

	public void setLiteratur(String literatur) {
		this.literatur = literatur;
	}

	public String getVoraussetzung() {
		return voraussetzung;
	}

	public void setVoraussetzung(String voraussetzung) {
		this.voraussetzung = voraussetzung;
	}

	public boolean isAnwesenheitspflicht() {
		return anwesenheitspflicht;
	}

	public void setAnwesenheitspflicht(boolean anwesenheitspflicht) {
		this.anwesenheitspflicht = anwesenheitspflicht;
	}

	public long getM_id() {
		return m_id;
	}

	public void setM_id(long m_id) {
		this.m_id = m_id;
	}

	public long getLvt_id() {
		return lvt_id;
	}

	public void setLvt_id(long lvt_id) {
		this.lvt_id = lvt_id;
	}

	public ModulEntity getModul() {
		return modul;
	}

	public void setModul(ModulEntity modul) {
		this.modul = modul;
	}

	public LvTypEntity getLvTyp() {
		return lvTyp;
	}

	public void setLvTyp(LvTypEntity lvTyp) {
		this.lvTyp = lvTyp;
	}

	public List<PlanungEntity> getPlanung() {
		return planung;
	}

	public void setPlanung(List<PlanungEntity> planung) {
		this.planung = planung;
	}
	
	public List<PlanungEntity> getPlanungBySemester(long sId){
		List<PlanungEntity> ret = new ArrayList<PlanungEntity>();
		for(PlanungEntity plan : this.getPlanung()){
			if(plan.getS_id() == sId)
				ret.add(plan);
		}
		if(!ret.isEmpty())
			return ret;
		
		return null;
	}

	public UebungEntity getUebung() {
		return uebung;
	}

	public void setUebung(UebungEntity uebung) {
		this.uebung = uebung;
	}

	public List<KlausurEntity> getKlausuren() {
		return klausuren;
	}

	public void setKlausuren(List<KlausurEntity> klausuren) {
		this.klausuren = klausuren;
	}
}
