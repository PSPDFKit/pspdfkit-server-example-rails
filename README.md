# PSPDFKit Server Example – Rails

This example shows how to integrate PSPDFKit Server and
[PSPDFKit for Web](https://pspdfkit.com/web/) into a Rails app.

_Note: This example demonstrates the usage of PSPDFKit for Web in a Rails application and is not optimized for production deployments. For information on how to set up PSPDFKit for Web in production, please refer to [our guides](https://pspdfkit.com/guides/server/current/deployment/getting-started/) instead._

## Prerequisites

- [Docker](https://www.docker.com/community-edition)
- A PSPDFKit Server license. If you don't already have one
  you can [request a free trial here](https://pspdfkit.com/try/).

## Getting Started with Docker

We recommend you use Docker to get all components up and running quickly.

The provided `docker-compose.yml` and `Dockerfile` will allow you to edit the example app on your
host and it will live-reload.

```sh
$ git clone https://github.com/PSPDFKit/pspdfkit-server-example-rails.git
$ cd pspdfkit-server-example-rails
$ ACTIVATION_KEY=YOUR_ACTIVATION_KEY_GOES_HERE docker-compose up
```

If you are using Windows make sure to set the environment variables accordingly. For this replace the line starting with `PSPDFKIT_ACTIVATION_KEY="...` with:

```shell
$ SET "PSPDFKIT_ACTIVATION_KEY=YOUR_ACTIVATION_KEY_GOES_HERE"
$ docker-compose up
```

Make sure to replace `YOUR_ACTIVATION_KEY_GOES_HERE` with your [PSPDFKit Server activation key](#request-a-license).
You only have to provide the activation key once, after that the server will remain activated until you reset it.

Once all containers are running, it's necessary to apply database migrations. You can do so by running:

```shell
docker-compose exec -T example ./bin/rails db:migrate
```

The example app is now running on <http://localhost:3000>. You can access PSPDFKit Server's
dashboard at <http://localhost:5000/dashboard> using `dashboard` // `secret`.

Login using any user name and upload a PDF, then click on the cover image to see PSPDFKit Web in
action.

You can also selectively share PDFs with other users you have created.

### Resetting the server

You can reset the server by first tearing down its containers and volumes and then recreating them.

```sh
$ docker-compose down --volumes
$ ACTIVATION_KEY=YOUR_ACTIVATION_KEY_GOES_HERE docker-compose up
```

If you are using Windows make sure to set the environment variables accordingly. For this replace the line starting with `PSPDFKIT_ACTIVATION_KEY="...` with:

```shell
$ SET "PSPDFKIT_ACTIVATION_KEY=YOUR_ACTIVATION_KEY_GOES_HERE"
$ docker-compose up
```

## Running the example locally

You can also run the example app directly on your machine, outside of a Docker container.

### Prerequisites

- Ruby 2.2.2 or newer (The sample is a Rails 5.0 app)
- [PSPDFKit Server](https://pspdfkit.com/guides/web/current/server-backed/setting-up-pspdfkit-server/)
  running on [http://localhost:5000](http://localhost:5000) with the default configuration

### Getting Started

```sh
$ git clone https://github.com/PSPDFKit/pspdfkit-server-example-rails.git
$ cd pspdfkit-server-example-rails
$ bundle
$ bin/rails db:migrate
$ bin/rails server
```

The example app is now running on <http://localhost:3000>.

Login using any user name and upload a PDF, then click on the cover image to see PSPDFKit Web in
action.

You can also selectively share PDFs with other users you have created.

You can quit the running containers with Ctrl-C.

If you want to test PSPDFKit for Web on different devices in your local network, you need
to edit the `PSPDFKIT_SERVER_EXTERNAL_URL` environment variable in the `docker-compose.yml` and set it to an address that's reachable from your device.

## Troubleshooting

Occasionally running the `docker-compose` scripts will result in errors because some containers are in a broken state. To resolve this, you can reset all containers and their attached volumes by running the following command:

```sh
docker-compose down --volumes
```

If you have further troubles, you can always reach out to us via our [support platform](https://pspdfkit.com/support/request).

## License

This software is licensed under a [modified BSD license](LICENSE).

## Contributing

Please ensure
[you signed our CLA](https://pspdfkit.com/guides/web/current/miscellaneous/contributing/) so we can
accept your contributions.
