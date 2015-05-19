defmodule Catcaluser.JsonAccountView do
  use Catcaluser.Web, :view

  alias Catcaluser.Account

  def render("index.json", %{jsonaccounts: jsonaccounts}) do
    %{data: render_many(jsonaccounts, "json_account.json")}
  end

  def render("show.json", %{json_account: json_account}) do
    # IO.puts "Render one json_account: #{inspect json_account}"
    %{data: render_one(json_account, "json_account.json")}
  end

  def render("json_account.json", %{json_account: json_account}) do
    render("json_account.json", %{account: json_account})
  end
  def render("json_account.json", %{account: json_account}) do
    %{id: json_account.id}
  end

end
