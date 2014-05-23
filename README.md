## UmbrellaTest

This application demonstrates a simple umbrella setup using cowboy to
drive two web servers, running under a single top level application.

### Architecture

The hierarchy looks like this:

```
↪ tree -L 2
.
├── README.md
├── _build
│   └── dev
├── apps
│   ├── app_one
│   ├── app_two
│   └── master_app
├── deps
│   ├── conform
│   ├── cowboy
│   ├── cowlib
│   └── ranch
├── mix.exs
└── mix.lock
```

As you can see, under apps, we have `app_one`, `app_two`, and
`master_app`. The two apps simply host a single url `/`, each
on their own port, as shown in the configuration files. The master
application is a bit unique in that it holds a dependency on `app_one`
and `app_two` in it's `mix.exs` file, and has no code of it's own.

The reason for this is that there is no way for us to generate a release
that boots both `app_one` and `app_two` as top level applications. The
only way we can build a single release that boots everything is by
rolling them under a top level application, which in our case is
`master_app`.

### Configuration

A key thing to be aware of is that normally configuration is not shared
between apps. However, due to exrm's integration with conform, we're
able to determine that `master_app` depends on two of it's sibling apps
under the same umbrella, and therefore generate a merged schema.exs file
which contains mappings and translations for all three, and allow you to
do all your configuration for the release in one place, `master_app`'s
`config/master_app.conf`. This is done by
default when the release task is run, but I would encourage you to run
the `mix conform.new` task when you get your apps and their configs set
up, so that you can properly validate and configure the configuration
schema. Conform does it's best to generate the right schema, but there
are limitations, and because of that, it's imperative you make sure it's
doing the right thing, or at runtime, your configuration will likely not be
what you expect it to be.

### Building the release

When you are ready to build a release for your app, just do `mix
release` like normal. This will go through each app in the umbrella and
generate a release for the individual app, by generating the necessary
files, and running plugins, including the conform configuration plugin which
will generate the release's final configuration files.

The end result will be a `rel` directory under each app, which contain
all the normal stuff you'd see in a standard application release.

### Deployment

The nice thing about the architecture I've built in this example app is
that while a release for each app is built, and you could deploy just
`app_one` and `app_two` as side-by-side services, it's easier if you can
deploy like you develop - as a single composite application. With `master_app`, we have
that. The release generated under `master_app/rel` will
contain all three apps and their dependencies, and because we have
`app_one` and `app_two` in `master_app`'s application array, when you
boot the `master_app` release, both of those will be started
automatically for you.

### Final thoughts

While this is now supported in exrm, and the above scenario is perfectly
fine, I'd still recommend avoiding umbrella projects unless you have a
real need for them. I don't use them myself, so if you run into issues,
please report them to the exrm tracker, and I'll address them as soon as I
can.
