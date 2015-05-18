defmodule Catcaluser.AccountControllerTest do
  use Catcaluser.ConnCase

  alias Catcaluser.Account
  alias Catcaluser.User
  @valid_params account: %{address: "some address", city: "some city", 
    country: "some country", name: "some name", # user_id: 42, 
    zip: "some zip"}
  @invalid_params account: %{}

  setup do
    conn = conn()
    {:ok, conn: conn}
  end

  def valid_account(user_id) do
    params = Dict.merge(@valid_params[:account], [user_id: user_id])
    %{:account => params}
  end

  test "GET /accounts", %{conn: conn} do
    conn = get conn, account_path(conn, :index)
    assert html_response(conn, 200) =~ "Listing accounts"
  end

  test "GET /accounts/new", %{conn: conn} do
    conn = get conn, account_path(conn, :new)
    assert html_response(conn, 200) =~ "New account"
  end

  test "POST /accounts with valid data", %{conn: conn} do
    user = Repo.insert %User{}
    acc = valid_account(user.id)
    conn = post conn, account_path(conn, :create), acc 
    assert redirected_to(conn) == account_path(conn, :index)
  end

  test "POST /accounts with invalid data", %{conn: conn} do
    conn = post conn, account_path(conn, :create), @invalid_params
    assert html_response(conn, 200) =~ "New account"
  end

  test "GET /accounts/:id", %{conn: conn} do
    user = Repo.insert %User{}
    account = Repo.insert %Account{user_id: user.id}
    conn = get conn, account_path(conn, :show, account)
    assert html_response(conn, 200) =~ "Show account"
  end

  test "GET /accounts/:id/edit", %{conn: conn} do
    account = Repo.insert %Account{}
    conn = get conn, account_path(conn, :edit, account)
    assert html_response(conn, 200) =~ "Edit account"
  end

  test "PUT /accounts/:id with valid data", %{conn: conn} do
    user = Repo.insert %User{}
    account = Repo.insert %Account{user_id: user.id}
    conn = put conn, account_path(conn, :update, account), @valid_params
    assert redirected_to(conn) == account_path(conn, :index)
  end

  test "PUT /accounts/:id with invalid data", %{conn: conn} do
    account = Repo.insert %Account{}
    conn = put conn, account_path(conn, :update, account), @invalid_params
    assert html_response(conn, 200) =~ "Edit account"
  end

  test "DELETE /accounts/:id", %{conn: conn} do
    account = Repo.insert %Account{}
    conn = delete conn, account_path(conn, :delete, account)
    assert redirected_to(conn) == account_path(conn, :index)
    refute Repo.get(Account, account.id)
  end
end
