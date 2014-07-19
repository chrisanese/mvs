package de.fu.mi.scuttle.modules;

import java.util.List;

import org.json.JSONArray;
import org.json.JSONObject;

import de.fu.mi.scuttle.domain.BuildingFloor;
import de.fu.mi.scuttle.domain.BuildingFloorAnyFeature;
import de.fu.mi.scuttle.domain.Room;
import de.fu.mi.scuttle.domain.RoomAnyFeature;
import de.fu.mi.scuttle.lib.util.JsonSerializer;
import de.fu.mi.scuttle.lib.web.AbstractScuttleModule;
import de.fu.mi.scuttle.lib.web.JSONResponse;
import de.fu.mi.scuttle.lib.web.MountPoint;
import de.fu.mi.scuttle.lib.web.ScuttleRequest;
import de.fu.mi.scuttle.lib.web.ScuttleResponse;
import de.fu.mi.scuttle.lib.web.ScuttleServlet;

@MountPoint("editor")
public class Editor extends AbstractScuttleModule<ScuttleServlet> {

    private final JsonSerializer<Room> roomSerializer = new JsonSerializer<>(
            Room.class);
    private final JsonSerializer<BuildingFloorAnyFeature> buildingFloorAnyFeatureSerializer = new JsonSerializer<BuildingFloorAnyFeature>(
            BuildingFloorAnyFeature.class);
    private final JsonSerializer<RoomAnyFeature> roomAnyFeatureSerializer = new JsonSerializer<RoomAnyFeature>(
            RoomAnyFeature.class);

    public Editor(final ScuttleServlet parent) {
        super(parent);
    }

    @Override
    public ScuttleResponse handle(final ScuttleRequest request)
            throws Exception {
        parent().check(request, "Scuttle.editor");

        final JSONObject json = new JSONObject();
        final String path = request.getPath();

        if (path.startsWith("edit/")) {
            final long which = Long.valueOf(path.substring(5));
            final BuildingFloor floor = db().find(BuildingFloor.class, which);

            final List<Room> rooms = db()
                    .createNamedQuery(Room.Q_FOR_FLOOR_WITH_ANY_FEATURES,
                            Room.class).setParameter("floor", floor)
                    .getResultList();

            final JSONArray jsonRooms = new JSONArray();
            for (final Room room : rooms) {
                final JSONObject jsonRoom = roomSerializer.serialize(room);
                jsonRoom.put("features", roomAnyFeatureSerializer
                        .serialize(room.getAnyFeatures()));
                jsonRooms.put(jsonRoom);
            }

            final List<BuildingFloorAnyFeature> features = db()
                    .createNamedQuery(BuildingFloorAnyFeature.Q_FOR_FLOOR,
                            BuildingFloorAnyFeature.class)
                    .setParameter("floor", floor).getResultList();

            json.put("edit", true);
            json.put("floor", which);
            json.put("rooms", jsonRooms);
            json.put("features",
                    buildingFloorAnyFeatureSerializer.serialize(features));
        }

        switch (path) {

        case "newObject": {
            final BuildingFloor floor = db().find(BuildingFloor.class,
                    request.get("floor", Long.class));
            final String type = request.get("type");
            switch (type) {
            case "room":
                final Room room = new Room(floor, request.get("x",
                        Integer.class),
                        request.get("y", Integer.class), request.get("a",
                                Integer.class), request.get("b", Integer.class));
                db().persist(room);
                json.put("room", roomSerializer.serialize(room));
                break;
            case "floor":
            case "grass":
            case "street":
                final BuildingFloorAnyFeature feature = new BuildingFloorAnyFeature(
                        floor, type, request.get("x", Integer.class),
                        request.get("y", Integer.class), request.get("a",
                                Integer.class), request.get("b", Integer.class));
                db().persist(feature);
                json.put("feature",
                        buildingFloorAnyFeatureSerializer.serialize(feature));
                break;
            }
            break;
        }

        case "removeObjects": {
            final JSONArray objects = request.get("objects", JSONArray.class);
            for (int i = 0; i < objects.length(); i++) {
                final JSONObject obj = objects.getJSONObject(i);
                final String type = obj.getString("type");
                final Long id = obj.getLong("id");
                switch (type) {
                case "room": {
                    final Room room = db().find(Room.class, id);
                    if (room != null) {
                        db().remove(room);
                    }
                    break;
                }
                case "door": {
                    final RoomAnyFeature feature = db()
                            .find(RoomAnyFeature.class, id);
                    if (feature != null) {
                        db().remove(feature);
                    }
                    break;
                }
                default: {
                    final BuildingFloorAnyFeature feature = db().find(
                            BuildingFloorAnyFeature.class, id);
                    if (feature != null) {
                        db().remove(feature);
                    }
                    break;
                }
                }
            }
            break;
        }

        case "updateObject": {
            final String type = request.get("type");
            final Long which = request.get("id", Long.class);
            final String prop = request.get("prop");
            switch (type) {
            case "room":
                final Room room = db().find(Room.class, which);
                switch (prop) {
                case "roomId":
                    room.setRoomId(request.get("val"));
                    break;
                case "name":
                    room.setName(request.get("val"));
                    break;
                case "capacity":
                    room.setCapacity(request.get("val", room.getCapacity()));
                    break;
                }
                db().persist(room);
                break;
            default:
                final BuildingFloorAnyFeature feature = db().find(
                        BuildingFloorAnyFeature.class, which);
                switch (prop) {
                case "label":
                    break;
                }
                db().persist(feature);
                break;
            }
            break;
        }

        case "createRoomAnyFeature": {
            final Room room = db().find(Room.class,
                    request.get("room", Long.class));
            final RoomAnyFeature feature = new RoomAnyFeature(room,
                    request.get("type"), request.get("x", Integer.class),
                    request.get("y", Integer.class));
            db().persist(feature);
            json.put("feature", roomAnyFeatureSerializer.serialize(feature));
            break;
        }

        case "changeFeatureType": {
            final RoomAnyFeature feature = db().find(RoomAnyFeature.class,
                    request.get("which", Long.class));
            feature.setType(request.get("type"));
            db().persist(feature);
            break;
        }

        case "updateRoomAnyFeature": {
            final RoomAnyFeature feature = db().find(RoomAnyFeature.class,
                    request.get("which", Long.class));
            feature.setData(request.get("data"));
            db().persist(feature);
            break;
        }

        case "setRoomPosition": {
            final Room room = db().find(Room.class,
                    request.get("room", Long.class));
            room.setPosX(request.get("x", Integer.class));
            room.setPosY(request.get("y", Integer.class));
            db().persist(room);
            break;
        }

        case "setRoomDimension": {
            final Room room = db().find(Room.class,
                    request.get("room", Long.class));
            room.setWidth(request.get("a", Integer.class));
            room.setHeight(request.get("b", Integer.class));
            db().persist(room);
            break;
        }

        case "setRoomFeatures": {
            final Room room = db().find(Room.class,
                    request.get("room", Long.class));
            db().persist(room);
            break;
        }

        }
        json.put("success", true);
        return new JSONResponse(json);
    }

}
