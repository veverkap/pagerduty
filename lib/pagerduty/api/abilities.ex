defmodule PagerDuty.Api.Abilities do
  @moduledoc ~S"""
  Module encompassing interactions with the abilities API endpoint
  """
  use PagerDuty.Api.Common
  require Logger

  @doc ~S"""
  List all of your account's abilities, by name.

  This describes your account's abilities by feature name, like `"teams"`.

  An ability may be available to your account based on things like your
  pricing plan or account state.
  """
  @spec account_abilities :: list(binary)
  def account_abilities do
    get("/abilities")
    |> handle_response
  end

  @doc ~S"""
  Test whether your account has a given ability.
  """
  @spec account_has_ability(binary) :: boolean()
  def account_has_ability(ability) when is_binary(ability) do
    get("/abilities/#{ability}")
    |> handle_response
  end

  defdelegate list_abilities(), to: __MODULE__, as: :account_abilities
  defdelegate test_ability(ability), to: __MODULE__, as: :account_has_ability

  defp handle_response(%Tesla.Env{status: 404}), do: false
  defp handle_response(%Tesla.Env{status: 204}), do: true
  
  defp handle_response(%Tesla.Env{status: 200, body: ""}), do: {:error, "No Abilities Returned"}
  defp handle_response(%Tesla.Env{status: 200, body: nil}), do: {:error, "No Abilities Returned"}
  defp handle_response(%Tesla.Env{status: 200, body: %{"abilities" => []}}), do: {:error, "No Abilities Returned"}
  defp handle_response(%Tesla.Env{status: 200, body: %{"abilities" => abilities}}) do
    abilities
    |> Enum.sort
  end
end