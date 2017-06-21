defmodule PagerDuty.Api.Users do
  @moduledoc ~S"""
  Module encompassing interactions with the abilities API endpoint
  """
  use PagerDuty.Api.Common
  require Logger

  def account_user(id) do
    get("/users/#{id}", query: %{"include[]" => "contact_methods"})
    |> handle_response
  end

  def account_users() do
    get("/users")
    |> handle_response
  end

  defp handle_response(%Tesla.Env{status: 200, body: %{"user" => user}}) do
    user
    |> PagerDuty.User.new
  end

  defp handle_response(%Tesla.Env{status: 200, body: %{"users" => users}}) do
    users
    |> Enum.map(&PagerDuty.User.new/1)
  end  

end