package de.fu.mi.scuttle.modules.backup;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.criteria.CriteriaBuilder;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import de.fu.mi.scuttle.lib.persistence.EntityManager;
import de.fu.mi.scuttle.lib.util.JsonSerializer;
import de.fu.mi.scuttle.lib.util.JsonUnserializer;
import de.fu.mi.scuttle.lib.util.JsonUnserializer.ObjectResolver;

/**
 * Provides a generic solution for importing and exporting of objects from and
 * to the database in various formats (currently only JSON, XML planned).
 * 
 * @author Julian Fleischer
 * @since 20103-10-26
 */
public class AbstractBackupHelper {

    private static class SerializerTriple<T> {

        private final String name;
        private final Class<?> type;
        private final JsonSerializer<T> serializer;
        private final JsonUnserializer<T> unserializer;

        SerializerTriple(String name, Class<T> clazz) {
            this.name = name;
            this.type = clazz;
            this.serializer = new JsonSerializer<>(clazz);
            this.unserializer = new JsonUnserializer<>(clazz);
        }

        public String getName() {
            return name;
        }

        public JsonSerializer<T> getSerializer() {
            return serializer;
        }

        public JsonUnserializer<T> getUnserializer() {
            return unserializer;
        }

        public Class<?> getType() {
            return type;
        }
    }

    private final List<SerializerTriple<?>> serializers;

    protected <T> void add(String name, Class<T> clazz) {
        serializers.add(new SerializerTriple<T>(name, clazz));
    }

    public AbstractBackupHelper() {
        serializers = new ArrayList<>();
    }

    public void importJson(
            final JSONObject json,
            final EntityManager em) throws JSONException {

        for (final SerializerTriple<?> s : serializers) {
            JsonUnserializer<?> unserializer = s.getUnserializer();
            JSONArray array = json.getJSONArray(s.getName());

            for (int i = 0; i < array.length(); i++) {
                final ObjectResolver resolver = new ObjectResolver() {
                    @Override
                    public Object resolve(Class<?> type, String uuid) {

                        final CriteriaBuilder cb = em.getCriteriaBuilder();
                        final CriteriaQuery<?> query = cb.createQuery(type);
                        final Root<?> entity = query.from(type);

                        query.where(cb.equal(entity.get("uuid"), uuid));

                        return em.createQuery(query).getSingleResult();
                    }
                };

                Object o = unserializer
                        .unserialize(array.getJSONObject(i), resolver);
                em.persist(o);
            }
        }
    }

    public JSONObject exportJson(
            final EntityManager em) throws JSONException {

        final JSONObject object = new JSONObject();

        for (final SerializerTriple<?> s : serializers) {
            final JSONArray data = s.getSerializer()
                    .serializeAny(em.findAll(s.getType()));
            object.put(s.getName(), data);
        }

        return object;
    }
}
