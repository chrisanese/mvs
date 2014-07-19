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
@Table(name="modulverwaltung1_modul_huelsen")
public class ModulHuelsenEntity {

	@Column(name="mh_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="m_id")
	private long m_id;
	
	@Column(name="h_id")
	private long h_id;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="m_id", referencedColumnName="m_id", insertable=false, updatable= false)
	private ModulEntity modul;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="h_id", referencedColumnName="h_id", insertable=false, updatable= false)
	private HuelsenEntity huelse;

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

	public long getH_id() {
		return h_id;
	}

	public void setH_id(long h_id) {
		this.h_id = h_id;
	}

	public ModulEntity getModul() {
		return modul;
	}

	public void setModul(ModulEntity modul) {
		this.modul = modul;
	}

	public HuelsenEntity getHuelse() {
		return huelse;
	}

	public void setHuelse(HuelsenEntity huelse) {
		this.huelse = huelse;
	}	
	
}
