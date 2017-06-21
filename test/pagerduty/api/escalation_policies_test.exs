defmodule PagerDuty.EscalationPoliciesTest do
  use ExUnit.Case, async: false

  setup do
    bypass = Bypass.open
    Application.put_env(:pagerduty, :pagerduty_url, "http://localhost:#{bypass.port}/")
    {:ok, %{bypass: bypass}}
  end

  # # account_escalation_policies
  # test "account_escalation_policies when nothing is returned", %{bypass: bypass} do
  #   Bypass.expect bypass, fn conn ->
  #     conn = %{conn | resp_headers: [{"content-type", "application/json"}]}          
  #     Plug.Conn.resp(conn, 200, "")
  #   end
  #   {:error, "No Escalation Policies Returned"} = PagerDuty.Api.EscalationPolicies.account_escalation_policies
  # end

  # # account_escalation_policies
  # test "account_escalation_policies when empty list is returned", %{bypass: bypass} do
  #   Bypass.expect bypass, fn conn ->
  #     conn = %{conn | resp_headers: [{"content-type", "application/json"}]}          
  #     Plug.Conn.resp(conn, 200, ~s<{"escalation_policies":[]}>)
  #   end
  #   {:error, "No Escalation Policies Returned"} = PagerDuty.Api.EscalationPolicies.account_escalation_policies
  # end 

  # # account_escalation_policies
  # test "account_escalation_policies when list is returned", %{bypass: bypass} do
  #   Bypass.expect bypass, fn conn ->
  #     conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
  #     response = %{"escalation_policies" => [%PagerDuty.EscalationPolicy{escalation_rules: [%PagerDuty.EscalationRule{}]}]} |> Poison.encode!
  #     Plug.Conn.resp(conn, 200, response)
  #   end
  #   [%PagerDuty.EscalationPolicy{}] = PagerDuty.Api.EscalationPolicies.account_escalation_policies
  # end 

  # create_escalation_policy
  test "create_escalation_policy without values" do
    policy = %PagerDuty.EscalationPolicy{}
    {:error, "Escalation Policy name is required"} = PagerDuty.Api.EscalationPolicies.create_escalation_policy("patrick@veverka.net", policy)
  
    policy = %PagerDuty.EscalationPolicy{name: "BLAH"}
    {:error, "Escalation Policy Rules are required"} = PagerDuty.Api.EscalationPolicies.create_escalation_policy("patrick@veverka.net", policy)

    policy = %PagerDuty.EscalationPolicy{name: "BLAH", escalation_rules: [%PagerDuty.EscalationRule{}]}
    {:error, "Escalation Policy Services are required"} = PagerDuty.Api.EscalationPolicies.create_escalation_policy("patrick@veverka.net", policy)    

    policy = %PagerDuty.EscalationPolicy{name: "BLAH", escalation_rules: [%PagerDuty.EscalationRule{}], services: []}
    {:error, "Escalation Policy Services are required"} = PagerDuty.Api.EscalationPolicies.create_escalation_policy("patrick@veverka.net", policy)

    policy = %PagerDuty.EscalationPolicy{name: "BLAH", escalation_rules: [%PagerDuty.EscalationRule{}], services: [%PagerDuty.Service{}]}
    {:error, "Escalation Policy Teams are required"} = PagerDuty.Api.EscalationPolicies.create_escalation_policy("patrick@veverka.net", policy)

    policy = %PagerDuty.EscalationPolicy{name: "BLAH", escalation_rules: [%PagerDuty.EscalationRule{}], services: [%PagerDuty.Service{}], teams: []}
    {:error, "Escalation Policy Teams are required"} = PagerDuty.Api.EscalationPolicies.create_escalation_policy("patrick@veverka.net", policy)    
  end   

  # test "creeate_escalation_policy", %{bypass: bypass} do
  #   Bypass.expect bypass, fn conn ->
  #     conn = %{conn | resp_headers: [{"content-type", "application/json"}]} 
  #     response = %{"escalation_policies" => [%PagerDuty.EscalationPolicy{}]} |> Poison.encode!
  #     Plug.Conn.resp(conn, 200, response)
  #   end
  #   policy = %PagerDuty.EscalationPolicy{name: "Guido"}
  #   IO.inspect PagerDuty.Api.EscalationPolicies.create_escalation_policy("patrick@veverka.net", policy)
  # end   
end