# Donation Management System

# Intro

The system is going to use dry-web-roda as the base framework. It will
also use sidekiq to process messages.

The idea of the application is that a CRM will send an API request with
donation details. These details will then be sent to a sidkiq worker to be
processed.

The processing consists of allocating donations to causes and projects
which the charity supports. This information is then sent as a tag back
to the CRM. The CRM can then inform the donors of the individual project
they have been allocated and are supporting.

The message sent back to the CRM will be executed after the sidekiq worker
has run to allocate the donation. The primary key is always going to be
the donors email address.

Phase two will be to develop a frontend to consume the API to allow for
reporting and adding/editing of projects/causes.

#TODO

* Design API and implement Roda routing, Operations and Schemas
* Write Specs for all code so far
* Hook up sidekick and send message when valid

