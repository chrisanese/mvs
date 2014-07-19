package de.fu.mi.scuttle.domain.misc;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.Table;

import de.fu.mi.scuttle.domain.DbConfig;
import de.fu.mi.scuttle.domain.Room;
import de.fu.mi.scuttle.domain.ScuttleEntity;

/**
 * 
 * @author Julian Fleischer
 * @since 2013-10-24
 */
@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "sakvv_room_to_scuttle_room")
public class SakvvRoomToScuttleRoom extends
        ScuttleEntity<SakvvRoomToScuttleRoom> {

    @Column(name = DbConfig.COLUMN_PREFIX + "sakai_location")
    private String sakaiLocation;

    @Column(name = DbConfig.COLUMN_PREFIX + "sakvv_haus")
    private String sakvvHaus;

    @Column(name = DbConfig.COLUMN_PREFIX + "sakvv_raum")
    private String sakvvRaum;

    @Column(name = DbConfig.COLUMN_PREFIX + "sakvv_id")
    private long sakvvId;

    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "room",
        referencedColumnName = DbConfig.ID_COLUMN)
    private Room room;

    public SakvvRoomToScuttleRoom() {

    }

    public SakvvRoomToScuttleRoom(final String sakaiLocation, final Room room) {

    }

    public SakvvRoomToScuttleRoom(final String sakvvHaus,
            final String sakvvRaum, final long sakvvId, final Room room) {

    }

    public String getSakaiLocation() {
        return sakaiLocation;
    }

    public void setSakaiLocation(final String sakaiLocation) {
        this.sakaiLocation = sakaiLocation;
    }

    public String getSakvvHaus() {
        return sakvvHaus;
    }

    public void setSakvvHaus(final String sakvvHaus) {
        this.sakvvHaus = sakvvHaus;
    }

    public String getSakvvRaum() {
        return sakvvRaum;
    }

    public void setSakvvRaum(final String sakvvRaum) {
        this.sakvvRaum = sakvvRaum;
    }

    public long getSakvvId() {
        return sakvvId;
    }

    public void setSakvvId(final long sakvvId) {
        this.sakvvId = sakvvId;
    }

    public Room getRoom() {
        return room;
    }

    public void setRoom(final Room room) {
        this.room = room;
    }

}
