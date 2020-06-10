import 'dart:async';
import 'dart:convert';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services3_rpc/pip_services3_rpc.dart';
import 'package:pip_services_jobs/pip_services_jobs.dart';
import './IJobsClientV1.dart';

class JobsHttpClientV1 extends CommandableHttpClient implements IJobsClientV1 {
  JobsHttpClientV1([config]) : super('v1/jobs') {
    if (config != null) {
      configure(ConfigParams.fromValue(config));
    }
  }

  JobV1 _fixJob(JobV1 job) {
    if (job == null) return null;

    job.completed = DateTimeConverter.toNullableDateTime(job.completed);
    job.started = DateTimeConverter.toNullableDateTime(job.started);
    job.execute_until = DateTimeConverter.toDateTime(job.execute_until);
    job.locked_until = DateTimeConverter.toNullableDateTime(job.locked_until);
    job.created = DateTimeConverter.toDateTime(job.created);

    return job;
  }

  /// Add new job from newJob.
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [newJob]                a new job to be added to exist job.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> addJob(String correlationId, NewJobV1 newJob) async {
    var result =
        await callCommand('add_job', correlationId, {'new_job': newJob});
    if (result == null) return null;
    var item = JobV1();
    item.fromJson(json.decode(result));
    return _fixJob(item);
  }

  /// Add new job if not exist with same type and ref_jobId
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [newJob]                a new job to be added to exist job.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> addUniqJob(String correlationId, NewJobV1 newJob) async {
    var result =
        await callCommand('add_uniq_job', correlationId, {'new_job': newJob});
    if (result == null) return null;
    var item = JobV1();
    item.fromJson(json.decode(result));
    return _fixJob(item);
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
    var result = await callCommand(
      'get_jobs',
      correlationId,
      {'filter': filter, 'paging': paging},
    );

    var page = json.decode(result);
    if (page == null || page['data'].length == 0) {
      return DataPage<JobV1>([], 0);
    }

    return DataPage<JobV1>.fromJson(page, (item) {
      var job = JobV1();
      job.fromJson(item);
      return _fixJob(job);
    });
  }

  /// Gets a job by its unique jobId.
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of job to be retrieved.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> getJobById(String correlationId, String jobId) async {
    var result =
        await callCommand('get_job_by_id', correlationId, {'job_id': jobId});
    if (result == null) return null;
    var item = JobV1();
    item.fromJson(json.decode(result));
    return _fixJob(item);
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
    var result = await callCommand('start_job_by_id', correlationId,
        {'job_id': jobId, 'timeout': timeout});
    if (result == null) return null;
    var item = JobV1();
    item.fromJson(json.decode(result));
    return _fixJob(item);
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
    var result = await callCommand('start_job_by_type', correlationId,
        {'type': jobType, 'timeout': timeout});
    if (result == null) return null;
    var item = JobV1();
    item.fromJson(json.decode(result));
    return _fixJob(item);
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
    var result = await callCommand(
        'extend_job', correlationId, {'job_id': jobId, 'timeout': timeout});
    if (result == null) return null;
    var item = JobV1();
    item.fromJson(json.decode(result));
    return _fixJob(item);
  }

  /// Aborts job
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of job to be retrieved.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> abortJob(String correlationId, String jobId) async {
    var result =
        await callCommand('abort_job', correlationId, {'job_id': jobId});
    if (result == null) return null;
    var item = JobV1();
    item.fromJson(json.decode(result));
    return _fixJob(item);
  }

  /// Completes job
  ///
  /// - [correlationId]     (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of job to be retrieved.
  /// Return         Future that receives job or error.
  @override
  Future<JobV1> completeJob(String correlationId, String jobId) async {
    var result =
        await callCommand('complete_job', correlationId, {'job_id': jobId});
    if (result == null) return null;
    var item = JobV1();
    item.fromJson(json.decode(result));
    return _fixJob(item);
  }

  /// Deletes a job by it's unique jobId.
  ///
  /// - [correlationId]    (optional) transaction jobId to trace execution through call chain.
  /// - [jobId]                a jobId of the job to be deleted
  /// Return                Future that receives deleted job
  /// Throws error.
  @override
  Future<JobV1> deleteJobById(String correlationId, String jobId) async {
    var result =
        await callCommand('delete_job_by_id', correlationId, {'job_id': jobId});
    if (result == null) return null;
    var item = JobV1();
    item.fromJson(json.decode(result));
    return _fixJob(item);
  }

  /// Removes all jobs
  ///
  /// - [correlationId]    (optional) transaction jobId to trace execution through call chain.
  /// Return                Future that receives null for success
  /// Throws error.
  @override
  Future deleteJobs(String correlationId) {
    return callCommand('delete_jobs', correlationId, {});
  }
}
