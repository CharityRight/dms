# Donation Management System
https://travis-ci.org/CharityRight/dms.svg?branch=master

# High Level Vision
The idea of the application is that a CRM will send an API request with
donation details. These details will then be sent to a message worker to be processed.

The processing consists of allocating donations to causes and projects
which the charity supports. This information is then sent as a tag back
to the CRM. The CRM can then inform the donors of the individual projects
they have been allocated and are supporting.

The message sent back to the CRM will be executed after the message worker
has run and allocated the donation. The primary key is always going to be
the donors email address.

Although this is being developed for Charity Right, every effort will be made to
ensure a generic solution and integration path. This will allow other small charities
to use the DMS to manage their own donations.

The DMS is a small but crucial part of a vision of developing a charity focused
CRM solution built by charities, for charities.

# Technology and architecture
The DMS is using [dry-web-roda](https://github.com/dry-rb/dry-web-roda) as the base Ruby framework. It will
also use [sidekiq](https://github.com/mperham/sidekiq) to process messages alongside PostgreSQL for persistence.

The aim is to write an application using functional architecture. Please watch the talks
linked to in the reference section for what this actually means.

# Requirements
* Ruby > 2
* PostgreSQL
* Redis (for sidekiq)

# Get Started
* Copy .env.example to .env
* Change the database url in your .evn file
* bundle install
* Create the databases defined in .env and env.test (using createdb or bundle exec rake db:create)
* bundle exec shotgun -p 3000 -o 0.0.0.0 config.ru

# References
* http://dry-rb.org/
* https://github.com/dry-rb/dry-web-roda
* https://github.com/icelab/berg
* [Functional Architecture for the Practical Rubyist - RedDotRubyConf 2017](https://youtu.be/7qnsRejCyEQ)
* [Next Generation Ruby Web Appswith dry-rb, ROM, and Roda - RedDotRubyConf 2016](https://youtu.be/6ecNAjVWqaI)
* [Piotr Solnica about “Meet ROM_RB & DRY_RB”](https://youtu.be/jZ0Xf47P6oo)
* [Luca Guidi. Functional web with Ruby](https://youtu.be/SRQVhHzW-Eo)

# Contributing
We appreciate contributions of any kind. If you have code to show us, open a pull request. If you found a bug,
want a new feature, or just want to talk design before submitting a pull request, open an issue.

Please include tests with code contributions, and try to follow conventions that you find in the code.

# License
DMS is released under the MIT license.
