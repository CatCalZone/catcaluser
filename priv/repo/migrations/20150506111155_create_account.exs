defmodule Catcaluser.Repo.Migrations.CreateAccount do
  use Ecto.Migration

  def change do
    create table(:accounts) do
      add :name, :string
      add :address, :string
      add :city, :string
      add :zip, :string
      add :country, :string
      add :user_id, references :users

      timestamps
    end
  end
end
