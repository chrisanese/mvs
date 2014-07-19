package de.fu.mi.scuttle.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "day")
@NamedQueries({
        @NamedQuery(
            name = Day.Q_FIND_ALL_WITH_TIMESLOTS,
            query = "SELECT DISTINCT d FROM Day d LEFT JOIN FETCH d.timeslots ORDER BY d.index")
})
public class Day implements Comparable<Day> {

    public static final String Q_FIND_ALL_WITH_TIMESLOTS = "Day.findAll";

    @Column(
        name = DbConfig.COLUMN_PREFIX + "name")
    private String name;

    @Id
    @Column(
        name = DbConfig.COLUMN_PREFIX + "index",
        nullable = false)
    private int index;

    @OneToMany(
        mappedBy = "day",
        cascade = CascadeType.ALL)
    private List<Timeslot> timeslots = new ArrayList<>();

    public Day() {

    }

    public Day(final int index, final String name) {
        setIndex(index);
        setName(name);
    }

    public String getName() {
        return name;
    }

    public Day setName(final String name) {
        this.name = name;
        return this;
    }

    public List<Timeslot> getTimeslots() {
        return timeslots;
    }

    public Day setTimeslots(final List<Timeslot> timeslots) {
        this.timeslots = timeslots;
        return this;
    }

    public Day addTimeslot(final Timeslot timeslot) {
        this.timeslots.add(timeslot);
        return this;
    }

    public int getIndex() {
        return index;
    }

    public Day setIndex(final int index) {
        this.index = index;
        return this;
    }

    @Override
    public int compareTo(final Day o) {
        return Integer.compare(this.getIndex(), o.getIndex());
    }

}
