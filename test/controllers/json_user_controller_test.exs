defmodule Catcaluser.JsonUserControllerTest do
  use Catcaluser.ConnCase

  alias Catcaluser.User
  @valid_params json_user: %{email: "some@email.zone", password: "big secret", 
    username: "some name"}
  @invalid_params json_user: %{}

  setup do
    conn = conn() |> put_req_header("accept", "application/json")
    {:ok, conn: conn}
  end

  # GET is the only request which is handled by 
  test "GET /jsonusers", %{conn: conn} do
    conn = get conn, json_user_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "GET /jsonusers/:id", %{conn: conn} do
    json_user = Repo.insert %User{}
    conn = get conn, json_user_path(conn, :show, json_user)
    assert json_response(conn, 200)["data"] == %{
      "id" => json_user.id
    }
  end

end
