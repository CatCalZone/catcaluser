defmodule Catcaluser.Mixfile do
  use Mix.Project

  def project do
    [app: :catcaluser,
     version: "0.0.1",
     elixir: "~> 1.0",
     elixirc_paths: elixirc_paths(Mix.env),
     compilers: [:phoenix] ++ Mix.compilers,
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [mod: {Catcaluser, []},
     applications: [:phoenix, :cowboy, :logger,
                    :phoenix_ecto, :postgrex, 
                    :phoenix_token_auth, 
                    :cors_plug,
                    :sasl]]
  end

  # Specifies which paths to compile per environment
  defp elixirc_paths(:test), do: ["lib", "web", "test/support"]
  defp elixirc_paths(_),     do: ["lib", "web"]

  # Specifies your project dependencies
  #
  # Type `mix help deps` for examples and options
  defp deps do
    [{:phoenix_token_auth, github: "alfert/phoenix_token_auth", branch: "config_wo_functions"},# "~> 0.0.10"},
     {:phoenix, "~> 0.12"},
     {:ecto, "~> 0.11"},
     {:phoenix_ecto, "~> 0.3"},
     {:postgrex, ">= 0.0.0"},
     {:cors_plug, "~> 0.1.2"},
     {:phoenix_live_reload, "~> 0.3.0", only: :dev},
     {:cowboy, "~> 1.0"}, 
     {:timex, "~>0.13.4", only: :test},
     {:inch_ex, only: :docs},
     {:exrm, "~> 0.16.0"}]
  end
end
