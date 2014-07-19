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
@Table(name="modulverwaltung1_sek_sto")
public class SekStoEntity {

	@Column(name="ss_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="m_id")
	private long m_id;
	
	@Column(name="sto_id")
	private long sto_id;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="m_id", referencedColumnName="m_id", insertable=false, updatable= false)
	private ModulEntity modul;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="sto_id", referencedColumnName="sto_id", insertable=false, updatable= false)
	private StudienordnungEntity sto;

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

	public long getSto_id() {
		return sto_id;
	}

	public void setSto_id(long sto_id) {
		this.sto_id = sto_id;
	}

	public ModulEntity getModul() {
		return modul;
	}

	public void setModul(ModulEntity modul) {
		this.modul = modul;
	}

	public StudienordnungEntity getSto() {
		return sto;
	}

	public void setSto(StudienordnungEntity sto) {
		this.sto = sto;
	}
	
	
}
