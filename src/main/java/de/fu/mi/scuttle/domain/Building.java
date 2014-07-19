package de.fu.mi.scuttle.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "building")
@NamedQueries({
        @NamedQuery(
            name = Building.Q_COUNT,
            query = "SELECT count(b) FROM Building b"),
        @NamedQuery(
            name = Building.Q_BY_UUID,
            query = "SELECT b FROM Building b WHERE b.uuid = :uuid"),
        @NamedQuery(
            name = Building.Q_BY_UUID_WITH_FLOORS,
            query = "SELECT DISTINCT b FROM Building b LEFT JOIN FETCH b.buildingFloors WHERE b.uuid = :uuid"),
        @NamedQuery(
            name = Building.Q_WITH_FLOORS,
            query = "SELECT DISTINCT b FROM Building b LEFT JOIN FETCH b.buildingFloors"),
        @NamedQuery(
            name = Building.Q_WITH_FLOORS_AND_ROOMS,
            query = "SELECT DISTINCT b FROM Building b LEFT JOIN b.buildingFloors f LEFT JOIN f.rooms r")
})
public class Building extends ScuttleEntity<Building> {

    public static final String Q_COUNT = "Buidling.count";
    public static final String Q_BY_UUID = "Building.byUuid";
    public static final String Q_BY_UUID_WITH_FLOORS = "Building.byUuidWithFloors";
    public static final String Q_WITH_FLOORS = "Building.withFloors";
    public static final String Q_WITH_FLOORS_AND_ROOMS = "Building.withFloorsAndRooms";

    @Size(
        min = 1,
        max = DbConfig.NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "name",
        nullable = true,
        length = DbConfig.NAME_LENGTH)
    private String name;

    @NotNull
    @Size(
        min = 1,
        max = DbConfig.NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "address",
        nullable = false)
    private String address;

    @Column(
        name = DbConfig.COLUMN_PREFIX + "info",
        nullable = true, length = DbConfig.DATA_LENGTH)
    private String info;

    @Column(
        name = DbConfig.COLUMN_PREFIX + "info_title",
        nullable = true)
    private String infoTitle;

    @OneToMany(
        mappedBy = "building",
        cascade = { CascadeType.REMOVE })
    private List<BuildingFloor> buildingFloors = new ArrayList<>();

    public Building() {
    }

    public Building(final String address) {
        setAddress(address);
    }

    public Building(final String address, final String name) {
        setAddress(address);
        setName(name);
    }

    public String getName() {
        return name;
    }

    public Building setName(final String name) {
        this.name = name;
        return this;
    }

    public String getAddress() {
        return address;
    }

    public Building setAddress(final String address) {
        this.address = address;
        return this;
    }

    public List<BuildingFloor> getBuildingFloors() {
        return buildingFloors;
    }

    public Building setBuildingFloors(final List<BuildingFloor> buildingFloors) {
        this.buildingFloors = buildingFloors;
        return this;
    }

    public Building addBuildingFloor(final BuildingFloor buildingFloor) {
        this.buildingFloors.add(buildingFloor);
        return this;
    }

    public String getInfo() {
        return info;
    }

    public void setInfo(final String info) {
        this.info = info;
    }

    public String getInfoTitle() {
        return infoTitle;
    }

    public void setInfoTitle(final String infoTitle) {
        this.infoTitle = infoTitle;
    }
}
