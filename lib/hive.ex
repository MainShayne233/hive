defmodule Hive do
  use Application
  require Logger
  alias Hive.{Bee, Beehive}

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # supervisor(Hive.Endpoint, []),
      supervisor(Hive.Beehive, []),
    ]

    opts = [strategy: :one_for_one, name: Hive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  def buzz(honeys_desired, honeys_gathered \\ 0)
  def buzz(honeys_desired, honeys_desired), do: {:ok, :all_spawned}
  def buzz(honeys_desired, honeys_gathered) do
    spawn fn -> Beehive.gather_honey end

    buzz honeys_desired, honeys_gathered + 1
  end

end
