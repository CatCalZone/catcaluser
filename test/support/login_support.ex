defmodule Catcaluser.LoginSupport do
	@moduledoc """
	This modules provides support functions for logging a user into the system
	and getting the token back. This is required for all kinds of authorized
	web requests.,	
	"""	

	alias Catcaluser.User
	alias Catcaluser.Repo

	@doc """
	Creates the user with given name, password and email-address, 
	and confirms the email address, such that a login is possible.
	"""
	def create_confirmed_user(email, password, name) do
    	login_user = PhoenixTokenAuth.Registrator.changeset(
        		%{email: email, password: password})
      		|> Repo.insert
    	login_user 
      		|> User.changeset(%{confirmed_at: Ecto.DateTime.local(), username: name})
      		|> Repo.update
      		# |> IO.inspect  	
  	end
  
  	@doc """
  	Creates a new session for the user identified with email and password.
  	Returns the generated authentication token. 
  	"""
  	def create_session(email, password) do
    	{:ok, token} = PhoenixTokenAuth.Authenticator.authenticate(email, password)
    	#u = Repo.get(User, login_user.id) |> IO.inspect
    	#assert token == hd(u.authentication_tokens)
    	token
  	end  

end