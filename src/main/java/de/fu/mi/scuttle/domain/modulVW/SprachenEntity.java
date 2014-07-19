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
@Table(name="modulverwaltung1_sprache")
public class SprachenEntity {
	
	@Column(name="sp_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="sp_name")
	private String name;
	
	@Column(name="sp_kuerzel")
	private String kuerzel;
	
	@OneToMany(mappedBy="sprache", targetEntity=ModulEntity.class, fetch=FetchType.LAZY)
	private List<ModulEntity> module;

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

	public List<ModulEntity> getModule() {
		return module;
	}

	public void setModule(List<ModulEntity> module) {
		this.module = module;
	}	

}
