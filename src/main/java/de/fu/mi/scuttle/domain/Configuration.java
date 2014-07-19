package de.fu.mi.scuttle.domain;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import de.fu.mi.scuttle.lib.ScuttleConfiguration;

@Entity
@Table(
    name = DbConfig.TABLE_PREFIX + "configuration")
@NamedQueries({
        @NamedQuery(
            name = Configuration.Q_GET_CONFIG_VALUE,
            query = "SELECT c FROM Configuration c WHERE c.key = :key"),
        @NamedQuery(
            name = Configuration.Q_ALL_SORTED_BY_KEY,
            query = "SELECT c FROM Configuration c ORDER BY c.key"
        )
})
public class Configuration extends ScuttleBaseEntity<Configuration> implements
        Comparable<Configuration>, ScuttleConfiguration {

    public final static String Q_GET_CONFIG_VALUE = "Configuration.getConfigValue";
    public final static String Q_ALL_SORTED_BY_KEY = "Configuration.allSortedByKey";

    @Id
    @Size(
        max = 40)
    @NotNull
    @Column(
        nullable = false,
        name = DbConfig.COLUMN_PREFIX + "key",
        length = 40)
    private String key;

    @Size(
        max = DbConfig.NAME_LENGTH)
    @NotNull
    @Column(
        nullable = false,
        name = DbConfig.COLUMN_PREFIX + "value",
        length = DbConfig.NAME_LENGTH)
    private String value;

    @Size(
        max = DbConfig.DATA_LENGTH)
    @Column(
        nullable = true,
        name = DbConfig.COLUMN_PREFIX + "comment",
        length = DbConfig.DATA_LENGTH)
    private String comment;

    public Configuration() {
    }

    public Configuration(final String key, final String value) {
        this.setKey(key);
        this.setValue(value);
    }

    public Configuration(final String key, final String value,
            final String comment) {
        this.setKey(key);
        this.setValue(value);
        this.setComment(comment);
    }

    @Override
    public String getKey() {
        return key;
    }

    @Override
    public Configuration setKey(final String key) {
        this.key = key;
        return this;
    }

    @Override
    public String getValue() {
        return value;
    }

    @Override
    public Configuration setValue(final String value) {
        this.value = value;
        return this;
    }

    @Override
    public String getComment() {
        return comment;
    }

    @Override
    public Configuration setComment(final String comment) {
        this.comment = comment;
        return this;
    }

    @Override
    public int compareTo(final Configuration o) {
        return key.compareTo(o.key);
    }

}
