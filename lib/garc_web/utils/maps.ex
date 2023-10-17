defmodule GarcWeb.Utils.Maps do
  @moduledoc """
  Module for Utils.Maps
  """
  def key_to_string(key_map) do
    key_map
    |> Digger.Stringifier.stringify()
  end
end
