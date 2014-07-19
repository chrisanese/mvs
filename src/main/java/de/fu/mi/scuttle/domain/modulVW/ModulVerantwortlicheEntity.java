package de.fu.mi.scuttle.domain.modulVW;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_modul_verantwortliche")
public class ModulVerantwortlicheEntity {

	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="mv_id", nullable=false)
	@Id
	private long id;
	
	//Foreign Keys
	@Column(name="m_id")
	private long m_id;
	
	@Column(name="l_id")
	private long l_id;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="m_id", referencedColumnName="m_id", insertable=false, updatable= false)
	private ModulEntity modul;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="l_id", referencedColumnName="l_id", insertable=false, updatable= false)
	private LecturerEntity lecturer;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getM_id() {
		return m_id;
	}

	public void setM_id(long m_id) {
		this.m_id = m_id;
	}

	public long getL_id() {
		return l_id;
	}

	public void setL_id(long l_id) {
		this.l_id = l_id;
	}

	public ModulEntity getModul() {
		return modul;
	}

	public void setModul(ModulEntity modul) {
		this.modul = modul;
	}

	public LecturerEntity getLecturer() {
		return lecturer;
	}

	public void setLecturer(LecturerEntity lecturer) {
		this.lecturer = lecturer;
	}
	
}
