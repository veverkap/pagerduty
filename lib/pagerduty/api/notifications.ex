defmodule PagerDuty.Api.Notifications do
  @moduledoc ~S"""
  Module encompassing interactions with the abilities API endpoint
  """
  use PagerDuty.Api.Common
  require Logger

  def account_notifications(options \\ []) do
    since = %DateTime{DateTime.utc_now() | day: DateTime.utc_now().day - 10}
            |> DateTime.to_iso8601
    until = DateTime.utc_now()
            |> DateTime.to_iso8601


    IO.inspect since
    defaults = [timeZone: "UTC", since: since, until: until, filter: nil, include: nil]
    query = Keyword.merge(defaults, options) 
            |> Enum.into(%{}) 
            |> load_query

    get("/notifications", query: query)
    |> handle_response
  end

  defp handle_response(%Tesla.Env{status: 200, body: %{"notifications" => addons}}) do
    addons
    |> Enum.map(&PagerDuty.Notification.new/1)
  end

  defp handle_response(%Tesla.Env{status: 200, body: body}) do
    body
    |> Poison.decode!
    |> Map.get("notifications") 
    |> PagerDuty.Notification.new
  end  

  defp load_query(query = %{include: nil}) do
     Map.delete(query, :include)
     |> load_query
  end

  defp load_query(query = %{include: includes}) do
    Map.delete(query, :include)
    |> Map.merge(%{"include" => includes})
    |> load_query
  end  

  defp load_query(query = %{filter: filter}) when filter == "sms_notification" or filter == "email_notification" or filter == "phone_notification" or filter == "push_notification" do
    Map.delete(query, :filter)
    |> Map.merge(%{"filter" => filter})
  end

  defp load_query(query = %{filter: _}), do: Map.delete(query, :filter)  
end
