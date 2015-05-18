defmodule Catcaluser.User do
  use Catcaluser.Web, :model

  schema "users" do
    field  :email,                       :string
    field  :username,                    :string
    field  :password,                    :string, virtual: true
    field  :hashed_password,             :string
    field  :hashed_confirmation_token,   :string
    field  :confirmed_at,                Ecto.DateTime
    field  :hashed_password_reset_token, :string
    field  :unconfirmed_email,           :string
    field  :authentication_tokens,       {:array, :string}, default: []

    timestamps
  end

  @required_fields ~w(email username )
  @optional_fields ~w(hashed_password hashed_confirmation_token  
    confirmed_at unconfirmed_email authentication_tokens hashed_password_reset_token)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If `params` are nil, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def has_password(%__MODULE__{hashed_password: nil}), do: "no"
  def has_password(%__MODULE__{hashed_password: ""}), do: "no"
  def has_password(%__MODULE__{}), do: "yes"
end
