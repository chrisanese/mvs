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
@Table(name="modulverwaltung1_lehrender_typ")
public class LecturerTypEntity {
	
	@Column(name="lt_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="lt_name")
	private String name;
	
	@OneToMany(mappedBy="lecturerTyp", targetEntity=LecturerEntity.class, fetch=FetchType.LAZY)
	private List<LecturerEntity> lecturer;

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

	public List<LecturerEntity> getLecturer() {
		return lecturer;
	}

	public void setLecturer(List<LecturerEntity> lecturer) {
		this.lecturer = lecturer;
	}	
}
