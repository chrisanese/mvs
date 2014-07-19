package de.fu.mi.scuttle.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Cacheable;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "timeslot")
@Cacheable(true)
public class Timeslot implements Comparable<Timeslot> {

    @ManyToOne
    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "day",
        nullable = false)
    private Day day;

    @Column(
        name = DbConfig.COLUMN_PREFIX + "num",
        nullable = false)
    private int num;

    @Id
    @Column(
        name = DbConfig.COLUMN_PREFIX + "index",
        nullable = false)
    private int index;

    @Column(
        name = DbConfig.COLUMN_PREFIX + "begin",
        nullable = false)
    private short begin;

    @Column(
        name = DbConfig.COLUMN_PREFIX + "end",
        nullable = false)
    private short end;

    @Column(
        name = DbConfig.COLUMN_PREFIX + "is_visible",
        nullable = false)
    private boolean isVisible = true;

    @OneToMany
    private List<EventTakesPlace> events = new ArrayList<EventTakesPlace>();

    public Timeslot() {

    }

    public Timeslot(final Day day, final int h, final short begin,
            final short end) {
        setDay(day);
        setIndex(h);
        setBegin(begin);
        setEnd(end);
    }

    public Timeslot(final Day day, final int h, final short begin,
            final short end, final int num) {
        setDay(day);
        setIndex(h);
        setBegin(begin);
        setEnd(end);
        setNum(num);
    }

    public Timeslot(final Day day, final int h, final short begin,
            final short end, final int num, final boolean isVisible) {
        setDay(day);
        setIndex(h);
        setBegin(begin);
        setEnd(end);
        setNum(num);
        setIsVisible(isVisible);
    }

    public int getIndex() {
        return index;
    }

    public Timeslot setIndex(final int index) {
        this.index = index;
        return this;
    }

    public Day getDay() {
        return day;
    }

    public Timeslot setDay(final Day day) {
        this.day = day;
        return this;
    }

    public short getBegin() {
        return begin;
    }

    public Timeslot setBegin(final short begin) {
        this.begin = begin;
        return this;
    }

    public short getEnd() {
        return end;
    }

    public Timeslot setEnd(final short end) {
        this.end = end;
        return this;
    }

    public int getNum() {
        return num;
    }

    public void setNum(final int num) {
        this.num = num;
    }

    public List<EventTakesPlace> getEvents() {
        return events;
    }

    public void setEvents(final List<EventTakesPlace> events) {
        this.events = events;
    }

    public boolean getIsVisible() {
        return isVisible;
    }

    public void setIsVisible(final boolean isVisible) {
        this.isVisible = isVisible;
    }

    @Override
    public int compareTo(final Timeslot o) {
        return Integer.compare(this.index, o.index);
    }

}
