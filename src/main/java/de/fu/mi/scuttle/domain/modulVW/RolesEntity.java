package de.fu.mi.scuttle.domain.modulVW;

import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

@Entity
@Table(name="modulverwaltung1_roles")
public class RolesEntity {
	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="ro_id")
	@Id
	private long id;
	
	@Column(name="ro_name")
	private String name;
	
	@OneToMany(mappedBy="role", targetEntity=UserRolesEntity.class, fetch=FetchType.LAZY)
	List<UserRolesEntity> users;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<UserRolesEntity> getUsers() {
		return users;
	}

	public void setUsers(List<UserRolesEntity> users) {
		this.users = users;
	}
	
}
