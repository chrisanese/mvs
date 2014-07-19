package de.fu.mi.scuttle.domain.misc;

import java.security.SecureRandom;

import javax.persistence.Column;
import javax.persistence.Embeddable;

import org.apache.commons.codec.digest.DigestUtils;

import com.google.common.base.Charsets;

import de.fu.mi.scuttle.domain.DbConfig;
import de.fu.mi.scuttle.lib.ScuttlePassword;

/**
 * Passwords that are stored as a hash/salt pair.
 * 
 * The current implementation uses a SHA-256 hash and a salt of 32 bytes length.
 * 
 * @author Julian Fleischer
 * @since 2012-10-24
 */
@Embeddable
public class Password implements ScuttlePassword {

    @Column(
        name = DbConfig.COLUMN_PREFIX + "pw_hash",
        length = 64)
    private String hash;

    @Column(
        name = DbConfig.COLUMN_PREFIX + "pw_salt",
        length = 32)
    private String salt;

    /**
     * Set a new password.
     * 
     * A salt is automatically generated using {@link SecureRandom}, only the
     * hash value and the salt value are stored. The salt is a 32 byte ASCII
     * string.
     * 
     * @param password
     *            The plain text password.
     * @return This (fluent interface)
     */
    @Override
    public Password set(String password) {
        SecureRandom random = new SecureRandom();
        byte[] bytes = new byte[32];
        random.nextBytes(bytes);
        for (int i = 0; i < bytes.length; i++) {
            bytes[i] = (byte) Math.abs(bytes[i]);
            bytes[i] %= 94;
            bytes[i] += 33;
        }
        String salt = new String(bytes, Charsets.US_ASCII);
        String saltedPassword = password + salt;
        String hash = DigestUtils.sha256Hex(saltedPassword
                .getBytes(Charsets.UTF_8));

        this.hash = hash;
        this.salt = salt;
        return this;
    }

    @Override
    public boolean check(String password) {
        String saltedPassword = password + this.salt;
        String hash = DigestUtils.sha256Hex(saltedPassword
                .getBytes(Charsets.UTF_8));

        return hash.equals(this.hash);
    }
}
