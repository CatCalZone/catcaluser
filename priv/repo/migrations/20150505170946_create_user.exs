defmodule Catcaluser.Repo.Migrations.CreateUser do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :email, :string
      add :username, :string
      add :hash, :string
      add :recovery_hash, :string
      add :name, :string

      timestamps
    end

    create index(:users, [:email], unique: true)
  end
end
