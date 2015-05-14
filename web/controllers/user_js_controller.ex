defmodule Catcaluser.UserJsController do
  use Catcaluser.Web, :controller

  alias Catcaluser.User
  require Logger

  plug :scrub_params, "user" when action in [:create, :update]
  plug :action

  def index(conn, %{}) do
    users = Repo.all(User)
    	|> Stream.take(10)
    	|> Enum.map fn %User{email: e, username: n} -> %{email: e, name: n} end
    Logger.debug("Catcaluser.UserJsController.index with results: #{inspect users}")
    json conn, users
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = # User.changeset(%User{}, user_params)
        PhoenixTokenAuth.Registrator.changeset(user_params)
    if changeset.valid? do
      Repo.insert(changeset)

      conn
      |> put_flash(:info, "User created successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)

    if changeset.valid? do
      Repo.update(changeset)

      conn
      |> put_flash(:info, "User updated successfully.")
      |> redirect(to: user_path(conn, :index))
    else
      render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    Repo.delete(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: user_path(conn, :index))
  end
end
