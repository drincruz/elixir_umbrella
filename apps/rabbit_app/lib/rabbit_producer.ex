require Logger

defmodule RabbitProducer do
  @moduledoc """
  Produces messages to send to RabbitMQ.

  ## Examples

      iex> RabbitProducer.run()
      :ok

      iex> RabbitProducer.send_message(channel, "Hello, world!")
  """

  @spec send_message(AMQP.Channel.t(), binary()) :: :ok
  def send_message(channel, message) do
    RabbitConnect.declare_exchange(channel, "logs", :fanout)
    AMQP.Basic.publish(channel, "logs", "", message)

    Logger.info " [x] Sent #{message}"
  end

  @spec run() :: :ok | {:error, :blocked | :closing}
  def run do
    {:ok, connection, channel} = RabbitConnect.connect()

    send_message(channel, "Hello, world!")

    AMQP.Connection.close(connection)
  end
end
