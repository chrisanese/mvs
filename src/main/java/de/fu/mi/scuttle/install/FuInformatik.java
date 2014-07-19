package de.fu.mi.scuttle.install;

import static de.fu.mi.scuttle.lib.util.UtilityMethods.list;

import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;

import org.apache.commons.codec.Charsets;
import org.json.JSONException;
import org.json.JSONObject;
import org.json.JSONTokener;

import de.fu.mi.scuttle.domain.Configuration;
import de.fu.mi.scuttle.domain.Day;
import de.fu.mi.scuttle.domain.Timeslot;
import de.fu.mi.scuttle.lib.ScuttleInstaller;
import de.fu.mi.scuttle.lib.persistence.EntityManager;
import de.fu.mi.scuttle.modules.backup.SketchesBackupHelper;

/**
 * Custom installer for FU Informatik.
 * 
 * @author Julian Fleischer
 */
public class FuInformatik implements ScuttleInstaller {

    private final SketchesBackupHelper sketchesBackupHelper =
            new SketchesBackupHelper();

    @Override
    public void install(final JSONObject config, final EntityManager em)
            throws JSONException, IOException {

        // Start
        em.getTransaction().begin();

        // Days + Timeslots

        int i = 0;
        int j = 0;
        for (final String dayName : list("Montag", "Dienstag", "Mittwoch",
                "Donnerstag", "Freitag", "Samstag", "Sonntag")) {
            final Day day = new Day(++i, dayName);
            int k = 0;
            for (short h = 0; h < 24; h++) {
                day.addTimeslot(new Timeslot(day, ++j, (short) (h * 60),
                        (short) ((h + 1) * 60), k++, k >= 8 && k < 20));
            }
            em.persist(day);
        }

        // Skizzen

        try (final InputStream stream = getClass().getResourceAsStream(
                "skizzen.json");
                final InputStreamReader reader = new InputStreamReader(stream,
                        Charsets.UTF_8)) {
            final JSONTokener tokener = new JSONTokener(reader);
            final JSONObject json = new JSONObject(tokener);
            sketchesBackupHelper.importJson(json, em);
        }

        new Configuration("sakvv.currentAcademicTerm", "WS 13/14",
                "The currenct academic term.").persist(em);

        // SakaiLink configuration

        new Configuration(
                "sakaiLink.jdbcUser",
                config.optString("jdbcUser", ""),
                "The username used to connect to the Sakai database.")
                .persist(em);
        new Configuration(
                "sakaiLink.jdbcPassword",
                config.optString("jdbcPassword", ""),
                "The password used to connect to the Sakai database.")
                .persist(em);
        new Configuration(
                "sakaiLink.jdbcDriver",
                config.optString("jdbcDriver", "com.mysql.jdbc.Driver"),
                "The JDBC driver used to connect to the Sakai database.")
                .persist(em);
        new Configuration(
                "sakaiLink.jdbcUrl",
                config.optString(
                        "jdbcUrl",
                        "jdbc:mysql://localhost/scuttle?zeroDateTimeBehavior=convertToNull&useUnicode=true&characterEncoding=UTF-8"),
                "The JDBD url that determines how to connect to the Sakai database.")
                .persist(em);

        // Done.
        em.getTransaction().commit();
    }

}
