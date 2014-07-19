package de.fu.mi.scuttle.modules.modulVW;

import de.fu.mi.scuttle.lib.web.JSONResponse;
import de.fu.mi.scuttle.lib.web.PDFResponse;
import org.json.JSONException;

import javax.xml.parsers.ParserConfigurationException;
import javax.xml.transform.*;
import java.io.InputStream;
import java.lang.reflect.Field;

class ParameterizedPDFResponse extends PDFResponse {

    public ParameterizedPDFResponse(
            final JSONResponse response,
            final InputStream stylesheet,
            final String parameter,
            final String value)
            throws TransformerConfigurationException,
            ParserConfigurationException, JSONException {
        super (response, stylesheet);

        Field transformField = null;
        try {
            transformField = PDFResponse.class.getDeclaredField("transformer");
        } catch (NoSuchFieldException e) {
            e.printStackTrace();
        }
        transformField.setAccessible(true);
        try {
            Transformer transformer = (Transformer)transformField.get(this);
            transformer.setParameter(parameter, value);
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

}
