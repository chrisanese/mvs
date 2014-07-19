package de.fu.mi.scuttle.domain;

import java.util.ArrayList;
import java.util.List;

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
    name = DbConfig.TABLE_PREFIX + "academic_term")
@NamedQueries({
        @NamedQuery(
            name = AcademicTerm.Q_COUNT,
            query = "SELECT count(t) FROM AcademicTerm t"),
})
public class AcademicTerm extends ScuttleEntity<AcademicTerm> {

    public static final String Q_COUNT = "AcademicTerm.count";

    @NotNull
    @Size(
        min = 1,
        max = DbConfig.NAME_LENGTH)
    @Column(
        name = DbConfig.COLUMN_PREFIX + "name",
        nullable = false,
        length = DbConfig.NAME_LENGTH)
    private String name;

    @OneToMany(mappedBy = "academicTerm")
    private List<Event> events = new ArrayList<>();

    public String getName() {
        return name;
    }

    public AcademicTerm setName(String name) {
        this.name = name;
        return this;
    }

    public List<Event> getEvents() {
        return events;
    }

    public AcademicTerm setEvents(List<Event> events) {
        this.events = events;
        return this;
    }

    public AcademicTerm addEvent(Event event) {
        this.events.add(event);
        return this;
    }
}
