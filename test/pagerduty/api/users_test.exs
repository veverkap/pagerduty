defmodule PagerDuty.UsersTest do
  use ExUnit.Case, async: false

  test "do" do
    PagerDuty.Api.Users.get("/users/PLXO1B7", query: %{"include[]" => "contact_methods"})
  end
end