import 'package:pip_clients_jobs/pip_clients_jobs.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_services_jobs/pip_services_jobs.dart';

Future<void> main(List<String> argument) async {
  try {
    var correlationId = '123';
    var config = ConfigParams.fromTuples([
      'connection.type',
      'http',
      'connection.host',
      'localhost',
      'connection.port',
      8080
    ]);
    var client = JobsHttpClientV1();
    client.configure(config);
    final JOB1 = NewJobV1(
        type: 't1', ref_id: 'obj_0fsd', ttl: 1000 * 60 * 60 * 3, params: null);
    final JOB2 = NewJobV1(
        type: 't1', ref_id: 'obj_1fsd', ttl: 1000 * 60 * 60, params: null);
    await client.open(correlationId);
    // Create 2 jobs
    await client.addJob(correlationId, JOB1);
    await client.addJob(correlationId, JOB2);
    var page = await client.getJobs(null, null, null);
    if (page.data.length == 2) {
      print('Get jobs length: ' +
          page.data.length.toString() +
          '! Everything works well!');
    } else {
      print('Get jobs length: ' +
          page.data.length.toString() +
          ' is not equal! Something was wrong!');
    }
    // Delete all activities
    print('Delete all jobs...');
    await client.deleteJobs(correlationId);

    page = await client.getJobs(null, null, null);
    if (page.data.isEmpty) {
      print('Get jobs length: ' +
          page.data.length.toString() +
          '! Everything works well!');
    } else {
      print('Get jobs length: ' +
          page.data.length.toString() +
          ' is not equal! Something was wrong!');
    }
    await client.close(correlationId);
  } catch (ex) {
    print(ex);
  }
}
