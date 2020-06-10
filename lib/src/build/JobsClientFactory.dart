import 'package:pip_services3_components/pip_services3_components.dart';
import 'package:pip_services3_commons/pip_services3_commons.dart';

import '../version1/JobsNullClientV1.dart';
import '../version1/JobsDirectClientV1.dart';
import '../version1/JobsHttpClientV1.dart';

class JobsClientFactory extends Factory {
  static final NullClientDescriptor =
      Descriptor('pip-services-jobs', 'client', 'null', '*', '1.0');
  static final DirectClientDescriptor =
      Descriptor('pip-services-jobs', 'client', 'direct', '*', '1.0');
  static final HttpClientDescriptor =
      Descriptor('pip-services-jobs', 'client', 'http', '*', '1.0');

  JobsClientFactory() : super() {
    registerAsType(JobsClientFactory.NullClientDescriptor, JobsNullClientV1);
    registerAsType(
        JobsClientFactory.DirectClientDescriptor, JobsDirectClientV1);
    registerAsType(JobsClientFactory.HttpClientDescriptor, JobsHttpClientV1);
  }
}
