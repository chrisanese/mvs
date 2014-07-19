package de.fu.mi.scuttle.modules;

import java.util.Date;

import de.fu.mi.scuttle.lib.ScuttleBackendServlet;
import de.fu.mi.scuttle.lib.util.JsonObject;
import de.fu.mi.scuttle.lib.util.concurrent.JobQueue;
import de.fu.mi.scuttle.lib.web.AbstractScuttleModule;
import de.fu.mi.scuttle.lib.web.JSONResponse;
import de.fu.mi.scuttle.lib.web.MountPoint;
import de.fu.mi.scuttle.lib.web.PDFResponse;
import de.fu.mi.scuttle.lib.web.ScuttleRequest;
import de.fu.mi.scuttle.lib.web.ScuttleResponse;
import de.fu.mi.scuttle.lib.web.XMLResponse;

@MountPoint("helloWorld")
public class HelloWorld extends AbstractScuttleModule<ScuttleBackendServlet> {

    public HelloWorld(final ScuttleBackendServlet parent) {
        super(parent);
    }

    /**
     * Here you can do stuff after the ScuttleBackendServlet initialized all the
     * handlers, which is automatically done on startup.
     * 
     * You do not need to implement this method as {@link AbstractScuttleModule}
     * already implements an empty stub for you. It is defined here just for
     * demonstrating.
     * 
     * You can also do initializing within the constructor, but it is not
     * guaranteed that any other module has been initialized yet when doing so.
     * Also, if you for example set up a job in the job queue, it is much more
     * advisable to do it in here. If you do not and any of the other modules
     * fails to initialize properly you might end up with a servlet doing random
     * things.
     * 
     * For example, {@link SakaiWatchdog} sets up a recurring task using the
     * {@link JobQueue} in here (See also
     * {@link ScuttleBackendServlet#getJobQueue()}.
     */
    @Override
    public void loaded() {
        // Do some startup stuff here.
    }

    /**
     * This method takes a {@link ScuttleRequest} and generates a
     * {@link ScuttleResponse} from that.
     */
    @Override
    public ScuttleResponse handle(final ScuttleRequest request)
            throws Exception {

        // A simple JsonObject is prepared here. It contains only one key, the
        // currentTime. Note that JsonObjects automatically convert objects they
        // do not know to Strings.
        final JsonObject object = new JsonObject()
                .put("currentTime", new Date(
                        System.currentTimeMillis()));

        // Prepare the JSONResponse from the JsonObject just created.
        final JSONResponse response = new JSONResponse(object);

        // You might want do differentiate several targets in your module.
        switch (request.getPath()) {

        case "helloWorld.xml":
            // An XMLResponse can simply be generated from a JSONResponse.
            return new XMLResponse(response);

        case "helloWorld.pdf":
            // A PDFResponse can be generated from a JSONResponse using an XSL
            // Transform.
            return new PDFResponse(
                    response,
                    // The resource can be found in
                    // src/main/resources/de/fu/mi/scuttle/modules/helloWorld.xslt
                    HelloWorld.class.getResourceAsStream("helloWorld.xslt"));

            // A default action - in this case we simply return the JSONResponse
            // that we constructed earlier.
        default:
            return response;
        }

    }

}
