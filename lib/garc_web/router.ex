defmodule GarcWeb.Router do
  use GarcWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {GarcWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    plug GarcWeb.Guardian.GuardianPipeline
  end

  scope "/", GarcWeb do
    pipe_through [:browser, :authenticated]

    live "/", HomeLive.Index, :index
    live "/home", HomeLive.Index, :index

    live "/products", ProductLive.Index, :index
    live "/products/new", ProductLive.Form, :new
    live "/products/edit/:id", ProductLive.Form, :edit
    live "/products/edit/:id/:step", ProductLive.Form, :edit
  end

  scope "/", GarcWeb do
    pipe_through :browser

    live "/login", LoginLive.Index, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", GarcWeb do
  #   pipe_through :api
  # end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: GarcWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
