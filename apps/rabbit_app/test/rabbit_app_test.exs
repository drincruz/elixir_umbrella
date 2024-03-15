defmodule RabbitAppTest do
  use ExUnit.Case
  doctest RabbitApp

  test "greets the world" do
    assert RabbitApp.hello() == :world
  end
end
