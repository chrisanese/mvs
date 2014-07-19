package de.fu.mi.scuttle.domain;

import javax.persistence.Column;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotNull;

import org.eclipse.persistence.annotations.Index;

import de.fu.mi.scuttle.lib.persistence.UuidEntity;

@MappedSuperclass
public class ScuttleEntity<T extends ScuttleEntity<T>> extends
        ScuttleBaseEntity<T> implements UuidEntity<T> {

    @Id
    @GeneratedValue(
        strategy = GenerationType.IDENTITY)
    @Column(
        name = DbConfig.ID_COLUMN,
        nullable = false)
    protected long id;

    @NotNull
    @Column(
        name = DbConfig.UUID_COLUMN,
        nullable = false,
        length = 36)
    @Index
    protected String uuid;

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }

    @Override
    public String getUuid() {
        return uuid;
    }

    @SuppressWarnings("unchecked")
    @Override
    public T setUuid(String uuid) {
        this.uuid = uuid;
        return (T) this;
    }
}
