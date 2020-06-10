# Examples for Jobs Microservice

This is the jobs microservice. It keeps list of working jobs.

The service allows you to manage tasks in those cases when the generation (statement) of the task is performed in a separate microservice, and direct execution is implemented in one way or another.

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

In the help for each class there is a general example of its use. Also one of the quality sources
are the source code for the [**tests**](https://github.com/pip-services-infrastructure/pip-clients-jobs-dart/tree/master/test).
