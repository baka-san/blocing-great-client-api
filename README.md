Blocing Great Client is an API Client Gem built to access the student endpoints of Bloc’s REST API. Blocing Great Client allows students to access mentor availability, send/receive messages and submit checkpoints for work completed.

Bloc’s API provides an external facing JSON Web Token authorized gateway to the Bloc application which can be accessed via cURL, but an API client can manage the low-level details of making requests and handling responses.

The API client needed to provide easy access to and use of the student endpoints of Bloc’s API, meeting each of the following user needs:

- Users can initialize and authorize Blocing Great Client with a Bloc username and password
- Users can retrieve the current user as a JSON blob
- Users can retrieve a list of their mentor's availability
- Users can retrieve roadmaps and checkpoints
- Users can retrieve a list of their messages, respond to an existing message, and create a new message thread
- Users can submit checkpoint assignments