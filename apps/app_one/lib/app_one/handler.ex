defmodule AppOne.Handler do
  @behaviour :cowboy_http_handler

  def init(_type, req, _opts), do: {:ok, req, nil}

  def handle(req, state) do
    {ok, req2} = :cowboy_req.reply(200, [], "Hello from App One!", req)
    {ok, req2, state}
  end

  def terminate(_reason, _req, _state), do: :ok
end