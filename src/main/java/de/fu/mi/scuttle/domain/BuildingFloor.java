package de.fu.mi.scuttle.domain;

import java.util.ArrayList;
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

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "building_floor",
    uniqueConstraints = {
            @UniqueConstraint(
                columnNames = {
                        DbConfig.COLUMN_PREFIX + "name",
                        DbConfig.FOREIGN_KEY_PREFIX + "building" }) })
@NamedQueries({
        @NamedQuery(
            name = BuildingFloor.Q_COUNT,
            query = "SELECT count(f) FROM BuildingFloor f"),
        @NamedQuery(
            name = BuildingFloor.Q_EVENTS,
            query = "SELECT DISTINCT tp FROM BuildingFloor f LEFT JOIN f.rooms r JOIN r.eventTakesPlace tp JOIN tp.event e WHERE f.id = :buildingFloor")
})
public class BuildingFloor extends ScuttleEntity<BuildingFloor> {

    public static final String Q_COUNT = "BuildingFloor.count";
    public static final String Q_EVENTS = "BuildingFloor.events";

    @NotNull
    @Size(
        min = 1,
        max = DbConfig.NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "name",
        nullable = false,
        length = DbConfig.NAME_LENGTH)
    private String name;

    @NotNull
    @ManyToOne(
        optional = false)
    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "building")
    private Building building;

    @OneToMany(
        mappedBy = "buildingFloor",
        cascade = { CascadeType.REMOVE })
    private List<Room> rooms = new ArrayList<>();

    @OneToMany(
        mappedBy = "buildingFloor",
        cascade = { CascadeType.REMOVE })
    private List<BuildingFloorAnyFeature> anyFeatures = new ArrayList<>();

    public BuildingFloor() {

    }

    public BuildingFloor(final Building building, final String name) {
        setBuilding(building);
        setName(name);
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public Building getBuilding() {
        return building;
    }

    public BuildingFloor setBuilding(final Building building) {
        this.building = building;
        return this;
    }

    public List<Room> getRooms() {
        return rooms;
    }

    public BuildingFloor setRooms(final List<Room> rooms) {
        this.rooms = rooms;
        return this;
    }

    public BuildingFloor addRoom(final Room room) {
        this.rooms.add(room);
        return this;
    }

    public List<BuildingFloorAnyFeature> getAnyFeatures() {
        return anyFeatures;
    }

    public BuildingFloor setAnyFeatures(
            final List<BuildingFloorAnyFeature> anyFeatures) {
        this.anyFeatures = anyFeatures;
        return this;
    }

    public BuildingFloor addAnyFeature(final BuildingFloorAnyFeature anyFeature) {
        this.anyFeatures.add(anyFeature);
        return this;
    }
}
