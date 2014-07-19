package de.fu.mi.scuttle.modules;

import java.sql.SQLException;
import java.util.List;
import java.util.Properties;
import java.util.Set;
import java.util.TreeSet;

import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.Assert;
import org.junit.Test;

import de.fu.mi.scuttle.lib.persistence.EntityManager;
import de.fu.mi.scuttle.lib.persistence.EntityManagerWrapper;
import de.fu.mi.scuttle.lib.persistence.PersistenceUtil;

public class SakaiLinkTest {

    private final static String jdbcUrl = "jdbc:derby:memory:sakai";
    private final static String jdbcDriver = "org.apache.derby.jdbc.EmbeddedDriver";
    private final static String jdbcUser = "";
    private final static String jdbcPassword = "";
    private final static String persistenceUnit = "sakai";

    private static boolean schemaCreated = false;

    public static EntityManager getEntityManager() {
        if (!schemaCreated) {
            PersistenceUtil.createTables(persistenceUnit,
                    jdbcDriver, jdbcUser, jdbcPassword, jdbcUrl
                            + ";create=true");
            schemaCreated = true;
        }

        final Properties properties = PersistenceUtil.getProperties(
                jdbcDriver, jdbcUser, jdbcPassword, jdbcUrl);

        final EntityManagerFactory emf = Persistence
                .createEntityManagerFactory(persistenceUnit, properties);
        final EntityManager em = EntityManagerWrapper
                .wrap(emf.createEntityManager());

        return em;
    }

    public static void closeEntityManager(final EntityManager em) {
        EntityManagerFactory emf = em.getEntityManagerFactory();
        em.close();
        emf.close();
    }

    @Test
    public void testCreatePersistenceUnit() throws SQLException {

        final EntityManager em = getEntityManager();

        Set<String> expectedTables =
                new TreeSet<>(PersistenceUtil.getSchemaTableNames(em));

        System.err.println(expectedTables);

        Set<String> actualTables = new TreeSet<>();
        @SuppressWarnings("unchecked")
        List<Object> tables = em
                .createNativeQuery("SELECT TABLENAME FROM SYS.SYSTABLES")
                .getResultList();
        for (Object o : tables) {
            actualTables.add(o.toString().toUpperCase());
        }

        closeEntityManager(em);

        System.err.println(actualTables);

        Assert.assertTrue(actualTables.containsAll(expectedTables));
    }

}
