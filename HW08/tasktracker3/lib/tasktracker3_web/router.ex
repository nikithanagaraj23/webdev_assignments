defmodule Tasktracker3Web.Router do
  use Tasktracker3Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Tasktracker3Web do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    get "/users", PageController, :index
    get "/posts", PageController, :index
    get "/feed", PageController, :index
    get "/users/:id", PageController, :index
  end

  # Other scopes may use custom stacks.
  scope "/api/v1", Tasktracker3Web do
    pipe_through :api
    resources "/users", UserController, except: [:edit]
    resources "/tasks", TaskController, except: [:new, :edit]
    post "/token", TokenController, :create
  end
end
