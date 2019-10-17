defmodule Clock.Server do
  use GenServer
  
  require Logger
  alias Logger, as: LOG

  #@vsn "0.1.0"
  @vsn Mix.Project.config[:version]
  
  def start_link(_),
    do: GenServer.start_link(__MODULE__, %{})

  def init(_default) do
    state = %{interval: Application.get_env(:clock, :interval)}
    #IO.puts("Init. with #{state[:interval]} ms interval ;-)")
    LOG.info("Init. with #{state[:interval]} ms interval ;-)")
    {:ok, state, 0}
  end

  def handle_info(:timeout, state) do
    date = DateTime.utc_now() |> DateTime.to_iso8601()
    version = Application.spec(:clock, :vsn)
    #IO.puts("Clock Server [#{version}]: #{date}")
    LOG.info("Clock srv. ~> [#{version}]: #{date}")
    {:noreply, state, state[:interval]}
  end

end
