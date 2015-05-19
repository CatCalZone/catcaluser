defmodule Catcaluser.AccountView do
  use Catcaluser.Web, :view

  @doc """
  Render all entries with a `json` prefix via `JsonAccountView`.
  """
  def render(entry = "json" <> _, js), do: Catcaluser.JsonAccountView.render(entry, js)
  
end
