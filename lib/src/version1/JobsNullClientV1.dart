import 'dart:async';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_jobs/pip_services_jobs.dart';
import './IJobsClientV1.dart';

class JobsNullClientV1 implements IJobsClientV1 {
  @override
  Future<JobV1> addJob(String correlationId, NewJobV1 newJob) {
    return null;
  }

  @override
  Future<JobV1> addUniqJob(String correlationId, NewJobV1 newJob) {
    return null;
  }

  @override
  Future<DataPage<JobV1>> getJobs(
      String correlationId, FilterParams filter, PagingParams paging) async {
    return DataPage<JobV1>([], 0);
  }

  @override
  Future<JobV1> getJobById(String correlationId, String jobId) async {
    return null;
  }

  @override
  Future<JobV1> startJobById(String correlationId, String jobId, num timeout) {
    return null;
  }

  @override
  Future<JobV1> startJobByType(
      String correlationId, String jobType, num timeout, num maxRetries) {
    return null;
  }

  @override
  Future<JobV1> extendJob(String correlationId, String jobId, num timeout) {
    return null;
  }

  @override
  Future<JobV1> abortJob(String correlationId, String jobId) {
    return null;
  }

  @override
  Future<JobV1> completeJob(String correlationId, String jobId) {
    return null;
  }

  @override
  Future<JobV1> deleteJobById(String correlationId, String jobId) {
    return null;
  }

  @override
  Future deleteJobs(String correlationId) {
    return null;
  }
}
