import 'package:test/test.dart';
import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services_jobs/pip_services_jobs.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';
import 'package:pip_clients_jobs/pip_clients_jobs.dart';
import './JobsClientV1Fixture.dart';

void main() {
  group('JobsDirectClientV1', () {
    JobsDirectClientV1 client;
    JobsClientFixtureV1 fixture;
    JobsMemoryPersistence persistence;
    JobsController controller;

    setUp(() async {
      var logger = ConsoleLogger();
      persistence = JobsMemoryPersistence();
      controller = JobsController();
      var references = References.fromTuples([
        Descriptor('pip-services', 'logger', 'console', 'default', '1.0'),
        logger,
        Descriptor(
            'pip-services-jobs', 'persistence', 'memory', 'default', '1.0'),
        persistence,
        Descriptor(
            'pip-services-jobs', 'controller', 'default', 'default', '1.0'),
        controller
      ]);
      controller.setReferences(references);

      client = JobsDirectClientV1();
      client.setReferences(references);

      fixture = JobsClientFixtureV1(client);
      await client.open(null);
    });

    tearDown(() async {
      await client.close(null);
    });

    test('CRUD Operations', () async {
      await fixture.testCrudOperations();
    });

    test('Control test', () async {
      await fixture.testControl();
    });
  });
}
