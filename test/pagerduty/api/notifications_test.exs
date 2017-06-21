defmodule PagerDuty.NotificationsTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open
    Application.put_env(:pagerduty, :pagerduty_url, "http://localhost:#{bypass.port}/")
    {:ok, %{bypass: bypass}}
  end

  # account_addons
  test "account_notifications", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      response = File.read!("./json/notifications.json")
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]}          
      Plug.Conn.resp(conn, 200, response)
    end

    IO.inspect PagerDuty.Api.Notifications.account_notifications
  end
end