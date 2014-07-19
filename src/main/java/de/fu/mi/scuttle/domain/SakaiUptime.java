package de.fu.mi.scuttle.domain;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = DbConfig.TABLE_PREFIX + "sakai_uptime")
public class SakaiUptime {

    @Id
    @Temporal(TemporalType.TIMESTAMP)
    private Date time;

    @Column(name = DbConfig.COLUMN_PREFIX + "up")
    private boolean up;

    public SakaiUptime() {
        // JPA requires the default constructor to be available.
    }

    public SakaiUptime(final boolean up) {
        this.time = new Date(System.currentTimeMillis());
        this.up = up;
    }

    public SakaiUptime(final Date time, final boolean up) {
        this.time = time;
        this.up = up;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(final Date time) {
        this.time = time;
    }

    public boolean isUp() {
        return up;
    }

    public void setUp(final boolean up) {
        this.up = up;
    }
}
