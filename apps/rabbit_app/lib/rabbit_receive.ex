require Logger

defmodule RabbitReceive do
  def receive_message(channel, queue) do
    {:ok, _consumer} = AMQP.Basic.consume(channel, queue)
    Logger.info("[#{__MODULE__}] waiting for messages. To exit press CTRL+C")
    receive_messages(channel)
  end

  defp receive_messages(channel) do
    receive do
      {:basic_deliver, payload, _meta} ->
        Logger.info(" [#{__MODULE__}] received #{payload}")
        receive_messages(channel)
    end
  end

  def run do
    {:ok, _connection, channel} = RabbitConnect.connect()
    RabbitConnect.declare(channel, "hello")
    receive_message(channel, "hello")
  end
end
