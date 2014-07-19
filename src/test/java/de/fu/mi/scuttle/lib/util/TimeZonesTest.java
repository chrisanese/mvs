package de.fu.mi.scuttle.lib.util;

import org.junit.Assert;
import org.junit.Test;

import de.fu.mi.scuttle.lib.util.TimeZones;

public class TimeZonesTest {

    @Test
    public void testCEST_long() {
        Assert.assertNotNull(TimeZones.forID("Central European Summer Time"));
    }

    @Test
    public void testCET_long() {
        Assert.assertNotNull(TimeZones.forID("Central European Time"));
    }

    @Test
    public void testAKST() {
        Assert.assertNotNull(TimeZones.AKST);
    }

    @Test
    public void testCEST() {
        Assert.assertNotNull(TimeZones.CEST);
    }

    @Test
    public void testCET() {
        Assert.assertNotNull(TimeZones.CET);
    }

    @Test
    public void testCST() {
        Assert.assertNotNull(TimeZones.CST);
    }

    @Test
    public void testEET() {
        Assert.assertNotNull(TimeZones.EET);
    }

    @Test
    public void testEST() {
        Assert.assertNotNull(TimeZones.EST);
    }

    @Test
    public void testGMT() {
        Assert.assertNotNull(TimeZones.GMT);
    }

    @Test
    public void testHST() {
        Assert.assertNotNull(TimeZones.HST);
    }

    @Test
    public void testMST() {
        Assert.assertNotNull(TimeZones.MST);
    }

    @Test
    public void testPST() {
        Assert.assertNotNull(TimeZones.PST);
    }

    @Test
    public void testUTC() {
        Assert.assertNotNull(TimeZones.UTC);
    }

    @Test
    public void testWT() {
        Assert.assertNotNull(TimeZones.WET);
    }
}
