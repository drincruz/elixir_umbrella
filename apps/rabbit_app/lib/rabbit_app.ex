defmodule RabbitApp do
  @moduledoc """
  Documentation for `RabbitApp`.
  """

  def send_message(channel, message) do
    AMQP.Basic.publish(channel, "", "hello", message)

    IO.puts " [x] Sent #{message}"
  end

  @spec run() :: :ok | {:error, :blocked | :closing}
  def run do
    {:ok, connection, channel} = RabbitConnect.connect()
    RabbitConnect.declare(channel, "hello")
    send_message(channel, "Hello, world!")

    AMQP.Connection.close(connection)
  end

  @doc """
  Hello world.

  ## Examples

      iex> RabbitApp.hello()
      :world

  """
  def hello do
    :world
  end
end
