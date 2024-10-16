defmodule GotQuotesApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      GotQuotesApiWeb.Telemetry,
      GotQuotesApi.Repo,
      {DNSCluster, query: Application.get_env(:got_quotes_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: GotQuotesApi.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: GotQuotesApi.Finch},
      # Start a worker by calling: GotQuotesApi.Worker.start_link(arg)
      # {GotQuotesApi.Worker, arg},
      # Start to serve requests, typically the last entry
      GotQuotesApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: GotQuotesApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    GotQuotesApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
