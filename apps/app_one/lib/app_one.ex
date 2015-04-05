defmodule AppOne do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    dispatch = :cowboy_router.compile([
        # {URIHost, list({URIPath, Handler, Opts})}
        {:_, [{"/", AppOne.Handler, []}]}
    ])
    # Name, NbAcceptors, TransOpts, ProtoOpts
    port = Application.get_env(:app_one, :port)
    {:ok, _} = :cowboy.start_http(:https, 100,
        [port: port],
        [env: [dispatch: dispatch]]
    )

    children = []
    opts = [
      strategy: :one_for_one,
      name: AppOne.Supervisor
    ]
    Supervisor.start_link(children, opts)
  end
end
