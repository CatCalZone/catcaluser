defmodule Catcaluser.JsonUserControllerTest do
  use Catcaluser.ConnCase

  alias Catcaluser.User
  alias Catcaluser.JsonUser
  @valid_email "some@email.zone"
  @valid_password "big secret"
  @valid_name "some name"
  @valid_params json_user: %{email: @valid_email, password: @valid_password, 
    username: @valid_name}
  @invalid_params json_user: %{}

  setup do
    Catcaluser.LoginSupport.create_confirmed_user(@valid_email, 
      @valid_password, @valid_name)
    jwt = Catcaluser.LoginSupport.create_session(@valid_email, @valid_password)
    conn = conn() 
      |> put_req_header("accept", "application/json")
    auth_conn = conn() 
      |> put_req_header("accept", "application/json")
      |> put_req_header("authorization", "Bearer #{jwt}")
    {:ok, %{conn: conn, auth_conn: auth_conn}}
  end

  # GET is the only request which is handled by 
  test "GET /jsonusers without authorization fails", %{conn: conn} do
    conn = get conn, json_user_path(conn, :index)
    assert response(conn, 401) == "{\"error\":\"Not authorized\"}"
  end

  # GET is the only request which is handled by 
  test "GET /jsonusers", %{auth_conn: conn} do
    conn = get conn, json_user_path(conn, :index)
    login_user = Repo.get_by(User, email: @valid_email)
    assert json_response(conn, 200)["data"] == [map_to_json(login_user)]
  end


  test "GET many /jsonusers", %{auth_conn: conn} do
    user1 = Repo.insert %User{email: "user1@mail.org"}
    user2 = Repo.insert %User{email: "user2@mail.org"}

    conn = get conn, json_user_path(conn, :index)
    login_user = Repo.get_by(User, email: @valid_email)

    assert json_response(conn, 200)["data"] |> is_list

    data = json_response(conn, 200)["data"]
    assert length(data) == 3
    # IO.inspect data
    [user1, user2, login_user] 
      |> Enum.map(&JsonUser.from_user/1)
      # |> Enum.map(&(Catcaluser.JsonUserView.render("json_user.json", %{json_user: &1}) ))
      |> Enum.map(&map_to_json/1)
      # |> IO.inspect
      |> Enum.each fn(u) -> assert Enum.member?(data, u) end
  end

  test "GET /jsonusers/:id", %{auth_conn: conn} do
    json_user = Repo.insert %User{}
    conn = get conn, json_user_path(conn, :show, json_user)
    assert json_response(conn, 200)["data"] == map_to_json(json_user) 
  end

  @doc """
  Maps a `User`, a `JsonUser` or another kind of map with atoms as keys to 
  the string valued map-structure. The keys `:email`, `:id` and `:name` are 
  required.
  """
  def map_to_json(json_user = %{name: n}) do
    %{"id" => json_user.id, "email" => json_user.email, "name" => n}
  end
  def map_to_json(json_user = %{username: n}) do
    %{"id" => json_user.id, "email" => json_user.email, "name" => n}
  end

end
