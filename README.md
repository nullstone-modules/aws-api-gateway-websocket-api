This capability injects the arn of the connection job definition into an application.
This allows the application to schedule jobs with this job definition.

The env variables injected are:
| Variable | Description |
| --- | --- |
| `BATCH_JOB_DEFINITION_ARN` | The arn of the Batch Job Definition that is connected to this capability. |
| `BATCH_JOB_DEFINITION_NAME` | The name of the Batch Job Definition that is connected to this capability. |
