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
@Table(name="modulverwaltung1_modul_kategorie")
public class ModulKategorieEntity {
	
	@Column(name="mk_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="mk_name")
	private String name;
	
	@Column(name="mk_kuerzel")
	private String kuerzel;
	
	@Column(name = "i_id")
	private long i_id;
	
	/*
	 * Begin: FKEY Definition
	 */
	@OneToMany(mappedBy="kategorie", targetEntity=ModulEntity.class, fetch=FetchType.LAZY)
	private List<ModulEntity> module;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="i_id", referencedColumnName="i_id", insertable=false, updatable=false)
	private InstitutEntity institut;
	
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

	public List<ModulEntity> getModule() {
		return module;
	}

	public void setModule(List<ModulEntity> module) {
		this.module = module;
	}

	public long getI_id() {
		return i_id;
	}

	public void setI_id(long i_id) {
		this.i_id = i_id;
	}

	public InstitutEntity getInstitut() {
		return institut;
	}

	public void setInstitut(InstitutEntity institut) {
		this.institut = institut;
	}
	
}
