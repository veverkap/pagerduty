defmodule PagerDuty.AbilitiesTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open
    Application.put_env(:pagerduty, :pagerduty_url, "http://localhost:#{bypass.port}/")
    {:ok, %{bypass: bypass}}
  end

  # account_abilities
  test "account_abilites when nothing is returned", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]}          
      Plug.Conn.resp(conn, 200, "")
    end
    {:error, "No Abilities Returned"} = PagerDuty.Api.Abilities.account_abilities
  end

  # account_abilities
  test "account_abilites when empty list is returned", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]}          
      Plug.Conn.resp(conn, 200, ~s<{"abilities":[]}>)
    end
    {:error, "No Abilities Returned"} = PagerDuty.Api.Abilities.account_abilities
  end 

  # account_abilities
  test "account_abilites when list is returned", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
      response = %{"abilities" => ["teams", "read_only_users"]} |> Poison.encode!
      Plug.Conn.resp(conn, 200, response)
    end
    ["read_only_users", "teams"] = PagerDuty.Api.Abilities.account_abilities
  end 

  # list_abilities
  test "list_abilities when nothing is returned", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]}          
      Plug.Conn.resp(conn, 200, "")
    end
    {:error, "No Abilities Returned"} = PagerDuty.Api.Abilities.list_abilities
  end
  
  # list_abilities
  test "list_abilities when empty list is returned", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]}          
      Plug.Conn.resp(conn, 200, ~s<{"abilities":[]}>)
    end
    {:error, "No Abilities Returned"} = PagerDuty.Api.Abilities.list_abilities
  end 

  # list_abilities
  test "list_abilities when list is returned", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
      response = %{"abilities" => ["teams", "read_only_users"]} |> Poison.encode!
      Plug.Conn.resp(conn, 200, response)
    end
    ["read_only_users", "teams"] = PagerDuty.Api.Abilities.list_abilities
  end

  test "account_has_ability when account has ability", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
      Plug.Conn.resp(conn, 204, "")
    end
    assert PagerDuty.Api.Abilities.account_has_ability("test")
  end

  test "account_has_ability when account does not have ability", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
      Plug.Conn.resp(conn, 404, "")
    end
    {:error, "Not Found"} = PagerDuty.Api.Abilities.account_has_ability("test")
  end 

  test "test_ability when account has ability", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
      Plug.Conn.resp(conn, 204, "")
    end
    assert PagerDuty.Api.Abilities.test_ability("test")
  end

  test "test_ability when account does not have ability", %{bypass: bypass} do
    Bypass.expect bypass, fn conn ->
      conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
      Plug.Conn.resp(conn, 404, "")
    end
    {:error, "Not Found"} = PagerDuty.Api.Abilities.test_ability("test")
  end 
end