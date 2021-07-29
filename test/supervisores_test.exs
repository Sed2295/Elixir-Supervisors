defmodule SupervisoresTest do
  use ExUnit.Case
  doctest Supervisores

  test "greets the world" do
    assert Supervisores.hello() == :world
  end
end
