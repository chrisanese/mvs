package de.fu.mi.scuttle.modules;

import org.json.JSONObject;

import de.fu.mi.scuttle.lib.web.AbstractScuttleModule;
import de.fu.mi.scuttle.lib.web.JSONResponse;
import de.fu.mi.scuttle.lib.web.MountPoint;
import de.fu.mi.scuttle.lib.web.ScuttleRequest;
import de.fu.mi.scuttle.lib.web.ScuttleResponse;
import de.fu.mi.scuttle.lib.web.ScuttleServlet;
import de.fu.mi.scuttle.modules.backup.SketchesBackupHelper;

/**
 * A handler that adds backup and restore functionality to scuttle.
 * 
 * @author Julian Fleischer
 */
@MountPoint("backup")
public class Backup extends AbstractScuttleModule<ScuttleServlet> {

    private final SketchesBackupHelper sketchesBackupHelper = new SketchesBackupHelper();

    public Backup(final ScuttleServlet parent) {
        super(parent);
    }

    @Override
    public ScuttleResponse handle(final ScuttleRequest req) throws Exception {
        switch (req.getPath()) {

        case "importSketches": {
            parent().check(req, "Backup.import");

            final JSONObject jsonData = req.get("data", JSONObject.class);
            sketchesBackupHelper.importJson(jsonData, db());

            break;
        }

        case "exportSketches": {
            parent().check(req, "Backup.export");

            final JSONObject object = sketchesBackupHelper.exportJson(db());
            return new JSONResponse(object);
        }
        }
        return new JSONResponse();
    }
}
