package de.fu.mi.scuttle;

import java.util.Collections;
import java.util.List;

import de.fu.mi.scuttle.domain.Configuration;
import de.fu.mi.scuttle.domain.DbConfig;
import de.fu.mi.scuttle.domain.User;
import de.fu.mi.scuttle.lib.ScuttleConfiguration;
import de.fu.mi.scuttle.lib.ScuttleIndexHtml;
import de.fu.mi.scuttle.lib.ScuttleMeta;
import de.fu.mi.scuttle.lib.ScuttleUser;
import de.fu.mi.scuttle.lib.persistence.EntityManager;

public class ScuttleConfig implements ScuttleMeta {

	private static final boolean DEBUG = true;
	
	/**
	 * The start page which {@link ScuttleIndexHtml} will redirect to if no
	 * specific target is given.
	 */
	private static final String FIRST_PAGE = "/modulVW/moduleListe:allModule";

	/**
	 * The date of this Scuttle release. Please do not edit this manually, it is
	 * set by the release script.
	 * 
	 * @since 2013-11-09
	 */
	private static final String RELEASE_DATE = "Tue Nov 19 02:29:12 CET 2013";

	/**
	 * The Scuttle Version. Please do not edit this manually, it is set by the
	 * release script.
	 * 
	 * @since 2013-11-09
	 */
	private static final String VERSION = "0.6";

	public boolean isDebugBuild() {
		return DEBUG;
	}
	
	@Override
	public String getReleaseDate() {
		return RELEASE_DATE;
	}

	@Override
	public String getVersion() {
		return VERSION;
	}

	@Override
	public String getFirstPage() {
		return FIRST_PAGE;
	}

	@Override
	public ScuttleConfiguration getConfiguration(EntityManager em, String key) {
		final Configuration config = em
				.createNamedQuery(Configuration.Q_GET_CONFIG_VALUE,
						Configuration.class).setParameter("key", key)
				.getSingleResult();
		return config;
	}

	@Override
	public List<? extends ScuttleConfiguration> getConfiguration(
			EntityManager db) {
		// TODO: This is a quick and dirty hack. But maybe we do not need the
		// configuration from the database in MVS.
		return Collections.emptyList(); // db.findAll(Configuration.class);
	}

	@Override
	public ScuttleUser getUserWithPrivileges(EntityManager em, String loginName) {
		final User user = em
				.createNamedQuery(User.Q_WITH_PRIVILEGES_BY_LOGIN_NAME,
						User.class).setParameter("name", loginName)
				.getSingleResult();

		return user;
	}

	@Override
	public ScuttleUser getUser(EntityManager em, String loginName) {
		final User user = em.createNamedQuery(User.Q_BY_LOGIN_NAME, User.class)
				.setParameter("name", loginName).getSingleResult();

		return user;
	}

	@Override
	public void setConfiguration(EntityManager em, String key, String value) {
		em.persist(new Configuration("db-version", DbConfig.DB_VERSION));
	}

	@Override
	public void createUser(EntityManager db, String loginName, String role,
			String password) {
		new User(loginName, role, password).persist(db);
	}

}
