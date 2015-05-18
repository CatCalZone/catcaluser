defmodule Catcaluser.Account do
  use Catcaluser.Web, :model

  schema "accounts" do
    field :name, :string
    field :address, :string
    field :city, :string
    field :zip, :string
    field :country, :string
    
    timestamps

    belongs_to :user, Catcaluser.User
  end

  @required_fields ~w(name address city zip country user_id)
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
end
