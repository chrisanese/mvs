package de.fu.mi.scuttle.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * A RoomAnyFeature is an arbitrary feature that is primarily used for rendering
 * the floor map nicely (for example doors). A RoomAnyFeature is directly
 * associated with a room, as opposed to {@link RoomFeature}, i.e. an instance
 * of RoomAnyFeature is the feature itself and belongs to exactly one room.
 * 
 * @author Julian Fleischer
 */
@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "room_any_feature")
@NamedQueries({
        @NamedQuery(
            name = RoomAnyFeature.Q_COUNT,
            query = "SELECT count(f) FROM RoomAnyFeature f")
})
public class RoomAnyFeature extends ScuttleEntity<RoomAnyFeature> {

    public static final String Q_COUNT = "RoomAnyFeature.count";

    @NotNull
    @Size(
        min = 1,
        max = DbConfig.FEATURE_NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "type",
        nullable = false,
        length = DbConfig.FEATURE_NAME_LENGTH)
    private String type;

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

    @Size(
        min = 0,
        max = DbConfig.DATA_LENGTH)
    @Column(
        nullable = true,
        length = DbConfig.DATA_LENGTH,
        name = DbConfig.COLUMN_PREFIX + "data")
    private String data;

    @NotNull
    @ManyToOne
    @JoinColumn(
        nullable = false,
        name = DbConfig.FOREIGN_KEY_PREFIX + "room")
    private Room room;

    // JPA needs a default constructor *always*
    public RoomAnyFeature() {

    }

    public RoomAnyFeature(Room room, String type, int x, int y) {
        setRoom(room);
        setType(type);
        setPosX(x);
        setPosY(y);
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getPosX() {
        return posX;
    }

    public void setPosX(int posX) {
        this.posX = posX;
    }

    public int getPosY() {
        return posY;
    }

    public void setPosY(int posY) {
        this.posY = posY;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }
}
