defmodule GarcWeb.Guardian.GuardianErrorHandler do
  @moduledoc """
  Module for Guardian.ErrorHandler
  """

  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, {_type, _reason}, _opts) do
    conn
    |> Phoenix.Controller.redirect(to: "/login")
  end
end
