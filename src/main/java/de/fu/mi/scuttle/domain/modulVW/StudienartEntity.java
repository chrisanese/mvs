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
@Table(name="modulverwaltung1_studienart")
public class StudienartEntity {
	
	@Column(name="sta_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="sta_name")
	private String name;
	
	/*
	 * Begin: FKEY Definition
	 */
	@OneToMany(mappedBy="sta", targetEntity=StudienordnungEntity.class, fetch=FetchType.LAZY)
	private List<StudienordnungEntity> sto;
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

	public List<StudienordnungEntity> getSto() {
		return sto;
	}

	public void setSto(List<StudienordnungEntity> sto) {
		this.sto = sto;
	}

}
