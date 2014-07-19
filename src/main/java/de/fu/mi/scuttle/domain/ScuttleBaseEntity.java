package de.fu.mi.scuttle.domain;

import javax.persistence.Column;
import javax.persistence.MappedSuperclass;

import de.fu.mi.scuttle.lib.persistence.CreationTimeEntity;
import de.fu.mi.scuttle.lib.persistence.EntityManager;
import de.fu.mi.scuttle.lib.persistence.LastModificationTimeEntity;

@MappedSuperclass
public class ScuttleBaseEntity<T extends ScuttleBaseEntity<T>> implements
        CreationTimeEntity<T>,
        LastModificationTimeEntity<T> {

    @Column(
        name = DbConfig.CREATION_TIME_COLUMN,
        nullable = false)
    protected long creationTime;

    @Column(
        name = DbConfig.LAST_MODIFICATION_TIME_COLUMN,
        nullable = false)
    protected long lastModificationTime;

    @Override
    public long getCreationTime() {
        return creationTime;
    }

    @SuppressWarnings("unchecked")
    @Override
    public T setCreationTime(long time) {
        this.creationTime = time;
        return (T) this;
    }

    @Override
    public long getLastModificationTime() {
        return lastModificationTime;
    }

    @SuppressWarnings("unchecked")
    @Override
    public T setLastModificationTime(long time) {
        this.lastModificationTime = time;
        return (T) this;
    }

    public void persist(EntityManager em) {
        em.persist(this);
    }
}
