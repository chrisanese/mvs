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
@Table(name="modulverwaltung1_lehrender")
@NamedQueries({
	@NamedQuery(
			name = LecturerEntity.GET_LEC_BY_ACC,
			query = "SELECT l FROM LecturerEntity l "
				+ "WHERE l.zedat = :acc "
			),
			@NamedQuery(
					name = LecturerEntity.GET_LEC_BY_LV_AND_SEM,
					query = "SELECT l FROM LecturerEntity l "
						+ "WHERE l.id IN ("
						+ " SELECT sl.l_id FROM SemesterLecturerEntity sl WHERE sl.p_id IN("
						+ " SELECT p.id FROM PlanungEntity p WHERE p.s_id = :sId"
						+ " AND p.lv_id = :lvId ) )"
					)
})
public class LecturerEntity {

	public static final String GET_LEC_BY_ACC = "lecturer.getLV";
	public static final String GET_LEC_BY_LV_AND_SEM = "lecturer.getLVSem";
	
	@Column(name="l_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="l_vorname")
	private String vorname;
	
	@Column(name="l_nachname")
	private String nachname;
	
	@Column(name="l_zedat_account")
	private String zedat;
	
	@Column(name="l_email")
	private String email;
	
	// Foreign Key
	@Column(name="lt_id")
	private long lt_id;
	
	@OneToMany(mappedBy="lecturer", targetEntity=ModulVerantwortlicheEntity.class, fetch=FetchType.LAZY)
	private List<ModulVerantwortlicheEntity> module;
	
	@OneToMany(mappedBy="lecturer", targetEntity=SemesterLecturerEntity.class, fetch=FetchType.LAZY)
	private List<SemesterLecturerEntity> semesterLecturer;

	@ManyToOne(optional=false)
	@JoinColumn(name="lt_id", referencedColumnName="lt_id", insertable=false, updatable= false)
	private LecturerTypEntity lecturerTyp;
	
	@OneToMany(mappedBy="tutor", targetEntity=UebungPlanungEntity.class, fetch=FetchType.LAZY)
	private List<UebungPlanungEntity> uplanung;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getVorname() {
		return vorname;
	}

	public void setVorname(String vorname) {
		this.vorname = vorname;
	}

	public String getNachname() {
		return nachname;
	}

	public void setNachname(String nachname) {
		this.nachname = nachname;
	}

	public String getZedat() {
		return zedat;
	}

	public void setZedat(String zedat) {
		this.zedat = zedat;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public long getLt_id() {
		return lt_id;
	}

	public void setLt_id(long lt_id) {
		this.lt_id = lt_id;
	}

	public List<ModulVerantwortlicheEntity> getModule() {
		return module;
	}

	public void setModule(List<ModulVerantwortlicheEntity> module) {
		this.module = module;
	}

	public LecturerTypEntity getLecturerTyp() {
		return lecturerTyp;
	}

	public void setLecturerTyp(LecturerTypEntity lecturerTyp) {
		this.lecturerTyp = lecturerTyp;
	}
	
	
	public List<SemesterLecturerEntity> getSemesterLecturer() {
		return semesterLecturer;
	}

	public void setSemesterLecturer(List<SemesterLecturerEntity> semesterLecturer) {
		this.semesterLecturer = semesterLecturer;
	}

	public List<UebungPlanungEntity> getUplanung() {
		return uplanung;
	}

	public void setUplanung(List<UebungPlanungEntity> uplanung) {
		this.uplanung = uplanung;
	}
	
}
