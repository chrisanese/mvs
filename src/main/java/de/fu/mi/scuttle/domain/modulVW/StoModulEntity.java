package de.fu.mi.scuttle.domain.modulVW;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_sto_module")
@NamedQueries({
	@NamedQuery(
			name = StoModulEntity.REGULARY_STO_MODULES,
			query = "SELECT sm FROM StoModulEntity sm, ModulEntity m "
					+ "WHERE sm.m_id = m.id "
					+ " AND ( m.typ = 1 OR m.typ = 2)"
					+ " AND sm.sto_id = :stoId"
					+ " AND (sm.frequency = 5 OR sm.frequency = :freq1 OR sm.frequency = :freq2)"
					+ " GROUP BY m.name"
			),
	@NamedQuery(
			name = StoModulEntity.NOT_REGULARY_STO_MODULES,
			query = "SELECT sm FROM StoModulEntity sm, ModulEntity m "
					+ "WHERE sm.m_id = m.id "
					+ " AND ( m.typ = 3 OR m.typ = 4)"
					+ " AND sm.sto_id = :stoId"
					+ " AND (sm.frequency = 5 OR sm.frequency = :freq1 OR sm.frequency = :freq2)"
					+ " GROUP BY m.name"
			)
})
public class StoModulEntity {
	
	public static final String REGULARY_STO_MODULES = "sm.regulary";
	public static final String NOT_REGULARY_STO_MODULES = "sm.notregulary";
	
	@Column(name="sm_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="sm_ects")
	private String ects;
	
	@Column(name="sm_frequency")
	private long frequency;
	
	@Column(name="sto_id")
	private long sto_id;
	
	@Column(name="m_id")
	private long m_id;
	
	/*
	 * Begin: FKEY Definition
	 */
	@ManyToOne(optional=false)
	@JoinColumn(name="sto_id", referencedColumnName="sto_id", insertable=false, updatable= false)
	private StudienordnungEntity sto;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="m_id", referencedColumnName="m_id", insertable=false, updatable= false)
	private ModulEntity modul;
	/*
	 * End: FKEY Definition
	 */

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getEcts() {
		return ects;
	}

	public void setEcts(String ects) {
		this.ects = ects;
	}

	public long getFrequency() {
		return frequency;
	}

	public void setFrequency(long frequency) {
		this.frequency = frequency;
	}

	public long getSto_id() {
		return sto_id;
	}

	public void setSto_id(long sto_id) {
		this.sto_id = sto_id;
	}

	public long getM_id() {
		return m_id;
	}

	public void setM_id(long m_id) {
		this.m_id = m_id;
	}

	public StudienordnungEntity getSto() {
		return sto;
	}

	public void setSto(StudienordnungEntity sto) {
		this.sto = sto;
	}

	public ModulEntity getModul() {
		return modul;
	}

	public void setModul(ModulEntity modul) {
		this.modul = modul;
	}
	
	public String getFrequenz(){
		String ret = "Wintersemester";
		switch ((int)this.getFrequency()) {
		case 2:
			ret = "Sommersemester";
			break;
		case 3:
			ret = "nach dem Wintersemester";
			break;
		case 4:
			ret = "nach dem Sommersemester";
			break;
		case 5:
			ret = "Winter- & Sommersemester";
			break;
		default:
			break;
		}
		return ret;
	}

}
