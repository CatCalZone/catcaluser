defmodule Catcaluser.JsonAccountControllerTest do
  use Catcaluser.ConnCase

  alias Catcaluser.Account, as: JsonAccount
  alias Catcaluser.User

  @valid_params account: %{address: "some address", city: "some city", 
    country: "some country", name: "some name", # user_id: 42, 
    zip: "some zip"}
  @invalid_params account: %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  def valid_account(user_id) do
    params = Dict.merge(@valid_params[:account], [user_id: user_id])
    %{:account => params}
  end

  test "GET /jsonaccounts", %{conn: conn} do
    user = Repo.insert %User{}
    conn = get conn, json_user_json_account_path(conn, :index, user.id)
    assert json_response(conn, 200)["data"] == []
  end

  test "GET /jsonaccounts/:id", %{conn: conn} do
    user = Repo.insert %User{}
    json_account = Repo.insert %JsonAccount{user_id: user.id}
    conn = get conn, json_user_json_account_path(conn, :show, user.id, json_account)
    assert json_response(conn, 200)["data"] == %{
      "id" => json_account.id
    }
  end

  test "POST /jsonaccounts with valid data", %{conn: conn} do
    user = Repo.insert %User{email: "someone@some.where"}
    acc = valid_account(user.id)
    # IO.inspect acc
    conn = post conn, 
        json_user_json_account_path(conn, :create, user.id), acc
    assert json_response(conn, 200)["data"]["id"]
  end

  test "POST /jsonaccounts with invalid data", %{conn: conn} do
    user = Repo.insert %User{}
    conn = post conn, json_user_json_account_path(conn, :create, user.id), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "PUT /jsonaccounts/:id with valid data", %{conn: conn} do
    user = Repo.insert %User{}
    json_account = Repo.insert %JsonAccount{user_id: user.id}
    conn = put conn, json_user_json_account_path(conn, :update, user.id, json_account), @valid_params
    assert json_response(conn, 200)["data"]["id"]
  end

  test "PUT /jsonaccounts/:id with invalid data", %{conn: conn} do
    user = Repo.insert %User{}
    json_account = Repo.insert %JsonAccount{user_id: user.id}
    conn = put conn, json_user_json_account_path(conn, :update, user.id, json_account), @invalid_params
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "DELETE /jsonaccounts/:id", %{conn: conn} do
    user = Repo.insert %User{}
    json_account = Repo.insert %JsonAccount{user_id: user.id}
    conn = delete conn, json_user_json_account_path(conn, :delete, user.id, json_account)
    assert json_response(conn, 200)["data"]["id"]
    refute Repo.get(JsonAccount, json_account.id)
  end
end
