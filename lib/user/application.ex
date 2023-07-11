defmodule User.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UserWeb.Telemetry,
      # Start the Ecto repository
      User.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: User.PubSub},
      # Start Finch
      {Finch, name: User.Finch},
      # Start the Endpoint (http/https)
      UserWeb.Endpoint
      # Start a worker by calling: User.Worker.start_link(arg)
      # {User.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: User.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UserWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
