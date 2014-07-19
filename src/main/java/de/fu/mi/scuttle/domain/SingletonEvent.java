package de.fu.mi.scuttle.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "singleton_event")
public class SingletonEvent extends ScuttleEntity<SingletonEvent> {

    @ManyToOne
    @JoinColumn(name = DbConfig.JOIN_TABLE_PREFIX + "academic_term")
    private AcademicTerm academicTerm;

    @NotNull
    @Column(name = DbConfig.COLUMN_PREFIX + "name", nullable = false)
    private String name;

    @NotNull
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = DbConfig.COLUMN_PREFIX + "start_time", nullable = false)
    private Date startTime;

    @NotNull
    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = DbConfig.COLUMN_PREFIX + "end", nullable = false)
    private Date endTime;

    public SingletonEvent() {

    }

    public SingletonEvent(final Date start, final Date end) {
        this.startTime = start;
        this.endTime = end;
    }

    public SingletonEvent(final Date start, final Date end, final String name) {
        this.startTime = start;
        this.endTime = end;
        this.name = name;
    }

    public AcademicTerm getAcademicTerm() {
        return academicTerm;
    }

    public void setAcademicTerm(final AcademicTerm academicTerm) {
        this.academicTerm = academicTerm;
    }

    public String getName() {
        return name;
    }

    public void setName(final String name) {
        this.name = name;
    }

    public Date getStartTime() {
        return startTime;
    }

    public void setStartTime(final Date startTime) {
        this.startTime = startTime;
    }

    public Date getEndTime() {
        return endTime;
    }

    public void setEndTime(final Date endTime) {
        this.endTime = endTime;
    }

}
