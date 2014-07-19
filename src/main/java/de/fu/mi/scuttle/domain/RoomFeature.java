package de.fu.mi.scuttle.domain;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

/**
 * A RoomFeature is an object such as a board or an overhead projector. An
 * instance of a RoomFeature is itself a template. A room is associated with a
 * feature or with a number of features (such as two overhead projectors) via
 * {@link RoomHasFeature}.
 * 
 * @author Julian Fleischer
 * @since 2013-09-15
 */
@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "room_feature")
@NamedQueries({
        @NamedQuery(
            name = RoomFeature.Q_COUNT,
            query = "SELECT count(f) FROM RoomFeature f")
})
public class RoomFeature extends ScuttleEntity<RoomFeature> {

    public static final String Q_COUNT = "RoomFeature.count";

    @NotNull
    @Size(
        min = 1,
        max = DbConfig.NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "name",
        nullable = false,
        length = DbConfig.NAME_LENGTH)
    private String name;

    @OneToMany(
        mappedBy = "feature")
    private List<RoomHasFeature> hasFeatures;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public List<RoomHasFeature> getHasFeatures() {
        return hasFeatures;
    }

    public void setHasFeatures(List<RoomHasFeature> hasFeatures) {
        this.hasFeatures = hasFeatures;
    }
}
