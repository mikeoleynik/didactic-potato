defmodule Kanban.Process do
  @moduledoc """
  Process to be run
  """

  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl GenServer
  def init(state), do: {:ok, state}

  @impl GenServer
  def handle_info(msg, state) do
    IO.puts("This is handle_info/2")
    schedule_work()
    {:noreply, state}
  end

  @impl GenServer
  def handle_call(msg, from, state) do
    IO.inspect({msg, from, state}, label: "CALL")
    {:reply, :ok, state}
  end

  @impl GenServer
  def handle_cast({:ping, pid}, state) do
    send(pid, :pong)
    {:noreply, state}
  end

  defp schedule_work() do
    Process.send_after(self(), :work, 2 * 1000)
  end
end
