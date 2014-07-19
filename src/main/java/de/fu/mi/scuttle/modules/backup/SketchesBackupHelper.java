package de.fu.mi.scuttle.modules.backup;

import de.fu.mi.scuttle.domain.Building;
import de.fu.mi.scuttle.domain.BuildingFloor;
import de.fu.mi.scuttle.domain.BuildingFloorAnyFeature;
import de.fu.mi.scuttle.domain.Room;
import de.fu.mi.scuttle.domain.RoomAnyFeature;

/**
 * 
 * @author Julian Fleischer
 * @since 2013-10-26
 */
public class SketchesBackupHelper extends AbstractBackupHelper {

    public SketchesBackupHelper() {
        super();
        add("buildings", Building.class);
        add("buildingFloors", BuildingFloor.class);
        add("buildingFloorsAnyFeatures", BuildingFloorAnyFeature.class);
        add("rooms", Room.class);
        add("roomAnyFeatures", RoomAnyFeature.class);
    }

}
