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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.OrderBy;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_planung")
@NamedQueries({
	@NamedQuery(
			name = PlanungEntity.GET_PLANUNG_BY_SEMESTER,
			query = "SELECT p FROM PlanungEntity p "
				+ "WHERE p.lv_id = :lvId "
				+ "AND p.s_id = :sId"
			),
	@NamedQuery(
			name = PlanungEntity.GET_LV_BY_SEMESTER,
			query = "SELECT p.lv_id FROM PlanungEntity p "
				+ "WHERE p.s_id = :sId "
				+ "GROUP BY p.lv_id "
			)
})
public class PlanungEntity {

	public static final String GET_PLANUNG_BY_SEMESTER = "planung.bysemester";
	public static final String GET_LV_BY_SEMESTER = "planung.Lvbysemester";
	
	@Column(name="p_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	// Foreign Keys
	@Column(name="lv_id")
	private long lv_id;
	
	@Column(name="s_id")
	private long s_id;
	
	@Column(name="r_id", nullable=true)
	private long r_id;
	
	@Column(name="t_id",nullable=true)
	private long t_id;
	
	@Column(name="p_startdatum",nullable=true)
	private String startDatum;
	
	@Column(name="p_enddatum",nullable=true)
	private String endDatum;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="lv_id", referencedColumnName="lv_id", insertable=false, updatable= false)
	private LehrveranstaltungEntity veranstaltung;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="s_id", referencedColumnName="s_id", insertable=false, updatable= false)
	private SemesterEntity semester;
	
	@ManyToOne(optional=true)
	@JoinColumn(name="r_id", referencedColumnName="r_id", insertable=false, updatable= false)
	private RaumEntity raum;
	
	@ManyToOne(optional=true)
	@JoinColumn(name="t_id", referencedColumnName="t_id", insertable=false, updatable= false)
	private TerminEntity termin;
	
	@OneToMany(mappedBy="planung", targetEntity=SemesterLecturerEntity.class, fetch=FetchType.LAZY)
	private List<SemesterLecturerEntity> semesterLecturer;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getLv_id() {
		return lv_id;
	}

	public void setLv_id(long lv_id) {
		this.lv_id = lv_id;
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

	public LehrveranstaltungEntity getVeranstaltung() {
		return veranstaltung;
	}

	public void setVeranstaltung(LehrveranstaltungEntity veranstaltung) {
		this.veranstaltung = veranstaltung;
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

	public List<SemesterLecturerEntity> getSemesterLecturer() {
		return semesterLecturer;
	}

	public void setSemesterLecturer(List<SemesterLecturerEntity> semesterLecturer) {
		this.semesterLecturer = semesterLecturer;
	}

}
