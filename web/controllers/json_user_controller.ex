defmodule Catcaluser.JsonUserController do
  use Catcaluser.Web, :controller

  require Logger
  alias Catcaluser.User

  plug :scrub_params, "json_user" when action in [:create, :update]
  plug :action

  @doc """
  Returns from all users the username, email and internal id.
  """
  def index(conn, _params) do
    jsonusers = Repo.all(User)
      |> Enum.map &Catcaluser.JsonUser.from_user/1
    render(conn, "index.json", jsonusers: jsonusers)
  end

  def show(conn, %{"id" => id}) do
    json_user = Repo.get(User, id) |> Catcaluser.JsonUser.from_user
    render conn, "show.json", json_user: json_user
  end

end
