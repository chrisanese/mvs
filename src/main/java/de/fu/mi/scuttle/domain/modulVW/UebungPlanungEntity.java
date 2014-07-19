package de.fu.mi.scuttle.domain.modulVW;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_uebung_planung")
@NamedQueries({
	@NamedQuery(
			name = UebungPlanungEntity.GET_UPLANUNG_BY_SEMESTER,
			query = "SELECT up FROM UebungPlanungEntity up "
				+ "WHERE up.ub_id = :ubId "
				+ "AND up.s_id = :sId"
			)
})
public class UebungPlanungEntity {

public static final String GET_UPLANUNG_BY_SEMESTER = "uplanung.bysemester";
	
	@Column(name="up_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	// Foreign Keys
	@Column(name="ub_id")
	private long ub_id;
	
	@Column(name="s_id")
	private long s_id;
	
	@Column(name="r_id", nullable=true)
	private long r_id;
	
	@Column(name="t_id",nullable=true)
	private long t_id;
	
	@Column(name="l_id",nullable=true)
	private long l_id;
	
	@Column(name="up_max_teilnehmer",nullable=true)
	private String maxTeilnehmer;
	
	@Column(name="up_startdatum",nullable=true)
	private String startDatum;
	
	@Column(name="up_enddatum",nullable=true)
	private String endDatum;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="ub_id", referencedColumnName="ub_id", insertable=false, updatable=false)
	private UebungEntity uebung;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="s_id", referencedColumnName="s_id", insertable=false, updatable= false)
	private SemesterEntity semester;
	
	@ManyToOne(optional=true)
	@JoinColumn(name="r_id", referencedColumnName="r_id", insertable=false, updatable= false)
	private RaumEntity raum;
	
	@ManyToOne(optional=true)
	@JoinColumn(name="t_id", referencedColumnName="t_id", insertable=false, updatable= false)
	private TerminEntity termin;
	
	@ManyToOne(optional=true)
	@JoinColumn(name="l_id", referencedColumnName="l_id", insertable=false, updatable= false)
	private LecturerEntity tutor;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getUb_id() {
		return ub_id;
	}

	public void setUb_id(long ub_id) {
		this.ub_id = ub_id;
	}

	public long getS_id() {
		return s_id;
	}

	public void setS_id(long s_id) {
		this.s_id = s_id;
	}

	public long getR_id() {
		return r_id;
	}

	public void setR_id(long r_id) {
		this.r_id = r_id;
	}

	public long getT_id() {
		return t_id;
	}

	public void setT_id(long t_id) {
		this.t_id = t_id;
	}

	public long getL_id() {
		return l_id;
	}

	public void setL_id(long l_id) {
		this.l_id = l_id;
	}

	public String getMaxTeilnehmer() {
		return maxTeilnehmer;
	}

	public void setMaxTeilnehmer(String maxTeilnehmer) {
		this.maxTeilnehmer = maxTeilnehmer;
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

	public UebungEntity getUebung() {
		return uebung;
	}

	public void setUebung(UebungEntity uebung) {
		this.uebung = uebung;
	}

	public SemesterEntity getSemester() {
		return semester;
	}

	public void setSemester(SemesterEntity semester) {
		this.semester = semester;
	}

	public RaumEntity getRaum() {
		return raum;
	}

	public void setRaum(RaumEntity raum) {
		this.raum = raum;
	}

	public TerminEntity getTermin() {
		return termin;
	}

	public void setTermin(TerminEntity termin) {
		this.termin = termin;
	}

	public LecturerEntity getTutor() {
		return tutor;
	}

	public void setTutor(LecturerEntity tutor) {
		this.tutor = tutor;
	}
	
}
