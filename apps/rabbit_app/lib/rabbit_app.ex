require Logger

defmodule RabbitApp do
  @moduledoc """
  Documentation for `RabbitApp`.
  """

  @spec send_message(AMQP.Channel.t(), binary()) :: :ok
  def send_message(channel, message) do
    AMQP.Basic.publish(channel, "", "hello", message)

    Logger.info " [x] Sent #{message}"
  end

  @spec run() :: :ok | {:error, :blocked | :closing}
  def run do
    {:ok, connection, channel} = RabbitConnect.connect()
    RabbitConnect.declare(channel, "hello")
    send_message(channel, "Hello, world!")

    AMQP.Connection.close(connection)
  end
end
