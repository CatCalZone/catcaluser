defmodule Catcaluser.JsonAccountController do
  use Catcaluser.Web, :controller

  alias Catcaluser.Account, as: JsonAccount

  plug :scrub_params, "json_account" when action in [:create, :update]
  plug :action

  def index(conn, _params) do
    jsonaccounts = Repo.all(JsonAccount)
    render(conn, "index.json", jsonaccounts: jsonaccounts)
  end

  def create(conn, %{"json_account" => json_account_params}) do
    changeset = JsonAccount.changeset(%JsonAccount{}, json_account_params)

    if changeset.valid? do
      json_account = Repo.insert(changeset)
      render(conn, "show.json", json_account: json_account)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Catcaluser.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    json_account = Repo.get(JsonAccount, id)
    render conn, "show.json", json_account: json_account
  end

  def update(conn, %{"id" => id, "json_account" => json_account_params}) do
    json_account = Repo.get(JsonAccount, id)
    changeset = JsonAccount.changeset(json_account, json_account_params)

    if changeset.valid? do
      json_account = Repo.update(changeset)
      render(conn, "show.json", json_account: json_account)
    else
      conn
      |> put_status(:unprocessable_entity)
      |> render(Catcaluser.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    json_account = Repo.get(JsonAccount, id)

    json_account = Repo.delete(json_account)
    render(conn, "show.json", json_account: json_account)
  end
end
