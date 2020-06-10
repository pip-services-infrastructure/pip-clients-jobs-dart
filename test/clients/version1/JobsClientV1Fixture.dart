import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_jobs/pip_services_jobs.dart';
import 'package:pip_clients_jobs/pip_clients_jobs.dart';

final JOB1 = NewJobV1(
    type: 't1', ref_id: 'obj_0fsd', ttl: 1000 * 60 * 60 * 3, params: null);
final JOB2 =
    NewJobV1(type: 't1', ref_id: 'obj_1fsd', ttl: 1000 * 60 * 60, params: null);
final JOB3 =
    NewJobV1(type: 't2', ref_id: 'obj_3fsd', ttl: 1000 * 60 * 30, params: null);

class JobsClientFixtureV1 {
  IJobsClientV1 _client;

  JobsClientFixtureV1(IJobsClientV1 client) {
    expect(client, isNotNull);
    _client = client;
  }

  void testCrudOperations() async {
    JobV1 job1;

    // Create the first job
    var job = await _client.addJob(null, JOB1);
    expect(job, isNotNull);
    expect(job.id, isNotNull);
    expect(JOB1.type, job.type);
    expect(JOB1.ref_id, job.ref_id);

    expect(0, job.retries);
    expect(JOB1.params, job.params);
    expect(job.created, isNotNull);
    expect(job.execute_until, isNotNull);
    expect(job.started, isNull);
    expect(job.completed, isNull);
    expect(job.locked_until, isNull);

    job1 = job;

    // Create the second job
    job = await _client.addJob(null, JOB2);
    expect(job, isNotNull);
    expect(job.id, isNotNull);
    expect(JOB2.type, job.type);
    expect(JOB2.ref_id, job.ref_id);

    expect(0, job.retries);
    expect(JOB2.params, job.params);
    expect(job.created, isNotNull);
    expect(job.execute_until, isNotNull);
    expect(job.started, isNull);
    expect(job.completed, isNull);
    expect(job.locked_until, isNull);

    // Create the third job
    job = await _client.addJob(null, JOB3);
    expect(job, isNotNull);
    expect(job.id, isNotNull);
    expect(JOB3.type, job.type);
    expect(JOB3.ref_id, job.ref_id);

    expect(0, job.retries);
    expect(JOB3.params, job.params);
    expect(job.created, isNotNull);
    expect(job.execute_until, isNotNull);
    expect(job.started, isNull);
    expect(job.completed, isNull);
    expect(job.locked_until, isNull);

    // Get one job
    job = await _client.getJobById(null, job1.id);
    expect(job, isNotNull);
    expect(job.id, job1.id);
    expect(JOB1.type, job.type);
    expect(JOB1.ref_id, job.ref_id);
    expect(job1.retries, job.retries);
    expect(JOB1.params, job.params);
    expect(job.created, isNotNull);
    expect(job.execute_until, isNotNull);
    expect(job.started, isNull);
    expect(job.completed, isNull);
    expect(job.locked_until, isNull);

    // Get all jobs
    var page = await _client.getJobs(null, FilterParams(), PagingParams());
    expect(page, isNotNull);
    expect(page.data.length, 3);

    job1 = page.data[0];

    // Delete the job
    job = await _client.deleteJobById(null, job1.id);
    expect(job, isNotNull);
    expect(job1.id, job.id);

    // Try to get deleted job
    job = await _client.getJobById(null, job1.id);
    expect(job, isNull);

    // Delete all jobs
    await _client.deleteJobs(null);

    // Try to get jobs after delete
    page = await _client.getJobs(null, FilterParams(), PagingParams());
    expect(page, isNotNull);
    expect(page.data.length, 0);
  }

  void testControl() async {
    JobV1 job1, job2;

    // Create the first job
    var job = await _client.addJob(null, JOB1);
    expect(job, isNotNull);
    expect(job.id, isNotNull);
    expect(JOB1.type, job.type);
    expect(JOB1.ref_id, job.ref_id);

    expect(0, job.retries);
    expect(JOB1.params, job.params);
    expect(job.created, isNotNull);
    expect(job.execute_until, isNotNull);
    expect(job.started, isNull);
    expect(job.completed, isNull);
    expect(job.locked_until, isNull);

    job1 = job;

    // Create the second job
    job = await _client.addJob(null, JOB2);
    expect(job, isNotNull);
    expect(job.id, isNotNull);
    expect(JOB2.type, job.type);
    expect(JOB2.ref_id, job.ref_id);

    expect(0, job.retries);
    expect(JOB2.params, job.params);
    expect(job.created, isNotNull);
    expect(job.execute_until, isNotNull);
    expect(job.started, isNull);
    expect(job.completed, isNull);
    expect(job.locked_until, isNull);

    // Create the third job
    job = await _client.addJob(null, JOB3);
    expect(job, isNotNull);
    expect(job.id, isNotNull);
    expect(JOB3.type, job.type);
    expect(JOB3.ref_id, job.ref_id);

    expect(0, job.retries);
    expect(JOB3.params, job.params);
    expect(job.created, isNotNull);
    expect(job.execute_until, isNotNull);
    expect(job.started, isNull);
    expect(job.completed, isNull);
    expect(job.locked_until, isNull);

    // Get one job
    job = await _client.getJobById(null, job1.id);
    expect(job, isNotNull);
    expect(job.id, job1.id);
    expect(JOB1.type, job.type);
    expect(JOB1.ref_id, job.ref_id);
    expect(job1.retries, job.retries);
    expect(JOB1.params, job.params);
    expect(job.created, isNotNull);
    expect(job.execute_until, isNotNull);
    expect(job.started, isNull);
    expect(job.completed, isNull);
    expect(job.locked_until, isNull);

    // Get all jobs
    var page = await _client.getJobs(null, FilterParams(), PagingParams());
    expect(page, isNotNull);
    expect(page.data.length, 3);

    job1 = page.data[0];
    job2 = page.data[1];

    // Test start job by type
    job = await _client.startJobByType(null, job1.type, 1000 * 60 * 10, 10);
    expect(job, isNotNull);
    expect(job.started, isNotNull);
    expect(job.locked_until, isNotNull);

    // Test extend job
    job = await _client.extendJob(null, job1.id, 1000 * 60 * 2);
    expect(job, isNotNull);
    expect(job.locked_until, isNotNull);

    // Test complete job
    job = await _client.completeJob(null, job1.id);
    expect(job, isNotNull);
    expect(job.completed, isNotNull);

    // Test start job
    job = await _client.startJobById(null, job2.id, 1000 * 60);
    expect(job, isNotNull);
    expect(job.started, isNotNull);
    expect(job.locked_until, isNotNull);

    // Test abort job
    job = await _client.abortJob(null, job2.id);
    expect(job, isNotNull);
    expect(job.started, isNull);
    expect(job.locked_until, isNotNull);
  }
}
