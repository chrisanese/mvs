package de.fu.mi.scuttle.lib.util;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.json.JSONException;
import org.junit.Assert;
import org.junit.Test;
import org.w3c.dom.Document;

import de.fu.mi.scuttle.lib.util.JsonObject;
import de.fu.mi.scuttle.lib.util.JsonToXml;
import de.fu.mi.scuttle.lib.util.XML;

public class JsonToXmlTest {

    @Test
    public void testSimpleObject() throws ParserConfigurationException,
            JSONException,
            TransformerException {
        final Document doc = JsonToXml.jsonToDomDocument(new JsonObject().put(
                "key", "value"));

        Assert.assertEquals(
                "<object><string key=\"key\">value</string></object>",
                XML.toString(doc));
    }

    @Test
    public void testComplexObject() throws ParserConfigurationException,
            JSONException,
            TransformerException {
        final Document doc = JsonToXml.jsonToDomDocument(new JsonObject()
                .put("obj", new JsonObject().put(
                        "key", "value")));

        Assert.assertEquals(
                "<object><object key=\"obj\"><string key=\"key\">value</string></object></object>",
                XML.toString(doc));
    }
}
