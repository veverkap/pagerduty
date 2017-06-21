defmodule PagerDuty.Api.Addons do
  @moduledoc ~S"""
  Module encompassing interactions with the addons API endpoint
  """
  use PagerDuty.Api.Common
  require Logger

  @doc ~S"""
  List all of your account's addons

  ### Options

    * `:include_services` - Includes service details with addons (boolean, default: `false`)
    * `:filter` - Filters the results, showing only add-ons of the given type (either `incident_show_addon` or `full_page_addon`) (default: nil)

    * `:service_ids` - Filters the results, showing only add-ons for the given services (default: `[]`)
  """
  @spec account_addons([include_services: boolean, filter: String, service_ids: list()]) :: list(PagerDuty.Addon) | {:error, String.t}
  def account_addons(options \\ []) do
    defaults = [include_services: false, filter: nil, service_ids: []]
    query = Keyword.merge(defaults, options) |> Enum.into(%{}) |> load_query
    Logger.info "#{inspect query}"
    all_account_addons(query)
  end
  defdelegate list_addons(), to: __MODULE__, as: :account_addons

  @doc ~S"""
  Loads up details about a particular addon
  """
  @spec get_addon(binary) :: PagerDuty.Addon | {:error, String.t}
  def get_addon(addon_id) when is_binary(addon_id) do
    get("/addons/" <> addon_id)
    |> handle_response    
  end

  @doc ~S"""
  Installs an addon in the current account
  """
  @spec install_addon(PagerDuty.Addon) :: PagerDuty.Addon | {:error, String.t}
  def install_addon(%{type: nil}), do: {:error, "Addon type is required"}
  def install_addon(%{name: nil}), do: {:error, "Addon name is required"}
  def install_addon(%{src: nil}), do: {:error, "Addon src is required"}
  def install_addon(addon) do
    item = %{"addon" => addon}
           |> Poison.encode!

    Tesla.post(base_url() <> "/addons", 
               item, 
               headers: headers())
    |> handle_response
  end
  defdelegate create_addon(addon), to: __MODULE__, as: :install_addon

  @doc ~S"""
  Updates the details of an addon in the current account
  """
  @spec update_addon(String, PagerDuty.Addon) :: PagerDuty.Addon | {:error, String.t}
  def update_addon(_, %{type: nil}), do: {:error, "Addon type is required"}
  def update_addon(_, %{name: nil}), do: {:error, "Addon name is required"}
  def update_addon(_, %{src: nil}), do: {:error, "Addon src is required"}
  def update_addon(addon_id, addon) when is_binary(addon_id) do
    item = %{"addon" => addon}
           |> Poison.encode!   

    Tesla.put(base_url() <> "/addons/" <> addon_id, 
              item, 
              headers: headers())
    |> handle_response
  end

  @doc ~S"""
  Updates the details of an addon in the current account
  """
  @spec delete_addon(String) :: {:ok, String.t} | {:error, String.t}
  def delete_addon(%{id: nil}), do: {:error, "Addon id is required"}
  def delete_addon(addon_id) when is_binary(addon_id), do: delete_addon(%PagerDuty.Addon{id: addon_id})
  def delete_addon(%PagerDuty.Addon{id: id}) do
    delete("/addons/#{id}")
    |> handle_response
  end

  @spec all_account_addons(list) :: list(PagerDuty.Addon) | {:error, String.t}
  defp all_account_addons(nil), do: all_account_addons
  defp all_account_addons(query) do
    query = Map.to_list(query)
    get("/addons", query: query)
    |> handle_response
  end
  
  @spec all_account_addons :: list(PagerDuty.Addon) | {:error, String.t}
  defp all_account_addons do
    get("/addons")
    |> handle_response
  end

  defp handle_response(%Tesla.Env{status: 200, body: ""}), do: {:error, "No Addons Returned"}
  defp handle_response(%Tesla.Env{status: 200, body: nil}), do: {:error, "No Addons Returned"}
  defp handle_response(%Tesla.Env{status: 200, body: %{"addons" => []}}), do: {:error, "No Addons Returned"}

  defp handle_response(%Tesla.Env{status: 200, body: %{"addon" => addon}}) do
    addon
    |> PagerDuty.Addon.new
  end

  defp handle_response(%Tesla.Env{status: 200, body: %{"addons" => addons}}) do
    addons
    |> Enum.map(&PagerDuty.Addon.new/1)
  end

  defp handle_response(%Tesla.Env{status: 200, body: body}) do
    body
    |> Poison.decode!
    |> Map.get("addon") 
    |> PagerDuty.Addon.new
  end

  defp handle_response(%Tesla.Env{status: 201, body: body}) do
    body
    |> Poison.decode!
    |> Map.get("addon") 
    |> PagerDuty.Addon.new
  end

  defp handle_response(%Tesla.Env{status: 204}) do
    {:ok, "Deleted"}
  end

  defp load_query(query = %{filter: filter}) when filter == "incident_show_addon" or filter == "full_page_addon" do
    Map.delete(query, :filter)
    |> Map.merge(%{"filter" => filter})
    |> load_query
  end

  defp load_query(query = %{filter: _}), do: Map.delete(query, :filter)

  defp load_query(query = %{include_services: false}), do: Map.delete(query, :include_services)
  defp load_query(query = %{include_services: true}) do
    Map.delete(query, :include_services)
    |> Map.merge(%{"include[]" => "services"})
    |> load_query
  end

  defp load_query(query = %{service_ids: []}), do: Map.delete(query, :service_ids)
  defp load_query(query = %{service_ids: service_ids}) do
    Map.delete(query, :service_ids)
    |> Map.merge(%{"service_ids" => service_ids})
  end
end