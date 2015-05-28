defmodule Catcaluser.Mailer do
	@moduledoc """
	This module holds some callbacks for the mail module configuration
	of `phonex_token_auth` and mailgun.
	"""
	@behaviour PhoenixTokenAuth.MailingBehaviour

	alias Catcaluser.User

	def welcome_subject(%User{} = user) do
		"Welcome to CatCal.Zone, dear #{user.email}"
	end

	def welcome_body(%User{} = user, confirmation_token) do
		"Please click on this link #{confirmation_token} to confirm your new login"		
	end
	
	def password_reset_subject(%User{} = user) do
		"Resetting your password at CatCal.Zone, dear #{user.email}"
	end

	def password_reset_body(%User{} = user, reset_token) do
		"Please click on this link #{reset_token} to confirm your new login"		
	end	

	def new_email_address_subject(%User{} = user) do
		"Please confirm your email address for CatCal.Zone, dear #{user.email}"
	end

	def new_email_address_body(%User{} = user, confirmation_token) do
		"Please click on this link #{confirmation_token} to confirm your new address"		
	end	
	
end