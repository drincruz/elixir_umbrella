require Logger

defmodule RabbitConsumer do
  @moduledoc """
  Consumes messages from RabbitMQ.
  """

  @spec consume_message(AMQP.Channel.t(), binary()) :: :ok
  def consume_message(channel, queue) do
    {:ok, _consumer} = AMQP.Basic.consume(channel, queue, nil, no_ack: true)
    Logger.info("[#{__MODULE__}] waiting for messages. To exit press CTRL+C")
    consume_messages(channel)
  end

  defp consume_messages(channel) do
    receive do
      {:basic_deliver, payload, _meta} ->
        Logger.info(" [#{__MODULE__}] received #{payload}")
        consume_messages(channel)
    end
  end

  @spec run() :: :ok | {:error, :blocked | :closing}
  def run do
    {:ok, _connection, channel} = RabbitConnect.connect()
    RabbitConnect.declare_exchange(channel, "logs", :fanout)
    {:ok, %{queue: queue_name}} = RabbitConnect.declare_queue(channel, "", exclusive: true)
    AMQP.Queue.bind(channel, queue_name, "logs")
    consume_message(channel, queue_name)
  end
end
