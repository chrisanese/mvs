package de.fu.mi.scuttle.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "room_label")
public class RoomLabel extends ScuttleEntity<Event> {

    @NotNull
    @Column(
        name = DbConfig.COLUMN_PREFIX + "label",
        nullable = false,
        unique = true)
    private String label;

    @NotNull
    @JoinColumn(name = DbConfig.JOIN_TABLE_PREFIX + "room", nullable = false)
    private Room room;

    public RoomLabel() {

    }

    public RoomLabel(final Room room, final String label) {
        this.room = room;
        this.label = label;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(final String label) {
        this.label = label;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(final Room room) {
        this.room = room;
    }
}
