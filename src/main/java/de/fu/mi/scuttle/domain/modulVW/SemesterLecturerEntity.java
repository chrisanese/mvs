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
@Table(name="modulverwaltung1_semester_lecturer")
public class SemesterLecturerEntity {

	@Column(name="sl_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="l_id")
	private long l_id;
	
	@Column(name="p_id")
	private long p_id;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="l_id", referencedColumnName="l_id", insertable=false, updatable= false)
	private LecturerEntity lecturer;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="p_id", referencedColumnName="p_id", insertable=false, updatable= false)
	private PlanungEntity planung;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getL_id() {
		return l_id;
	}

	public void setL_id(long l_id) {
		this.l_id = l_id;
	}

	public long getP_id() {
		return p_id;
	}

	public void setP_id(long p_id) {
		this.p_id = p_id;
	}

	public LecturerEntity getLecturer() {
		return lecturer;
	}

	public void setLecturer(LecturerEntity lecturer) {
		this.lecturer = lecturer;
	}

	public PlanungEntity getPlanung() {
		return planung;
	}

	public void setPlanung(PlanungEntity planung) {
		this.planung = planung;
	}	
}
