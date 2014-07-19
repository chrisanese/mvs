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
@Table(name="modulverwaltung1_users")
public class UsersEntity {
	
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	@Column(name="uu_id")
	@Id
	private long id;
	
	@Column(name="u_name")
	private String uname;
	
	@Column(name="u_pwd")
	private String pwd;
	
	@OneToMany(mappedBy="user", targetEntity=UserRolesEntity.class, fetch=FetchType.LAZY)
	List<UserRolesEntity> roles;

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getUname() {
		return uname;
	}

	public void setUname(String uname) {
		this.uname = uname;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {		
		this.pwd = BCrypt.hashpw(pwd, BCrypt.gensalt());
	}
	
	public boolean checkPwd(String pwd){
		System.out.println(pwd+ " encrypted"+getPwd());
		return BCrypt.checkpw(pwd, getPwd());
	}

	public List<UserRolesEntity> getRoles() {
		return roles;
	}

	public void setRoles(List<UserRolesEntity> roles) {
		this.roles = roles;
	}
}
