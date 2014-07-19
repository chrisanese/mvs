package de.fu.mi.scuttle.lib.util.concurrent;

import java.util.concurrent.BlockingQueue;
import java.util.concurrent.LinkedBlockingQueue;
import java.util.concurrent.TimeUnit;

import org.junit.Assert;
import org.junit.Test;

import de.fu.mi.scuttle.lib.util.concurrent.AbstractJob;
import de.fu.mi.scuttle.lib.util.concurrent.JobQueue;

public class JobQueueTest {

    final JobQueue q = new JobQueue();

    final BlockingQueue<Integer> r = new LinkedBlockingQueue<>();

    void report(final int i) {
        System.out.println(i);
        r.add(i);
    }

    @Test()
    public void test() throws InterruptedException {

        q.start();

        q.submit(new AbstractJob("A test job.") {
            @Override
            public void execute() throws Exception {
                report(1);
            }
        }, 1, TimeUnit.SECONDS);

        q.submit(new AbstractJob("A test job.") {
            @Override
            public void execute() throws Exception {
                report(0);
            }
        });

        q.submit(new AbstractJob("A test job.") {
            @Override
            public void execute() throws Exception {
                report(2);
            }
        }, 2, TimeUnit.SECONDS);

        Thread.sleep(1000);

        q.submit(new AbstractJob("A test job.") {
            @Override
            public void execute() throws Exception {
                report(4);
            }
        }, 4, TimeUnit.SECONDS);

        final AbstractJob job = new AbstractJob("A test job.") {
            @Override
            public void execute() throws Exception {
                report(4711);
            }
        };
        q.submit(job, 3, TimeUnit.SECONDS);

        q.submit(new AbstractJob("A test job.") {
            @Override
            public void execute() throws Exception {
                report(3);
                q.cancel(job);
            }
        }, 2, TimeUnit.SECONDS);

        q.waitStop();

        Assert.assertEquals(true, q.isStopped());
        Assert.assertEquals(false, q.isStarted());

        Assert.assertArrayEquals(new Object[] {
                0, 1, 2, 3, 4
        }, r.toArray());
    }
}
