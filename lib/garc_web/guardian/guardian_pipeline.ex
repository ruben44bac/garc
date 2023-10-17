defmodule GarcWeb.Guardian.GuardianPipeline do
  @moduledoc """
  Module for Guardian.Pipeline
  """
  use Guardian.Plug.Pipeline,
    otp_app: :garc,
    module: GarcWeb.Guardian.Guardian,
    error_handler: GarcWeb.Guardian.GuardianErrorHandler

  plug Guardian.Plug.VerifySession, claims: %{"typ" => "access"}
  plug Guardian.Plug.LoadResource

  plug :add_current_user

  defp add_current_user(conn, _params) do
    put_session(conn, :current_user, Guardian.Plug.current_resource(conn))
  end
end
