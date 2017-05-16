defmodule PagerDuty.Addon do
  @moduledoc ~S"""
  Third-party developers can write their own add-ons to PagerDuty's UI, to
  add HTML to the product.

  Given a configuration containing a `src` parameter, that URL will be
  embedded in an `iframe` on a page that's available to users from
  a drop-down menu.
    
  ## Attributes
    * `@id`: id
    * `@summary`: A short-form, server-generated string that provides succinct, important information about an object suitable for primary labeling of an entity in a client. In many cases, this will be identical to `name`, though it is not intended to be an identifier.
    * `@type`: one of:
      * `full_page_addon`
      * `full_page_addon_reference`
      * `incident_show_addon`
      * `incident_show_addon_reference`      
    * `@self`: the API show URL at which the object is accessible 
    * `@html_url`: a URL at which the entity is uniquely displayed in the Web app
    * `@name`: The name of the add-on (maximum of 100 characters)
    * `@src`: The source URL to display in a frame in the PagerDuty UI. HTTPS is required.
  """  
  defstruct id: nil, summary: nil, type: nil, self: nil, html_url: nil, name: nil, src: nil

  @type t :: %__MODULE__{
    id: String.t,
    summary: String.t,
    type: String.t,
    self: String.t,
    html_url: String.t,
    name: String.t,
    src: String.t
  }     

  @doc ~S"""
  Generates a new `PagerDuty.Addon` from a map

  ## Examples

      iex> map = %{type: "full_page_addon", name: "name", src: "https://uniqueurl.com"}
      ...> result = PagerDuty.Addon.new(map)
      ...> result.type
      "full_page_addon"
      ...> result.name
      "name"
      ...> result.src
      "https://uniqueurl.com"  

      iex> decoded = ~s<{"type": "incident_show_addon", "name": "name", "src": "https://anotheruniqueurl.com"}>
      ...> |> Poison.decode!
      ...> result = PagerDuty.Addon.new(decoded)
      ...> result.type
      "incident_show_addon"
      ...> result.name
      "name"
      ...> result.src
      "https://anotheruniqueurl.com"        
  """  
  def new(addon) do
    struct(PagerDuty.Addon, PagerDuty.Utils.atomize(addon))
  end

  @doc """
  Checks whether the addon is valid
  An addon is valid when is has the correct `type` (either `full_page_addon` or `incident_show_addon`), the required attributes of `name` and `src` and
  is using https as the `src` protocol

  ## Examples
      iex> addon = %PagerDuty.Addon{name: "test"}
      ...> PagerDuty.Addon.is_valid?(addon)
      false

      iex> addon = %PagerDuty.Addon{src: "https://test.com"}
      ...> PagerDuty.Addon.is_valid?(addon)
      false      

      iex> addon = %PagerDuty.Addon{name: "test", src: "https://test.com"}
      ...> PagerDuty.Addon.is_valid?(addon)
      false

      iex> addon = %PagerDuty.Addon{name: "test", src: "https://test.com", type: "something"}
      ...> PagerDuty.Addon.is_valid?(addon)
      false     

      iex> addon = %PagerDuty.Addon{name: "test", src: "http://test.com", type: "full_page_addon"}
      ...> PagerDuty.Addon.is_valid?(addon)
      false

      iex> addon = %PagerDuty.Addon{name: "test", src: "https://test.com", type: "full_page_addon"}
      ...> PagerDuty.Addon.is_valid?(addon)
      true   

      iex> addon = %PagerDuty.Addon{name: "test", src: "https://test.com", type: "incident_show_addon"}
      ...> PagerDuty.Addon.is_valid?(addon)
      true           
  """
  def is_valid?(%PagerDuty.Addon{name: name, src: src, type: type}) when is_nil(name) or is_nil(src) or is_nil(type), do: false
  def is_valid?(%PagerDuty.Addon{type: type}) when type != "full_page_addon" and type != "incident_show_addon", do: false
  def is_valid?(%PagerDuty.Addon{name: name, src: src, type: type}) when not is_nil(name) and not is_nil(src) and not is_nil(type) do
    Regex.match?(~r/^https/, src)
  end
end