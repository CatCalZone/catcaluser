defmodule Catcaluser.Endpoint do
  use Phoenix.Endpoint, otp_app: :catcaluser

  # Serve at "/" the static files from "priv/static" directory.
  #
  # You should set gzip to true if you are running phoenix.digest
  # when deploying your static files in production.
  plug Plug.Static,
    at: "/", from: :catcaluser, gzip: false,
    only: ~w(css images js favicon.ico robots.txt)

  # Code reloading can be explicitly enabled under the
  # :code_reloader configuration of your endpoint.
  if code_reloading? do
    plug Phoenix.LiveReloader
    plug Phoenix.CodeReloader
  end

  plug Plug.Logger
  plug CORSPlug, [origin: ["http://localhost:9000", "http://127.0.0.1:9000"]]


  plug Plug.Parsers,
    parsers: [:urlencoded, :multipart, :json],
    pass: ["*/*"],
    json_decoder: Poison

  plug Plug.MethodOverride
  plug Plug.Head

  plug Plug.Session,
    store: :cookie,
    key: "_catcaluser_key",
    signing_salt: "LxnT458o"

  plug :router, Catcaluser.Router
end
