defmodule Catcaluser.Repo.Migrations.UserForTokenAuth do
  use Ecto.Migration

  def change do
  	alter table(:users) do
  		remove :hash
  		remove :recovery_hash

		add :hashed_password,              :string 	
		add  :hashed_confirmation_token,   :string
  		add  :confirmed_at,                :datetime
  		add  :hashed_password_reset_token, :string
  		add  :unconfirmed_email,           :string
  		add  :authentication_tokens,       {:array, :string}
  	end
  end
end
