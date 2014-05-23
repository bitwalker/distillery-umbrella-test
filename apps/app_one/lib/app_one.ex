defmodule AppOne do
  use Application

  # See http://elixir-lang.org/docs/stable/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    dispatch = :cowboy_router.compile([
        # {URIHost, list({URIPath, Handler, Opts})}
        {:_, [{"/", AppOne.Handler, []}]}
    ])
    # Name, NbAcceptors, TransOpts, ProtoOpts
    {:ok, port} = :application.get_env(:app_one, :port)
    {:ok, _} = :cowboy.start_http(:https, 100,
        [port: port],
        [env: [dispatch: dispatch]]
    )
    AppOne.Supervisor.start_link
  end
end
