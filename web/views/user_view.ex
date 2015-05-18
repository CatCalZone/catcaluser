defmodule Catcaluser.UserView do
  use Catcaluser.Web, :view

  @doc """
  Render all entries with a `json` prefix via `JsonUserView`.
  """
  def render(entry = "json" <> _, js), do: Catcaluser.JsonUserView.render(entry, js)
  
end
