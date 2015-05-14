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
    plug CORSPlug, [origin: "http://localhost:9000"]
  end

  scope "/", Catcaluser do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/accounts", AccountController

    # get "/login.html"
    resources "/login", SessionController 
    # get "/login", SessionController, :index
    # post "/login"
  end

  # Other scopes may use custom stacks.
  scope "/api", Catcaluser do
    pipe_through :api
    resources "/users", UserJsController
  end
end
