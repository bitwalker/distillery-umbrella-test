use Mix.Releases.Config,
    # This sets the default release built by `mix release`
    default_release: :master_app,
    # This sets the default environment used by `mix release`
    default_environment: Mix.env

# For a full list of config options for both releases
# and environments, visit https://hexdocs.pm/distillery/configuration.html


# You may define one or more environments in this file,
# an environment's settings will override those of a release
# when building in that environment, this combination of release
# and environment configuration is called a profile

environment :dev do
  set dev_mode: true
  set include_erts: false
end

environment :prod do
  set include_erts: true
  set include_src: false
end

# You may define one or more releases in this file.
# If you have not set a default release, or selected one
# when running `mix release`, the first release in the file
# will be used by default
release :combined do
  set version: "0.1.0"
  set applications: [:master_app, :app_one, :app_two]
  plugin Conform.ReleasePlugin
end

release :app_one do
  set version: current_version(:app_one)
  plugin Conform.ReleasePlugin
end

release :app_two do
  set version: current_version(:app_two)
  plugin Conform.ReleasePlugin
end

release :master_app do
  set version: current_version(:master_app)
  plugin Conform.ReleasePlugin
end

