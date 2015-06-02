# Catcaluser

[![Build Status](https://travis-ci.org/CatCalZone/catcaluser.svg?branch=master)](https://travis-ci.org/CatCalZone/catcaluser)
[![Inline docs](http://inch-ci.org/github/CatCalZone/catcaluser.svg?branch=master&style=flat-square)](http://inch-ci.org/github/CatCalZone/catcaluser)

This project contains the User Management for the CatCal.Zone and is
implemented in Elixir with the Phoenix framework. As database Postgres 9 is
used.

## Features

* Users management, identified by email, password and a user name
* Account management, addiing additional information to a user
* Session management with the help of `PhoenixTokenAuth`: Each new session
  creates a JWT token which is used for authenicating all requests.
* API documentation is found in the RAML-file (catcaluser.raml)


These features are provided as a JSON REST API on the URL-prefix `/api/`. The production 
port is 4001, for development purposes the port is 4000. Currently, there is no support
for HTTPS, this may change in the future. 

In addition to the JSON API there is HTML-interface which is only served on
`localhost`  and uses no authentication. It allows for creation of new users,
which can afterwards be used with the JSON APIs. The HTML-interface is
required to become independent of a mailer implementation: currently
`PhoenixTokenAuth` requires the use of `mailgun` for a two-factor-registering
procedure, which is unhandy in our networking scenario for the Zühlke Camp.

## Docker Deployment

The provision of `Catcaluser` in a Docker setup is defined in the `machines`
directory. The postgres database is started with `start-pg.sh`, the image is
linked into the phoenix container as `db`, which is started via `start-
phoenix.sh`. Since for `catcaluser` no default image exists, a new image can
be build with the `build-docker.sh` script. 

### Generate docker images from the build

Generate a new release from source with `MIX_ENV=prod mix release`. After
that, simply run `build-docker.sh` to create a fresh Docker image from the
generated release in `/rel/catcaluser`.

### Download a binary relase for the docker image

To generate a docker image from an "official" release build binary, run
`build-docker.sh -r`. This downloads the last official build from GitHub and
creates a fresh Docker image.

## Generic Build Instructions

To start your new Phoenix application:

1. Install dependencies with `mix deps.get`
2. Start Phoenix endpoint with `mix phoenix.server`. Now you can visit 
  `localhost:4000` from your browser.
3. Test the application with `mix test`
4. Create a release with `MIX_ENV=prod mix release`

