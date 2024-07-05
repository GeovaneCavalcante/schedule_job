defmodule ScheduleJob.ScheduleTest do
  use Oban.Worker, queue: :events

  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id} = args}) do
    case args do
      "teste" ->
        IO.inspect("TESTE")

      "teste2" ->
        IO.inspect("TESTE2")
    end

    :ok
  end
end
