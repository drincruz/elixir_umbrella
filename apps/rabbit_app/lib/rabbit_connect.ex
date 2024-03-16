require Logger

defmodule RabbitConnect do
  @spec connect() :: {:ok, AMQP.Connection.t(), AMQP.Channel.t()}
  def connect do
    {:ok, connection} = AMQP.Connection.open
    {:ok, channel} = AMQP.Channel.open(connection)
    Logger.info("[#{__MODULE__}] connected to RabbitMQ!")


    {:ok, connection, channel}
  end

  @spec declare(AMQP.Channel.t(), binary()) ::
          :ok
          | {:error, :blocked | :closing}
          | {:ok, %{consumer_count: integer(), message_count: integer(), queue: binary()}}
  def declare(channel, queue) do
    Logger.info("[#{__MODULE__}] declaring queue: #{queue}")
    AMQP.Queue.declare(channel, queue)
  end
end
