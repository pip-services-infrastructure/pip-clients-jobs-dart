import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_jobs/pip_services_jobs.dart';
import './IJobsClientV1.dart';

class JobsDirectClientV1 extends DirectClient<dynamic>
    implements IJobsClientV1 {
  JobsDirectClientV1() : super() {
    dependencyResolver.put('controller',
        Descriptor('pip-services-jobs', 'controller', '*', '*', '1.0'));
  }

  /// Add new job from newJob.
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [newJob]                a new job to be added to exist job.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> addJob(String correlationId, NewJobV1 newJob) async {
    var timing = instrument(correlationId, 'jobs.add_job');
    var result = await controller.addJob(correlationId, newJob);
    timing.endTiming();
    return result;
  }

  /// Add new job if not exist with same type and ref_jobId
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [newJob]                a new job to be added to exist job.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> addUniqJob(String correlationId, NewJobV1 newJob) async {
    var timing = instrument(correlationId, 'jobs.add_uniq_job');
    var result = await controller.addUniqJob(correlationId, newJob);
    timing.endTiming();
    return result;
  }

  /// Gets a page of jobs retrieved by a given filter.
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [filter]            (optional) a filter function to filter items
  /// - [paging]            (optional) paging parameters
  /// Return         Future that receives a data page
  /// Throws error.
  @override
  Future<DataPage<JobV1>> getJobs(
      String correlationId, FilterParams filter, PagingParams paging) async {
    var timing = instrument(correlationId, 'jobs.get_jobs');
    var page = await controller.getJobs(correlationId, filter, paging);
    timing.endTiming();
    return page;
  }

  /// Gets a job by its unique jobId.
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of job to be retrieved.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> getJobById(String correlationId, String jobId) async {
    var timing = instrument(correlationId, 'jobs.get_job_by_id');
    var job = await controller.getJobById(correlationId, jobId);
    timing.endTiming();
    return job;
  }

  /// Starts a job by its unique jobId.
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of job to be retrieved.
  /// - [timeout]                a timeout for set locked_until time for job.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> startJobById(
      String correlationId, String jobId, num timeout) async {
    var timing = instrument(correlationId, 'jobs.start_job_by_id');
    var job = await controller.startJobById(correlationId, jobId, timeout);
    timing.endTiming();
    return job;
  }

  /// Start fist free job by type
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [jobType]                a jobType of job to be retrieved.
  /// - [timeout]                a timeout for set locked_until time for job.
  /// - [maxRetries]                a maxRetries for get item with retries less than them.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> startJobByType(
      String correlationId, String jobType, num timeout, num maxRetries) async {
    var timing = instrument(correlationId, 'jobs.start_job_by_type');
    var job = await controller.startJobByType(
        correlationId, jobType, timeout, maxRetries);
    timing.endTiming();
    return job;
  }

  /// Extends job execution limit on timeout value
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of job to be retrieved.
  /// - [timeout]                a timeout for set locked_until time for job.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> extendJob(
      String correlationId, String jobId, num timeout) async {
    var timing = instrument(correlationId, 'jobs.extend_job');
    var job = await controller.extendJob(correlationId, jobId, timeout);
    timing.endTiming();
    return job;
  }

  /// Aborts job
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of job to be retrieved.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> abortJob(String correlationId, String jobId) async {
    var timing = instrument(correlationId, 'jobs.abort_job');
    var job = await controller.abortJob(correlationId, jobId);
    timing.endTiming();
    return job;
  }

  /// Completes job
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of job to be retrieved.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> completeJob(String correlationId, String jobId) async {
    var timing = instrument(correlationId, 'jobs.complete_job');
    var job = await controller.completeJob(correlationId, jobId);
    timing.endTiming();
    return job;
  }

  /// Deletes a job by it's unique jobId.
  ///
  /// - [correlationId]    (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of the job to be deleted
  /// Return                Future that receives deleted job
  /// Throws error.
  @override
  Future<JobV1> deleteJobById(String correlationId, String jobId) async {
    var timing = instrument(correlationId, 'jobs.delete_job_by_id');
    var job = await controller.deleteJobById(correlationId, jobId);
    timing.endTiming();
    return job;
  }

  /// Removes all jobs
  ///
  /// - [correlationId]    (optional) transaction jobId to trace execution through call chain.
  /// Return                Future that receives null for success
  /// Throws error.
  @override
  Future deleteJobs(String correlationId) async {
    var timing = instrument(correlationId, 'jobs.delete_jobs');
    await controller.deleteJobs(correlationId);
    timing.endTiming();
  }
}
