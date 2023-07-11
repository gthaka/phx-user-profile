defmodule UserWeb.Router do
  use UserWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {UserWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", UserWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  # other
  scope "/", UserWeb do
    pipe_through :browser

    live "/users", UsrLive.Index, :index
    live "/users/new", UsrLive.Index, :new
    live "/users/:id/edit", UsrLive.Index, :edit

    live "/users/:id", UsrLive.Show, :show
    live "/users/:id/show/edit", UsrLive.Show, :edit
  end

  # Other scopes may use custom stacks.
  # scope "/api", UserWeb do
  #   pipe_through :api
  # end

  # Enable Swoosh mailbox preview in development
  if Application.compile_env(:user, :dev_routes) do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
