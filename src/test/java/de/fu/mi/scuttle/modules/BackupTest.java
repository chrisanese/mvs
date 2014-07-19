package de.fu.mi.scuttle.modules;

import javax.validation.ConstraintViolation;
import javax.validation.ConstraintViolationException;

import org.json.JSONException;
import org.json.JSONObject;
import org.junit.After;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import de.fu.mi.scuttle.domain.Building;
import de.fu.mi.scuttle.domain.BuildingFloor;
import de.fu.mi.scuttle.lib.persistence.EntityManager;
import de.fu.mi.scuttle.modules.backup.SketchesBackupHelper;

public class BackupTest {

    private EntityManager em = PersistenceTest.getEntityManager();

    @Before
    public void setup() {
        em = PersistenceTest.getEntityManager();
    }

    @After
    public void teardown() {
        PersistenceTest.closeEntityManager(em);
    }

    //@Test
    public void testImportExport() throws JSONException {

        String buildingUuid = "";
        try {

            SketchesBackupHelper helper = new SketchesBackupHelper();

            Building b = new Building("Alt-Moabit 86", "Die WG");
            em.persist(b);
            BuildingFloor f0 = new BuildingFloor(b, "Erdgeschoss");
            BuildingFloor f1 = new BuildingFloor(b, "1. Obergeschoss");
            BuildingFloor f2 = new BuildingFloor(b, "2. Obergeschoss");
            em.persistAll(f0, f1, f2);

            buildingUuid = b.getUuid();

            JSONObject json = helper.exportJson(em);

            em.removeAll(b, f0, f1, f2);

            helper.importJson(json, em);

        } catch (ConstraintViolationException exc) {
            for (ConstraintViolation<?> e : exc.getConstraintViolations()) {
                System.out.println(e);
            }
        }

        Building b = new Building("Alt-Moabit 87", "Zur Quelle");
        em.persist(b);
        BuildingFloor f0 = new BuildingFloor(b, "Erdgeschoss");
        BuildingFloor f1 = new BuildingFloor(b, "1. Obergeschoss");
        BuildingFloor f2 = new BuildingFloor(b, "2. Obergeschoss");
        em.persistAll(f0, f1, f2);

        em.clear();

        Building b2 = em
                .createNamedQuery(Building.Q_BY_UUID, Building.class)
                .setParameter("uuid", buildingUuid)
                .getSingleResult();

        Assert.assertEquals("Alt-Moabit 86", b2.getAddress());
        Assert.assertEquals("Die WG", b2.getName());
        Assert.assertEquals(buildingUuid, b2.getUuid());
        Assert.assertEquals(3, b2.getBuildingFloors().size());

        for (BuildingFloor floor : b2.getBuildingFloors()) {
            Assert.assertEquals(buildingUuid, floor.getBuilding().getUuid());
        }

        Assert.assertTrue(em.removeAll(BuildingFloor.class) >= 3);
    }

}
