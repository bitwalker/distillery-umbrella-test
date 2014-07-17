defmodule MasterApp do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = []
    opts = [
      strategy: :one_for_one,
      name: MasterApp.Supervisor
    ]
    Supervisor.start_link(children, opts)
  end
end
