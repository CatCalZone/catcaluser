defmodule Catcaluser.Router do
  use Catcaluser.Web, :router
  require PhoenixTokenAuth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug PhoenixTokenAuth.Plug
  end


  scope "/", Catcaluser do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    post "/users/:id/confirm", UserController, :confirm
    resources "/accounts", AccountController

    # get "/login.html"
    resources "/login", SessionController 
    # get "/login", SessionController, :index
    # post "/login"
  end

  scope "/api" do
    PhoenixTokenAuth.mount
  end

  # Other scopes may use custom stacks.
  scope "/api", Catcaluser do
    pipe_through :api
    resources "/users", JsonUserController , only: [:index, :show, :delete]
    resources "/users/:user_id/account", AccountJsController, 
      only: [:create, :delete, :show, :update ]
  end
end
