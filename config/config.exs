# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# Configures the endpoint
config :catcaluser, Catcaluser.Endpoint,
  url: [host: "localhost"],
  root: Path.expand("..", __DIR__),
  secret_key_base: "wORXytHF+wnkpjK2Vog5mPZJYEigoJ8hGhHLpBhN1J45WrmxrS5gTNMpaExi84LE",
  debug_errors: false,
  pubsub: [name: Catcaluser.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :phoenix_token_auth,
  user_model: Catcaluser.User,           # ecto model used for authentication
  repo: Catcaluser.Repo,                 # ecto repo
  crypto_provider: Comeonin.Bcrypt,      # crypto provider for hashing passwords/tokens. see http://hexdocs.pm/comeonin/
  # secret string used to sign the authentication token
  token_secret: "the_very_secret_token", 
  # minutes from login until a token expires
  token_validity_in_minutes: 7 * 24 * 60, 
  # sender address of emails sent by the app   
  email_sender: "catcaluser@catcal.zone", 
  # function returning the subject of a welcome email
  welcome_email_subject: fn user -> "Hello #{user.email}" end,
  # function returning the body of a welcome email
  welcome_email_body: fn user, confirmation_token -> confirmation_token end,
  # function returning the subject of a welcome email
  password_reset_email_subject: fn user -> "Hello #{user.email}" end,
  # function returning the body of a welcome email
  password_reset_email_body: fn user, reset_token -> reset_token end,
  # function returning the subject of the email sent when the users changes his email address
  new_email_address_email_subject: fn user -> "Hello #{user.email}" end, 
  # function returning the body of the email sent when the users changes his email address
  new_email_address_email_body: 
  	fn user, confirmation_token -> confirmation_token end, 
  # domain of your mailgun account
  mailgun_domain: "catcal.zone",
  # secret key of your mailgun account
  mailgun_key: "secret", 
  # function receiving and returning the changeset for a user on registration and 
  # when updating the account. This is the place to run custom validations.
  user_model_validator: fn changeset -> changeset end

# Setting configuration for the Joken library
config :joken, 
  secret_key: "very secrect test keys",
  json_module: PhoenixTokenAuth.PoisonHelper

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
