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
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_studienordnung")
@NamedQueries({
	@NamedQuery(
			name = StudienordnungEntity.CURRENT_STO_BY_INSTITUTE_STA,
			query = "SELECT sto FROM StudienordnungEntity sto "
					+ "WHERE sto.i_id = :iId "
					+ " AND sto.sta_id = :staId "
					+ " AND sto.aktuell = 1"
			),
	@NamedQuery(
			name = StudienordnungEntity.CURRENT_STOS_BY_INSTITUTE,
			query = "SELECT sto FROM StudienordnungEntity sto "
					+ "WHERE sto.i_id = :iId "
					+ " AND sto.aktuell = 1"
	)
})
public class StudienordnungEntity {
	
	public static final String CURRENT_STO_BY_INSTITUTE_STA = "sto.byInstituteSta";
	public static final String CURRENT_STOS_BY_INSTITUTE = "sto.byInstitute";
	
	@Column(name="sto_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="sto_name")
	private String name;
	
	@Column(name="sto_jahr")
	private String jahr;
	
	@Column(name="sto_aktuell")
	private long aktuell;
	
	// Foreign Keys
	@Column(name="i_id")
	private long i_id;
	
	@Column(name="sta_id")
	private long sta_id;
	
	/*
	 * Begin FKEY Definition
	 */
	@ManyToOne(optional=false)
	@JoinColumn(name="i_id", referencedColumnName="i_id", insertable=false, updatable= false)
	private InstitutEntity institut;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="sta_id", referencedColumnName="sta_id", insertable=false, updatable= false)
	private StudienartEntity sta;
	
	@OneToMany(mappedBy="sto", targetEntity=SekStoEntity.class, fetch=FetchType.LAZY)
	private List<SekStoEntity> sekStos;

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

	public String getJahr() {
		return jahr;
	}

	public void setJahr(String jahr) {
		this.jahr = jahr;
	}

	public long getI_id() {
		return i_id;
	}

	public void setI_id(long i_id) {
		this.i_id = i_id;
	}

	public long getSta_id() {
		return sta_id;
	}

	public void setSta_id(long sta_id) {
		this.sta_id = sta_id;
	}

	public InstitutEntity getInstitut() {
		return institut;
	}

	public void setInstitut(InstitutEntity institut) {
		this.institut = institut;
	}

	public StudienartEntity getSta() {
		return sta;
	}

	public void setSta(StudienartEntity sta) {
		this.sta = sta;
	}
	
	public long getAktuell() {
		return aktuell;
	}

	public void setAktuell(long aktuell) {
		this.aktuell = aktuell;
	}

	@OneToMany(mappedBy="sto", targetEntity=StoModulEntity.class, fetch=FetchType.LAZY)
	private List<StoModulEntity> stoModule;
	/*
	 * End: FKEY Definition
	 */

	public List<StoModulEntity> getStoModule() {
		return stoModule;
	}

	public void setStoModule(List<StoModulEntity> stoModule) {
		this.stoModule = stoModule;
	}
	

}
