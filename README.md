# <img src="https://github.com/pip-services/pip-services/raw/master/design/Logo.png" alt="Pip.Services Logo" style="max-width:30%"> <br> Jobs Microservice Client SDK for Dart

This is a Dart client SDK for [pip-services-jobs](https://github.com/pip-services-infrastructure/pip-services-jobs-dart) microservice.

## Download

Right now the only way to get the microservice is to check it out directly from github repository
```bash
git clone git@github.com:pip-services-infrastructure/pip-clients-jobs-dart.git
```

Pip.Service team is working to implement packaging and make stable releases available for your 
as zip downloadable archieves.

## Contract

Logical contract of the microservice is presented below. For physical implementation (HTTP/REST),
please, refer to documentation of the specific protocol.

```dart
class NewJobV1 {
  String type;
  String ref_id;
  num ttl;
  dynamic params;
}

class JobV1 implements IStringIdentifiable {
  // Job description
  String id;
  String type;
  String ref_id;
  dynamic params;

  // Job control
  DateTime created;
  DateTime started;
  DateTime locked_until;
  DateTime execute_until;
  DateTime completed;
  num retries;
}

abstract class IJobsV1 {
  Future<JobV1> addJob(String correlationId, NewJobV1 newJob);

  Future<JobV1> addUniqJob(String correlationId, NewJobV1 newJob);

  Future<DataPage<JobV1>> getJobs(
      String correlationId, FilterParams filter, PagingParams paging);

  Future<JobV1> getJobById(String correlationId, String jobId);

  Future<JobV1> startJobById(String correlationId, String jobId, num timeout);

  Future<JobV1> startJobByType(
      String correlationId, String jobType, num timeout, num maxRetries);

  Future<JobV1> extendJob(String correlationId, String jobId, num timeout);

  Future<JobV1> abortJob(String correlationId, String jobId);
  
  Future<JobV1> completeJob(String correlationId, String jobId);

  Future<JobV1> deleteJobById(String correlationId, String jobId);

  Future deleteJobs(String correlationId);

  Future cleanJobs(String correlationId);
}
```

## Use

The easiest way to work with the microservice is to use client SDK. 

Define client configuration parameters that match the configuration of the microservice's external API
```dart
// Client configuration
var httpConfig = ConfigParams.fromTuples(
	"connection.protocol", "http",
	"connection.host", "localhost",
	"connection.port", 8080
);
```

Instantiate the client and open connection to the microservice
```dart
// Create the client instance
var client = JobsHttpClientV1(config);

// Configure the client
client.configure(httpConfig);

// Connect to the microservice
try{
  await client.open(null)
}catch() {
  // Error handling...
}       
// Work with the microservice
// ...
```

Now the client is ready to perform operations
```dart
// Create a new job
final JOB = NewJobV1(
    type: 't1', ref_id: 'obj_0fsd', ttl: 1000 * 60 * 60 * 3, params: null);

    // Create the job
    try {
      JobV1 job1 = await client.addJob('123', JOB);
      // Do something with the returned job...
    } catch(err) {
      // Error handling...     
    }
```

```dart
// Get the job
try {
var job = await client.getJobByid(
    null,
    job1.id);
    // Do something with job...

    } catch(err) { // Error handling}
```

## Acknowledgements

This microservice was created and currently maintained by
- **Sergey Seroukhov**
- **Nuzhnykh Egor**.
