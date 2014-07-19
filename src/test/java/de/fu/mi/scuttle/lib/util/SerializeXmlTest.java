package de.fu.mi.scuttle.lib.util;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.TransformerException;

import org.junit.Assert;
import org.junit.Test;
import org.w3c.dom.Document;
import org.w3c.dom.Element;

import de.fu.mi.scuttle.lib.util.SerializeXml;

public class SerializeXmlTest {

    @Test
    public void testEmptyDocument() throws ParserConfigurationException,
            TransformerException {
        final DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
        final DocumentBuilder b = f.newDocumentBuilder();
        final Document d = b.newDocument();

        final Element e = d.createElement("document");
        d.appendChild(e);

        final String xml = SerializeXml.domDocumentToString(d, false);

        Assert.assertEquals("<document/>", xml);
    }

    @Test
    public void testXmlDeclaration() throws ParserConfigurationException,
            TransformerException {
        final DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
        final DocumentBuilder b = f.newDocumentBuilder();
        final Document d = b.newDocument();

        final Element e = d.createElement("document");
        d.appendChild(e);

        final String xml = SerializeXml.domDocumentToString(d, true);

        Assert.assertEquals(
                "<?xml version=\"1.0\" encoding=\"UTF-8\"?><document/>", xml);
    }

    @Test
    public void test() throws ParserConfigurationException,
            TransformerException {
        final DocumentBuilderFactory f = DocumentBuilderFactory.newInstance();
        final DocumentBuilder b = f.newDocumentBuilder();
        final Document d = b.newDocument();

        final Element e = d.createElement("document");
        d.appendChild(e);

        final Element e2 = d.createElement("e");
        e2.setAttribute("key", "value");
        e2.appendChild(d.createTextNode("nodeValue"));
        e.appendChild(e2);

        final String xml = SerializeXml.domDocumentToString(d, false);

        System.out.println(xml);
        Assert.assertEquals(
                "<document><e key=\"value\">nodeValue</e></document>", xml);
    }
}
