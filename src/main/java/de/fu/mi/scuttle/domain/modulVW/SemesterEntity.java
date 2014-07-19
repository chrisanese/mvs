package de.fu.mi.scuttle.domain.modulVW;

import java.sql.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name="modulverwaltung1_semester")
@NamedQueries({
	@NamedQuery(
			name = SemesterEntity.GET_CURRENT_SEMESTER,
			query = "SELECT s FROM SemesterEntity s "
				+ "WHERE :date BETWEEN s.startDatum AND s.endDatum"
			),
	@NamedQuery(
			name = SemesterEntity.GET_SEMESTER_WITH_DATES,
			query = "SELECT s FROM SemesterEntity s "
					+ "WHERE s.startDatum IS NOT NULL"
			),
	@NamedQuery(
			name = SemesterEntity.GET_SEMESTER_BETWEEN,
			query = "SELECT s FROM SemesterEntity s "
					+ "WHERE s.id BETWEEN :sId AND :sId2"
			)
})
public class SemesterEntity {

	public static final String GET_CURRENT_SEMESTER = "sem.current";
	public static final String GET_SEMESTER_WITH_DATES = "sem.dates";
	public static final String GET_SEMESTER_BETWEEN = "sem.between";
	
	@Column(name="s_id", nullable=false)
	@Id
	private long id;
	
	@Column(name="s_jahr")
	private String jahr;
	
	@Column(name="s_typ")
	private boolean typ;
	
	@Column(name="s_startdatum")
	private String startDatum;
	
	@Column(name="s_enddatum")
	private String endDatum;
	
	@OneToMany(mappedBy="semester", targetEntity=PlanungEntity.class, fetch=FetchType.LAZY)
	private List<PlanungEntity> planung;
	
	@OneToMany(mappedBy="semester", targetEntity=UebungPlanungEntity.class, fetch=FetchType.LAZY)
	private List<UebungPlanungEntity> uplanung;
	
	@OneToMany(mappedBy="semester", targetEntity=KlausurEntity.class, fetch=FetchType.LAZY)
	private List<KlausurEntity> klausuren;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getJahr() {
		return jahr.substring(0,4);
	}

	public void setJahr(String jahr) {
		this.jahr = jahr;
	}

	public boolean isTyp() {
		return typ;
	}

	public void setTyp(boolean typ) {
		this.typ = typ;
	}
	
	public long getTyp(){
		return (isTyp() ? 1 : 0);
	}

	public String getStartDatum() {
		return startDatum;
	}

	public void setStartDatum(String startDatum) {
		this.startDatum = startDatum;
	}

	public String getEndDatum() {
		return endDatum;
	}

	public void setEndDatum(String endDatum) {
		this.endDatum = endDatum;
	}

	public List<PlanungEntity> getPlanung() {
		return planung;
	}

	public void setPlanung(List<PlanungEntity> planung) {
		this.planung = planung;
	}

	public List<KlausurEntity> getKlausuren() {
		return klausuren;
	}

	public void setKlausuren(List<KlausurEntity> klausuren) {
		this.klausuren = klausuren;
	}
	
	public String getName(){
		String ret = this.getTyp() == 0 ? "WS "
			+ (Integer.parseInt(this.getJahr().substring(2, 4))-1 )+ "/"
			+ this.getJahr().substring(2, 4)
			: "SS " + this.getJahr().substring(2, 4);
		return ret;
	}

	public List<UebungPlanungEntity> getUplanung() {
		return uplanung;
	}

	public void setUplanung(List<UebungPlanungEntity> uplanung) {
		this.uplanung = uplanung;
	}
	
	public long getCurrentSemester(){
		
		return 0;
	}
	
	
}
