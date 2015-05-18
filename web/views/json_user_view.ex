defmodule Catcaluser.JsonUserView do
  use Catcaluser.Web, :view

  def render("index.json", %{jsonusers: jsonusers}) do
    IO.puts "Render may jsonusers: #{inspect jsonusers}"
    %{data: render_many(jsonusers, "json_user.json")}
  end

  def render("show.json", %{json_user: json_user}) do
    %{data: render_one(json_user, "json_user.json")}
  end

  def render("json_user.json", %{json_user: json_user}) do
    %{id: json_user.id}
  end

end
