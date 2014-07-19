package de.fu.mi.scuttle.domain.modulVW;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_user_roles")
public class UserRolesEntity {

	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ur_id")
	@Id
	private long id;
	
	@Column(name="uu_id")
	private long uuid;
	
	@Column(name="ro_id")
	private long ro_id;
	
	@ManyToOne(optional=false)
	@JoinColumn(name="uu_id",referencedColumnName="uu_id", insertable=false, updatable=false)
	private UsersEntity user;

	@ManyToOne(optional=false)
	@JoinColumn(name="ro_id",referencedColumnName="ro_id", insertable=false, updatable=false)
	private RolesEntity role;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getUuid() {
		return uuid;
	}

	public void setUuid(long uuid) {
		this.uuid = uuid;
	}

	public long getRo_id() {
		return ro_id;
	}

	public void setRo_id(long ro_id) {
		this.ro_id = ro_id;
	}
	public UsersEntity getUser() {
		return user;
	}

	public void setUser(UsersEntity user) {
		this.user = user;
	}

	public RolesEntity getRole() {
		return role;
	}

	public void setRole(RolesEntity role) {
		this.role = role;
	}
	
}
