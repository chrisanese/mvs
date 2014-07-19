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

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "building_floor_any_feature")
@NamedQueries({
        @NamedQuery(
            name = BuildingFloorAnyFeature.Q_COUNT,
            query = "SELECT count(f) FROM BuildingFloorAnyFeature f"),
        @NamedQuery(
            name = BuildingFloorAnyFeature.Q_FOR_FLOOR,
            query = "SELECT f FROM BuildingFloorAnyFeature f WHERE f.buildingFloor = :floor")
})
public class BuildingFloorAnyFeature extends
        ScuttleEntity<BuildingFloorAnyFeature> {

    public static final String Q_COUNT = "BuildingFloorAnyFeature.count";
    public static final String Q_FOR_FLOOR = "BuildingFloorAnyFeature.forFloor";

    @NotNull
    @Size(
        min = 1,
        max = DbConfig.FEATURE_NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "type",
        nullable = false,
        length = DbConfig.FEATURE_NAME_LENGTH)
    private String type;

    @Size(
        min = 1,
        max = DbConfig.NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "label",
        nullable = true,
        length = DbConfig.NAME_LENGTH)
    private String label;

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
        name = DbConfig.FOREIGN_KEY_PREFIX + "building_floor")
    private BuildingFloor buildingFloor;

    // JPA needs a default constructor *always*
    public BuildingFloorAnyFeature() {

    }

    public BuildingFloorAnyFeature(BuildingFloor floor, String type) {
        setBuildingFloor(floor);
        setType(type);
    }

    public BuildingFloorAnyFeature(BuildingFloor floor, String type, int x,
            int y, int a, int b) {
        setBuildingFloor(floor);
        setType(type);
        setPosX(x);
        setPosY(y);
        setWidth(a);
        setHeight(b);
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
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

    public int getWidth() {
        return width;
    }

    public void setWidth(int width) {
        this.width = width;
    }

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public String getData() {
        return data;
    }

    public void setData(String data) {
        this.data = data;
    }

    public BuildingFloor getBuildingFloor() {
        return buildingFloor;
    }

    public void setBuildingFloor(BuildingFloor buildingFloor) {
        this.buildingFloor = buildingFloor;
    }
}
