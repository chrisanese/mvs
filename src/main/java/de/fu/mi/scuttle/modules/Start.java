package de.fu.mi.scuttle.modules;

import org.json.JSONObject;

import de.fu.mi.scuttle.lib.web.AbstractScuttleModule;
import de.fu.mi.scuttle.lib.web.JSONResponse;
import de.fu.mi.scuttle.lib.web.MountPoint;
import de.fu.mi.scuttle.lib.web.PDFResponse;
import de.fu.mi.scuttle.lib.web.ScuttleRequest;
import de.fu.mi.scuttle.lib.web.ScuttleResponse;
import de.fu.mi.scuttle.lib.web.ScuttleServlet;

/**
 * 
 * @author Julian Fleischer
 * @since 2013-09-09
 */
@MountPoint("start")
public class Start extends AbstractScuttleModule<ScuttleServlet> {

    public Start(final ScuttleServlet parent) {
        super(parent);
    }

    @Override
    public ScuttleResponse handle(final ScuttleRequest req) throws Exception {
        final JSONObject json = new JSONObject();

        switch (req.getPath()) {
        case "logout":
            req.getSession().remove("username");
            break;

        case "pdfdemo":
            // This is just a demo, it renders an XSL-FO as "example.pdf".
            // This is different from what you would normally do (normally
            // you would preocess data with an XSL-T stylesheet into an XSL-FO
            // and render that).
            return new PDFResponse("example.pdf",
                    Start.class.getResourceAsStream("fonts.fo"));
        }

        json.put("loggedIn", req.getSession().get("username") != null);

        return new JSONResponse(json);
    }
}
