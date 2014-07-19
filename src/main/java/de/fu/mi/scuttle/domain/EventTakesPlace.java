package de.fu.mi.scuttle.domain;

import javax.persistence.Cacheable;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "event_takes_place",
    uniqueConstraints = @UniqueConstraint(columnNames = {
            DbConfig.FOREIGN_KEY_PREFIX + "room",
            DbConfig.FOREIGN_KEY_PREFIX + "timeslot",
    }))
@Cacheable(true)
public class EventTakesPlace extends ScuttleEntity<EventTakesPlace> {

    @ManyToOne
    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "room")
    private Room room;

    @ManyToOne
    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "event")
    private Event event;

    @ManyToOne
    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "timeslot")
    private Timeslot timeslot;

    public EventTakesPlace() {

    }

    public EventTakesPlace(final Event event, final Room room,
            final Timeslot timeslot) {
        this.event = event;
        this.room = room;
        this.timeslot = timeslot;
    }

    public Room getRoom() {
        return room;
    }

    public EventTakesPlace setRoom(final Room room) {
        this.room = room;
        return this;
    }

    public Event getEvent() {
        return event;
    }

    public EventTakesPlace setEvent(final Event event) {
        this.event = event;
        return this;
    }

    public Timeslot getTimeslot() {
        return timeslot;
    }

    public void setTimeslot(final Timeslot timeslot) {
        this.timeslot = timeslot;
    }

    @Override
    public String toString() {
        return String.format("%s %s\n", getTimeslot().getNum(), getRoom()
                .getRoomId());
    }
}
