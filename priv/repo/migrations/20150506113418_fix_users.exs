defmodule Catcaluser.Repo.Migrations.FixUsers do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  		remove :name	
  	end

  	create index(:users, [:username], unique: true)
  end
end
