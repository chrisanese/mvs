package de.fu.mi.scuttle.domain.modulVW;

import java.util.ArrayList;
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
@Table(name="modulverwaltung1_modul")

public class ModulEntity {
	
	public static final String GET_MODULE_BY_INSTITUTE = "module.institute";
	
	@Column(name="m_id",nullable=false)
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Id
	private long id;
	
	@Column(name="m_name")
	private String name;
	
	@Column(name="m_inhalt")
	private String inhalt;
	
	@Column(name="m_ziel")
	private String ziel;

	@Column(name="m_literatur")
	private String literatur;
	
	@Column(name="m_voraussetzung")
	private String voraussetzung;
	
	@Column(name="m_typ")
	private long typ;
	
	@Column(name="m_lvNummer")
	private String mNummer;
	
	@Column(name="m_geaendert_am")
	private String letzteAenderung;
		
	
	// Foreign Keys
	@Column(name="mk_id")
	private long mk_id;
	
	@Column(name="sp_id")
	private long sp_id;
	/*
	 * 
	 */
	@OneToMany(mappedBy="modul", targetEntity=StoModulEntity.class, fetch=FetchType.LAZY)
	private List<StoModulEntity> stoModule;

	@OneToMany(mappedBy="modul", targetEntity=LehrveranstaltungEntity.class, fetch=FetchType.LAZY)
	private List<LehrveranstaltungEntity> veranstaltungen;
		
	@OneToMany(mappedBy="modul", targetEntity=ModulVerantwortlicheEntity.class, fetch=FetchType.LAZY)
	private List<ModulVerantwortlicheEntity> verantwortliche;
	
	@OneToMany(mappedBy="modul", targetEntity=ModulLvsEntity.class, fetch=FetchType.LAZY)
	private List<ModulLvsEntity> modulLvs;
	
	@OneToMany(mappedBy="modul", targetEntity=SekStoEntity.class, fetch=FetchType.LAZY)
	private List<SekStoEntity> sekStos;
	
	@OneToMany(mappedBy="modul", targetEntity=ModulHuelsenEntity.class, fetch=FetchType.LAZY)
	private List<ModulHuelsenEntity> modulHuelsen;

	@ManyToOne(optional=false)
	@JoinColumn(name="mk_id", referencedColumnName="mk_id", insertable=false, updatable= false)
	private ModulKategorieEntity kategorie;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="sp_id", referencedColumnName="sp_id", insertable=false, updatable= false)
	private SprachenEntity sprache;
	/*
	 * 
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

	public String getInhalt() {
		return inhalt;
	}

	public void setInhalt(String inhalt) {
		this.inhalt = inhalt;
	}

	public String getZiel() {
		return ziel;
	}

	public void setZiel(String ziel) {
		this.ziel = ziel;
	}

	public String getLiteratur() {
		return literatur;
	}

	public void setLiteratur(String literatur) {
		this.literatur = literatur;
	}

	public String getVoraussetzung() {
		return voraussetzung;
	}

	public void setVoraussetzung(String voraussetzung) {
		this.voraussetzung = voraussetzung;
	}

	public String getMNummer() {
		return mNummer;
	}

	public void setMNummer(String mNummer) {
		this.mNummer = mNummer;
	}

	public String getLetzteAenderung() {
		return letzteAenderung;
	}

	public void setLetzteAenderung(String letzteAenderung) {
		this.letzteAenderung = letzteAenderung;
	}

	public long getMk_id() {
		return mk_id;
	}

	public void setMk_id(long mk_id) {
		this.mk_id = mk_id;
	}

	public long getSp_id() {
		return sp_id;
	}

	public void setSp_id(long sp_id) {
		this.sp_id = sp_id;
	}

	public List<StoModulEntity> getStoModule() {
		return stoModule;
	}

	public void setStoModule(List<StoModulEntity> stoModule) {
		this.stoModule = stoModule;
	}

	public List<LehrveranstaltungEntity> getVeranstaltungen() {
		return veranstaltungen;
	}

	public void setVeranstaltungen(List<LehrveranstaltungEntity> veranstaltungen) {
		this.veranstaltungen = veranstaltungen;
	}

	public List<ModulVerantwortlicheEntity> getVerantwortliche() {
		return verantwortliche;
	}

	public void setVerantwortliche(List<ModulVerantwortlicheEntity> verantwortliche) {
		this.verantwortliche = verantwortliche;
	}

	public ModulKategorieEntity getKategorie() {
		return kategorie;
	}

	public void setKategorie(ModulKategorieEntity kategorie) {
		this.kategorie = kategorie;
	}

	public SprachenEntity getSprache() {
		return sprache;
	}

	public void setSprache(SprachenEntity sprache) {
		this.sprache = sprache;
	}
	
	public long getM_typ() {
		return typ;
	}

	public void setM_typ(long m_typ) {
		this.typ = m_typ;
	}
	
	
	public List<ModulLvsEntity> getModulLvs() {
		return modulLvs;
	}

	public void setModulLvs(List<ModulLvsEntity> modulLvs) {
		this.modulLvs = modulLvs;
	}
	
	public StoModulEntity getCurrentStoModul(){
		List<StoModulEntity> stoModList = this.getStoModule();
		//StoModulEntity ret = null;
		for(StoModulEntity stoMod : stoModList){
			if(stoMod.getSto().getAktuell() == 1){
				return stoMod;
			}
		}	
		return new StoModulEntity();
	}
	
	public LehrveranstaltungEntity getTutorium(){
		List<LehrveranstaltungEntity> lvs = this.getVeranstaltungen();
		
		for(LehrveranstaltungEntity lv : lvs){
			if(lv.getLvt_id() == 2){
				return lv;
			}
		}		
		return null;
	}
	
	public List<LehrveranstaltungEntity> getLvs(){
		List<LehrveranstaltungEntity> lvs = this.getVeranstaltungen();
		List<LehrveranstaltungEntity> lvList = new ArrayList<LehrveranstaltungEntity>();
		for(LehrveranstaltungEntity lv : lvs){
			if(lv.getLvt_id() != 2){
				lvList.add(lv);
			}
		}		
		return lvList;
	}
	
	public String getTypName(){
		String ret = "Pflicht";
		if(this.getM_typ() == 2)
			ret = "Regelmäßig";
		else if(this.getM_typ() == 3)
			ret = "Einmalig";
		else if(this.getM_typ() == 4)
			ret = "Forschungsseminar";
		return ret;
	}
	
	public LehrveranstaltungEntity getUebung(){
		
		return null;
	}

	public long getTyp() {
		return typ;
	}

	public void setTyp(long typ) {
		this.typ = typ;
	}

	public String getmNummer() {
		return mNummer;
	}

	public void setmNummer(String mNummer) {
		this.mNummer = mNummer;
	}

	public List<SekStoEntity> getSekStos() {
		return sekStos;
	}

	public void setSekStos(List<SekStoEntity> sekStos) {
		this.sekStos = sekStos;
	}

	public List<ModulHuelsenEntity> getModulHuelsen() {
		return modulHuelsen;
	}

	public void setModulHuelsen(List<ModulHuelsenEntity> modulHuelsen) {
		this.modulHuelsen = modulHuelsen;
	}
}
