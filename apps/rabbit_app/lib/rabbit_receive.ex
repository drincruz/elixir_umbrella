defmodule RabbitReceive do
  def receive_message(channel, queue) do
    {:ok, _consumer} = AMQP.Basic.consume(channel, queue)
    IO.puts " [*] Waiting for messages. To exit press CTRL+C"
    receive_messages(channel)
  end

  defp receive_messages(channel) do
    receive do
      {:basic_deliver, payload, _meta} ->
        IO.puts " [x] Received #{payload}"
        receive_messages(channel)
    end
  end

  def run do
    {:ok, _connection, channel} = RabbitConnect.connect()
    RabbitConnect.declare(channel, "hello")
    receive_message(channel, "hello")
  end
end
