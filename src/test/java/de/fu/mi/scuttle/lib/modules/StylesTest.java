package de.fu.mi.scuttle.lib.modules;

import org.junit.Assert;
import org.junit.Test;

import de.fu.mi.scuttle.lib.modules.Styles;
import de.fu.mi.scuttle.lib.util.test.ScuttleRequestMockup;
import de.fu.mi.scuttle.lib.util.test.ScuttleServletMockup;
import de.fu.mi.scuttle.lib.util.test.ScuttleServletResponseMockup;
import de.fu.mi.scuttle.lib.web.ScuttleResponse;

public class StylesTest {

    @Test
    public void testLess() throws Exception {
        final Styles styles = new Styles(new ScuttleServletMockup(
                "src/main/webapp"));

        final String result = styles
                .compileLess("@blue: red;"
                        + " .x { background: @blue; }"
                        + " div { .x; span { color: red; } }");

        Assert.assertEquals(".x {\n"
                + "  background: #ff0000;\n"
                + "}\n"
                + "div {\n"
                + "  background: #ff0000;\n"
                + "}\n"
                + "div span {\n"
                + "  color: red;\n"
                + "}\n", result);
    }

    @Test
    public void testHandler() throws Exception {
        final Styles styles = new Styles(new ScuttleServletMockup(
                "src/main/webapp"));

        final ScuttleResponse response = styles
                .handle(new ScuttleRequestMockup());

        final ScuttleServletResponseMockup servletResponse = new ScuttleServletResponseMockup();
        response.doResponse(false, servletResponse);

        servletResponse.close();
        final String result = servletResponse.toString();

        Assert.assertTrue(result.length() > 10);
    }
}
