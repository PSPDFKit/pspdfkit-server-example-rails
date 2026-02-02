# Nutrient Document Engine Example – Rails

This example shows how to integrate Nutrient Document Engine and
[Nutrient Web SDK](https://www.nutrient.io/sdk/web/) into a Rails app.

_Note: This example demonstrates the usage of Nutrient Document Engine
in a Rails application and is not optimized for production deployments.
For information on how to set up Document Engine in production, please
refer to
[our guides](https://www.nutrient.io/guides/document-engine/deployment/)
instead._

## Prerequisites

We recommend you use Docker to get all components up and running
quickly.

- [Docker](https://www.docker.com/community-edition)

You can easily run the example in trial mode without need for a license
or activation key. Just make sure to check out this repository locally.
The provided `docker-compose.yml` and `Dockerfile` will allow you to
edit the example app on your host, and it will live-reload:

```sh
$ git clone https://github.com/PSPDFKit/pspdfkit-server-example-rails.git
$ cd pspdfkit-server-example-rails
$ docker compose up
```

The example is now running on
[http://localhost:3000](http://localhost:3000). You can access the
Nutrient Document Engine dashboard at
[http://localhost:5000/dashboard](http://localhost:5000/dashboard) using
`dashboard` username and `secret` as a password.

Upload a PDF via the button in the top-left, then click on the cover
image to see Nutrient Web SDK in action.

## Using a license

If you have a Nutrient Document Engine license you can use it as well by
going through the following steps:

1. Open the [`docker-compose.yml`](docker-compose.yml) file in an editor
   of your choice and replace the `YOUR_LICENSE_KEY_GOES_HERE` placeholder
   with your standalone license key.

2. Start environment with your Nutrient Document Engine activation key:

```sh
$ ACTIVATION_KEY=YOUR_ACTIVATION_KEY_GOES_HERE docker compose up
```

If you are using Windows make sure to set the environment variables
accordingly. For this replace the line starting with
`ACTIVATION_KEY="...` with:

```shell
$ SET "ACTIVATION_KEY=YOUR_ACTIVATION_KEY_GOES_HERE"
$ docker compose up
```

Make sure to replace `YOUR_ACTIVATION_KEY_GOES_HERE` with your Nutrient
Document Engine activation key. You only have to provide the activation
key once, after that the server will remain activated until you reset
it.

### Resetting the server

You can reset the server by first tearing down its containers and
volumes and then recreating them.

```sh
$ docker compose down --volumes
$ docker compose up
```

If using an activation key, you'd need to set it again so as to recreate
the containers:

```sh
$ docker compose down --volumes
$ ACTIVATION_KEY=YOUR_ACTIVATION_KEY_GOES_HERE docker compose up
```

If you are using Windows make sure to set the environment variables
accordingly. For this replace the line starting with
`ACTIVATION_KEY="...` with:

```shell
$ SET "ACTIVATION_KEY=YOUR_ACTIVATION_KEY_GOES_HERE"
$ docker compose up
```

## Running the example locally

You can also run the example app directly on your machine, outside of a
Docker container.

### Prerequisites

- Ruby 3.4.5 or newer (The sample is a Rails 8.0 app)
- [Nutrient Document Engine](https://www.nutrient.io/getting-started/document-engine/)
  running on [http://localhost:4000](http://localhost:4000) with the
  default configuration

### Getting started

```sh
$ git clone https://github.com/PSPDFKit/pspdfkit-server-example-rails.git
$ cd pspdfkit-server-example-rails
$ bundle
$ bin/rails db:migrate
$ bin/rails server
```

The example app is now running on <http://localhost:3000>.

Login using any user name and upload a PDF, then click on the cover
image to see Nutrient Web SDK in action.

You can also selectively share PDFs with other users you have created.

You can quit the running containers with Ctrl-C.

If you want to test Nutrient Web SDK on different devices in your local
network, you need to edit the `DOCUMENT_ENGINE_EXTERNAL_URL` environment
variable in the `docker-compose.yml` and set it to an address that's
reachable from your device.

## Troubleshooting

Occasionally running the `docker compose` scripts will result in errors
because some containers are in a broken state. To resolve this, you can
reset all containers and their attached volumes by running the following
command:

```sh
docker compose down --volumes
```

If you have further troubles, you can always reach out to us via our
[support platform](https://support.nutrient.io/hc/requests/new).

## Support, issues and license questions

Nutrient offers support for customers with an active SDK license via
https://support.nutrient.io/hc/requests/new

Are you [evaluating our SDK](https://www.nutrient.io/sdk/try)? That's
great, we're happy to help out! To make sure this is fast, please use a
work email and have someone from your company fill out our sales form:
https://www.nutrient.io/contact-sales?=sdk

## License

This software is licensed under a [modified BSD license](LICENSE).

## Contributing

Please ensure
[you signed our CLA](https://www.nutrient.io/guides/web/miscellaneous/contributing/)
so we can accept your contributions.

Any contribution must successfully pass `bin/ci` checks.
