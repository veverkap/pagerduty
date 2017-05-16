defmodule PagerDuty.NotificationsTest do
  use ExUnit.Case, async: false

  # setup do
  #   bypass = Bypass.open
  #   Application.put_env(:pagerduty, :pagerduty_url, "http://localhost:#{bypass.port}/")
  #   {:ok, %{bypass: bypass}}
  # end

  # account_addons
  test "account_notifications" do
    PagerDuty.Api.Notifications.account_notifications
  end
end