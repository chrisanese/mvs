package de.fu.mi.scuttle.modules;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import com.google.common.base.Splitter;
import com.google.common.collect.Iterators;

import de.fu.mi.scuttle.domain.Event;
import de.fu.mi.scuttle.domain.EventTakesPlace;
import de.fu.mi.scuttle.domain.Room;
import de.fu.mi.scuttle.domain.Timeslot;
import de.fu.mi.scuttle.lib.persistence.EntityManager;
import de.fu.mi.scuttle.lib.web.AbstractScuttleModule;
import de.fu.mi.scuttle.lib.web.JSONResponse;
import de.fu.mi.scuttle.lib.web.MountPoint;
import de.fu.mi.scuttle.lib.web.ScuttleRequest;
import de.fu.mi.scuttle.lib.web.ScuttleResponse;
import de.fu.mi.scuttle.lib.web.ScuttleServlet;

@MountPoint("events2")
public class Events2 extends AbstractScuttleModule<ScuttleServlet> {

    public Events2(final ScuttleServlet parent) {
        super(parent);
    }

    private static void parseData(final EntityManager em, final String data) {

        final List<Timeslot> slots = em.findAll(Timeslot.class);

        final Map<String, List<Timeslot>> allSlots = new HashMap<>();

        for (final Timeslot slot : slots) {
            final String dayName = slot.getDay().getName();
            if (!allSlots.containsKey(dayName)) {
                allSlots.put(dayName, new ArrayList<Timeslot>());
            }
            allSlots.get(dayName).add(slot);
        }

        final Splitter lineSplitter = Splitter.on('\n');
        final Splitter wsSplitter = Splitter.on(' ');

        final Iterator<String> nextLine = lineSplitter.split(data).iterator();

        while (nextLine.hasNext()) {

            final String eventName = nextLine.next().trim();
            if (eventName.isEmpty()) {
                break;
            }
            final String room = nextLine.next().trim();
            final String dayName = nextLine.next().trim();
            final String timeslots = nextLine.next().trim();

            final List<String> all = new ArrayList<>();
            Iterators.addAll(all, wsSplitter.split(timeslots).iterator());

            final Room r = em.find(Room.class, Long.parseLong(room));

            final Event e = new Event(eventName);
            em.persist(e);

            final List<Timeslot> daySlots = allSlots.get(dayName);
            for (final String timeslot : all) {

                for (final Timeslot s : daySlots) {
                    if (Integer.toString(s.getNum()).equals(timeslot)) {

                        final EventTakesPlace p = new EventTakesPlace(e, r, s);
                        em.persist(p);
                        break;
                    }
                }

            }
        }

    }

    @Override
    public ScuttleResponse handle(final ScuttleRequest request)
            throws Exception {

        System.out.println("SERVING EVENTS");

        if (!request.isNull("textdata")) {
            System.out.println("GOT REQUEST");

            final String data = request.get("textdata");
            parseData(db(), data);
        }

        return new JSONResponse();
    }

}
