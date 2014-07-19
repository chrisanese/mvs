package de.fu.mi.scuttle.domain.modulVW;

import java.util.List;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Table(name="modulverwaltung1_fachbereich")
@Entity
public class FachbereichEntity  {

	@Column(name="fb_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="fb_name")
	private String name;
	
	@Column(name="fb_kuerzel")
	private String kuerzel;
	
	/*
	 * Begin FKEY Definition
	 */
	@OneToMany(mappedBy="fachbereich", targetEntity=InstitutEntity.class,fetch=FetchType.LAZY)
	private List<InstitutEntity> institute;
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

	public String getKuerzel() {
		return kuerzel;
	}

	public void setKuerzel(String kuerzel) {
		this.kuerzel = kuerzel;
	}

	public List<InstitutEntity> getInstitute() {
		return institute;
	}

	public void setInstitute(List<InstitutEntity> institute) {
		this.institute = institute;
	}	
	
}
