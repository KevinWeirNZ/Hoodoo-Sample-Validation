# Hoodoo-sample-validation
A Hoodoo service that validates input received and returns either a valid response or an error message.

Goals:

* Create an endpoint that responds to  `HTTP POST`
* Validate incoming data
* Understand Hoodoo presenters

Task
Build a Hoodoo service that responds to `POST 1/Hello` and takes the following input payload:



  {
    "first_name": "John",
    "surname": "Smith"
  }

The response should be:

  {
    "message": "Hello John Smith"
  }

You should create a presenter for the input payload, which defines the field structure, and use it to validate the incoming payload

If the payload is valid, respond with the message above

If the payload is invalid, for example if I forgot to include the surname field, respond with the standardised Hoodoo error structure, eg:



  {
    "interaction_id": "44017daf774442609098d9c7f44c072a",
    "errors": [
      {
        "code": "generic.required_field_missing",
        "message": "Field `surname` is required",
        "reference": "surname"
      }
    ],
    "id": "3daf423fc2014164a9a88d0bca0f7c6e",
    "kind": "Errors",
    "created_at": "2021-11-10T19:19:14.061763Z"
  }

curl command to call a valid response:
  curl -X POST http://localhost:9292/v1/Hello --header 'Content-Type: application/json; charset=utf-8' -d '{ "first_name": "John", "surname": "Smith" }'

curl command to call an invalid response:
  curl -X POST http://localhost:9292/v1/Hello --header 'Content-Type: application/json; charset=utf-8' -d '{ "first_name": "John"}'
