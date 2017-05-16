defmodule PagerDuty.AddonsTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open
    Application.put_env(:pagerduty, :pagerduty_url, "http://localhost:#{bypass.port}/")
    {:ok, %{bypass: bypass}}
  end

  # account_addons
  test "account_addons when nothing is returned", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]}          
      Plug.Conn.resp(conn, 200, "")
    end
    {:error, "No Addons Returned"} = PagerDuty.Api.Addons.account_addons
  end

  # account_addons
  test "account_addons when empty list is returned", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]}          
      Plug.Conn.resp(conn, 200, ~s<{"addons":[]}>)
    end
    {:error, "No Addons Returned"} = PagerDuty.Api.Addons.account_addons
  end 

  # account_addons
  test "account_addons when list is returned", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
      response = %{"addons" => [%PagerDuty.Addon{}]} |> Poison.encode!
      Plug.Conn.resp(conn, 200, response)
    end
    [%PagerDuty.Addon{}] = PagerDuty.Api.Addons.account_addons
  end 

  # account_addons
  test "account_addons when list is returned including services", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
      response = %{"addons" => [%PagerDuty.Addon{}]} |> Poison.encode!
      Plug.Conn.resp(conn, 200, response)
    end
    [%PagerDuty.Addon{}] = PagerDuty.Api.Addons.account_addons(include_services: true)
  end      
end