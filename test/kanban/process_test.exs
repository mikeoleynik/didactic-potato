defmodule Kanban.ProcessTest do
  use ExUnit.Case
  doctest Kanban.Process

  test "process return :ok" do
    {result, _pid} = Kanban.Process.start_link(%{foo: :bar})

    assert result == :ok
    assert GenServer.call(Kanban.Process, {:hello, [1, 2]}) == :ok
  end

  test "called handle_cast/2" do
    Kanban.Process.start_link(%{foo: :bar})

    assert GenServer.cast(Kanban.Process, {:ping, self()}) == :ok
    assert_receive :pong
  end

  test "called handle_info/2" do
    {:ok, pid} = Kanban.Process.start_link(:work)
    GenServer.cast(Kanban.Process, {:ping, self()})

    assert send(pid, :work == :work)
    assert_receive :pong
  end
end
