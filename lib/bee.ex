defmodule Hive.Bee do
  require Logger
  use GenServer

  def start_link(opts \\ []) do
    {:ok, pid} = GenServer.start_link __MODULE__, [], opts
    Logger.info "Bee #{inspect pid} standing by..."

    {:ok, pid}
  end

  def init([]) do
    {:ok, %{honey: nil}}
  end

  def gather_honey(pid), do: GenServer.call pid, {pid, :gather_honey}

  def handle_call({pid, :gather_honey}, from, state) do
    Logger.info "Bee #{inspect pid} going to get some honey!"
    honey_state = (0..9000000)
    |> Enum.map( &(:math.pow(&1, 0.5)) )
    |> List.last
    Logger.info "Bee #{inspect pid} got some honey!"

    {:reply, honey_state, state}
  end
end
