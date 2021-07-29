Feature: Active Job

@rails4
Scenario: A handled error will be delivered
  Given I start the rails service
  When I navigate to the route "/active_job/handled" on the rails app
  And I wait to receive a request
  Then the request is valid for the error reporting API version "4.0" for the "Ruby Bugsnag Notifier"
  And the event "unhandled" is false
  And the event "severity" equals "warning"
  And the event "context" equals "NotifyJob@default"
  And the event "app.type" equals "active job"
  And the exception "errorClass" equals "RuntimeError"
  And the exception "message" equals "Failed"
  And the event "metaData.active_job.job_id" matches "^[0-9a-f-]{36}$"
  And the event "metaData.active_job.job_name" equals "NotifyJob"
  And the event "metaData.active_job.queue" equals "default"
  And the event "metaData.active_job.locale" equals "en"
  And the event "metaData.active_job.arguments.0" equals 1
  And the event "metaData.active_job.arguments.1" equals "hello"
  And the event "metaData.active_job.arguments.2.a" equals "a"
  And the event "metaData.active_job.arguments.2.b" equals "b"
  And the event "metaData.active_job.arguments.3.keyword" is true

@rails4
Scenario: An unhandled error will be delivered
  Given I start the rails service
  When I navigate to the route "/active_job/unhandled" on the rails app
  And I wait to receive 2 requests
  Then the request is valid for the error reporting API version "4.0" for the "Ruby Bugsnag Notifier"
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "context" equals "UnhandledJob@default"
  And the event "app.type" equals "active job"
  And the event "severityReason.type" equals "unhandledExceptionMiddleware"
  And the event "severityReason.attributes.framework" equals "Active Job"
  And the exception "errorClass" equals "RuntimeError"
  And the exception "message" equals "Oh no!"
  And the event "metaData.active_job.job_id" matches "^[0-9a-f-]{36}$"
  And the event "metaData.active_job.job_name" equals "UnhandledJob"
  And the event "metaData.active_job.queue" equals "default"
  And the event "metaData.active_job.locale" equals "en"
  And the event "metaData.active_job.arguments.0" equals 123
  And the event "metaData.active_job.arguments.1.abc" equals "xyz"
  And the event "metaData.active_job.arguments.2" equals "abcxyz"
  When I discard the oldest request
  Then the request is valid for the error reporting API version "4.0" for the "Ruby Bugsnag Notifier"
  And the event "unhandled" is true
  And the event "severity" equals "error"
  And the event "context" equals "UnhandledJob@default"
  And the event "app.type" equals "active job"
  And the event "severityReason.type" equals "unhandledExceptionMiddleware"
  And the event "severityReason.attributes.framework" equals "Active Job"
  And the exception "errorClass" equals "RuntimeError"
  And the exception "message" equals "Oh no!"
  And the event "metaData.active_job.job_id" matches "^[0-9a-f-]{36}$"
  And the event "metaData.active_job.job_name" equals "UnhandledJob"
  And the event "metaData.active_job.queue" equals "default"
  And the event "metaData.active_job.locale" equals "en"
  And the event "metaData.active_job.arguments.0" equals 123
  And the event "metaData.active_job.arguments.1.abc" equals "xyz"
  And the event "metaData.active_job.arguments.2" equals "abcxyz"
