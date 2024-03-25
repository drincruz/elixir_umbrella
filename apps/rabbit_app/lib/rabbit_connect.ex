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

  @spec declare_exchange(AMQP.Channel.t(), binary(), atom()) ::
          :ok | {:error, :blocked | :closing}
  def declare_exchange(channel, exchange, type) do
    Logger.info("[#{__MODULE__}] declaring exchange: #{exchange}")
    AMQP.Exchange.declare(channel, exchange, type)
  end

  @spec declare_queue(AMQP.Channel.t(), binary()) ::
          :ok
          | {:error, :blocked | :closing}
          | {:ok, %{consumer_count: integer(), message_count: integer(), queue: binary()}}
  def declare_queue(channel, queue, opts \\ []) do
    Logger.info("[#{__MODULE__}] declaring queue: #{queue}")
    AMQP.Queue.declare(channel, queue, opts)
  end
end
