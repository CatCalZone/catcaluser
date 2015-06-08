defmodule Catcaluser do
  use Application
  require Logger

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(Catcaluser.Endpoint, []),
      # Start the Ecto repository
      worker(Catcaluser.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(Catcaluser.Worker, [arg1, arg2, arg3]),
      worker(Eurexa.EurexaServer, ["catcaluser"])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Catcaluser.Supervisor]
    return_value = Supervisor.start_link(children, opts)

    ########### 
    ## Check for a production env var that requires migration
    repo_env = Application.get_env(:catcaluser, Catcaluser.Repo)
    if (repo_env |> Keyword.get(:auto_migrate, false)) do
      migrate_database()
    end
    ###########
    
    return_value
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    Catcaluser.Endpoint.config_change(changed, removed)
    :ok
  end

  @doc """
  Migrates the database on system startup.
  """
  def migrate_database() do
     Logger.info "Migrating the database"
     repo = Mix.Ecto.ensure_started(Catcaluser.Repo)
     mig_path = Application.app_dir(:catcaluser, "priv/repo/migrations")
     Logger.info("Migrations Path is #{mig_path}")
     :ok = case Ecto.Storage.up(repo) do
      :ok ->
        Logger.info "The database for #{inspect repo} has been created."
        :ok
      {:error, :already_up} ->
        Logger.info "The database for #{inspect repo} has already been created."
        :ok
      {:error, term} ->
        Logger.error "The database for #{inspect repo} couldn't be created, reason given: #{term}."
        :error        
    end
    Ecto.Migrator.run(repo, mig_path, :up, [all: true, log: :info])
  end
  
end
