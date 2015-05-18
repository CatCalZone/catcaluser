defmodule Catcaluser.JsonUserView do
  use Catcaluser.Web, :view

  alias Catcaluser.JsonUser
  alias Catcaluser.User

  def render("index.json", %{jsonusers: jsonusers}) do
    IO.puts "Render may jsonusers: #{inspect jsonusers}"
    %{data: render_many(jsonusers, "json_user.json")}
  end

  def render("show.json", %{json_user: json_user}) do
    %{data: render_one(json_user, "json_user.json")}
  end

  def render("json_user.json", %{json_user: json_user = %JsonUser{}}) do
    %{id: json_user.id, email: json_user.email, name: json_user.name}
  end

end
