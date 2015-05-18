defmodule Catcaluser.JsonAccountView do
  use Catcaluser.Web, :view

  def render("index.json", %{jsonaccountss: jsonaccountss}) do
    %{data: render_many(jsonaccountss, "json_account.json")}
  end

  def render("show.json", %{json_account: json_account}) do
    %{data: render_one(json_account, "json_account.json")}
  end

  def render("json_account.json", %{json_account: json_account}) do
    %{id: json_account.id}
  end
end
