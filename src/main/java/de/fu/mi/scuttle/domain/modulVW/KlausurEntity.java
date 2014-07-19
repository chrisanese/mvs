package de.fu.mi.scuttle.domain.modulVW;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
@Table(name="modulverwaltung1_klausur")
@NamedQueries({
	@NamedQuery(
			name = KlausurEntity.GET_AT_BY_SEMLV,
			query = "SELECT at FROM KlausurEntity at "
				+ "WHERE at.lv_id = :lvId "
				+ "AND at.s_id = :sId "
				+ "ORDER BY at.datum"
			)
})
public class KlausurEntity {
	
	public static final String GET_AT_BY_SEMLV = "at.semlv";

	@Column(name="k_id", nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	// Foreign Keys
	
	@Column(name="lv_id")
	private long lv_id;
	
	@Column(name="kt_id")
	private long kt_id;
	
	@Column(name="s_id")
	private long s_id;
	
	@Column(name="r_id")
	private long r_id;
	
	@Column(name="k_datum")
	private String datum;
	
	@Column(name="k_von")
	private String von;
	
	@Column(name="k_bis")
	private String bis;
	
	/*
	 * Begin: FKEY Definition
	 */
	@ManyToOne(optional=false)
	@JoinColumn(name="lv_id", referencedColumnName="lv_id", insertable=false, updatable= false)
	private LehrveranstaltungEntity lv;
	
	
	@ManyToOne(optional=false)
	@JoinColumn(name="kt_id", referencedColumnName="kt_id", insertable=false, updatable= false)
	private KlausurTypEntity klausurTyp;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="s_id", referencedColumnName="s_id", insertable=false, updatable= false)
	private SemesterEntity semester;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="r_id", referencedColumnName="r_id", insertable=false, updatable= false)
	private RaumEntity raum;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getM_id() {
		return lv_id;
	}

	public void setM_id(long m_id) {
		this.lv_id = m_id;
	}

	public long getKt_id() {
		return kt_id;
	}

	public void setKt_id(long kt_id) {
		this.kt_id = kt_id;
	}

	public long getS_id() {
		return s_id;
	}

	public void setS_id(long s_id) {
		this.s_id = s_id;
	}

	public KlausurTypEntity getKlausurTyp() {
		return klausurTyp;
	}

	public void setKlausurTyp(KlausurTypEntity klausurTyp) {
		this.klausurTyp = klausurTyp;
	}
	
	public SemesterEntity getSemester() {
		return semester;
	}

	public void setSemester(SemesterEntity semester) {
		this.semester = semester;
	}

	public long getR_id() {
		return r_id;
	}

	public void setR_id(long r_id) {
		this.r_id = r_id;
	}

	public String getDatum() {
		return datum;
	}

	public void setDatum(String datum) {
		this.datum = datum;
	}

	public RaumEntity getRaum() {
		return raum;
	}

	public void setRaum(RaumEntity raum) {
		this.raum = raum;
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

	public long getLv_id() {
		return lv_id;
	}

	public void setLv_id(long lv_id) {
		this.lv_id = lv_id;
	}

	public LehrveranstaltungEntity getLv() {
		return lv;
	}

	public void setLv(LehrveranstaltungEntity lv) {
		this.lv = lv;
	}
	
	public String getFormattedDate() throws ParseException{
		final String FORMAT = "dd.MM.yyyy";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date d = sdf.parse(this.getDatum());
		sdf.applyPattern(FORMAT);
		return sdf.format(d);
	}
}
