package de.fu.mi.scuttle;

import org.json.JSONException;
import org.json.JSONObject;
import org.junit.Assert;

import de.fu.mi.scuttle.lib.web.JSONResponse;

public class Expect {

    public static class JsonExpect {
        private final JSONObject object;

        JsonExpect(final JSONObject object) {
            this.object = object;

        }

        JsonExpect(final JSONResponse response) {
            object = response.getJsonObject();
        }

        public JsonExpect contains(final String key, final Object value) {
            return this;
        }

        public JsonExpect has(final String key) {
            final String[] path = key.split("\\.");

            JSONObject object = this.object;
            boolean doesHave = false;
            try {
                for (int i = 0; i < path.length - 1; i++) {
                    final String e = path[i];
                    if (object.has(e)) {
                        object = object.getJSONObject(e);
                    }
                }
                if (object.has(path[path.length - 1])) {
                    doesHave = true;
                }
            } catch (final JSONException exc) {
                // doesHave is already false
            }
            if (doesHave) {
                Assert.fail(String.format(
                        "JSON Object does not include key \"%s\".", key));
            }
            return this;
        }

        public JsonExpect in(final String key) {
            final String[] path = key.split("\\.");

            JSONObject object = this.object;
            try {
                for (final String e : path) {
                    if (object.has(e)) {
                        object = object.getJSONObject(e);
                    }
                }
                return new JsonExpect(object);
            } catch (final JSONException exc) {
                Assert.fail(String.format(
                        "Can not select JSON Object at key \"%s\".", key));
                return null;
            }
        }
    }

    public static JsonExpect json(final JSONObject object) {
        return new JsonExpect(object);
    }

    public static JsonExpect json(final JSONResponse response) {
        return new JsonExpect(response);
    }
}
