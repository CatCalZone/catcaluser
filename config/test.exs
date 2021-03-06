use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :catcaluser, Catcaluser.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :catcaluser, Catcaluser.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "catcaluser_test",
  size: 1,
  max_overflow: 0

config :eurexa, 
  eureka_server: "127.0.0.1",
  eureka_port: 8761,
  eureka_prefix: "/",
  eureka_version: 2