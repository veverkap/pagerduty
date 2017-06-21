defmodule PagerDuty.AbilitiesTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open
    Application.put_env(:pagerduty, :pagerduty_url, "http://localhost:#{bypass.port}/")
    {:ok, %{bypass: bypass}}
  end
end