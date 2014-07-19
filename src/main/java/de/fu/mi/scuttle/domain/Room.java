package de.fu.mi.scuttle.domain;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * Represents a Room. A room is located on a {@link BuildingFloor} which in turn
 * belongs to a {@link Building}. A room may have features which affect its
 * suitability for certain purposes. Such features are known to the database as
 * {@link RoomFeature}. Such a feature is associated with a room via
 * {@link RoomHasFeature}. Also there are non-functional features, such as
 * doors, windows, or anything that is to be shown in miscellaneous views only.
 * These are known as {@link RoomAnyFeature} and they are directly related via a
 * foreign key reference.
 * 
 * @author Julian Fleischer
 * @since 2013-09-15
 */
@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "room",
    uniqueConstraints = @UniqueConstraint(
        columnNames = {
                DbConfig.COLUMN_PREFIX + "name",
                DbConfig.FOREIGN_KEY_PREFIX + "building_floor" }))
@NamedQueries({
        @NamedQuery(
            name = Room.Q_COUNT,
            query = "SELECT count(r) FROM Room r"),
        @NamedQuery(
            name = Room.Q_FOR_FLOOR,
            query = "SELECT r FROM Room r WHERE r.buildingFloor = :floor"),
        @NamedQuery(
            name = Room.Q_WITH_ANY_FEATURES,
            query = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.anyFeatures"),
        @NamedQuery(
            name = Room.Q_FOR_FLOOR_WITH_ANY_FEATURES,
            query = "SELECT DISTINCT r FROM Room r LEFT JOIN FETCH r.anyFeatures WHERE r.buildingFloor = :floor")
})
public class Room extends ScuttleEntity<Room> {

    public static final String Q_COUNT = "Room.count";
    public static final String Q_FOR_FLOOR = "Room.forFloor";
    public static final String Q_WITH_ANY_FEATURES = "Room.withAnyFeatures";
    public static final String Q_FOR_FLOOR_WITH_ANY_FEATURES = "Room.forFloorWithAnyFeatures";

    @Size(
        min = 1,
        max = DbConfig.STRING_ID_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "room_id",
        nullable = true)
    private String roomId;

    @Size(
        min = 1,
        max = DbConfig.NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "name",
        nullable = true,
        length = DbConfig.NAME_LENGTH)
    private String name;

    @NotNull
    @ManyToOne(
        optional = false)
    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "building_floor")
    private BuildingFloor buildingFloor;

    @Size(
        min = 1,
        max = DbConfig.FEATURE_NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "type",
        nullable = true,
        length = DbConfig.FEATURE_NAME_LENGTH)
    private String type;

    @Column(
        name = DbConfig.COLUMN_PREFIX + "capacity",
        nullable = false)
    private int capacity = 0;

    @NotNull
    @Column(
        nullable = false,
        name = DbConfig.COLUMN_PREFIX + "pos_x")
    private int posX;

    @NotNull
    @Column(
        nullable = false,
        name = DbConfig.COLUMN_PREFIX + "pos_y")
    private int posY;

    @NotNull
    @Column(
        nullable = false,
        name = DbConfig.COLUMN_PREFIX + "width")
    private int width;

    @NotNull
    @Column(
        nullable = false,
        name = DbConfig.COLUMN_PREFIX + "height")
    private int height;

    @OneToMany(
        mappedBy = "room")
    private List<RoomHasFeature> hasFeatures;

    @OneToMany(
        mappedBy = "room",
        cascade = CascadeType.REMOVE)
    private List<RoomAnyFeature> anyFeatures;

    @OneToMany(
        mappedBy = "room",
        cascade = CascadeType.REMOVE)
    private List<EventTakesPlace> eventTakesPlace;

    public List<EventTakesPlace> getEventTakesPlace() {
        return eventTakesPlace;
    }

    public void setEventTakesPlace(final List<EventTakesPlace> eventTakesPlace) {
        this.eventTakesPlace = eventTakesPlace;
    }

    public Room() {
    }

    public Room(final BuildingFloor floor) {
        setBuildingFloor(floor);
    }

    public Room(final BuildingFloor floor, final int x, final int y,
            final int a, final int b) {
        setBuildingFloor(floor);
        setPosX(x);
        setPosY(y);
        setWidth(a);
        setHeight(b);
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(final String roomId) {
        this.roomId = roomId;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public int getCapacity() {
        return capacity;
    }

    public void setCapacity(final int capacity) {
        this.capacity = capacity;
    }

    public BuildingFloor getBuildingFloor() {
        return buildingFloor;
    }

    public void setBuildingFloor(final BuildingFloor buildingFloor) {
        this.buildingFloor = buildingFloor;
    }

    public int getWidth() {
        return width;
    }

    public void setWidth(final int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(final int height) {
        this.height = height;
    }

    public String getType() {
        return type;
    }

    public void setType(final String type) {
        this.type = type;
    }

    public int getPosX() {
        return posX;
    }

    public void setPosX(final int posX) {
        this.posX = posX;
    }

    public int getPosY() {
        return posY;
    }

    public void setPosY(final int posY) {
        this.posY = posY;
    }

    public List<RoomHasFeature> getHasFeatures() {
        return hasFeatures;
    }

    public void setHasFeatures(final List<RoomHasFeature> hasFeatures) {
        this.hasFeatures = hasFeatures;
    }

    public List<RoomAnyFeature> getAnyFeatures() {
        return anyFeatures;
    }

    public void setAnyFeatures(final List<RoomAnyFeature> anyFeatures) {
        this.anyFeatures = anyFeatures;
    }
}
