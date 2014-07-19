package de.fu.mi.scuttle.modules;

import java.util.List;

import de.fu.mi.scuttle.domain.Configuration;
import de.fu.mi.scuttle.lib.util.JsonObject;
import de.fu.mi.scuttle.lib.util.JsonSerializer;
import de.fu.mi.scuttle.lib.web.AbstractScuttleModule;
import de.fu.mi.scuttle.lib.web.JSONResponse;
import de.fu.mi.scuttle.lib.web.MountPoint;
import de.fu.mi.scuttle.lib.web.ScuttleRequest;
import de.fu.mi.scuttle.lib.web.ScuttleResponse;
import de.fu.mi.scuttle.lib.web.ScuttleServlet;

@MountPoint("admin")
public class Admin extends AbstractScuttleModule<ScuttleServlet> {

    JsonSerializer<Configuration> configSerializer = new JsonSerializer<>(
            Configuration.class);

    public Admin(final ScuttleServlet parent) {
        super(parent);
    }

    @Override
    public ScuttleResponse handle(final ScuttleRequest req) throws Exception {
        parent().check(req, "Scuttle.admin");

        switch (req.getPath()) {

        case "config": {
            parent().check(req, "Scuttle.admin.config");

            final List<Configuration> config = db().createNamedQuery(
                    Configuration.Q_ALL_SORTED_BY_KEY,
                    Configuration.class).getResultList();
            final JsonObject json = new JsonObject()
                    .put("config", configSerializer.serialize(config));

            return new JSONResponse(json);
        }
        case "saveConfig": {
            parent().check(req, "Scuttle.admin.saveConfig");

            final JsonObject json = new JsonObject().put("success", true);

            return new JSONResponse(json);
        }
        default: {
            parent().check(req, "Scuttle.admin");

            final Runtime runtime = Runtime.getRuntime();
            final JsonObject json = new JsonObject()
                    .put("totalMemory", runtime.totalMemory())
                    .put("freeMemory", runtime.freeMemory())
                    .put("maxMemory", runtime.maxMemory())
                    .put("availableProcessors", runtime.availableProcessors());

            return new JSONResponse(json);
        }
        }
    }
}
