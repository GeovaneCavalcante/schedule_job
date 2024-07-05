import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :schedule_job, ScheduleJob.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "localhost",
  database: "schedule_job_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: System.schedulers_online() * 2

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :schedule_job, ScheduleJobWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "ZxJQz06TNTM2Y2jhhgb1tHroJQ3ZRAGRtVivyzXuDeFERUh8xau4XI8tf/GIfl0v",
  server: false

# Print only warnings and errors during test
config :logger, level: :warning

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
