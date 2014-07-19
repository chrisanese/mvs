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
@Table(name="modulverwaltung1_modul_lvs")
@NamedQueries({
	@NamedQuery(
			name = ModulLvsEntity.GET_PRIMARY_MODULLV,
			query = "SELECT ml FROM ModulLvsEntity ml "
				+ "WHERE ml.m_id = :mId "
				+ "AND ml.lvt_id = :lvtId"
			),
	@NamedQuery(
			name = ModulLvsEntity.GET_MODULES,
			query = "SELECT ml FROM ModulLvsEntity ml "
				+ "WHERE ml.m_id = :mId "
				+ "AND NOT(ml.lvt_id = 2)"
			),
	@NamedQuery(
			name = ModulLvsEntity.GET_TUTORIAL,
			query = "SELECT ml FROM ModulLvsEntity ml "
				+ "WHERE ml.m_id = :mId "
				+ "AND ml.primary = :primaryId"
			)
})
public class ModulLvsEntity {
	
	public static final String GET_PRIMARY_MODULLV = "ml.modullv";
	public static final String GET_MODULES = "ml.modul";
	public static final String GET_TUTORIAL = "ml.uebung";	
	
	@Column(name="ml_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="ml_sws")
	private String sws;
	
	@Column(name="ml_anwesenheitspflicht")
	private boolean anwesenheitspflicht;
	
	@Column(name="ml_primary")
	private long primary;
	
	@Column(name="m_id")
	private long m_id;
	
	@Column(name="lvt_id")
	private long lvt_id;
	
	
	@ManyToOne(optional=false)
	@JoinColumn(name="m_id", referencedColumnName="m_id", insertable=false, updatable= false)
	private ModulEntity modul;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="lvt_id", referencedColumnName="lvt_id", insertable=false, updatable= false)
	private LvTypEntity lvTyp;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}
	
	public String getSws() {
		return sws;
	}

	public void setSws(String sws) {
		this.sws = sws;
	}
	
	public boolean isAnwesenheitspflicht() {
		return anwesenheitspflicht;
	}

	public void setAnwesenheitspflicht(boolean anwesenheitspflicht) {
		this.anwesenheitspflicht = anwesenheitspflicht;
	}

	public long getPrimary() {
		return primary;
	}

	public void setPrimary(long primary) {
		this.primary = primary;
	}

	public long getM_id() {
		return m_id;
	}

	public void setM_id(long m_id) {
		this.m_id = m_id;
	}

	public long getLvt_id() {
		return lvt_id;
	}

	public void setLvt_id(long lvt_id) {
		this.lvt_id = lvt_id;
	}

	public ModulEntity getModul() {
		return modul;
	}

	public void setModul(ModulEntity modul) {
		this.modul = modul;
	}

	public LvTypEntity getLvTyp() {
		return lvTyp;
	}

	public void setLvTyp(LvTypEntity lvTyp) {
		this.lvTyp = lvTyp;
	}
}
