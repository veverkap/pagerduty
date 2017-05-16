defmodule PagerDuty.Server do
  @moduledoc false
  require Logger
  use GenServer

  def start_link(service_key) do
    Logger.info "service_key = #{inspect service_key}"
    GenServer.start_link(__MODULE__, service_key, name: __MODULE__)
  end

end
