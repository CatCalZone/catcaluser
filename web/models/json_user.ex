defmodule Catcaluser.JsonUser do
  use Catcaluser.Web, :model

  schema "json_users" do
    field  :email,                       :string, virtual: true
    field  :name,                        :string, virtual: true
    field  :password,                    :string, virtual: true
  end

  @required_fields ~w(email username password)
  @optional_fields ~w()

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def from_user(%Catcaluser.User{email: email, username: name, id: id}) do
  	%__MODULE__{email: email, name: name, id: id}
  end
  
end
