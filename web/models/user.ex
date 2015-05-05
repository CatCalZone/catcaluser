defmodule Catcaluser.User do
  use Catcaluser.Web, :model

  schema "users" do
    field :email, :string
    field :username, :string
    field :hash, :string
    field :recovery_hash, :string
    field :name, :string

    timestamps
  end

  @required_fields ~w(email username hash recovery_hash name)
  @optional_fields ~w()

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
