PSPDFKit Server Example – Rails
===============================

This example shows how to integrate PSPDFKit Server and [PSPDFKit for Web](https://pspdfkit.com/web/) into a Rails app.

## Prerequisites

* Ruby 2.2.2 or newer (The sample is a Rails 5.0 app)
* [PSPDFKit Server](https://pspdfkit.com/guides/web/current/server-backed/setting-up-pspdfkit-server/) running on [http://localhost:5000](http://localhost:5000) with the default configuration

## Getting Started

```sh
$ git clone git@github.com:PSPDFKit/pspdfkit-server-example-rails.git
$ cd pspdfkit-server-example-rails
$ bundle
$ bin/rails db:migrate
$ bin/rails server
```

The example app is now running on <http://localhost:3000>.

Login using any user name and upload a PDF, then click on the cover image to see PSPDFKit Web in action.

You can also selectively share PDFs with other users you have created.
