package de.fu.mi.scuttle.modules.modulVW;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.persistence.Query;

import org.json.JSONArray;
import org.json.JSONException;

import de.fu.mi.scuttle.domain.modulVW.FachbereichEntity;
import de.fu.mi.scuttle.domain.modulVW.GebaeudeEntity;
import de.fu.mi.scuttle.domain.modulVW.HuelsenEntity;
import de.fu.mi.scuttle.domain.modulVW.InstitutEntity;
import de.fu.mi.scuttle.domain.modulVW.KlausurEntity;
import de.fu.mi.scuttle.domain.modulVW.KlausurTypEntity;
import de.fu.mi.scuttle.domain.modulVW.LecturerEntity;
import de.fu.mi.scuttle.domain.modulVW.LehrveranstaltungEntity;
import de.fu.mi.scuttle.domain.modulVW.LvTypEntity;
import de.fu.mi.scuttle.domain.modulVW.ModulCounterEntity;
import de.fu.mi.scuttle.domain.modulVW.ModulEntity;
import de.fu.mi.scuttle.domain.modulVW.ModulHuelsenEntity;
import de.fu.mi.scuttle.domain.modulVW.ModulKategorieEntity;
import de.fu.mi.scuttle.domain.modulVW.ModulLvsEntity;
import de.fu.mi.scuttle.domain.modulVW.ModulVerantwortlicheEntity;
import de.fu.mi.scuttle.domain.modulVW.PlanungEntity;
import de.fu.mi.scuttle.domain.modulVW.RaumEntity;
import de.fu.mi.scuttle.domain.modulVW.SekStoEntity;
import de.fu.mi.scuttle.domain.modulVW.SemesterEntity;
import de.fu.mi.scuttle.domain.modulVW.SemesterLecturerEntity;
import de.fu.mi.scuttle.domain.modulVW.SprachenEntity;
import de.fu.mi.scuttle.domain.modulVW.StoModulEntity;
import de.fu.mi.scuttle.domain.modulVW.StudienartEntity;
import de.fu.mi.scuttle.domain.modulVW.StudienordnungEntity;
import de.fu.mi.scuttle.domain.modulVW.TerminEntity;
import de.fu.mi.scuttle.domain.modulVW.UebungEntity;
import de.fu.mi.scuttle.domain.modulVW.UebungPlanungEntity;
import de.fu.mi.scuttle.domain.modulVW.UsersEntity;
import de.fu.mi.scuttle.lib.ScuttleBackendServlet;
import de.fu.mi.scuttle.lib.persistence.TypedQuery;
import de.fu.mi.scuttle.lib.util.JsonArray;
import de.fu.mi.scuttle.lib.util.JsonObject;
import de.fu.mi.scuttle.lib.util.concurrent.AbstractJob;
import de.fu.mi.scuttle.lib.web.AbstractScuttleModule;
import de.fu.mi.scuttle.lib.web.JSONResponse;
import de.fu.mi.scuttle.lib.web.MountPoint;
import de.fu.mi.scuttle.lib.web.ScuttleRequest;
import de.fu.mi.scuttle.lib.web.ScuttleResponse;
import de.fu.mi.scuttle.lib.web.XMLResponse;

@MountPoint("modulVW")
public class ModulVW extends AbstractScuttleModule<ScuttleBackendServlet> {

	public ModulVW(final ScuttleBackendServlet parent) throws JSONException {
		super(parent);
		redo();
		updateData();
		/*setFactory(Persistence
				.createEntityManagerFactory(PERSISTENCE_UNIT_NAME));
		setEm(EntityManagerWrapper.wrap(getFactory().createEntityManager()));*/
	}
	
	private void updateData() throws JSONException {
        parent().getJobQueue().repeat(
                new AbstractJob("Update Data every 5 minutes") {
                    @Override
                    public void execute() throws Exception {
                    	db().evictAll();
                    	db().getEntityManagerFactory().getCache().evictAll();
                    	System.gc();
                        redo();
                    }
                }, 300, TimeUnit.SECONDS);
	}

	public void redo(){
		// TODO: Implement redo such that if flushes the cache
	}
	
	@Override
	public ScuttleResponse handle(ScuttleRequest request) throws Exception {
		JSONResponse response = null;
		JsonObject re = null;
		// Path aufspalten
		String path = request.getPath();
		final String paths[] = path.split("/");

		String semId = "", mId = "";
		if (paths.length > 1) {
		//	System.out.println(paths[0] + " " + paths[1] + " " + paths[2]);
			mId = paths[1];
			semId = paths[2];
			path = paths[0];
		}

		switch (path) {
		case "logout":			
			re = getInstituteModulesBySemester("7", "4");
			re.put("editM", getMEditData());
			if(request.getSession().get("username")!= null)
				request.getSession().remove("username");
			response = new JSONResponse(re);
			break;
		case "insertModul":
			re = neuesModul(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "langfristPlanung":
			re = getLangfristplanung(mId,semId);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "newModule":
			re = getMetaInformation();
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "insertModule":
			re = insertModule(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;

		case "moduleList":
			re = getModuleList();
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
        case "export":
            return new ParameterizedPDFResponse(new JSONResponse(getModuleInfos(request)), ModulVW.class.getResourceAsStream("modulVW.xsl"), "sId", semId);
        case "detailed":
            return new ParameterizedPDFResponse(new JSONResponse(getModuleInfos(request)), ModulVW.class.getResourceAsStream("detail.xsl"), "sId", semId);
		case "modules":
			response = new JSONResponse(new JsonObject().put("return", "yes"));
			break;
		case "editModule":
			re = editModule(mId, semId);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "updateModule":
			re = updateModule(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		/*case "updateSchedule":
			re = updateSchedule(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;*/
		case "login":
			response = new JSONResponse(login(request));
			break;
		case "setPwd":
			re = createUser(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;			
		case "saveLecturer":
			re = saveLecturer(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;			
		case "newCourse":
			re = getCourseInfos(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "insertLv":
			re = insertLv(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "moduleListeOld":
			re = getModuleInfos(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re); 
			break;
		case "moduleListe":
			// mId := iId
			re = getInstituteModulesBySemester(mId,semId);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re); 
			break;
		case "newExport":
			return new XMLResponse(new JSONResponse(getModuleInfos(request)));
		case "planLv":
			re = lvSemesterData(mId, semId);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "updateLv":
			re = updateLv(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "mEditInfo":
			re = mEditInfo(mId);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "saveMEdit":
			re = saveMEdit(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
			
		case "meineModule":
			re = meineModule(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		case "readDb":
			re = getDbStats(request);
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;		
		default:
			re = new JsonObject().put("success", "true");
			re.put("editM", getMEditData());
			if(request.getSession().get("firstlogin")!= null){
				re.put("firstlogin", request.getSession().get("firstlogin"));
				request.getSession().remove("firstlogin");
			}
			if(request.getSession().get("username")!= null)
				re.put("loginname", request.getSession().get("username"));
			response = new JSONResponse(re);
			break;
		}
		return response;
	}

	/**
	 * Returns a List of the tables and there row Count
	 * @param request
	 * @return
	 */
	private JsonObject getDbStats(ScuttleRequest request) {
		JsonArray tablesJson = new JsonArray();
		// Module
		
		// LVs
		
		// STOs
		
		// Termine
		/**
		 * SELECT SUM(t.t_bis - t.t_von) FROM `modulverwaltung1_planung` p, `modulverwaltung1_termin` t WHERE p.t_id = t.t_id AND p.s_id = 4
		 */
		
		return null;
	}

	private JsonObject meineModule(ScuttleRequest request) throws JSONException {
		JsonObject ret = new JsonObject();
		//long lId = Long.parseLong(mId);
		String account = request.getSession().getString("username");
		System.out.println(account);
		LecturerEntity l = db().createNamedQuery(
				LecturerEntity.GET_LEC_BY_ACC,
				LecturerEntity.class)
				.setParameter("acc", account)
				.getSingleResult();
		if(l != null){
			ret.put("lName", l.getVorname() + " " + l.getNachname());
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			Date today = new Date();
			
			SemesterEntity s = db().createNamedQuery(
					SemesterEntity.GET_CURRENT_SEMESTER,
					SemesterEntity.class)
					.setParameter("date", format.format(today))
					.getSingleResult(); 
			
			if(s!=null){
				System.out.println("SEMESTER " + s.getId() + " " + s.getName());
				List<LehrveranstaltungEntity> lvList = db().createNamedQuery(
						LehrveranstaltungEntity.GET_LV_BY_SEMESTER,
						LehrveranstaltungEntity.class)
						.setParameter("sId", s.getId())
						.setParameter("lId", l.getId())
						.getResultList();
				List<LehrveranstaltungEntity> nextLvList = db().createNamedQuery(
						LehrveranstaltungEntity.GET_LV_BY_SEMESTER,
						LehrveranstaltungEntity.class)
						.setParameter("sId", s.getId()+1)
						.setParameter("lId", 6)
						.getResultList();
				
				JsonArray lvListJson  = new JsonArray();
				JsonArray nextLvListJson  = new JsonArray();
				for(LehrveranstaltungEntity lv : lvList){
					JsonObject lvJson = new JsonObject()
					.put("lvId", lv.getId())
					.put("lvName", lv.getName())
					.put("lvNummer", lv.getNummer());
					lvListJson.put(lvJson);
				}
				if(!lvListJson.isEmpty()){
					JsonObject semJson = new JsonObject()
					.put("sId", s.getId())
					.put("sName", s.getName())
					.put("lvs",lvListJson);
					ret.put("currentSem", semJson);
				}
				
				
				for(LehrveranstaltungEntity lv : nextLvList){
					JsonObject lvJson = new JsonObject()
					.put("lvId", lv.getId())
					.put("lvName", lv.getName())
					.put("lvNummer", lv.getNummer());
					nextLvListJson.put(lvJson);
				}
				SemesterEntity nextSem = db().find(
						SemesterEntity.class,
						s.getId()+1);
				
				if(nextSem != null){
					JsonObject nSemJson = new JsonObject()
					.put("sId", nextSem.getId())
					.put("sName", nextSem.getName())
					.put("lvs", nextLvListJson);
					ret.put("nextSem", nSemJson);
				}
			}			
			
		}else{
			ret.put("success",false);
		}
		return ret;
	}

	private JsonObject updateLv(ScuttleRequest request) throws JSONException {
			Long lvId = Long.parseLong(request.get("lvId"));
			Long ubId = Long.parseLong(request.get("ubId"));
			Long sid = Long.parseLong(request.get("sId"));
			String name = request.get("lvName");
			String inhalt = request.get("inhalt");
			String lit = request.get("literatur");
			String info = request.get("info");
			JSONArray loescheLvs = new JSONArray(request.get("loescheLvs"));
			JSONArray loescheUb = new JSONArray(request.get("loescheUb"));
			JSONArray loescheAt = new JSONArray(request.get("loescheAt"));
			
			JSONArray neueLvs = new JSONArray(request.get("neueLvs"));
			JSONArray neueTuts = new JSONArray(request.get("neueUb"));
			JSONArray neueAt = new JSONArray(request.get("neueAt"));
			
			if(loescheLvs.length() > 0){
				for(int i=0; i < loescheLvs.length();i++){
					String pId = (String) loescheLvs.get(i);
					PlanungEntity plan = db().find(PlanungEntity.class, Long.parseLong(pId));
					if(plan != null){
						db().getTransaction().begin();
						db().remove(plan);
						db().getTransaction().commit();
					}
				}
			}
			
			if(loescheUb.length() > 0){
				for(int i=0; i < loescheUb.length();i++){
					String pId = (String) loescheUb.get(i);
					UebungPlanungEntity plan = db().find(UebungPlanungEntity.class, Long.parseLong(pId));
					if(plan != null){
						db().getTransaction().begin();
						db().remove(plan);
						db().getTransaction().commit();
					}
				}
			}
			
			if(loescheAt.length() > 0){
				for(int i=0; i < loescheAt.length();i++){
					String atId = (String) loescheAt.get(i);
					KlausurEntity klaus = db().find(KlausurEntity.class, Long.parseLong(atId));
					//UebungPlanungEntity plan = db().find(UebungPlanungEntity.class, Long.parseLong(pId));
					if(klaus != null){
						db().getTransaction().begin();
						db().remove(klaus);
						db().getTransaction().commit();
					}
				}
			}
			
			// Update Lv
			LehrveranstaltungEntity lv = db().find(LehrveranstaltungEntity.class, lvId);
			if(lv != null){
				db().getTransaction().begin();
				lv.setName(name);
				lv.setInhalt(inhalt);
				lv.setLiteratur(lit);
				lv.setVoraussetzung(info);					
				db().getTransaction().commit();
			}
			
			// Eintragen der Haupttermine
			for(int i=0; i < neueLvs.length();i++){
				JSONArray nLv = neueLvs.getJSONArray(i);
				
				String tag = (String) nLv.get(0);
				String von = ((String) nLv.get(1)).substring(0, 2);
				String bis = ((String) nLv.get(2)).substring(0, 2);;
				String rId = (String) nLv.get(3);
				long tId = 0;
				
				//System.out.println("von "+von + " bis "+bis);
				TerminEntity termin = db().createNamedQuery(
						TerminEntity.GET_ID_BY_DAY_TIME,
						TerminEntity.class)
						.setParameter("tTag", tag)
						.setParameter("tVon", von)
						.setParameter("tBis", bis)
						.getSingleResult();
				if (termin == null) {
					db().getTransaction().begin();
					TerminEntity newTermin = new TerminEntity();
					newTermin.setTag(tag);
					newTermin.setVon(von);
					newTermin.setBis(bis);
					db().getTransaction().commit();
					db().persist(newTermin);
					tId = newTermin.getId();
				}else
					tId = termin.getId();
				//System.out.println("TId : " + tId);
			
			
				db().getTransaction().begin();
				PlanungEntity lvPlan = new PlanungEntity();
				lvPlan.setLv_id(lvId);
				lvPlan.setT_id(tId);
				lvPlan.setR_id(Long.parseLong(rId));
				lvPlan.setS_id(sid);
				
				db().getTransaction().commit();
				db().persist(lvPlan);
				long pId = lvPlan.getId();
				
				JSONArray lecturer = nLv.getJSONArray(4);
				for(int j = 0; j <lecturer.length();j++){
					String lId = (String) lecturer.get(j);
					db().getTransaction().begin();
					SemesterLecturerEntity semLec = new SemesterLecturerEntity();
					semLec.setP_id(pId);
					semLec.setL_id(Long.parseLong(lId));
					db().getTransaction().commit();
					db().persist(semLec);
				}
				
			}
			
			// Eintragen der Begleittermine
			for(int i = 0; i < neueTuts.length();i++){
				JSONArray nTut = neueTuts.getJSONArray(i);
				String tag = (String) nTut.get(0);
				String von = ((String) nTut.get(1)).substring(0, 2);
				String bis = ((String) nTut.get(2)).substring(0, 2);;
				String rId = (String) nTut.get(3);
				String lId = (String) nTut.get(4);
				long tId = 0;
				
				TerminEntity termin = db().createNamedQuery(
						TerminEntity.GET_ID_BY_DAY_TIME,
						TerminEntity.class)
						.setParameter("tTag", tag)
						.setParameter("tVon", von)
						.setParameter("tBis", bis)
						.getSingleResult();
				if (termin == null) {
					db().getTransaction().begin();
					TerminEntity newTermin = new TerminEntity();
					newTermin.setTag(tag);
					newTermin.setVon(von);
					newTermin.setBis(bis);
					db().getTransaction().commit();
					db().persist(newTermin);
					tId = newTermin.getId();
				}else
					tId = termin.getId();
				
				db().getTransaction().begin();
				UebungPlanungEntity ubPlan = new UebungPlanungEntity();
				ubPlan.setUb_id(ubId);
				ubPlan.setT_id(tId);
				ubPlan.setR_id(Long.parseLong(rId));
				ubPlan.setS_id(sid);
				ubPlan.setL_id(Long.parseLong(lId));
				db().getTransaction().commit();
				db().persist(ubPlan);				
			}
			
			for(int i=0; i < neueAt.length(); i++){
				JSONArray nAt = neueAt.getJSONArray(i);
				String datum = (String) nAt.get(0);
				String von = ((String) nAt.get(1)).substring(0, 2);
				String bis = ((String) nAt.get(2)).substring(0, 2);;
				String rId = (String) nAt.get(3);
				String atId = (String) nAt.get(4);
				
				db().getTransaction().begin();
				KlausurEntity at = new KlausurEntity();
				at.setDatum(datum);
				at.setVon(von);
				at.setBis(bis);
				at.setKt_id(Long.parseLong(atId));
				at.setS_id(sid);
				at.setR_id(Long.parseLong(rId));
				at.setLv_id(lvId);
				db().getTransaction().commit();
				db().persist(at);				
			}
			
			return new JsonObject().put("success", "true");
	}

	private JsonObject saveMEdit(ScuttleRequest request) {
		long mId = Long.parseLong(request.get("mId"));
		String mName = request.get("mName");
		String mEcts = request.get("mEcts");
		long mTypId = Long.parseLong(request.get("mTypId"));
		
		ModulEntity modul = db().find(ModulEntity.class, mId);
		if(modul != null){
			db().getTransaction().begin();
			modul.setName(mName);
			modul.setM_typ(mTypId);
			modul.getCurrentStoModul().setEcts(mEcts);
			db().getTransaction().commit();
		}
		return new JsonObject().put("success", "true");
	}

	private JsonObject mEditInfo(String mId) throws JSONException {
		JsonObject ret = new JsonObject();
		ModulEntity modul = db().find(
				ModulEntity.class,
				Long.parseLong(mId));
		if(modul != null){
			InstitutEntity ins = modul.getCurrentStoModul().getSto().getInstitut();
			StudienartEntity sta = modul.getCurrentStoModul().getSto().getSta();
			ret
			.put("mId", modul.getId())
			.put("mName", modul.getName())
			.put("mNummer", modul.getMNummer())
			.put("mEcts", modul.getCurrentStoModul().getEcts())
			.put("mFrequenz", modul.getCurrentStoModul().getFrequency())
			.put("mTyp", modul.getM_typ())
			.put("mTypName", modul.getTypName())
			.put("mEdit", modul.getLetzteAenderung())
			.put("mIId", ins.getId())
			.put("mIName", ins.getName())
			.put("mStaId", sta.getId())
			.put("mStaName", sta.getName());
			
			List<ModulLvsEntity> modulLvs = db().createNamedQuery(
					ModulLvsEntity.GET_MODULES,
					ModulLvsEntity.class)
					.setParameter("mId", modul.getId())
					.getResultList();
					
			JsonArray modulLvsJson = new JsonArray();
			for(ModulLvsEntity modulLv : modulLvs){
				JsonObject modulLvJson = new JsonObject()
				.put("mlId", modulLv.getId())
				.put("mlSws", modulLv.getSws())
				.put("mlPflicht", modulLv.isAnwesenheitspflicht())
				.put("mlTypd", modulLv.getLvt_id())
				.put("mlTypName", modulLv.getLvTyp().getName());
				
				ModulLvsEntity tut = db().createNamedQuery(
						ModulLvsEntity.GET_TUTORIAL,
						ModulLvsEntity.class)
						.setParameter("mId", modul.getId())
						.setParameter("primaryId", modulLv.getId())
						.getSingleResult();
				if(tut!=null){
					modulLvJson
					.put("uId", tut.getId())
					.put("uSws", tut.getSws())
					.put("uPflicht", tut.isAnwesenheitspflicht())
					.put("uTyp", "Übung");
				}
				modulLvsJson.put(modulLvJson);
			}
			if(!modulLvsJson.isEmpty())
				ret.put("modulLvs", modulLvsJson);
			
			List<LehrveranstaltungEntity> lvListe = modul.getVeranstaltungen();
			JsonArray lvListeJson = new JsonArray();
			for(LehrveranstaltungEntity lv : lvListe){
				JsonObject lvJson = new JsonObject()
				.put("lvId", lv.getId())
				.put("lvName", lv.getName())
				.put("lvNummer", lv.getNummer())
				.put("lvSws", lv.getSws());
				
				UebungEntity uebung = lv.getUebung();
				if( uebung!= null){
					JsonObject ubJson = new JsonObject()
					.put("ubId", uebung.getId())
					.put("ubNummer", uebung.getLvnummer())
					.put("uSws", uebung.getSws());
					
					lvJson.put("uebung", ubJson);
				}
				
				lvListeJson.put(lvJson);
			}
			if(!lvListeJson.isEmpty())
				ret.put("currentLvs", lvListeJson);
			
		}
		return ret;
	}

	private Object getMEditData() throws JSONException {
		JsonObject ret = new JsonObject();
		
		List<StudienordnungEntity> infoStos = db().createNamedQuery(StudienordnungEntity.CURRENT_STOS_BY_INSTITUTE,
				StudienordnungEntity.class)
				.setParameter("iId", 7)
				.getResultList();
		List<StudienordnungEntity> matheStos = db().createNamedQuery(StudienordnungEntity.CURRENT_STOS_BY_INSTITUTE,
				StudienordnungEntity.class)
				.setParameter("iId", 8)
				.getResultList();
		List<StudienordnungEntity> physikStos = db().createNamedQuery(StudienordnungEntity.CURRENT_STOS_BY_INSTITUTE,
				StudienordnungEntity.class)
				.setParameter("iId", 10)
				.getResultList();
		List<StudienordnungEntity> bioStos = db().createNamedQuery(StudienordnungEntity.CURRENT_STOS_BY_INSTITUTE,
				StudienordnungEntity.class)
				.setParameter("iId", 11)
				.getResultList();
		
		// Bsc
		JsonArray infoModules = new JsonArray();
		JsonArray matheModules = new JsonArray();
		JsonArray physikModules = new JsonArray();
		JsonArray bioModules = new JsonArray();
		
		// Master
		JsonArray minfoModules = new JsonArray();
		JsonArray mmatheModules = new JsonArray();
		JsonArray mphysikModules = new JsonArray();
		JsonArray mbioModules = new JsonArray();
		
		// Lehramt
		JsonArray linfoModules = new JsonArray();
		JsonArray lmatheModules = new JsonArray();
		JsonArray lphysikModules = new JsonArray();
		JsonArray lbioModules = new JsonArray();
		for(StudienordnungEntity sto : infoStos){
			List<StoModulEntity> modulListe = sto.getStoModule();
			for(StoModulEntity stoM : modulListe){
				ModulEntity modul = stoM.getModul();
				JsonObject modulJson = new JsonObject()
				.put("mId", modul.getId())
				.put("mName", modul.getName())
				.put("staId", sto.getSta_id());
				
				switch ((int)sto.getSta_id()) {
				case 1:
					infoModules.put(modulJson);
					break;
				case 2:
					minfoModules.put(modulJson);
					break;
				case 3:
					linfoModules.put(modulJson);
					break;
				default:
					break;
				}
				
			}
		}
		
		for(StudienordnungEntity sto : matheStos){
			List<StoModulEntity> modulListe = sto.getStoModule();
			for(StoModulEntity stoM : modulListe){
				ModulEntity modul = stoM.getModul();
				JsonObject modulJson = new JsonObject()
				.put("mId", modul.getId())
				.put("mName", modul.getName())
				.put("staId", sto.getSta_id());
				
				switch ((int)sto.getSta_id()) {
				case 1:
					matheModules.put(modulJson);
					break;
				case 2:
					mmatheModules.put(modulJson);
					break;
				case 3:
					lmatheModules.put(modulJson);
					break;
				default:
					break;
				}
			}
		}
		
		for(StudienordnungEntity sto : physikStos){
			List<StoModulEntity> modulListe = sto.getStoModule();
			for(StoModulEntity stoM : modulListe){
				ModulEntity modul = stoM.getModul();
				JsonObject modulJson = new JsonObject()
				.put("mId", modul.getId())
				.put("mName", modul.getName())
				.put("staId", sto.getSta_id());
				
				switch ((int)sto.getSta_id()) {
				case 1:
					physikModules.put(modulJson);
					break;
				case 2:
					mphysikModules.put(modulJson);
					break;
				case 3:
					lphysikModules.put(modulJson);
					break;
				default:
					break;
				}
				
			}
		}
		
		for(StudienordnungEntity sto : bioStos){
			List<StoModulEntity> modulListe = sto.getStoModule();
			for(StoModulEntity stoM : modulListe){
				ModulEntity modul = stoM.getModul();
				JsonObject modulJson = new JsonObject()
				.put("mId", modul.getId())
				.put("mName", modul.getName())
				.put("staId", sto.getSta_id());
				
				
				switch ((int)sto.getSta_id()) {
				case 1:
					bioModules.put(modulJson);
					break;
				case 2:
					mbioModules.put(modulJson);
					break;
				case 3:
					lbioModules.put(modulJson);
					break;
				default:
					break;
				}
				
			}
		}
		
		ret
		.put("binfo", infoModules)
		.put("minfo", minfoModules)
		.put("linfo", linfoModules)
		.put("bmathe", matheModules)
		.put("mmathe", mmatheModules)
		.put("lmathe", lmatheModules)
		.put("bphysik", physikModules)
		.put("mphysik", mphysikModules)
		.put("lphysik", lphysikModules)
		.put("bbio", bioModules)
		.put("mbio", mbioModules)
		.put("lbio", lbioModules);
		
		return ret;
	}

	private JsonObject lvSemesterData(String lvId, String semId) throws JSONException, ParseException {
		JsonObject ret = new JsonObject();
		
		LehrveranstaltungEntity lv = db().find(LehrveranstaltungEntity.class, Long.parseLong(lvId));
		SemesterEntity semester = db().find(SemesterEntity.class, Long.parseLong(semId));
		
		ModulEntity modul = lv.getModul();
		StoModulEntity stoModul = modul.getCurrentStoModul();
		LvTypEntity typ = lv.getLvTyp();
		
		
		ret
		.put("lvId", lv.getId())
		.put("lvName", lv.getName())
		.put("lvInhalt", lv.getInhalt())
		.put("lvLiteratur", lv.getLiteratur())
		.put("lvInfo", lv.getVoraussetzung())
		.put("lvSws", lv.getSws())
		.put("lvPflicht", lv.isAnwesenheitspflicht())
		.put("lvNummer", lv.getNummer())
		.put("lvtId", typ.getId())
		.put("lvtName", typ.getName())
		.put("sId", semester.getId())
		.put("sName", semester.getName())
		.put("sTyp", semester.getTyp())
		.put("sJahr", semester.getJahr())
		.put("mId", modul.getId())
		.put("mName", modul.getName())
		.put("mNummer", modul.getMNummer())
		.put("mSprache", modul.getSprache().getName())
		.put("lvEcts", stoModul.getEcts());
		
		List<Long> lecturerIdList = new ArrayList<Long>();
		List<PlanungEntity> planungList = db().createNamedQuery(
				PlanungEntity.GET_PLANUNG_BY_SEMESTER,
				PlanungEntity.class)
				.setParameter("lvId", lv.getId())
				.setParameter("sId", semester.getId())
				.getResultList();
		
		JsonArray planungListJson = new JsonArray();
		JsonArray lecturerListJson = new JsonArray();
		for(PlanungEntity planung : planungList){
			TerminEntity termin = planung.getTermin();
			RaumEntity raum = planung.getRaum();
			GebaeudeEntity gebaeude = raum.getGebaeude();
			
			JsonObject planungJson = new JsonObject()
			.put("pId", planung.getId())
			.put("pStartDatum", planung.getStartDatum())
			.put("pEndDatum", planung.getEndDatum())
			.put("tId", termin.getId())
			.put("tTag", termin.getTag())
			.put("tVon", termin.getVon())
			.put("tBis", termin.getBis())
			.put("rId", raum.getId())
			.put("rName", raum.getName())
			.put("rKuerzel", raum.getKuerzel())
			.put("rKapaz", raum.getKapazitaet())
			.put("gId", gebaeude.getId())
			.put("gName", gebaeude.getName())
			.put("gKuerzel", gebaeude.getKuerzel())
			.put("gStr", gebaeude.getStrasse())
			.put("gStrNr", gebaeude.getStrassenNr());
			
			planungListJson.put(planungJson);
			
			List<SemesterLecturerEntity> semesterLecturerList = planung.getSemesterLecturer();
			
			for(SemesterLecturerEntity semesterLecturer : semesterLecturerList){
				LecturerEntity lecturer = semesterLecturer.getLecturer();
				
				if(!lecturerIdList.contains(lecturer.getId())){
					JsonObject lecturerJson = new JsonObject()
					.put("lId", lecturer.getId())
					.put("lVorname", lecturer.getVorname())
					.put("lNachname", lecturer.getNachname())
					.put("lZedat", lecturer.getZedat())
					.put("lEmail", lecturer.getEmail());
					
					lecturerIdList.add(lecturer.getId());
					lecturerListJson.put(lecturerJson);
				}				
			}
		}
		if(!planungListJson.isEmpty())
			ret.put("termine", planungListJson);
		if(!lecturerListJson.isEmpty())
			ret.put("lecturer", lecturerListJson);
		
		UebungEntity uebung = lv.getUebung();
		if(uebung != null){
			JsonObject uebungJson = new JsonObject()
			.put("uSws", uebung.getSws())
			.put("ubId", uebung.getId());
			List<UebungPlanungEntity> uPlanungList = db().createNamedQuery(
					UebungPlanungEntity.GET_UPLANUNG_BY_SEMESTER,
					UebungPlanungEntity.class)
					.setParameter("ubId", uebung.getId())
					.setParameter("sId", semester.getId())
					.getResultList();
			JsonArray uPlanungListJson = new JsonArray();
			for(UebungPlanungEntity uPlanung : uPlanungList){
				TerminEntity termin = uPlanung.getTermin();
				RaumEntity raum = uPlanung.getRaum();
				GebaeudeEntity gebaeude = raum.getGebaeude();
				LecturerEntity tutor = uPlanung.getTutor();
				
				JsonObject uplanungJson = new JsonObject()
				.put("pId", uPlanung.getId())
				.put("pStartDatum", uPlanung.getStartDatum())
				.put("pEndDatum", uPlanung.getEndDatum())
				.put("tId", termin.getId())
				.put("tTag", termin.getTag())
				.put("tVon", termin.getVon())
				.put("tBis", termin.getBis())
				.put("rId", raum.getId())
				.put("rName", raum.getName())
				.put("rKuerzel", raum.getKuerzel())
				.put("rKapaz", raum.getKapazitaet())
				.put("gId", gebaeude.getId())
				.put("gName", gebaeude.getName())
				.put("gKuerzel", gebaeude.getKuerzel())
				.put("gStr", gebaeude.getStrasse())
				.put("gStrNr", gebaeude.getStrassenNr())
				.put("lId", tutor.getId())
				.put("lVorname", tutor.getVorname())
				.put("lNachname", tutor.getNachname())
				.put("lZedat", tutor.getZedat())
				.put("lEmail", tutor.getEmail());
				
				uPlanungListJson.put(uplanungJson);
			}
			if(!uPlanungListJson.isEmpty())
				uebungJson.put("utermine", uPlanungListJson);
			
			ret.put("uebung", uebungJson);
		}
		
		List<KlausurEntity> atermineBySemester = db().createNamedQuery(
				KlausurEntity.GET_AT_BY_SEMLV,
				KlausurEntity.class)
				.setParameter("lvId", lv.getId())
				.setParameter("sId", semester.getId())
				.getResultList();
		JsonArray atermineListJson = new JsonArray();
		for(KlausurEntity at : atermineBySemester){
			KlausurTypEntity atT = at.getKlausurTyp();
			RaumEntity atRaum = at.getRaum();
			GebaeudeEntity atGebaeude = atRaum.getGebaeude();
			
			JsonObject atJson = new JsonObject()
			.put("atId", at.getId())
			.put("atName", atT.getName())
			.put("atDatum", at.getDatum())
			.put("atDate", at.getFormattedDate())
			.put("atVon", at.getVon())
			.put("atBis", at.getBis())
			.put("rId", atRaum.getId())
			.put("rName", atRaum.getName())
			.put("rKuerzel", atRaum.getKuerzel())
			.put("rKapaz", atRaum.getKapazitaet())
			.put("gId", atGebaeude.getId())
			.put("gName", atGebaeude.getName())
			.put("gKuerzel", atGebaeude.getKuerzel());
			
			atermineListJson.put(atJson);
		}
		if(!atermineListJson.isEmpty())
			ret.put("atermine", atermineListJson);
		
		
		// Data for Modals
		List<LecturerEntity> lecList = db().findAll(LecturerEntity.class);
		JsonArray lecListJson = new JsonArray();
		JsonArray tutListJson = new JsonArray();
		JsonArray otherListJson = new JsonArray();
		for(LecturerEntity lec : lecList){
			JsonObject lecJson = new JsonObject()
			.put("lId",lec.getId())
			.put("lVorname",lec.getVorname())
			.put("lNachname",lec.getNachname());
			if(lec.getLt_id() == 1)
				lecListJson.put(lecJson);
			else if(lec.getLt_id() == 2)
				tutListJson.put(lecJson);
			else
				otherListJson.put(lecJson);
		}
		if(!lecListJson.isEmpty())
			ret.put("allLecturer", lecListJson);
		if(!tutListJson.isEmpty())
			ret.put("allTut", tutListJson);
		if(!otherListJson.isEmpty())
			ret.put("allOther", otherListJson);
		
		List<GebaeudeEntity> gebList = db().findAll(GebaeudeEntity.class);
		JsonArray gebListJson = new JsonArray();
		for(GebaeudeEntity gebaeude : gebList){
			JsonObject gebJson = new JsonObject()
			.put("gId", gebaeude.getId())
			.put("gName", !gebaeude.getName().equals("") ? gebaeude.getName() : gebaeude.getStrasse()+" "+gebaeude.getStrassenNr())
			.put("gKuerzel", gebaeude.getKuerzel())
			.put("gStrasse", gebaeude.getStrasse())
			.put("gStrasseNr", gebaeude.getStrassenNr());			
			
			List<RaumEntity> raumList = gebaeude.getRaeume();
			JsonArray raumListJson = new JsonArray();			
			for(RaumEntity raum : raumList){
				JsonObject raumJson = new JsonObject()
				.put("rId", raum.getId())
				.put("rName", raum.getName())
				.put("rKuerzel", raum.getKuerzel())
				.put("rKap", raum.getKapazitaet());
				if(raum.getId() != 999)
					raumListJson.put(raumJson);
			}
			if(!raumList.isEmpty()){
				gebJson.put("raeume", raumListJson);
				gebListJson.put(gebJson);
			}				
		}
		if(!gebListJson.isEmpty())
			ret.put("gebaeude", gebListJson);
		
		
		return ret;
	}

	private JsonObject insertLv(ScuttleRequest request) {
		long iId = Long.parseLong(request.get("iId"));
		long mId = Long.parseLong(request.get("mId"));
		long lvtId = Long.parseLong(request.get("lvtId"));
		String lvSws = request.get("lvSws");
		boolean lvPflicht = Boolean.parseBoolean(request.get("lvPflicht"));
		String lvName = request.get("lvName");
		String lvInhalt = request.get("lvInhalt");
		String lvLit = request.get("lvLit");
		String lvInfo = request.get("lvInfo");
		boolean hasUebung = Boolean.parseBoolean(request.get("lvUebung"));
		
		InstitutEntity institute = db().find(InstitutEntity.class, iId);
		if(institute != null){
			
			LvTypEntity lvTyp = db().find(LvTypEntity.class, lvtId);
			if(lvTyp != null){
				ModulCounterEntity mCounter = db().createNamedQuery(
						ModulCounterEntity.GET_COUNTER_BY_INSTITUTE,
						ModulCounterEntity.class)
						.setParameter("iId", iId)
						.getSingleResult();
				
				/*
				 * TO-DO COunter erhoehen 
				 * 
				 */
				
				String counter = parseCounter(mCounter.getCounter());
				String lvNummer = institute.getFachbereich().getKuerzel()
						+ institute.getKuerzel()
						+ counter;
				
				
				db().getTransaction().begin();
				mCounter.setCounter(mCounter.getCounter()+1);
				LehrveranstaltungEntity lv = new LehrveranstaltungEntity();
				lv.setName(lvName);
				lv.setInhalt(lvInhalt);
				lv.setLiteratur(lvLit);
				lv.setVoraussetzung(lvInfo);
				lv.setSws(lvSws);
				lv.setM_id(mId);
				lv.setLvt_id(lvtId);
				lv.setNummer(lvNummer+lvTyp.getKuerzel());
				lv.setAnwesenheitspflicht(lvPflicht);
				db().persist(lv);
				db().getTransaction().commit();
				
				if(hasUebung){
					String uSws = request.get("uSws");
					boolean uPflicht = Boolean.parseBoolean(request.get("uPficht"));
					db().getTransaction().begin();
					UebungEntity uebung = new UebungEntity();
					uebung.setSws(uSws);
					uebung.setAnwesenheitspflicht(uPflicht);
					uebung.setLvnummer(lvNummer+"02");
					uebung.setLv_id(lv.getId());
					db().persist(uebung);
					db().getTransaction().commit();
				}
			}
		}
		return new JsonObject().put("success","true");
	}

	private JsonObject neuesModul(ScuttleRequest request) throws JSONException {
		long miId = Long.parseLong(request.get("miId"));
		String mName = request.get("mName");
		String mNummer = request.get("mNummer");
		long mStaId = Long.parseLong(request.get("mStaId"));
		long mArtId = Long.parseLong(request.get("mArtId"));
		String mEcts = request.get("mEcts");
		long mFrequenz = Long.parseLong(request.get("mFrequenz"));
		
		JSONArray mSecStos = new JSONArray(request.get("mSecStos"));
		JSONArray mVer = new JSONArray(request.get("mVer"));
		JSONArray mLvs = new JSONArray(request.get("mLvs"));
		JSONArray mUebungen = new JSONArray(request.get("mUebungen"));
		
		// Neues Modul in DB eintragen
		db().getTransaction().begin();
		ModulEntity modul = new ModulEntity();
		modul.setName(mName);
		modul.setMNummer(mNummer);
		modul.setMk_id(1);
		modul.setSp_id(1);
		modul.setM_typ(mArtId);
		db().persist(modul);
		db().getTransaction().commit();
		long mId = modul.getId();
		
		StudienordnungEntity sto = db().createNamedQuery(
				StudienordnungEntity.CURRENT_STO_BY_INSTITUTE_STA,
				StudienordnungEntity.class)
				.setParameter("iId", miId)
				.setParameter("staId", mStaId)
				.getSingleResult();
		
		if(sto != null){
			//System.out.println("studienordnung " + sto.getId());
			db().getTransaction().begin();
			StoModulEntity stoModul = new StoModulEntity();
			stoModul.setEcts(mEcts);
			stoModul.setFrequency(mFrequenz);
			stoModul.setM_id(mId);
			stoModul.setSto_id(sto.getId());
			db().persist(stoModul);
			db().getTransaction().commit();
			
			long stoId = sto.getId();
			
			for(int i = 0; i < mSecStos.length(); i++){
				long secSto = mSecStos.getLong(i);
				if(secSto != stoId){
					db().getTransaction().begin();
					SekStoEntity sekSto = new SekStoEntity();
					sekSto.setM_id(mId);
					sekSto.setSto_id(secSto);
					db().persist(sekSto);
					db().getTransaction().commit();
				}
			}
			
			for(int i = 0; i < mVer.length(); i++){
				long lId = mVer.getLong(i);
				db().getTransaction().begin();
				ModulVerantwortlicheEntity verantwortlicher = new ModulVerantwortlicheEntity();
				verantwortlicher.setM_id(mId);
				verantwortlicher.setL_id(lId);
				db().persist(verantwortlicher);
				db().getTransaction().commit();
			}
			
			for(int i = 0; i < mLvs.length(); i++){
				JSONArray lv = mLvs.getJSONArray(i);
				if(lv.length() == 4){
					long lvtId = lv.getLong(0);
					String lvtSws = lv.getString(1);
					boolean lvtPflicht = lv.getBoolean(2);
					
					db().getTransaction().begin();
					ModulLvsEntity modulLv = new ModulLvsEntity();
					modulLv.setSws(lvtSws);
					modulLv.setM_id(mId);					
					modulLv.setLvt_id(lvtId);
					modulLv.setAnwesenheitspflicht(lvtPflicht);
					db().persist(modulLv);
					db().getTransaction().commit();
					
					if(lvtId == 1){
						String uSws = lv.getString(3);
						if(uSws != "nn"){
							db().getTransaction().begin();
							ModulLvsEntity uebungLv = new ModulLvsEntity();
							uebungLv.setSws(uSws);
							uebungLv.setAnwesenheitspflicht(true);
							uebungLv.setPrimary(modulLv.getId());
							uebungLv.setM_id(mId);
							uebungLv.setLvt_id(2);
							db().persist(uebungLv);
							db().getTransaction().commit();
						}
					}
				}
			}
			
			for(int i = 0; i < mUebungen.length(); i++){
				JSONArray uebung = mUebungen.getJSONArray(i);
				if(uebung.length() == 3){
					long lvtId = uebung.getLong(0);
					String uSws = uebung.getString(1);
					boolean uPflicht = uebung.getBoolean(2);
					
					ModulLvsEntity primaryModLv = db().createNamedQuery(
							ModulLvsEntity.GET_PRIMARY_MODULLV,
							ModulLvsEntity.class)
							.setParameter("mId", mId)
							.setParameter("lvtId", lvtId)
							.getSingleResult();
					if(primaryModLv != null){
						db().getTransaction().begin();
						ModulLvsEntity modulLv = new ModulLvsEntity();
						modulLv.setSws(uSws);
						modulLv.setM_id(mId);					
						modulLv.setLvt_id(2);
						modulLv.setAnwesenheitspflicht(uPflicht);
						modulLv.setPrimary(primaryModLv.getId());
						db().persist(modulLv);
						db().getTransaction().commit();
					}
				}
			/*	
				
				System.out.println("Primary lvt "+uebungLvt);
				*/
				
			}
		}
		
		
		
		return new JsonObject().put("success", "here");
	}

	private JsonObject getModuleInfos(ScuttleRequest request) throws JSONException {
		JsonObject ret = new JsonObject();
		
		JsonArray semesterListJson = new JsonArray();
		List<SemesterEntity> semesterList = db().findAll(SemesterEntity.class);
		for(SemesterEntity semester : semesterList){
			String sName = semester.getTyp() == 0 ? "WS "
					+ (Integer.parseInt(semester.getJahr().substring(2,4))-1) + "/"
					+ semester.getJahr().substring(2,4)
					: "SS " + semester.getJahr().substring(2,4);
					
			JsonObject semesterJson = new JsonObject()
			.put("sId", semester.getId())
			.put("sTyp", semester.getTyp())
			.put("sJahr", semester.getJahr())
			.put("sName", sName);
			
			semesterListJson.put(semesterJson);
			
			// Abbruchbedingung --> TO-DO: Funktion die immer das aktuelle Semester liefert
			// abbruchbedingunge ist dann aktuelles + 4
			if(semester.getId() == 8)
				break;
		}
		if(!semesterListJson.isEmpty())
			ret.put("sem", semesterListJson);
		
		
		List<StudienartEntity> staList = db().findAll(StudienartEntity.class);
		List<FachbereichEntity> fbList = db().findAll(FachbereichEntity.class);
		
		JsonArray fbListJson = new JsonArray();
		
		for(FachbereichEntity fb : fbList){
			JsonObject fbJson = new JsonObject()
			.put("fbId", fb.getId())
			.put("fbName", fb.getName())
			.put("fbKuerzel",fb.getKuerzel());
			
			// Institute des Fachbereichs
			List<InstitutEntity> institutList = fb.getInstitute();
			JsonArray institutListJson = new JsonArray();
			
			for(InstitutEntity institut : institutList){
				JsonObject institutJson = new JsonObject()
				.put("iId", institut.getId())
				.put("iName", institut.getName())
				.put("iKuerzel", institut.getKuerzel());
				
				// Stas des Institut
				JsonArray staListJson = new JsonArray();
				for(StudienartEntity sta : staList){
					long iId = institut.getId();
					long staId = sta.getId();
					
					StudienordnungEntity sto = db().createNamedQuery(
							StudienordnungEntity.CURRENT_STO_BY_INSTITUTE_STA,
							StudienordnungEntity.class)
							.setParameter("iId", iId)
							.setParameter("staId", staId)
							.getSingleResult();
					if(sto != null){
						//System.out.println("Found "+sto.getId()+" inst "+ iId);
						
						JsonObject staJson = new JsonObject()
						.put("stoId", sto.getId())
						.put("stoName", sto.getName())
						.put("stoJahr", sto.getJahr())
						.put("staId", sta.getId())
						.put("staName", sta.getName());
						
											
						
						JsonArray sListJson = new JsonArray();
						for(SemesterEntity semester : semesterList){
							JsonObject semesterJson = new JsonObject()
							.put("sId", semester.getId())
							.put("sJahr", semester.getJahr())
							.put("sTyp", semester.getTyp());
							
							//System.out.println("Beginne Semester "+semester.getId());
							
							long freq1 = 1, freq2 = 3;
							if(semester.getTyp() == 1){
								freq1++;
								freq2++;
							}						
							
							List<StoModulEntity> regStoModulList = db().createNamedQuery(
									StoModulEntity.REGULARY_STO_MODULES,
									StoModulEntity.class)
									.setParameter("stoId", sto.getId())
									.setParameter("freq1", freq1)
									.setParameter("freq2", freq2)
									.getResultList();
							
							List<StoModulEntity> nonRegStoModulList = db().createNamedQuery(
									StoModulEntity.NOT_REGULARY_STO_MODULES,
									StoModulEntity.class)
									.setParameter("stoId", sto.getId())
									.setParameter("freq1", freq1)
									.setParameter("freq2", freq2)
									.getResultList();
							
							JsonArray modulListJson = new JsonArray();
							
							for(StoModulEntity stoModul : regStoModulList){
								//System.out.println("Durchlaufe regSto");
								ModulEntity modul = stoModul.getModul();
								JsonObject modulJson = new JsonObject()
								.put("mId", modul.getId())
								.put("mName", modul.getName())
								.put("mNummer", modul.getMNummer())
								.put("mArt", modul.getTypName())
								.put("mEcts", stoModul.getEcts())
								.put("mTyp", modul.getM_typ())
								.put("mFrequenz", stoModul.getFrequenz());
								
								
								
								List<ModulHuelsenEntity> huelsenListe = modul.getModulHuelsen();
								JsonArray huelsenListeJson = new JsonArray();
								if(huelsenListe != null){
									for(ModulHuelsenEntity mhuelse : huelsenListe){
										HuelsenEntity huelse = mhuelse.getHuelse();
										JsonObject huelseJson = new JsonObject()
										.put("hId",huelse.getId())
										.put("hKuerzel",huelse.getKuerzel());
										
										huelsenListeJson.put(huelseJson);
									}
								}
								if(!huelsenListeJson.isEmpty())
									modulJson.put("huelsen", huelsenListeJson);
								
								List<ModulLvsEntity> modulLvList = db().createNamedQuery(
										ModulLvsEntity.GET_MODULES,
										ModulLvsEntity.class)
										.setParameter("mId", modul.getId())
										.getResultList();
								if(modul.getId() == 149){
									System.out.println(modul.getName());
									System.out.println("Laenge "+modulLvList.size());
								}
								
								JsonArray modulLvListJson = new JsonArray();
								for(ModulLvsEntity modulLv : modulLvList){
									List<LehrveranstaltungEntity> lvList = db().createNamedQuery(
											LehrveranstaltungEntity.GET_LV_BY_MODUL_LVT,
											LehrveranstaltungEntity.class)
											.setParameter("mId", modul.getId())
											.setParameter("lvtId", modulLv.getLvt_id())
											.getResultList();
									
									JsonArray lvListJson = new JsonArray();
									for(LehrveranstaltungEntity lv : lvList){
										String lNummer = lv.getNummer();
										String lTyp = lv.getLvTyp().getName();
										String lSws = lv.getSws();
										
										JsonObject lvJson = new JsonObject()
										.put("lvId", lv.getId())
										.put("lvName", lv.getName())
										.put("lvInhalt", lv.getInhalt())
										.put("lvLiteratur", lv.getLiteratur())
										.put("lvVoraussetzung", lv.getVoraussetzung());
										
										
										UebungEntity uebung = lv.getUebung();
										if(uebung != null ){
											lvJson
											.put("lvUebung", true)
											.put("lvUebungSws", uebung.getSws());
											lNummer += " + " + uebung.getLvnummer();
											lTyp += " + Übung";
											lSws += " + " + uebung.getSws();
										}
										lvJson
										.put("lvNummer", lNummer)
										.put("lvTyp", lTyp)
										.put("lvSws", lSws);
										
										List<PlanungEntity> semesterPlanungsListe = db().createNamedQuery(
												PlanungEntity.GET_PLANUNG_BY_SEMESTER,
												PlanungEntity.class)
												.setParameter("lvId", lv.getId())
												.setParameter("sId", semester.getId())
												.getResultList();
										
										JsonArray terminListeJson = new JsonArray();
										
										JsonArray dozentenListeJson = new JsonArray();
										List<Long> dozentenIdList = new ArrayList<Long>();
										
										for(PlanungEntity planung : semesterPlanungsListe){
											TerminEntity termin = planung.getTermin();
											RaumEntity raum = planung.getRaum();
											GebaeudeEntity gebaeude = raum.getGebaeude();
											
											JsonObject terminJson = new JsonObject()
											.put("pId", planung.getId())
											.put("tId", termin.getId())
											.put("tTag", termin.getTag())
											.put("tVon", termin.getVon())
											.put("tBis", termin.getBis())
											.put("rId", raum.getId())
											.put("rId", raum.getName())
											.put("rId", raum.getKuerzel())
											.put("gId", gebaeude.getId())
											.put("gName", gebaeude.getName())
											.put("gKuerzel", gebaeude.getKuerzel())
											.put("gStrasse", gebaeude.getStrasse())
											.put("gStrassenNr", gebaeude.getStrassenNr());
											
											
											if(termin.getTag()=="Blockveranstaltung")
												terminJson
												.put("tStart", planung.getStartDatum())
												.put("tEnde", planung.getEndDatum());
											
											terminListeJson.put(terminJson);

											
											
											List<SemesterLecturerEntity> semLecturerList = planung.getSemesterLecturer();
											for(SemesterLecturerEntity semLecturer : semLecturerList){
												if(!dozentenIdList.contains(semLecturer.getL_id())){
													LecturerEntity lecturer = semLecturer.getLecturer();
													JsonObject lecturerJson = new JsonObject()
													.put("lId", lecturer.getId())
													.put("lVorname", lecturer.getVorname())
													.put("lNachname", lecturer.getNachname())
													.put("lZedat", lecturer.getZedat())
													.put("lEmail", lecturer.getEmail());
													dozentenIdList.add(lecturer.getId());
													dozentenListeJson.put(lecturerJson);
												}
											}
											
											if(!terminListeJson.isEmpty())
												lvJson.put("termine", terminListeJson);
											if(!dozentenListeJson.isEmpty())
												lvJson.put("dozenten", dozentenListeJson);
											
										}
										lvListJson.put(lvJson);											
									}
									
									if(!lvListJson.isEmpty()){
										JsonObject mLvJson = new JsonObject()
										.put("lvs", lvListJson);
										modulLvListJson.put(mLvJson);
									}

								}
								if(!modulLvListJson.isEmpty())
									modulJson.put("mlvs", modulLvListJson);
								modulListJson.put(modulJson);							
							}
							if(!modulListJson.isEmpty())
								semesterJson.put("module",modulListJson);							
							
							// Fuer alle nicht regelmaessigen Module
							JsonArray nonRegModulListJson = new JsonArray();
							for(StoModulEntity stoModul : nonRegStoModulList){
								//System.out.println("Durchlaufe regSto");
								ModulEntity modul = stoModul.getModul();
								JsonObject modulJson = new JsonObject()
								.put("mId", modul.getId())
								.put("mName", modul.getName())
								.put("mNummer", modul.getMNummer())
								.put("mArt", modul.getTypName())
								.put("mTyp", modul.getM_typ())
								.put("mEcts", stoModul.getEcts())
								.put("mFrequenz", stoModul.getFrequenz());;
								
								
								
								
								List<ModulLvsEntity> modulLvList = db().createNamedQuery(
										ModulLvsEntity.GET_MODULES,
										ModulLvsEntity.class)
										.setParameter("mId", modul.getId())
										.getResultList();
								JsonArray modulLvListJson = new JsonArray();
								for(ModulLvsEntity modulLv : modulLvList){
									List<LehrveranstaltungEntity> lvList = db().createNamedQuery(
											LehrveranstaltungEntity.GET_LV_BY_MODUL_LVT,
											LehrveranstaltungEntity.class)
											.setParameter("mId", modul.getId())
											.setParameter("lvtId", modulLv.getLvt_id())
											.getResultList();
									//System.out.println("Dazu gehoeren " + lvList.size() + " Lvs");
									JsonArray lvListJson = new JsonArray();
									for(LehrveranstaltungEntity lv : lvList){
										String lNummer = lv.getNummer();
										String lTyp = lv.getLvTyp().getName();
										String lSws = lv.getSws();
										
										JsonObject lvJson = new JsonObject()
										.put("lvId", lv.getId())
										.put("lvName", lv.getName())
										.put("lvInhalt", lv.getInhalt())
										.put("lvLiteratur", lv.getLiteratur())
										.put("lvVoraussetzung", lv.getVoraussetzung());
										
										
										UebungEntity uebung = lv.getUebung();
										if(uebung != null ){
											lNummer += " + " + uebung.getLvnummer();
											lTyp += " + Übung";
											lSws += " + " + uebung.getSws();
										}
										lvJson
										.put("lvNummer", lNummer)
										.put("lvTyp", lTyp)
										.put("lvSws", lSws);
										
										List<PlanungEntity> semesterPlanungsListe = db().createNamedQuery(
												PlanungEntity.GET_PLANUNG_BY_SEMESTER,
												PlanungEntity.class)
												.setParameter("lvId", lv.getId())
												.setParameter("sId", semester.getId())
												.getResultList();
										
										JsonArray terminListeJson = new JsonArray();
										
										JsonArray dozentenListeJson = new JsonArray();
										List<Long> dozentenIdList = new ArrayList<Long>();
										
										for(PlanungEntity planung : semesterPlanungsListe){
											TerminEntity termin = planung.getTermin();
											RaumEntity raum = planung.getRaum();
											GebaeudeEntity gebaeude = raum.getGebaeude();
											
											JsonObject terminJson = new JsonObject()
											.put("pId", planung.getId())
											.put("tId", termin.getId())
											.put("tTag", termin.getTag())
											.put("tVon", termin.getVon())
											.put("tBis", termin.getBis())
											.put("rId", raum.getId())
											.put("rId", raum.getName())
											.put("rId", raum.getKuerzel())
											.put("gId", gebaeude.getId())
											.put("gName", gebaeude.getName())
											.put("gKuerzel", gebaeude.getKuerzel())
											.put("gStrasse", gebaeude.getStrasse())
											.put("gStrassenNr", gebaeude.getStrassenNr());
											
											
											if(termin.getTag()=="Blockveranstaltung")
												terminJson
												.put("tStart", planung.getStartDatum())
												.put("tEnde", planung.getEndDatum());
											
											terminListeJson.put(terminJson);

											
											List<SemesterLecturerEntity> semLecturerList = planung.getSemesterLecturer();
											for(SemesterLecturerEntity semLecturer : semLecturerList){
												if(!dozentenIdList.contains(semLecturer.getL_id())){
													LecturerEntity lecturer = semLecturer.getLecturer();
													JsonObject lecturerJson = new JsonObject()
													.put("lId", lecturer.getId())
													.put("lVorname", lecturer.getVorname())
													.put("lNachname", lecturer.getNachname())
													.put("lZedat", lecturer.getZedat())
													.put("lEmail", lecturer.getEmail());
													dozentenIdList.add(lecturer.getId());
													dozentenListeJson.put(lecturerJson);
												}
											}
											
										}
										if(!terminListeJson.isEmpty())
											lvJson.put("termine", terminListeJson);
										if(!dozentenListeJson.isEmpty())
											lvJson.put("dozenten", dozentenListeJson);
												
										
										
										
										lvListJson.put(lvJson);
									}
									
									if(!lvListJson.isEmpty()){
										JsonObject mLvJson = new JsonObject()
										.put("lvs", lvListJson);
										modulLvListJson.put(mLvJson);
									}
								}
								if(!modulLvListJson.isEmpty())
									modulJson.put("mlvs", modulLvListJson);
								nonRegModulListJson.put(modulJson);							
							}
							if(!nonRegModulListJson.isEmpty())
								semesterJson.put("nRModule",nonRegModulListJson);
							
							sListJson.put(semesterJson);
							/*ENDE*/
							
						}
						if(!sListJson.isEmpty())
							staJson.put("semester", sListJson);
						staListJson.put(staJson);
					}
				}
				if(!staListJson.isEmpty())
					institutJson.put("sta", staListJson);
				institutListJson.put(institutJson);
			}
			if(!institutListJson.isEmpty())
				fbJson.put("institute", institutListJson);
			fbListJson.put(fbJson);
		}
		if(!fbListJson.isEmpty())
			ret.put("fachbereiche", fbListJson);
		//return new JsonObject().put("success", "here");
		return ret;
	}

	private JsonObject getCourseInfos(ScuttleRequest request) throws JSONException {
		JsonObject ret = new JsonObject();
		
		List<ModulEntity> mList = db().findAll(ModulEntity.class);
		JsonArray mListJson = new JsonArray();
		for(ModulEntity modul : mList){
			StoModulEntity current = modul.getCurrentStoModul();
			if(current != null){
				StudienordnungEntity sto = current.getSto();
				if(sto != null){
					InstitutEntity institut = sto.getInstitut();
					if(institut != null){
						
						JsonObject modulJson = new JsonObject()
						.put("mId", modul.getId())
						.put("mName", modul.getName())
						.put("mEcts", current.getEcts())
						.put("iId", institut.getId())
						.put("mTypName", modul.getTypName());
						
						List<ModulLvsEntity> modulLvList = modul.getModulLvs();
						JsonArray modulLvListJson = new JsonArray();
						for(ModulLvsEntity modulLv : modulLvList){
							if(modulLv.getLvt_id() != 2){
								LvTypEntity lvTyp = modulLv.getLvTyp();
								
								JsonObject modulLvJson = new JsonObject()
								.put("mlId", modulLv.getId())
								.put("mlSws", modulLv.getSws())
								.put("mlPflicht", modulLv.isAnwesenheitspflicht())
								.put("mlLvtId", lvTyp.getId())
								.put("mlLvtName", lvTyp.getName());
								
								ModulLvsEntity modulLvUebung = db().createNamedQuery(
										ModulLvsEntity.GET_TUTORIAL,
										ModulLvsEntity.class)
										.setParameter("mId", modul.getId())
										.setParameter("primaryId", modulLv.getId())
										.getSingleResult();
								if(modulLvUebung != null){
									modulLvJson.put("mUebung", true);
									modulLvJson.put("uSws", modulLvUebung.getSws());
									modulLvJson.put("uPflicht", modulLvUebung.isAnwesenheitspflicht());
									//System.out.println("Uebung zu ModulLV "+modulLv.getId()+" mit id "+modulLvUebung.getId()+" und "+modulLvUebung.getSws()+" SWS");
								}
										
								
								modulLvListJson.put(modulLvJson);
							}
						}
						if(!modulLvList.isEmpty())
							modulJson.put("mLvs", modulLvListJson);
						mListJson.put(modulJson);
					}
				}
			}
		}
		//ret.put("module", mListArray);		
		ret.put("module", mListJson);
		return ret;
	}

	private JsonObject saveLecturer(ScuttleRequest request) throws JSONException {
		String vname = request.get("vorname");
		String nname = request.get("nachname");
		String zedat = request.get("zedat");
		String email = request.get("email");
		Long lTyp = Long.parseLong(request.get("typ"));		
		if(zedat.length() != 0){
			Query q = db().createQuery("SELECT COUNT(l.zedat) FROM LecturerEntity l WHERE l.zedat LIKE '"+zedat+"'");
			long count = (long)q.getSingleResult();
		
			if(count != 0){
				return new JsonObject().put("lExists", true);
			}
		}
		
		db().getTransaction().begin();
		LecturerEntity l = new LecturerEntity();
		l.setVorname(vname);
		l.setNachname(nname);
		l.setEmail(email);
		l.setZedat(zedat);
		l.setLt_id(lTyp);
		db().getTransaction().commit();
		db().persist(l);
		
		return new JsonObject().put("success", true);
	}

	private JsonObject createUser(ScuttleRequest request) {
		String uname = request.get("uname");
		String pwd = request.get("pwd");
		
		db().getTransaction().begin();
		UsersEntity user = new UsersEntity();
		user.setUname(uname);
		user.setPwd(pwd);
		db().getTransaction().commit();
		db().persist(user);
		
		db().evictAll();
    	db().getEntityManagerFactory().getCache().evictAll();
    	System.gc();
    	redo();
		
		request.getSession().put("username", uname);
		
		return new JsonObject().put("loginSuccess", "successfull");
	}

	private JsonObject login(ScuttleRequest request) throws JSONException {
		String uname = request.get("username");
		String upwd = request.get("pwd");
		JsonObject ret = new JsonObject();
		
		TypedQuery<UsersEntity> q = db().createQuery("SELECT u FROM UsersEntity u WHERE u.uname LIKE '"+uname+"'", UsersEntity.class);
		List<UsersEntity> uL = q.getResultList();
		if(!uL.isEmpty()){
			for(UsersEntity u: uL){
				if(u.checkPwd(upwd)){
					request.getSession().put("username", uname);
					ret.put("pwd", true)
					.put("loginname", request.getSession().get("username"));
				}else
					ret.put("pwd", false);
			}			
		}else{
			List<LecturerEntity> lec = db().createNamedQuery(
					LecturerEntity.GET_LEC_BY_ACC,
					LecturerEntity.class)
					.setParameter("acc", uname)
					.getResultList();
			//List<LecturerEntity> lList = q1.getResultList();
			if(lec.isEmpty())
				ret.put("wrongUser", true);
			else{
				request.getSession().put("firstlogin", uname);
				ret.put("wrongUser", false);
			}
		}
		return ret.put("logged", request.getSession().get("username") != null);
	}

	/*private JsonObject updateSchedule(ScuttleRequest request) throws JSONException {
		JSONArray loescheP = new JSONArray(request.get("removeP"));
		JSONArray neueP = new JSONArray(request.get("newP"));
		//System.out.println(neueP.length());
		
		// Eintragen der Haupttermine
		for(int i=0; i < loescheP.length();i++){
			JSONArray lP = loescheP.getJSONArray(i);
			String lvId = (String) lP.get(0);
			String sId = (String) lP.get(1);
			String lId = (String) lP.get(2);
			
			Query q = db().createQuery("SELECT p FROM PlanungEntity p WHERE p.lv_id = "+lvId+" AND p.s_id = "+sId);
			List<PlanungEntity> planungList = q.getResultList();
			for(PlanungEntity p : planungList){
				db().getTransaction().begin();
				int del = db().createQuery("DELETE FROM SemesterLecturerEntity sl WHERE sl.p_id = "+p.getId()+" AND sl.l_id = "+lId).executeUpdate();
				db().getTransaction().commit();
			}
			
		}
		
		
		// Eintragen der Haupttermine
		for(int i=0; i < neueP.length();i++){
			JSONArray nP = neueP.getJSONArray(i);
			String lvId = (String) nP.get(0);
			String sId = (String) nP.get(1);
			String lId = (String) nP.get(2);
			
			Query q = db().createQuery("SELECT p FROM PlanungEntity p WHERE p.lv_id = "+lvId+" AND p.s_id = "+sId);
			List<PlanungEntity> planung = q.getResultList();
			long pId;
			if(planung.size() == 0){
				db().getTransaction().begin();
				PlanungEntity neuePlanung = new PlanungEntity();
				neuePlanung.setLv_id(Long.parseLong(lvId));
				neuePlanung.setS_id(Long.parseLong(sId));
				neuePlanung.setT_id(999);
				neuePlanung.setR_id(999);
				db().getTransaction().commit();
				db().persist(neuePlanung);
				planung.add(neuePlanung);
			}
			
			for(PlanungEntity p : planung){
				db().getTransaction().begin();
				SemesterLecturerEntity semLec = new SemesterLecturerEntity();
				semLec.setL_id(Long.parseLong(lId));
				semLec.setP_id(p.getId());
				db().getTransaction().commit();
				db().persist(semLec);
			}
			//System.out.println("Lv "+lvId+" bereits in Planung "+planung.size());
		}
		return new JsonObject().put("success", "true");
	}
*/
	/**
	 * 
	 * @param iId,	Institut fuer welches die Langfrisplanung gezeigt wird
	 * @param sId, das Semester ab welchem die Daten angezeigt werden
	 * @return
	 * @throws JSONException 
	 */
	private JsonObject getLangfristplanung(String iId, String sId) throws JSONException {
		JsonObject ret = new JsonObject();
		
		List<LecturerEntity> lecList = db().findAll(LecturerEntity.class);
		JsonArray lecListJson = new JsonArray();
		for(LecturerEntity lecturer: lecList){
			JsonObject lecturerJson = new JsonObject()
			.put("lId", lecturer.getId())
			.put("lVorname", lecturer.getVorname())
			.put("lNachname", lecturer.getNachname())
			.put("lEmail", lecturer.getEmail())
			.put("lZedat", lecturer.getZedat())
			.put("lInitiale", lecturer.getVorname().substring(0, 1));
			
			lecListJson.put(lecturerJson);
		}
		ret.put("allLecturer", lecListJson);
		
		//System.out.println("Hole Institut "+iId);
		InstitutEntity institut = db().find(InstitutEntity.class,Long.parseLong(iId));
		//System.out.println("Nach Institut");
		Long semId = Long.parseLong(sId);
		
		//Query q = db().createQuery("SELECT s FROM SemesterEntity s WHERE s.id BETWEEN "+semId+" AND " + (semId+4));
		List<SemesterEntity> semesterList = db().createNamedQuery(SemesterEntity.GET_SEMESTER_BETWEEN,
				SemesterEntity.class)
				.setParameter("sId", semId)
				.setParameter("sId2", (semId+4))
				.getResultList();
				//q.getResultList();
		JsonArray semesterArray = new JsonArray();
		for(SemesterEntity semester : semesterList){
			JsonObject semesterJson = new JsonObject()
			.put("sId", semester.getId())
			.put("sName", semester.getName())
			.put("sTyp", semester.getTyp());
			
			semesterArray.put(semesterJson);
		}
		if(!semesterArray.isEmpty())
			ret.put("semester", semesterArray);		
		
		List<StudienordnungEntity> stoList = institut.getCurrentSto();	
		
		if(!stoList.isEmpty()){
			
			JsonArray stoListJson = new JsonArray();
			for(StudienordnungEntity sto: stoList){
				StudienartEntity sta = sto.getSta();
				JsonObject stoJson = new JsonObject()
				.put("stoId", sto.getI_id())
				.put("staId", sta.getId())
				.put("staName", sta.getName());
				
				
				List<StoModulEntity> stoModulList  = sto.getStoModule();
				JsonArray modulListJson = new JsonArray();
				for(StoModulEntity stoModul : stoModulList){
					ModulEntity modul = stoModul.getModul();
					JsonObject modulJson = new JsonObject()
					.put("mId", modul.getId())
					.put("mName", modul.getName())
					.put("mFrequenz", stoModul.getFrequency());
					
					List<LehrveranstaltungEntity> lvList = modul.getLvs();
					JsonArray lvListJson = new JsonArray();
					for(LehrveranstaltungEntity lv : lvList){
						JsonObject lvJson = new JsonObject()
						.put("lvId", lv.getId())
						.put("lvTyp",lv.getLvTyp().getName())
						.put("lvName", lv.getName());
						
						//modulJson.put("lvName", lv.getName());

						if(!semesterList.isEmpty()){
							JsonArray semesterListJson = new JsonArray();
							for(SemesterEntity semester : semesterList){
															
								JsonObject semesterJson = new JsonObject()
								.put("sId", semester.getId())								
								.put("sName", semester.getName())
								.put("sTyp", semester.getTyp());
								//semesterListJson.put(semesterJson);
								
								/*Query ql = db().createQuery("SELECT l FROM LecturerEntity l WHERE l.id IN ("
										+ " SELECT sl.l_id FROM SemesterLecturerEntity sl WHERE sl.p_id IN("
										+ " SELECT p.id FROM PlanungEntity p WHERE p.s_id = "+semester.getId()+" AND p.lv_id ="+lv.getId()+"))");*/
								
								List<LecturerEntity> lecturerList = db().createNamedQuery(
										LecturerEntity.GET_LEC_BY_LV_AND_SEM,
										LecturerEntity.class)
										.setParameter("sId", semester.getId())
										.setParameter("lvId", lv.getId())
										.getResultList();
								
								JsonArray lecturerListJson = new JsonArray();
								for(LecturerEntity lecturer : lecturerList){
									JsonObject lecturerJson = new JsonObject()
									.put("lId", lecturer.getId())
									.put("lVorname", lecturer.getVorname())
									.put("lNachname", lecturer.getNachname())
									.put("lEmail", lecturer.getEmail())
									.put("lInitiale", lecturer.getVorname().substring(0, 1));
									lecturerListJson.put(lecturerJson);
								}
								if(!lecturerListJson.isEmpty())
									semesterJson.put("lecturer", lecturerListJson);
								
								/*List<PlanungEntity> planungList = lv.getPlanungBySemester(semester.getId());
								JsonArray planListJson = new JsonArray();
								if(!planungList.isEmpty()){
									for(PlanungEntity plan : planListJson){
										JsonObject planJson = new JsonObject();
									}
								}*/
								semesterListJson.put(semesterJson);
								
							}
							if(!semesterListJson.isEmpty())
								lvJson.put("semester", semesterListJson);
						}
						lvListJson.put(lvJson);
					}
					if(!lvListJson.isEmpty())
						modulJson.put("lvs",lvListJson);
					modulListJson.put(modulJson);
				}

				if(!modulListJson.isEmpty())
					stoJson.put("module", modulListJson);
				
				stoListJson.put(stoJson);
				
			}
			if(!stoListJson.isEmpty())
				ret.put("stos", stoListJson);
		}
		
		return ret;
	}

	private JsonObject updateModule(ScuttleRequest request) throws JSONException {
		Long mid = Long.parseLong(request.get("mId"));
		Long sid = Long.parseLong(request.get("sId"));
		String mInhalt = request.get("inhalt");
		String mLit = request.get("literatur");
		String mInfo = request.get("info");
		JSONArray loescheLvs = new JSONArray(request.get("loescheLvs"));
		JSONArray neueLvs = new JSONArray(request.get("neueLvs"));
		JSONArray neueTuts = new JSONArray(request.get("neueTutorien"));
		
		if(loescheLvs.length() > 0){
			for(int i=0; i < loescheLvs.length();i++){
				String pId = (String) loescheLvs.get(i);
				PlanungEntity plan = db().find(PlanungEntity.class, Long.parseLong(pId));
				if(plan != null){
					db().getTransaction().begin();
			//		System.out.println("Loesche lv mit pid "+pId);
					db().remove(plan);
					db().getTransaction().commit();
				}
			}
		}
		
		// Update modul
		ModulEntity modul = db().find(ModulEntity.class, mid);
		if(modul != null){
			db().getTransaction().begin();
			if(!mInhalt.equals("false"))
				modul.setInhalt(mInhalt);
				//System.out.println("update inhalt");
				
			if(!mLit.equals("false"))
				modul.setLiteratur(mLit);
				//System.out.println("update lit");
				
			if(!mInfo.equals("false"))
				modul.setVoraussetzung(mInfo);
				//System.out.println("update info");
				
			db().getTransaction().commit();
		}
		
		// Eintragen der Haupttermine
		for(int i=0; i < neueLvs.length();i++){
			JSONArray nLv = neueLvs.getJSONArray(i);
			String lvId = (String) nLv.get(0);
			String tId = (String) nLv.get(1);
			String rId = (String) nLv.get(2);

			db().getTransaction().begin();
			PlanungEntity lvPlan = new PlanungEntity();
			lvPlan.setLv_id(Long.parseLong(lvId));
			lvPlan.setT_id(Long.parseLong(tId));
			lvPlan.setR_id(Long.parseLong(rId));
			lvPlan.setS_id(sid);
			
			db().getTransaction().commit();
			db().persist(lvPlan);
			long pId = lvPlan.getId();
			
		//	System.out.println("New Plan id "+pId);
			JSONArray lecturer = nLv.getJSONArray(3);
			for(int j = 0; j <lecturer.length();j++){
				String lId = (String) lecturer.get(j);
				db().getTransaction().begin();
				SemesterLecturerEntity semLec = new SemesterLecturerEntity();
				semLec.setP_id(pId);
				semLec.setL_id(Long.parseLong(lId));
				db().getTransaction().commit();
				db().persist(semLec);
				//System.out.println("Added lecturer "+lId+" to paln "+pId);
			}
			
		}
		
		// Eintragen der Begleittermine
		for(int i = 0; i < neueTuts.length();i++){
			JSONArray nTut = neueTuts.getJSONArray(i);
			String lvId = (String) nTut.get(0);
			String tId = (String) nTut.get(1);
			String rId = (String) nTut.get(2);
			String lId = (String) nTut.get(3);
			
			db().getTransaction().begin();
			PlanungEntity tutPlan = new PlanungEntity();
			tutPlan.setLv_id(Long.parseLong(lvId));
			tutPlan.setT_id(Long.parseLong(tId));
			tutPlan.setR_id(Long.parseLong(rId));
			tutPlan.setS_id(sid);
			db().getTransaction().commit();
			db().persist(tutPlan);
			
			long pId = tutPlan.getId();
			// Speichern des Tutors in SemesterLecturer
			db().getTransaction().begin();
			SemesterLecturerEntity semTut = new SemesterLecturerEntity();
			semTut.setP_id(pId);
			semTut.setL_id(Long.parseLong(lId));
			db().getTransaction().commit();
			db().persist(semTut);
			
		}
		
		return new JsonObject().put("success", "true");
	}

	private JsonObject editModule(String mId, String semId)
			throws JSONException {
		//System.out.println("Modul " + mId + " Semester " + semId);
		JsonObject ret = new JsonObject();
		// Hole das Modul zu der uebergebenen mId aus der DB
		ModulEntity modul = db()
				.find(ModulEntity.class, Long.parseLong(mId));
		StoModulEntity stoMod = modul.getCurrentStoModul();

		SemesterEntity semester = db().find(SemesterEntity.class,
				Long.parseLong(semId));
		
		String semName = semester.getTyp() == 0 ? "WS "
				+ (Integer.parseInt(semester.getJahr().substring(2, 4)) - 1) + "/"
				+ semester.getJahr().substring(2, 4)
				: "SS " + semester.getJahr().substring(2, 4);
		String lvNummern = "";
		String lvSws = "";

		List<Long> lecIdList = new ArrayList<Long>();

		ret.put("mId", modul.getId()).put("mName", modul.getName())
				.put("mInhalt", modul.getInhalt())
				.put("mZiel", modul.getZiel())
				.put("mLiteratur", modul.getLiteratur())
				.put("mInformation", modul.getVoraussetzung())
				.put("mFrequenz", stoMod.getFrequency())
				.put("mEcts", stoMod.getEcts())
				.put("mLvNummer", modul.getMNummer())
				.put("mSprache", modul.getSprache().getName())
				.put("sId", semester.getId()).put("sName", semName)
				.put("sTyp", semester.getTyp())
				.put("sJahr", semester.getJahr());

		// Hole alle veranstaltungen, die Liste beinhaltet alle
		// Hauptveranstaltungen
		// und tut die Uebung
		List<LehrveranstaltungEntity> alleLvs = modul.getVeranstaltungen();
		List<LehrveranstaltungEntity> lvList = modul.getLvs();
		LehrveranstaltungEntity tut = modul.getTutorium();
		if(tut != null)
			ret.put("tutId", tut.getId());
		
		JsonArray lvTypenJson = new JsonArray();
		for (LehrveranstaltungEntity lv : alleLvs) {
			if (lvNummern != "")
				lvNummern += " + ";
			lvNummern += lv.getNummer();

			if (lvSws != "")
				lvSws += " + ";
			lvSws += lv.getSws();
		}
		
		ret.put("mLvNummer", lvNummern).put("mLvSws", lvSws);

		if (tut != null) {
			List<PlanungEntity> tutPlanungList = tut.getPlanung();
			JsonArray tutListJson = new JsonArray();
			for (PlanungEntity tutPlanung : tutPlanungList) {
				if(tutPlanung.getS_id() == Long.parseLong(semId)){
					RaumEntity raum = tutPlanung.getRaum();
					TerminEntity termin = tutPlanung.getTermin();
					GebaeudeEntity gebaeude = raum.getGebaeude();
	
					JsonObject tutPlanungJson = new JsonObject()
							.put("pId", tutPlanung.getId())
							.put("rId", raum.getId()).put("rName", raum.getName())
							.put("rKuerzel", raum.getKuerzel())
							.put("gId", gebaeude.getId())
							.put("gName", gebaeude.getName())
							.put("gKuerzel", gebaeude.getKuerzel())
							.put("gStr", gebaeude.getStrasse())
							.put("gStrNr", gebaeude.getStrassenNr())
							.put("tId", termin.getId())
							.put("tTag", termin.getTag())
							.put("tVon", termin.getVon())
							.put("tBis", termin.getBis());
	
					List<SemesterLecturerEntity> semLecList = tutPlanung
							.getSemesterLecturer();
					JsonArray semLecListJson = new JsonArray();
					for (SemesterLecturerEntity semLec : semLecList) {
						LecturerEntity lec = semLec.getLecturer();
						JsonObject lecJson = new JsonObject()
								.put("lId", lec.getId())
								.put("lVorname", lec.getVorname())
								.put("lNachname", lec.getNachname())
								.put("lZedat", lec.getZedat())
								.put("lEmail", lec.getEmail());
	
						semLecListJson.put(lecJson);
					}
					
					if (!semLecListJson.isEmpty())
						tutPlanungJson.put("tutoren", semLecListJson);
	
					tutListJson.put(tutPlanungJson);
				}
			}
			if (!tutListJson.isEmpty())
				ret.put("tutorien", tutListJson);
		}

		JsonArray lecturerListJson = new JsonArray();
		// List<Long> lecIdList = new ArrayList<Long>();
		/*
		 * Alle Hauptveranstaltungen
		 */
		if (lvList.size() > 0) {
			for (LehrveranstaltungEntity lv : lvList) {
				List<PlanungEntity> lvPlanungList = lv.getPlanung();

				LvTypEntity lvt = lv.getLvTyp();
				JsonObject lvTypJson = new JsonObject()
					.put("lvId", lv.getId())
					.put("lvtId", lvt.getId())
					.put("lvtName", lvt.getName());
				lvTypenJson.put(lvTypJson);

				JsonArray lvListJson = new JsonArray();
				for (PlanungEntity lvPlanung : lvPlanungList) {
					if(lvPlanung.getS_id() == Long.parseLong(semId)){
						RaumEntity raum = lvPlanung.getRaum();
						TerminEntity termin = lvPlanung.getTermin();
						GebaeudeEntity gebaeude = raum.getGebaeude();
	
						JsonObject lvPlanungJson = new JsonObject()
								.put("pId", lvPlanung.getId())
								.put("rId", raum.getId())
								.put("rName", raum.getName())
								.put("rKuerzel", raum.getKuerzel())
								.put("gId", gebaeude.getId())
								.put("gName", gebaeude.getName())
								.put("gKuerzel", gebaeude.getKuerzel())
								.put("gStr", gebaeude.getStrasse())
								.put("gStrNr", gebaeude.getStrassenNr())
								.put("tId", termin.getId())
								.put("tTag", termin.getTag())
								.put("tVon", termin.getVon())
								.put("tBis", termin.getBis());
	
						List<SemesterLecturerEntity> semLecList = lvPlanung
								.getSemesterLecturer();
						JsonArray semLecListJson = new JsonArray();
						for (SemesterLecturerEntity semLec : semLecList) {
							LecturerEntity lec = semLec.getLecturer();
							JsonObject lecJson = new JsonObject()
									.put("lId", lec.getId())
									.put("lVorname", lec.getVorname())
									.put("lNachname", lec.getNachname())
									.put("lZedat", lec.getZedat())
									.put("lEmail", lec.getEmail());
	
							if (!lecIdList.contains(lec.getId())) {
								lecIdList.add(lec.getId());
								lecturerListJson.put(lecJson);
							}
	
							semLecListJson.put(lecJson);
						}
						if (!semLecListJson.isEmpty())
							lvPlanungJson.put("lecturer", semLecListJson);
	
						lvListJson.put(lvPlanungJson);
					}
				}
				if (!lvListJson.isEmpty())
					ret.put("lvs", lvListJson);

				if (!lvTypenJson.isEmpty())
					ret.put("lvts", lvTypenJson);
			}
		}
		if (!lecturerListJson.isEmpty())
			ret.put("lecturer", lecturerListJson);

		List<RaumEntity> raumListe = db().findAll(RaumEntity.class);
		JsonArray raumListeJson = new JsonArray();
		for (RaumEntity raum : raumListe) {
			GebaeudeEntity gebaeude = raum.getGebaeude();
			JsonObject raumJson = new JsonObject()
			.put("rId", raum.getId())
			.put("rKuerzel", raum.getKuerzel())
			.put("rName", raum.getName())
			.put("gId", gebaeude.getId())
			.put("gKuerzel", gebaeude.getKuerzel());

			raumListeJson.put(raumJson);
		}
		if (!raumListeJson.isEmpty())
			ret.put("raeume", raumListeJson);

		List<TerminEntity> terminListe = db().findAll(TerminEntity.class);
		JsonArray terminListeJson = new JsonArray();
		for (TerminEntity termin : terminListe) {
			JsonObject terminJson = new JsonObject().put("tId", termin.getId())
					.put("tTag", termin.getTag()).put("tVon", termin.getVon())
					.put("tBis", termin.getBis());

			terminListeJson.put(terminJson);
		}
		if (!terminListeJson.isEmpty())
			ret.put("termine", terminListeJson);

		List<LecturerEntity> tutorListe = db().findAll(LecturerEntity.class);
		JsonArray tutorListeJson = new JsonArray();
		for (LecturerEntity tutor : tutorListe) {
			JsonObject tutorJson = new JsonObject().put("lId", tutor.getId())
					.put("lVorname", tutor.getVorname())
					.put("lNachname", tutor.getNachname())
					.put("lZedat", tutor.getZedat())
					.put("lEmail", tutor.getEmail());

			tutorListeJson.put(tutorJson);
		}
		if (!tutorListeJson.isEmpty())
			ret.put("tutoren", tutorListeJson);

		return ret;
	}

	private JsonObject getModuleList() throws JSONException {
		JsonObject ret = new JsonObject();

		JsonArray semListJson = new JsonArray();
		List<SemesterEntity> semList = db().findAll(SemesterEntity.class);
		for (SemesterEntity sem : semList) {
			JsonObject semJson = new JsonObject().put("sId", sem.getId())
					.put("sTyp", sem.getTyp()).put("sJahr", sem.getJahr());
			String semName = sem.getTyp() == 0 ? "WS "
					+ (Integer.parseInt(sem.getJahr().substring(2, 4)) - 1) + "/"
					+ sem.getJahr().substring(2, 4)
					: "SS " + sem.getJahr().substring(2, 4);
			semJson.put("sName", semName);

			semListJson.put(semJson);
			if(sem.getId() == 8)
				break;
		}
		ret.put("sem", semListJson);

		/**
		 * Hole alle existierenden Studienarten diese werden dann beim holen der
		 * aktuellen Sto fuer jede Sta eines Instituts benoetigt
		 */
		List<StudienartEntity> staList = db()
				.findAll(StudienartEntity.class);

		List<FachbereichEntity> fachbereichList = db().findAll(
				FachbereichEntity.class);
		JsonArray fachbereichListJson = new JsonArray();
		for (FachbereichEntity fb : fachbereichList) {
			JsonObject fbJson = new JsonObject().put("fbId", fb.getId())
					.put("fbName", fb.getName())
					.put("fbKuerzel", fb.getKuerzel());

			/**
			 * Hole alle zum FB zugehoerigen Institute
			 */
			List<InstitutEntity> institutList = fb.getInstitute();
			JsonArray institutListJson = new JsonArray();
			for (InstitutEntity institut : institutList) {
				JsonObject institutJson = new JsonObject()
						.put("iId", institut.getId())
						.put("iName", institut.getName())
						.put("iKuerzel", institut.getKuerzel());

				JsonArray staListJson = new JsonArray();
				for (StudienartEntity sta : staList) {
					long iId = institut.getId();
					long staId = sta.getId();
					
					StudienordnungEntity sto = db().createNamedQuery(
							StudienordnungEntity.CURRENT_STO_BY_INSTITUTE_STA,
							StudienordnungEntity.class)
							.setParameter("iId", iId)
							.setParameter("staId", staId)
							.getSingleResult();

					// Wir holen uns zu jeder sta des Instituts die aktuelle STO
					/*Query qAktuelleSto = db().createQuery(
							"SELECT sto FROM StudienordnungEntity sto "
									+ "WHERE sto.i_id = " + iId
									+ " AND sto.sta_id = " + staId
									+ " AND sto.aktuell = 1");*/
					// qAktuelleSto.setParameter("iId", institut.getId());
					// qAktuelleSto.setParameter("staId", sta.getId());

					//sto = (StudienordnungEntity) qAktuelleSto.getSingleResult();
					if (sto != null) {
						JsonObject staJson = new JsonObject()
								.put("stoId", sto.getId())
								.put("stoName", sto.getName())
								.put("stoJahr", sto.getJahr())
								.put("staId", sta.getId())
								.put("staName", sta.getName());

						/**
						 * Holen aller Module einer STO
						 */
						List<SemesterEntity> semesterList = db().findAll(
								SemesterEntity.class);
						JsonArray semesterListJson = new JsonArray();
						for (SemesterEntity semester : semesterList) {
							JsonObject semesterJson = new JsonObject()
									.put("sId", semester.getId())
									.put("sTyp", semester.getTyp())
									.put("sJahr", semester.getJahr());

							
							
							List<StoModulEntity> stoModulList = sto
									.getStoModule();
							JsonArray modulListJson = new JsonArray();
							for (StoModulEntity stoModul : stoModulList) {
								long frequenz = stoModul.getFrequency();

								
								// Abfrage effizienter schoener machen und in
								// Fkt packen
								if (frequenz == 5
										|| (frequenz == 1 || frequenz == 3)
										&& semester.getTyp() == 0
										|| (frequenz == 2 || frequenz == 4)
										&& semester.getTyp() == 1) {

									String mLvNummer = "";
									String mLvArt = "";
									String mLvSws = "";

									ModulEntity modul = stoModul.getModul();

									List<Long> modulLecturerListJson = new ArrayList<Long>();

									List<LehrveranstaltungEntity> lvList = modul
											.getVeranstaltungen();
									JsonArray lvListJson = new JsonArray();
									for (LehrveranstaltungEntity lv : lvList) {
										LvTypEntity lvt = lv.getLvTyp();
										JsonObject lvJson = new JsonObject()
												.put("lvId", lv.getId())
												.put("lvName", lv.getName())
												.put("lvSws", lv.getSws())
												.put("lvNummer", lv.getNummer())
												.put("lvtId", lvt.getId())
												.put("lvtName", lvt.getName());
										
										/*if (mLvNummer != "") {
											mLvNummer += " + ";
											mLvSws += " + ";
											mLvArt += " + ";
										}*/
										//mLvNummer += lv.getNummer();
										//mLvSws += lv.getSws();
										//mLvArt += lvt.getName();
										
										// List<PlanungEntity> planungList;
										// Hole alle Termine dieser Lv in diesem
										// Semester
										List<PlanungEntity> planList = lv
												.getPlanung();
										JsonArray planListJson = new JsonArray();
										for (PlanungEntity plan : planList) {
											if (plan.getS_id() == semester
													.getId()) {
												/*LecturerEntity tLecturer = plan
														.getLecturer();*/
												TerminEntity tTermin = plan
														.getTermin();
												RaumEntity tRaum = plan
														.getRaum();
												GebaeudeEntity tGebaeude = tRaum
														.getGebaeude();

												JsonObject planJson = new JsonObject()
														.put("pId",
																plan.getId());

												// Falls kein Begleittermin hole
												// alle Daten
												// Uebungen werden getrennt
												// behandelt da es
												// Begleittermine sind
												//String lect = "";
												if (plan.getVeranstaltung()
														.getLvt_id() != 2) {

													List<SemesterLecturerEntity> semesterLecturerList = plan
															.getSemesterLecturer();
													JsonArray semesterLecturerListJson = new JsonArray();
													for (SemesterLecturerEntity semesterLecturer : semesterLecturerList) {
														if (!modulLecturerListJson
																.contains(semesterLecturer
																		.getL_id())) {
															LecturerEntity lec = semesterLecturer
																	.getLecturer();
															// Zusammenstellen
															// der Dozenteninfos
															JsonObject lecturerJson = new JsonObject()
																	.put("lId",
																			lec.getId())
																	.put("lVorname",
																			lec.getVorname())
																	.put("lNachname",
																			lec.getNachname())
																	.put("lEmail",
																			lec.getEmail())
																	.put("lZedat",
																			lec.getZedat());
															//if(lect=="")
																//lect = lec.getVorname()+" "+lec.getNachname();
															modulLecturerListJson
																	.add(lec.getId());
															semesterLecturerListJson
																	.put(lecturerJson);
														}
													}
													if (!semesterLecturerListJson
															.isEmpty())
														planJson.put(
																"semesterLecturer",
																semesterLecturerListJson);

													JsonObject terminJson = new JsonObject()
															.put("rId",
																	tRaum.getId())
															.put("rName",
																	tRaum.getName())
															.put("rKuerzel",
																	tRaum.getKuerzel())
															.put("gId",
																	tGebaeude
																			.getId())
															.put("gName",
																	tGebaeude
																			.getName())
															.put("gKuerzel",
																	tGebaeude
																			.getKuerzel())
															.put("gStrasse",
																	tGebaeude
																			.getStrasse())
															.put("gStrasseNr",
																	tGebaeude
																			.getStrassenNr())
															.put("tId",
																	tTermin.getId())
															.put("tTag",
																	tTermin.getTag())
															.put("tVon",
																	tTermin.getVon())
															.put("tBis",
																	tTermin.getBis());

													planJson.put("pTermin",
															terminJson);

													planListJson.put(planJson);
												}
											}
											if (!planListJson.isEmpty())
												lvJson.put("termine",
														planListJson);
										}

										lvListJson.put(lvJson);
									}
									// Zusammenstellen des JsonObjekts fuer alle
									// mModule die in diesem Semester
									// stattfinden
									JsonObject modulJson = new JsonObject()
											.put("mId", modul.getId())
											.put("mName", modul.getName())
											.put("mTyp", modul.getM_typ())
											.put("mLvNummer", mLvNummer)
											.put("mLvSws", mLvSws)
											.put("mLvArt", mLvArt)
											.put("mEcts", stoModul.getEcts())
											.put("mFrequenz",
													stoModul.getFrequency());
											//.put("mLec", lect);
									String mTypName = "Pflicht";
									switch ((int)modul.getM_typ()) {
									case 2:
										mTypName = "Regelmäßig";
										break;
									case 3:
										mTypName = "Einmalig";
										break;
									case 4:
										mTypName = "";
										break;
									}
									modulJson.put("mTypName", mTypName);
									
										
									

									// if(!modulLecturerListJson.isEmpty())
									// modulJson.put("mlecturer",
									// modulLecturerListJson);
									if (!lvListJson.isEmpty()) {
										modulJson.put("lvs", lvListJson);
									}
									modulListJson.put(modulJson);
								}
							}
							semesterJson.put("module", modulListJson);
							if (!modulListJson.isEmpty())
								semesterListJson.put(semesterJson);
						}

						staJson.put("semester", semesterListJson);
						if (!semesterListJson.isEmpty())
							staListJson.put(staJson);
					}
				}
				institutJson.put("sta", staListJson);
				if (!staListJson.isEmpty())
					institutListJson.put(institutJson);
			}
			fbJson.put("institute", institutListJson);
			if (!institutListJson.isEmpty())
				fachbereichListJson.put(fbJson);
		}
		ret.put("fachbereiche", fachbereichListJson);

		return ret;
	}

	private JsonObject insertModule(ScuttleRequest request)
			throws JSONException {
		String iId = request.get("iId");
		String mName = request.get("mName");
		String mkId = request.get("mkId");
		//String mkKuerzel = request.get("mkKuerzel");
		String mFrequenz = request.get("mFrequenz");
		String mEcts = request.get("mEcts");
		String spId = request.get("spId");
		String mInhalt = request.get("mInhalt");
		String mZiele = request.get("mZiele");
		String mLiteratur = request.get("mLiteratur");
		String mVoraussetzungen = request.get("mVoraussetzungen");
		String stoId = request.get("stoId");
		String mTyp = request.get("mTyp");
		
		JSONArray mVerantwortliche = new JSONArray(
				request.get("mVerantwortliche"));
		JSONArray mLvs = new JSONArray(request.get("mLvs"));
		// Lv Nummer
		InstitutEntity institut = db().find(InstitutEntity.class,
				Long.parseLong(iId));
		String lvNummer = institut.getFachbereich().getKuerzel()
				+ institut.getKuerzel();
	//	System.out.println("Lv Nummer fb + inst " + lvNummer);
		// Hole Counter fuer Institut
		Query counter = db().createQuery(
				"SELECT mc FROM ModulCounterEntity mc WHERE mc.i_id ="
						+ Long.parseLong(iId));
		ModulCounterEntity modulCounter = (ModulCounterEntity) counter
				.getSingleResult();

		long mCounter = modulCounter.getCounter();
		String parsedCounter = parseCounter(mCounter);
		lvNummer += parsedCounter; // Bis auf letzten beiden Ziffern wurde
									// eindeutige Nummer erstellt
		// System.out.println("Lange Lv "+lvNummer);

		// counter fuer gewaehltes institut muss erhoeht werden
		db().getTransaction().begin();
		modulCounter.setCounter(mCounter + 1);
		db().getTransaction().commit();

		// Erstelle neues Modul
		db().getTransaction().begin();
		ModulEntity modul = new ModulEntity();
		modul.setName(mName);
		modul.setInhalt(mInhalt);
		modul.setZiel(mZiele);
		modul.setLiteratur(mLiteratur);
		modul.setVoraussetzung(mVoraussetzungen);
		modul.setMk_id(Long.parseLong(mkId));
		modul.setSp_id(Long.parseLong(spId));
		modul.setMNummer(lvNummer);
		modul.setM_typ(Long.parseLong(mTyp));

		db().persist(modul);

		db().getTransaction().commit();
		// Hole Id des eben hinzugefuegten Moduls
		long mId = modul.getId();

		StoModulEntity stoModul = new StoModulEntity();
		db().getTransaction().begin();
		stoModul.setEcts(mEcts);
		stoModul.setFrequency(Long.parseLong(mFrequenz));
		stoModul.setM_id(mId);
		stoModul.setSto_id(Long.parseLong(stoId));
		db().persist(stoModul);
		db().getTransaction().commit();

		// Modulverantwortliche zuweisen
		db().getTransaction().begin();
		for (int i = 0; i < mVerantwortliche.length(); i++) {
			ModulVerantwortlicheEntity verantwortlicher = new ModulVerantwortlicheEntity();
			verantwortlicher.setM_id(mId);
			long lId = mVerantwortliche.getLong(i);
			// System.out.println("id von verantw " + lId);
			verantwortlicher.setL_id(lId);
			db().persist(verantwortlicher);
		}
		db().getTransaction().commit();

		// Hole Daten der Lvs
		JSONArray lvTypen = mLvs.getJSONArray(0);
		JSONArray lvSws = mLvs.getJSONArray(1);
		JSONArray lvAPflicht = mLvs.getJSONArray(2);

		db().getTransaction().begin();
		for (int i = 0; i < lvTypen.length(); i++) {
			LvTypEntity lvTyp = db().find(LvTypEntity.class,
					lvTypen.getLong(i));
			String lvNum = modul.getMNummer() + lvTyp.getKuerzel();
			String lvName = lvTyp.getName() + " : " + modul.getName();
			// System.out.println("TYP Kuerzel "+lvTyp.getKuerzel()+" Name "+lvTyp.getName());
			// System.out.println("TYP ID "+lvTypen.getLong(i));
			// System.out.println("TYP ID "+lvSws.getString(i));
			// System.out.println("TYP Pflicht "+lvAPflicht.getBoolean(i));
			LehrveranstaltungEntity lv = new LehrveranstaltungEntity();
			lv.setName(lvName);
			lv.setLvt_id(lvTypen.getLong(i));
			lv.setM_id(modul.getId());
			lv.setSws(lvSws.getString(i));
			lv.setAnwesenheitspflicht(lvAPflicht.getBoolean(i));
			lv.setNummer(lvNum);
			db().persist(lv);
		}
		db().getTransaction().commit();

		return new JsonObject().put("antwort", iId).put("lvLaenge",
				mLvs.length());
	}

	/**
	 * Holen aller Metainformationen die dem Template: newModule zur verfuegung
	 * gestellt werden um ein neues Modul anzulegen
	 * 
	 * @return ret - Json-Array mit allen benoetigten Meta-Informationen
	 * @throws JSONException
	 */
	private JsonObject getMetaInformation() throws JSONException {
		JsonObject ret = new JsonObject();
		/**
		 * Holen der Fachbereiche
		 */
		List<FachbereichEntity> fachbereiche = db().findAll(
				FachbereichEntity.class);
		JsonArray fachbereicheJson = new JsonArray();
		for (FachbereichEntity fb : fachbereiche) {
			JsonObject fbJson = new JsonObject().put("fbId", fb.getId())
					.put("fbName", fb.getName())
					.put("fbKuerzel", fb.getKuerzel());

			/**
			 * Hole Institute die zu FB gehoeren
			 */
			List<InstitutEntity> institute = fb.getInstitute();
			JsonArray instituteJson = new JsonArray();
			for (InstitutEntity institut : institute) {
				JsonObject institutJson = new JsonObject()
						.put("iId", institut.getId())
						.put("iName", institut.getName())
						.put("iKuerzel", institut.getKuerzel());

				instituteJson.put(institutJson);
			}
			fbJson.put("institute", instituteJson);
			// FB mit Institute wird entsprechenden JSON-Array hinzugefuegt
			fachbereicheJson.put(fbJson);
		}
		// FB-Array wird der Ergebnismenge hinzugefuegt
		ret.put("fachbereiche", fachbereicheJson);
		/**
		 * Hole alle Modul Kategorien und fuege sie der Ergebnismenge hinzu
		 */
		List<ModulKategorieEntity> kategorien = db().findAll(
				ModulKategorieEntity.class);
		JsonArray kategorienJson = new JsonArray();
		for (ModulKategorieEntity kategorie : kategorien) {
			JsonObject kategorieJson = new JsonObject()
					.put("mkId", kategorie.getId())
					.put("mkName", kategorie.getName())
					.put("mkKuerzel", kategorie.getKuerzel())
					.put("iId", kategorie.getI_id());

			kategorienJson.put(kategorieJson);
		}
		// Hinzufuegen der Modulkategorien zur Ergebnismenge
		ret.put("mkategorien", kategorienJson);

		/**
		 * Holen der verschiedenen Sprachen in der ein Modul gehalten werden
		 * kann
		 */
		List<SprachenEntity> sprachen = db().findAll(SprachenEntity.class);
		JsonArray sprachenJson = new JsonArray();
		for (SprachenEntity sprache : sprachen) {
			JsonObject spracheJson = new JsonObject()
					.put("spId", sprache.getId())
					.put("spName", sprache.getName())
					.put("spKuerzel", sprache.getKuerzel());

			sprachenJson.put(spracheJson);
		}
		// Hinz. der Sprachen zur Ergebnismenge
		ret.put("sprachen", sprachenJson);

		/**
		 * Holen der verschiedenen LV-Typen
		 */
		List<LvTypEntity> lvTypen = db().findAll(LvTypEntity.class);
		JsonArray lvTypenJson = new JsonArray();
		for (LvTypEntity lvTyp : lvTypen) {
			JsonObject lvTypJson = new JsonObject().put("lvtId", lvTyp.getId())
					.put("lvtName", lvTyp.getName())
					.put("lvtKuerzel", lvTyp.getKuerzel());

			lvTypenJson.put(lvTypJson);
		}
		// Hinz. der LvTypen zur Ergebnismenge
		ret.put("lvTypen", lvTypenJson);

		/**
		 * Holen aller Studienarten
		 */
		List<StudienartEntity> stArten = db()
				.findAll(StudienartEntity.class);
		JsonArray stArtenJson = new JsonArray();
		for (StudienartEntity sta : stArten) {
			JsonObject staJson = new JsonObject().put("staId", sta.getId())
					.put("staName", sta.getName());

			stArtenJson.put(staJson);
		}
		// Hinz. der Stas zur Ergebnismenge
		ret.put("sta", stArtenJson);

		/**
		 * Holen aller Studienordnungen
		 */
		List<StudienordnungEntity> stOrdnungen = db().findAll(
				StudienordnungEntity.class);
		JsonArray stOrdnungenJson = new JsonArray();
		for (StudienordnungEntity sto : stOrdnungen) {
			JsonObject stoJson = new JsonObject().put("stoId", sto.getId())
					.put("stoName", sto.getName())
					.put("stoJahr", sto.getJahr()).put("iId", sto.getI_id())
					.put("staId", sto.getSta_id());
			if(sto.getAktuell() == 1)
				stoJson.put("stoAktuell", "aktuell");

			stOrdnungenJson.put(stoJson);
		}
		// HInz. der Stos zur Ergebnismenge
		ret.put("sto", stOrdnungenJson);

		/**
		 * Holen aller Lehrende
		 */
		List<LecturerEntity> lehrende = db().findAll(LecturerEntity.class);
		JsonArray lehrendeJson = new JsonArray();
		for (LecturerEntity lehrender : lehrende) {
			JsonObject lehrenderJson = new JsonObject()
					.put("lId", lehrender.getId())
					.put("lVorname", lehrender.getVorname())
					.put("lNachname", lehrender.getNachname())
					.put("lZedat", lehrender.getZedat())
					.put("lEmail", lehrender.getEmail())
					.put("ltId", lehrender.getLt_id());

			lehrendeJson.put(lehrenderJson);
		}
		ret.put("lehrende", lehrendeJson);

		/**
		 * Hole alle Gebaeude und Raeume
		 */
		List<GebaeudeEntity> gebaeude = db().findAll(GebaeudeEntity.class);
		JsonArray gebaeudeJson = new JsonArray();
		for (GebaeudeEntity geb : gebaeude) {
			JsonObject gebJson = new JsonObject().put("gId", geb.getId())
					.put("gName", geb.getName())
					.put("gKuerzel", geb.getKuerzel())
					.put("gStrasse", geb.getStrasse())
					.put("gStNr", geb.getStrassenNr());

			/**
			 * Hole Raeume die zu Gebaeude
			 */
			List<RaumEntity> raeume = geb.getRaeume();
			JsonArray raeumeJson = new JsonArray();
			for (RaumEntity raum : raeume) {
				JsonObject raumJson = new JsonObject().put("rId", raum.getId())
						.put("rName", raum.getName())
						.put("rKuerzel", raum.getKuerzel());

				raeumeJson.put(raumJson);
			}
			gebJson.put("raeume", raeumeJson);
			// FB mit Institute wird entsprechenden JSON-Array hinzugefuegt
			gebaeudeJson.put(gebJson);
		}
		// Gebaeude und Raeume werden der Ergebnismenge hinzugefuegt
		ret.put("gebaeude", gebaeudeJson);

		return ret;
	}

	private String parseCounter(long counter) {
		if (counter > 99)
			return String.valueOf(counter);
		if (counter > 9)
			return "0" + String.valueOf(counter);
		return "00" + String.valueOf(counter);
	}

	/**
	 * Liefert eine Liste aller Raeume und Gebaeude mit die im uebergebnen
	 * Semester noch frei sind
	 * 
	 * @param sId
	 * @return
	 * @throws JSONException
	 */
	public JsonArray getFreeRooms(long sId) throws JSONException {
		List<GebaeudeEntity> gebaeudeListe = db().findAll(
				GebaeudeEntity.class);
		JsonArray gebaeudeListeJson = new JsonArray();
		for (GebaeudeEntity gebaeude : gebaeudeListe) {
			List<RaumEntity> freieRaeumeListe = gebaeude.getRaeume();
			if (!freieRaeumeListe.isEmpty()) {
				JsonArray raumListeJson = new JsonArray();
				for (RaumEntity raum : freieRaeumeListe) {
					/*Query q = db()
							.createQuery(
									"SELECT t FROM TerminEntity t WHERE t.id NOT IN ("
											+ " SELECT p.t_id FROM PlanungEntity p WHERE p.s_id = "
											+ sId + " AND p.r_id="
											+ raum.getId() + ")");*/
					
					List<TerminEntity> terminListe = db().createNamedQuery(
							TerminEntity.GET_FREE_TERMIN,
							TerminEntity.class)
							.setParameter("sId", sId)
							.setParameter("rId", raum.getId())
							.getResultList();
					if (!terminListe.isEmpty()) {
						JsonArray terminListeJson = new JsonArray();
						for (TerminEntity termin : terminListe) {
							JsonObject terminJson = new JsonObject()
									.put("tId", termin.getId())
									.put("tTag", termin.getTag())
									.put("tVon", termin.getVon())
									.put("tBis", termin.getBis());

							terminListeJson.put(terminJson);
						}
						if (!terminListeJson.isEmpty()) {
							JsonObject raumJson = new JsonObject()
									.put("rId", raum.getId())
									.put("rName", raum.getName())
									.put("rKuerzel", raum.getKuerzel())
									.put("termine", terminListeJson);

							raumListeJson.put(raumJson);
						}
					}
				}
				if (!raumListeJson.isEmpty()) {
					JsonObject gebaeudeJson = new JsonObject()
							.put("gId", gebaeude.getId())
							.put("gName", gebaeude.getName())
							.put("gKuerzel", gebaeude.getKuerzel())
							.put("gStr", gebaeude.getStrasse())
							.put("gStrNr", gebaeude.getStrassenNr())
							.put("raeume", raumListeJson);

					gebaeudeListeJson.put(gebaeudeJson);
				}
			}
		}
		
		if(!gebaeudeListeJson.isEmpty())
			return gebaeudeListeJson;

		return null;
	}
	
	
	/**
	 * 
	 * 
	 */
	private JsonObject getInstituteModulesBySemester(String inId, String sId) throws JSONException {
		if(inId == ""|| sId == "" ){
			inId = "7";
			sId = "4";
		}
		
		JsonObject ret = new JsonObject();
		
		JsonArray semesterListJson = new JsonArray();
		List<SemesterEntity> semesterList = db().findAll(SemesterEntity.class);
		for(SemesterEntity semester : semesterList){
			String sName = semester.getTyp() == 0 ? "WS "
					+ (Integer.parseInt(semester.getJahr().substring(2,4))-1) + "/"
					+ semester.getJahr().substring(2,4)
					: "SS " + semester.getJahr().substring(2,4);
					
			JsonObject semesterJson = new JsonObject()
			.put("sId", semester.getId())
			.put("sTyp", semester.getTyp())
			.put("sJahr", semester.getJahr())
			.put("sName", sName);
			
			semesterListJson.put(semesterJson);
			
			// Abbruchbedingung --> TO-DO: Funktion die immer das aktuelle Semester liefert
			// abbruchbedingunge ist dann aktuelles + 4
			if(semester.getId() == 8)
				break;
		}
		if(!semesterListJson.isEmpty())
			ret.put("sem", semesterListJson);
		
		
		List<StudienartEntity> staList = db().findAll(StudienartEntity.class);		
		
		InstitutEntity institut = db().find(InstitutEntity.class, Long.parseLong(inId));
		if(institut != null){
			FachbereichEntity fb = institut.getFachbereich();
			JsonObject fbJson = new JsonObject()
			.put("fbId", fb.getId())
			.put("fbName", fb.getName())
			.put("fbKuerzel",fb.getKuerzel());
	
			JsonObject institutJson = new JsonObject()
			.put("iId", institut.getId())
			.put("iName", institut.getName())
			.put("iKuerzel", institut.getKuerzel());
				
			// Stas des Institut
			JsonArray staListJson = new JsonArray();
			for(StudienartEntity sta : staList){
				long iId = institut.getId();
				long staId = sta.getId();
				
				StudienordnungEntity sto = db().createNamedQuery(
						StudienordnungEntity.CURRENT_STO_BY_INSTITUTE_STA,
						StudienordnungEntity.class)
						.setParameter("iId", iId)
						.setParameter("staId", staId)
						.getSingleResult();
				if(sto != null){
						//System.out.println("Found "+sto.getId()+" inst "+ iId);
						
					JsonObject staJson = new JsonObject()
					.put("stoId", sto.getId())
					.put("stoName", sto.getName())
					.put("stoJahr", sto.getJahr())
					.put("staId", sta.getId())
					.put("staName", sta.getName());
						
											
					SemesterEntity semester = db().find(SemesterEntity.class, Long.parseLong(sId));
						//JsonArray sListJson = new JsonArray();
						//for(SemesterEntity semester : semesterList){
					if(semester != null){
						JsonObject semesterJson = new JsonObject()
						.put("sId", semester.getId())
						.put("sJahr", semester.getJahr())
						.put("sTyp", semester.getTyp());
							
						long freq1 = 1, freq2 = 3;
						if(semester.getTyp() == 1){
							freq1++;
							freq2++;
						}						
							
						List<StoModulEntity> regStoModulList = db().createNamedQuery(
								StoModulEntity.REGULARY_STO_MODULES,
								StoModulEntity.class)
								.setParameter("stoId", sto.getId())
								.setParameter("freq1", freq1)
								.setParameter("freq2", freq2)
								.getResultList();
							
						List<StoModulEntity> nonRegStoModulList = db().createNamedQuery(
								StoModulEntity.NOT_REGULARY_STO_MODULES,
								StoModulEntity.class)
								.setParameter("stoId", sto.getId())
								.setParameter("freq1", freq1)
								.setParameter("freq2", freq2)
								.getResultList();
							
						JsonArray modulListJson = new JsonArray();
							
						for(StoModulEntity stoModul : regStoModulList){
							//System.out.println("Durchlaufe regSto");
							ModulEntity modul = stoModul.getModul();
							JsonObject modulJson = new JsonObject()
							.put("mId", modul.getId())
							.put("mName", modul.getName())
							.put("mNummer", modul.getMNummer())
							.put("mArt", modul.getTypName())
							.put("mEcts", stoModul.getEcts())
							.put("mTyp", modul.getM_typ())
							.put("mFrequenz", stoModul.getFrequenz());
								
							List<ModulHuelsenEntity> huelsenListe = modul.getModulHuelsen();
							JsonArray huelsenListeJson = new JsonArray();
							if(huelsenListe != null){
								for(ModulHuelsenEntity mhuelse : huelsenListe){
									HuelsenEntity huelse = mhuelse.getHuelse();
									JsonObject huelseJson = new JsonObject()
									.put("hId",huelse.getId())
									.put("hKuerzel",huelse.getKuerzel());
									
									huelsenListeJson.put(huelseJson);
								}
							}
							if(!huelsenListeJson.isEmpty())
								modulJson.put("huelsen", huelsenListeJson);
								
							List<ModulLvsEntity> modulLvList = db().createNamedQuery(
									ModulLvsEntity.GET_MODULES,
									ModulLvsEntity.class)
									.setParameter("mId", modul.getId())
									.getResultList();
							
							JsonArray modulLvListJson = new JsonArray();
							for(ModulLvsEntity modulLv : modulLvList){
								List<LehrveranstaltungEntity> lvList = db().createNamedQuery(
										LehrveranstaltungEntity.GET_LV_BY_MODUL_LVT,
										LehrveranstaltungEntity.class)
										.setParameter("mId", modul.getId())
										.setParameter("lvtId", modulLv.getLvt_id())
										.getResultList();
									
								JsonArray lvListJson = new JsonArray();
								for(LehrveranstaltungEntity lv : lvList){
									String lNummer = lv.getNummer();
									String lTyp = lv.getLvTyp().getName();
									String lSws = lv.getSws();
									
									JsonObject lvJson = new JsonObject()
									.put("lvId", lv.getId())
									.put("lvName", lv.getName())
									.put("lvInhalt", lv.getInhalt())
									.put("lvLiteratur", lv.getLiteratur())
									.put("lvVoraussetzung", lv.getVoraussetzung());
										
										
									UebungEntity uebung = lv.getUebung();
									if(uebung != null ){
										lvJson
										.put("lvUebung", true)
										.put("lvUebungSws", uebung.getSws());
										lNummer += " + " + uebung.getLvnummer();
										lTyp += " + Übung";
										lSws += " + " + uebung.getSws();
									}
									lvJson
									.put("lvNummer", lNummer)
									.put("lvTyp", lTyp)
									.put("lvSws", lSws);
										
									List<PlanungEntity> semesterPlanungsListe = db().createNamedQuery(
											PlanungEntity.GET_PLANUNG_BY_SEMESTER,
											PlanungEntity.class)
											.setParameter("lvId", lv.getId())
											.setParameter("sId", semester.getId())
											.getResultList();
										
									JsonArray terminListeJson = new JsonArray();
										
									JsonArray dozentenListeJson = new JsonArray();
									List<Long> dozentenIdList = new ArrayList<Long>();
									
									for(PlanungEntity planung : semesterPlanungsListe){
										TerminEntity termin = planung.getTermin();
										RaumEntity raum = planung.getRaum();
										GebaeudeEntity gebaeude = raum.getGebaeude();
										
										JsonObject terminJson = new JsonObject()
										.put("pId", planung.getId())
										.put("tId", termin.getId())
										.put("tTag", termin.getTag())
										.put("tVon", termin.getVon())
										.put("tBis", termin.getBis())
										.put("rId", raum.getId())
										.put("rId", raum.getName())
										.put("rId", raum.getKuerzel())
										.put("gId", gebaeude.getId())
										.put("gName", gebaeude.getName())
										.put("gKuerzel", gebaeude.getKuerzel())
										.put("gStrasse", gebaeude.getStrasse())
										.put("gStrassenNr", gebaeude.getStrassenNr());
										
										
										if(termin.getTag()=="Blockveranstaltung")
											terminJson
											.put("tStart", planung.getStartDatum())
											.put("tEnde", planung.getEndDatum());
										
										terminListeJson.put(terminJson);

										List<SemesterLecturerEntity> semLecturerList = planung.getSemesterLecturer();
										for(SemesterLecturerEntity semLecturer : semLecturerList){
											if(!dozentenIdList.contains(semLecturer.getL_id())){
												LecturerEntity lecturer = semLecturer.getLecturer();
												JsonObject lecturerJson = new JsonObject()
												.put("lId", lecturer.getId())
												.put("lVorname", lecturer.getVorname())
												.put("lNachname", lecturer.getNachname())
												.put("lZedat", lecturer.getZedat())
												.put("lEmail", lecturer.getEmail());
												dozentenIdList.add(lecturer.getId());
												dozentenListeJson.put(lecturerJson);
											}
										}
											
										if(!terminListeJson.isEmpty())
											lvJson.put("termine", terminListeJson);
										if(!dozentenListeJson.isEmpty())
											lvJson.put("dozenten", dozentenListeJson);
											
									}
									lvListJson.put(lvJson);											
								}
									
								if(!lvListJson.isEmpty()){
									JsonObject mLvJson = new JsonObject()
									.put("lvs", lvListJson);
									modulLvListJson.put(mLvJson);
								}

							}
							if(!modulLvListJson.isEmpty())
								modulJson.put("mlvs", modulLvListJson);
								modulListJson.put(modulJson);							
							}
							if(!modulListJson.isEmpty())
								semesterJson.put("module",modulListJson);							
							
							// Fuer alle nicht regelmaessigen Module
							JsonArray nonRegModulListJson = new JsonArray();
							for(StoModulEntity stoModul : nonRegStoModulList){
								//System.out.println("Durchlaufe regSto");
								ModulEntity modul = stoModul.getModul();
								JsonObject modulJson = new JsonObject()
								.put("mId", modul.getId())
								.put("mName", modul.getName())
								.put("mNummer", modul.getMNummer())
								.put("mArt", modul.getTypName())
								.put("mTyp", modul.getM_typ())
								.put("mEcts", stoModul.getEcts())
								.put("mFrequenz", stoModul.getFrequenz());;

								List<ModulLvsEntity> modulLvList = db().createNamedQuery(
										ModulLvsEntity.GET_MODULES,
										ModulLvsEntity.class)
										.setParameter("mId", modul.getId())
										.getResultList();
								JsonArray modulLvListJson = new JsonArray();
								for(ModulLvsEntity modulLv : modulLvList){
									List<LehrveranstaltungEntity> lvList = db().createNamedQuery(
											LehrveranstaltungEntity.GET_LV_BY_MODUL_LVT,
											LehrveranstaltungEntity.class)
											.setParameter("mId", modul.getId())
											.setParameter("lvtId", modulLv.getLvt_id())
											.getResultList();
									
									JsonArray lvListJson = new JsonArray();
									for(LehrveranstaltungEntity lv : lvList){
										String lNummer = lv.getNummer();
										String lTyp = lv.getLvTyp().getName();
										String lSws = lv.getSws();
										
										JsonObject lvJson = new JsonObject()
										.put("lvId", lv.getId())
										.put("lvName", lv.getName())
										.put("lvInhalt", lv.getInhalt())
										.put("lvLiteratur", lv.getLiteratur())
										.put("lvVoraussetzung", lv.getVoraussetzung());
										
										
										UebungEntity uebung = lv.getUebung();
										if(uebung != null ){
											lNummer += " + " + uebung.getLvnummer();
											lTyp += " + Übung";
											lSws += " + " + uebung.getSws();
										}
										lvJson
										.put("lvNummer", lNummer)
										.put("lvTyp", lTyp)
										.put("lvSws", lSws);
										
										List<PlanungEntity> semesterPlanungsListe = db().createNamedQuery(
												PlanungEntity.GET_PLANUNG_BY_SEMESTER,
												PlanungEntity.class)
												.setParameter("lvId", lv.getId())
												.setParameter("sId", semester.getId())
												.getResultList();
										
										JsonArray terminListeJson = new JsonArray();
										
										JsonArray dozentenListeJson = new JsonArray();
										List<Long> dozentenIdList = new ArrayList<Long>();
										
										for(PlanungEntity planung : semesterPlanungsListe){
											TerminEntity termin = planung.getTermin();
											RaumEntity raum = planung.getRaum();
											GebaeudeEntity gebaeude = raum.getGebaeude();
											
											JsonObject terminJson = new JsonObject()
											.put("pId", planung.getId())
											.put("tId", termin.getId())
											.put("tTag", termin.getTag())
											.put("tVon", termin.getVon())
											.put("tBis", termin.getBis())
											.put("rId", raum.getId())
											.put("rId", raum.getName())
											.put("rId", raum.getKuerzel())
											.put("gId", gebaeude.getId())
											.put("gName", gebaeude.getName())
											.put("gKuerzel", gebaeude.getKuerzel())
											.put("gStrasse", gebaeude.getStrasse())
											.put("gStrassenNr", gebaeude.getStrassenNr());
											
											
											if(termin.getTag()=="Blockveranstaltung")
												terminJson
												.put("tStart", planung.getStartDatum())
												.put("tEnde", planung.getEndDatum());
											
											terminListeJson.put(terminJson);

											
											List<SemesterLecturerEntity> semLecturerList = planung.getSemesterLecturer();
											for(SemesterLecturerEntity semLecturer : semLecturerList){
												if(!dozentenIdList.contains(semLecturer.getL_id())){
													LecturerEntity lecturer = semLecturer.getLecturer();
													JsonObject lecturerJson = new JsonObject()
													.put("lId", lecturer.getId())
													.put("lVorname", lecturer.getVorname())
													.put("lNachname", lecturer.getNachname())
													.put("lZedat", lecturer.getZedat())
													.put("lEmail", lecturer.getEmail());
													dozentenIdList.add(lecturer.getId());
													dozentenListeJson.put(lecturerJson);
												}
											}
											
										}
										if(!terminListeJson.isEmpty())
											lvJson.put("termine", terminListeJson);
										if(!dozentenListeJson.isEmpty())
											lvJson.put("dozenten", dozentenListeJson);
										
										lvListJson.put(lvJson);
									}
									
									if(!lvListJson.isEmpty()){
										JsonObject mLvJson = new JsonObject()
										.put("lvs", lvListJson);
										modulLvListJson.put(mLvJson);
									}
								}
								if(!modulLvListJson.isEmpty())
									modulJson.put("mlvs", modulLvListJson);
								nonRegModulListJson.put(modulJson);							
							}
							if(!nonRegModulListJson.isEmpty())
								semesterJson.put("nRModule",nonRegModulListJson);
							if(!semesterJson.isEmpty())
								staJson.put("semester", semesterJson);
						}
						staListJson.put(staJson);
					}
				}
				if(!staListJson.isEmpty())
					institutJson.put("sta", staListJson);
				if(!institutJson.isEmpty())
					fbJson.put("institute", institutJson);
				if(!fbJson.isEmpty())
					ret.put("fachbereiche", fbJson);
			}
		return ret;
	}
}