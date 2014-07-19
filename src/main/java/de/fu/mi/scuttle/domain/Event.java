package de.fu.mi.scuttle.domain;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "event")
public class Event extends ScuttleEntity<Event> {

    @ManyToOne
    @JoinColumn(
        name = DbConfig.FOREIGN_KEY_PREFIX + "academic_term")
    private AcademicTerm academicTerm;

    @NotNull
    @Column(name = DbConfig.COLUMN_PREFIX + "name", nullable = false)
    private String name;

    @OneToMany(mappedBy = "event")
    private List<EventTakesPlace> takesPlaceAt = new ArrayList<EventTakesPlace>();

    public Event() {
    }

    public Event(final String name) {
        this.name = name;
    }

    public AcademicTerm getAcademicTerm() {
        return academicTerm;
    }

    public Event setAcademicTerm(final AcademicTerm academicTerm) {
        this.academicTerm = academicTerm;
        return this;
    }

    public String getName() {
        return name;
    }

    public Event setName(final String name) {
        this.name = name;
        return this;
    }
}