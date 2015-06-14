defmodule Catcaluser.Repo do
  use Ecto.Repo, otp_app: :catcaluser

  alias :exometer, as: Exometer

  @doc """
  Override the logging of Ecto and forwards metrics towards Exometer
  """
  def log({atom, cmd, params}, fun) do
    before_time = :os.timestamp
 
    result = super({atom, cmd, params}, fun)
 
    after_time = :os.timestamp
    diff = :timer.now_diff after_time, before_time
    :ok = Exometer.update ~w(catcaluser ecto query_exec_time)a, diff / 1_000
    :ok = Exometer.update ~w(catcaluser ecto query_count)a, 1
 
    result
  end
  def log(atom, fun), do: super(atom, fun)
  
end
