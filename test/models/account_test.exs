defmodule Catcaluser.AccountTest do
  use Catcaluser.ModelCase

  alias Catcaluser.Account

  @valid_attrs %{address: "some content", city: "some content", country: "some content", name: "some content", user_id: 42, zip: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Account.changeset(%Account{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Account.changeset(%Account{}, @invalid_attrs)
    refute changeset.valid?
  end
end
