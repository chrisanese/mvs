package de.fu.mi.scuttle.scheduler;

public class Scheduler {

    public interface EventSource {
        int getCount();

        int[] getConflictingEventsFor(int event);

        int[] getConflictingTimeslotsFor(int event);

        int[] getPreferredTimeslotsFor(int event);
    }

    public interface RoomSource {
        int getCount();
    }

    public interface TimeslotSource {
        int getCount();
    }

    @SuppressWarnings("unused")
    private final long[][] matrix;

    public Scheduler(RoomSource rooms, EventSource events,
            TimeslotSource timeslots) {
        matrix = new long[rooms.getCount()][timeslots.getCount()];
    }
}
