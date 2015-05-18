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
      |> Enum.map fn %User{email: e, username: n, id: id} -> %{email: e, name: n, id: id} end
    render(conn, "index.json", jsonusers: jsonusers)
  end

  def show(conn, %{"id" => id}) do
    json_user = Repo.get(User, id)
    render conn, "show.json", json_user: json_user
  end


  def delete(conn, %{"id" => id}) do
    json_user = Repo.get(User, id)
    Logger.debug "Got #{inspect json_user} from DB"

    json_user = Repo.delete(json_user)
    Logger.debug "Deleted #{inspect json_user} from DB"
    Logger.debug "will call render on show.json, #{inspect json_user}"
    render(conn, "show.json", json_user: json_user)
  end
end
