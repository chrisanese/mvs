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
@Table(name="modulverwaltung1_modul_counter")
@NamedQueries({
	@NamedQuery(
			name = ModulCounterEntity.GET_COUNTER_BY_INSTITUTE,
			query = "SELECT mc FROM ModulCounterEntity mc "
				+ "WHERE mc.i_id = :iId "
			)
})
public class ModulCounterEntity {

	public static final String GET_COUNTER_BY_INSTITUTE = "counter.byinstitue";
	
	@Id
	@Column(name="mc_id",nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private long id;
	
	@Column(name="i_id")
	private long i_id;
	
	@Column(name="mc_counter")
	private long counter;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="i_id", referencedColumnName="i_id", insertable=false, updatable=false)
	private InstitutEntity institut;
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getI_id() {
		return i_id;
	}

	public void setI_id(long i_id) {
		this.i_id = i_id;
	}

	public long getCounter() {
		return counter;
	}

	public void setCounter(long counter) {
		this.counter = counter;
	}

	public InstitutEntity getInstitut() {
		return institut;
	}

	public void setInstitut(InstitutEntity institut) {
		this.institut = institut;
	}
	
	
	
}
