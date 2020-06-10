import 'dart:async';

import 'package:test/test.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_jobs/pip_clients_jobs.dart';
import './JobsClientV1Fixture.dart';

var httpConfig = ConfigParams.fromTuples([
  'connection.protocol',
  'http',
  'connection.host',
  'localhost',
  'connection.port',
  8080
]);

void main() {
  group('JobsHttpClientV1', () {
    JobsHttpClientV1 client;
    JobsClientFixtureV1 fixture;

    setUp(() async {
      client = JobsHttpClientV1();
      client.configure(httpConfig);
      var references = References.fromTuples([
        Descriptor('pip-services-jobs', 'client', 'http', 'default', '1.0'),
        client
      ]);
      client.setReferences(references);
      fixture = JobsClientFixtureV1(client);
      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
      await Future.delayed(Duration(milliseconds: 2000));
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });

    test('Control test', () async {
      await fixture.testControl();
    });
  });
}
