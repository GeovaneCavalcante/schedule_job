defmodule ScheduleJob.Repo do
  use Ecto.Repo,
    otp_app: :schedule_job,
    adapter: Ecto.Adapters.Postgres
end
