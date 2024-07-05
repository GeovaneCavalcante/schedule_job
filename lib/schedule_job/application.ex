defmodule ScheduleJob.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ScheduleJobWeb.Telemetry,
      ScheduleJob.Repo,
      {Oban, Application.fetch_env!(:schedule_job, Oban)},
      {DNSCluster, query: Application.get_env(:schedule_job, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: ScheduleJob.PubSub},
      # Start a worker by calling: ScheduleJob.Worker.start_link(arg)
      # {ScheduleJob.Worker, arg},
      # Start to serve requests, typically the last entry
      ScheduleJobWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ScheduleJob.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    ScheduleJobWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
