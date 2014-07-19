package de.fu.mi.scuttle.domain;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

import de.fu.mi.scuttle.domain.RoomHasFeature.Primary;

/**
 * Associates a {@link Room} with a {@link RoomFeature}. A Room can have a
 * specific {@link #getAmount() amount} of RoomFeatures, which defaults to one
 * (Example: A Room can be associated with the feature overhead projector and it
 * can have two overhead projectors, thus the amount would be two but there is
 * only one entry in {@link RoomHasFeature}.
 * 
 * @author Julian Fleischer
 * @since 2013-09-15
 */
@Entity
@Table(
    name = DbConfig.JOIN_TABLE_PREFIX + "room_has_feature")
@IdClass(
    value = Primary.class)
public class RoomHasFeature {

    public static class Primary implements Serializable {

        private static final long serialVersionUID = -7124652475690443649L;
        private Long room;
        private Long feature;

        public Long getRoom() {
            return room;
        }

        public void setRoom(Long room) {
            this.room = room;
        }

        public Long getFeature() {
            return feature;
        }

        public void setFeature(Long feature) {
            this.feature = feature;
        }

        @Override
        public int hashCode() {
            final int prime = 31;
            int result = 1;
            result = prime * result
                    + ((feature == null) ? 0 : feature.hashCode());
            result = prime * result + ((room == null) ? 0 : room.hashCode());
            return result;
        }

        @Override
        public boolean equals(Object obj) {
            if (this == obj) {
                return true;
            }
            if (obj instanceof Primary) {
                Primary p = (Primary) obj;
                return p.room == this.room && p.feature == this.feature;
            }
            return false;
        }
    }

    @Id
    @ManyToOne
    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "room")
    private Room room;

    @Id
    @ManyToOne
    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "feature")
    private RoomFeature feature;

    @NotNull
    @Column(
        nullable = false,
        name = DbConfig.COLUMN_PREFIX + "amount")
    private int amount = 1;

    public Room getRoom() {
        return room;
    }

    public void setRoom(Room room) {
        this.room = room;
    }

    public RoomFeature getFeature() {
        return feature;
    }

    public void setFeature(RoomFeature feature) {
        this.feature = feature;
    }

    public int getAmount() {
        return amount;
    }

    public void setAmount(int amount) {
        this.amount = amount;
    }
}
