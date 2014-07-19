package de.fu.mi.scuttle.domain;

import java.util.HashSet;
import java.util.Set;

import javax.persistence.CollectionTable;
import javax.persistence.Column;
import javax.persistence.ElementCollection;
import javax.persistence.Embedded;
import javax.persistence.Entity;
import javax.persistence.JoinColumn;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.Table;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import de.fu.mi.scuttle.domain.misc.Password;
import de.fu.mi.scuttle.lib.ScuttlePassword;
import de.fu.mi.scuttle.lib.ScuttleUser;

@Entity
@Table(name = DbConfig.TABLE_PREFIX + "user")
@NamedQueries({
		@NamedQuery(name = User.Q_COUNT, query = "SELECT count(u) FROM User u"),
		@NamedQuery(name = User.Q_WITH_PRIVILEGES, query = "SELECT DISTINCT u FROM User u LEFT JOIN FETCH u.privileges"),
		@NamedQuery(name = User.Q_WITH_PRIVILEGES_BY_LOGIN_NAME, query = "SELECT DISTINCT u FROM User u LEFT JOIN FETCH u.privileges WHERE u.userLoginId = :name"),
		@NamedQuery(name = User.Q_BY_LOGIN_NAME, query = "SELECT u FROM User u WHERE u.userLoginId = :name") })
public class User extends ScuttleEntity<User> implements ScuttleUser {

	public static final String Q_COUNT = "User.count";
	public static final String Q_WITH_PRIVILEGES = "User.withPrivileges";
	public static final String Q_WITH_PRIVILEGES_BY_LOGIN_NAME = "User.withPrivilegesByLoginName";
	public static final String Q_BY_LOGIN_NAME = "User.byLoginName";

	@NotNull
	@Size(min = 1, max = DbConfig.STRING_ID_LENGTH)
	@Column(name = DbConfig.COLUMN_PREFIX + "user_login_id", nullable = false)
	private String userLoginId;

	@NotNull
	@ElementCollection
	@CollectionTable(name = DbConfig.TABLE_PREFIX + "user_privileges", joinColumns = { @JoinColumn(name = DbConfig.FOREIGN_KEY_PREFIX
			+ "user") })
	@Column(name = DbConfig.COLUMN_PREFIX + "privilege", nullable = false, length = DbConfig.PRIVILEGE_LENGTH)
	private Set<String> privileges = new HashSet<>();

	@Column(name = DbConfig.COLUMN_PREFIX + "role", nullable = false)
	private String role = "";

	@Embedded
	private Password password = new Password();

	public User() {

	}

	public User(String userLoginId) {
		setUserLoginId(userLoginId);
	}

	public User(String userLoginId, String role) {
		setUserLoginId(userLoginId);
		setRole(role);
	}

	/**
	 * 
	 * @param userLoginId
	 *            The login name of the user.
	 * @param role
	 *            The role of the user.
	 * @param password
	 *            The password of the user.
	 */
	public User(String userLoginId, String role, String password) {
		setUserLoginId(userLoginId);
		setRole(role);
		getPassword().set(password);
	}

	@Override
	public String getUserLoginId() {
		return userLoginId;
	}

	@Override
	public User setUserLoginId(String userLoginId) {
		this.userLoginId = userLoginId;
		return this;
	}

	@Override
	public Password getPassword() {
		return password;
	}

	@Override
	public void setPassword(ScuttlePassword password) {
		if (password instanceof Password) {
			this.password = (Password) password;
		} else {
			throw new UnsupportedOperationException();
		}
	}

	@Override
	public String getRole() {
		return role;
	}

	@Override
	public User setRole(String role) {
		this.role = role;
		return this;
	}

	@Override
	public Set<String> getPrivileges() {
		return privileges;
	}

	@Override
	public User setPrivileges(Set<String> privileges) {
		this.privileges = privileges;
		return this;
	}

	@Override
	public User addPrivilege(String privilege) {
		this.privileges.add(privilege);
		return this;
	}
}
