defmodule Catcaluser.User do
  use Catcaluser.Web, :model

  schema "users" do
    field :email, :string
    field :username, :string
    field :hash, :string
    field :recovery_hash, :string
    field :password, :string, virtual: true

    timestamps
  end

  @required_fields ~w(email username )
  @optional_fields ~w(hash recovery_hash)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ nil) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end
end