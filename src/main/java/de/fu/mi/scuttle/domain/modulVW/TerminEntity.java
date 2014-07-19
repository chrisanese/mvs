package de.fu.mi.scuttle.domain.modulVW;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_termin")
@NamedQueries({
	@NamedQuery(
			name = TerminEntity.GET_ID_BY_DAY_TIME,
			query = "SELECT t FROM TerminEntity t "
				+ "WHERE t.tag = :tTag"
				+ " AND t.von = :tVon"
				+ " AND t.bis = :tBis"
			),
			@NamedQuery(
					name = TerminEntity.GET_FREE_TERMIN,
					query = "SELECT t FROM TerminEntity t "
						+ "WHERE t.id NOT IN ( "
						+ " SELECT p.t_id FROM PlanungEntity p "
						+ " WHERE p.s_id = :sId AND p.r_id = :rId )"
					)
})
public class TerminEntity {

	public static final String GET_ID_BY_DAY_TIME = "termin.id";
	public static final String GET_FREE_TERMIN = "termin.free";
	
	@Column(name="t_id",nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="t_tag")
	private String tag;
	
	@Column(name="t_von")
	private String von;
	
	@Column(name="t_bis")
	private String bis;
	
	@OneToMany(mappedBy="termin", targetEntity=PlanungEntity.class, fetch=FetchType.LAZY)
	private List<PlanungEntity> planung;
	
	@OneToMany(mappedBy="termin", targetEntity=UebungPlanungEntity.class, fetch=FetchType.LAZY)
	private List<UebungPlanungEntity> uplanung;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public String getVon() {
		return von;
	}

	public void setVon(String von) {
		this.von = von;
	}

	public String getBis() {
		return bis;
	}

	public void setBis(String bis) {
		this.bis = bis;
	}

	public List<PlanungEntity> getPlanung() {
		return planung;
	}

	public void setPlanung(List<PlanungEntity> planung) {
		this.planung = planung;
	}

	public List<UebungPlanungEntity> getUplanung() {
		return uplanung;
	}

	public void setUplanung(List<UebungPlanungEntity> uplanung) {
		this.uplanung = uplanung;
	}	
	
}
