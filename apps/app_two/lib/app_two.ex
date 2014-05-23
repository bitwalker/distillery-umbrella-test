defmodule AppTwo do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    dispatch = :cowboy_router.compile([
        # {URIHost, list({URIPath, Handler, Opts})}
        {:_, [{"/", AppTwo.Handler, []}]}
    ])
    # Name, NbAcceptors, TransOpts, ProtoOpts
    {:ok, port} = :application.get_env(:app_two, :port)
    {:ok, _} = :cowboy.start_http(:http, 100,
        [port: port],
        [env: [dispatch: dispatch]]
    )
    AppTwo.Supervisor.start_link
  end
end
