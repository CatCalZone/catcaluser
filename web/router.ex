defmodule Catcaluser.Router do
  use Catcaluser.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Catcaluser do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/accounts", AccountController
  end

  # Other scopes may use custom stacks.
  # scope "/api", Catcaluser do
  #   pipe_through :api
  # end
end
