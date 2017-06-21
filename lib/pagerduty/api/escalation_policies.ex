defmodule PagerDuty.Api.EscalationPolicies do
  @moduledoc ~S"""
  Module encompassing interactions with the escalation policies API endpoint
  """
  use PagerDuty.Api.Common
  require Logger

  @doc ~S"""
  List all of your account's escalation policies
  """
  @spec account_escalation_policies(list(Keyword)) :: list(PagerDuty.EscalationPolicy)
  def account_escalation_policies(options \\ []) do
    defaults = [query: nil, user_ids: [], team_ids: [], include: [], sort_by: "name"]
    query = Keyword.merge(defaults, options) |> Enum.into(%{}) |> load_query
    Logger.info "#{inspect query}"
    all_account_escalation_policies(query)
  end

  @spec all_account_escalation_policies(list) :: list(PagerDuty.EscalationPolicy) | {:error, String.t}
  defp all_account_escalation_policies(nil), do: all_account_escalation_policies
  defp all_account_escalation_policies(query) do
    query = Map.to_list(query)
    get("/escalation_policies", query: query)
    |> handle_response
  end
  
  @spec all_account_escalation_policies :: list(PagerDuty.EscalationPolicy) | {:error, String.t}
  defp all_account_escalation_policies do
    get("/escalation_policies")
    |> handle_response
  end  

  @spec create_escalation_policy(String.t, PagerDuty.EscalationPolicy) :: PagerDuty.EscalationPolicy | {:error, String.t}
  def create_escalation_policy(_, %{name: nil}), do: {:error, "Escalation Policy name is required"}
  def create_escalation_policy(_, %{escalation_rules: []}), do: {:error, "Escalation Policy Rules are required"}
  def create_escalation_policy(_, %{services: []}), do: {:error, "Escalation Policy Services are required"}
  def create_escalation_policy(_, %{teams: []}), do: {:error, "Escalation Policy Teams are required"}
  def create_escalation_policy(from_email, escalation_policy) do
    data = %{"escalation_policy" => escalation_policy} |> Poison.encode!
    IO.inspect data

    Tesla.post(base_url <> "/escalation_policies", 
               data, 
               headers: %{"Content-Type" => "application/json", 
                          "Accept" => "application/vnd.pagerduty+json;version=2", 
                          "From" => from_email,
                          "Authorization" => token})
    |> IO.inspect
    # # |> handle_response

    IO.inspect from_email
  end


  defp handle_response(%Tesla.Env{status: 200, body: ""}), do: {:error, "No Escalation Policies Returned"}
  defp handle_response(%Tesla.Env{status: 200, body: nil}), do: {:error, "No Escalation Policies Returned"}
  defp handle_response(%Tesla.Env{status: 200, body: %{"escalation_policies" => []}}), do: {:error, "No Escalation Policies Returned"}

  defp handle_response(%Tesla.Env{status: 200, body: %{"escalation_policy" => escalation_policy}}) do
    escalation_policy
    |> PagerDuty.EscalationPolicy.new
  end

  defp handle_response(%Tesla.Env{status: 200, body: %{"escalation_policies" => escalation_polices}}) do
    escalation_polices
    |> Enum.map(&PagerDuty.EscalationPolicy.new/1)
  end

  defp handle_response(%Tesla.Env{status: 200, body: body}) do
    body
    |> Poison.decode!
    |> Map.get("escalation_policies") 
    |> PagerDuty.Addon.new
  end

  defp handle_response(%Tesla.Env{status: 201, body: body}) do
    body
    |> Poison.decode!
    |> Map.get("escalation_policy") 
    |> PagerDuty.Addon.new
  end

  defp handle_response(%Tesla.Env{status: 204}) do
    {:ok, "Deleted"}
  end


  defp load_query(query = %{query: query}) when is_binary(query) do
    Map.delete(query, :query)
    |> Map.merge(%{"query" => query})
    |> load_query
  end

  defp load_query(query = %{query: _}) do 
    Map.delete(query, :query)
    |> load_query
  end

  defp load_query(query = %{include: []}) do
    Map.delete(query, :include)
    |> load_query
  end
  
  defp load_query(query = %{include: include}) do
    Map.delete(query, :include)
    |> Map.merge(%{"include[]" => include})
    |> load_query
  end  

  defp load_query(query = %{team_ids: []}) do
    Map.delete(query, :team_ids)
    |> load_query
  end
  
  defp load_query(query = %{team_ids: team_ids}) do
    Map.delete(query, :team_ids)
    |> Map.merge(%{"team_ids" => team_ids})
    |> load_query
  end  

  defp load_query(query = %{user_ids: []}) do
    Map.delete(query, :user_ids)
    |> load_query
  end

  defp load_query(query = %{user_ids: user_ids}) do
    Map.delete(query, :user_ids)
    |> Map.merge(%{"user_ids" => user_ids})
    |> load_query
  end  

  defp load_query(query = %{sort_by: sort_by}) when sort_by == "name" or sort_by == "name:asc" or sort_by == "name:desc" do
    Map.delete(query, :sort_by)
    |> Map.merge(%{"sort_by" => sort_by})
  end
end