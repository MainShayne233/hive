defmodule Hive.Beehive do
  use Supervisor
  require Logger

  alias Hive.{Bee}

  def start_link do
    Logger.info "Starting up Hive.Beehive supervisor"
    Supervisor.start_link __MODULE__, []
  end

  def init([]) do
    hive_opts = [
      name: {:local, :hive_poolboy},
      worker_module: Bee,
      size: 20,
      max_overflow: 10,
    ]

    Logger.info "Bees assmple!"

    children = [
      :poolboy.child_spec(:hive_poolboy, hive_opts)
    ]

    supervise children, strategy: :one_for_one, name: __MODULE__
  end

  def gather_honey do
    :poolboy.transaction :hive_poolboy, &Bee.gather_honey/1
  end
end
