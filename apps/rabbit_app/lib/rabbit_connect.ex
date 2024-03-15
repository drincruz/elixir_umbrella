defmodule RabbitConnect do
  def connect do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)

    {:ok, connection, channel}
  end

  def declare(channel, queue) do
    AMQP.Queue.declare(channel, queue)
  end
end
